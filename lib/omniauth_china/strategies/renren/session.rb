require 'digest/md5'
require 'multi_json'

module OmniAuth
  module Strategies
    class Renren
      class Session
        class IncorrectSignature < Exception; end
        class SessionExpired < Exception; end
        class OtherException < Exception; end

        attr_reader :session_key
        attr_reader :expires
        attr_reader :uid

        def initialize(user_hash)
          @expires = user_hash['renren_token']['expires_in'] ? user_hash['renren_token']['expires_in'].to_i : 0
          @session_key = user_hash['renren_token']['session_key']
          @uid = user_hash['user']['id']
        end

        def user
          @user ||= invoke_method('users.getInfo', :uids => @uid, :format => :json).first
        end

        def infinite?
          @expires == 0
        end

        def expired?
          @expires.nil? || (!infinite? && Time.at(@expires) <= Time.now)
        end

        def secured?
          !@session_key.nil? && !expired?
        end

        def invoke_method(method, params = {})
          xn_params = {
            :method => method,
            :api_key => Renren.api_key,
            :session_key => session_key,
            :call_id => Time.now.to_i,
            :v => '1.0',
            :format => :json
          }
          xn_params.merge!(params) if params
          xn_params.merge!(:sig => compute_sig(xn_params))
          MultiJson.decode(Service.new.post(xn_params).body)
        end

        class << self
          private
          def verify_signature(renren_sig_params, expected_signature)
            raise Renren::Session::IncorrectSignature if compute_sig(renren_sig_params) != expected_signature
            # raise Renren::Session::SignatureTooOld if renren_sig_params['time'] && Time.at(renren_sig_params['time'].to_f) < earliest_valid_session
            true
          end

          def compute_sig(params)
            raw_string = params.collect {|*args| args.join('=') }.sort.join
            actual_sig = Digest::MD5.hexdigest([raw_string, Renren.secret_key].join)
          end
        end

        private

        def verify_signature(renren_sig_params, expected_signature)
          self.class.send :verify_signature, renren_sig_params, expected_signature
        end

        def compute_sig(params)
          self.class.send :compute_sig, params
        end
      end
    end
  end
end
