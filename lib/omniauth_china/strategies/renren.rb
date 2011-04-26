require 'omniauth/oauth'
require 'multi_json'

module OmniAuth
  module Strategies
    
    # Authenticate to Renren utilizing OAuth 2.0 and retrieve
    # basic user information.
    #
    # @example Basic Usage
    #   use OmniAuth::Strategies::Renren, 'client_id', 'client_secret'
    class Renren < OAuth2
      autoload :Session, 'omniauth_china/strategies/renren/session'
      autoload :Service, 'omniauth_china/strategies/renren/service'
      
      class << self
        def api_key; @@api_key; end
        def secret_key; @@secret_key; end
      end
      
      # @param [Rack Application] app standard middleware application parameter
      # @param [String] client_id the application id as [registered on Renren](http://www.renren.com/developers/)
      # @param [String] client_secret the application secret as registered on Renren
      # @option options [String] :scope ('email') comma-separated extended permissions such as `email` and `manage_pages`
      def initialize(app, client_id = nil, client_secret = nil, options = {}, &block)
        @@api_key = client_id
        @@secret_key = client_secret
        super(app, :renren, client_id, client_secret, {:site => 'https://graph.renren.com/', :access_token_path => "/oauth/token"}, options, &block)
      end
      
      def user_hash
        @data ||= MultiJson.decode(@access_token.get('/renren_api/session_key', { :oauth_token => @access_token.token }, { "Accept-Language" => "zh;"}))
        @renren_session ||= Renren::Session.new(@data)
      end
      
      def request_phase
        options[:scope] ||= "email"
        options[:response_type] ||= "code"
        super
      end
      
      # need to have :grant_type=>"authorization_code" for renren to work
      def callback_phase
        if request.params['error'] || request.params['error_reason']
          raise CallbackError.new(request.params['error'], request.params['error_description'] || request.params['error_reason'], request.params['error_uri'])
        end
        verifier = request.params['code']
        @access_token = client.web_server.get_access_token(verifier,  {:redirect_uri => callback_url, :grant_type=>"authorization_code" })
        @env['omniauth.auth'] = auth_hash
        call_app!
      rescue ::OAuth2::HTTPError, ::OAuth2::AccessDenied, CallbackError => e
        fail!(:invalid_credentials, e)
      end
      
      def auth_hash
        OmniAuth::Utils.deep_merge(super, {
          'uid' => user_hash.uid,
          'user_info' => user_info,
          'extra' => {
            'user_hash' => user_hash.user
          }
        })
      end
      
      def user_info
        user_hash = self.user_hash.user
        {
          'username' => user_hash['name'],
          'name' => user_hash['name'],
          'image' => user_hash['tinyurl'],
          'vip' => user_hash['vip'],
          'headurl' => user_hash['headurl']
        }
      end
      
    end
    
  end
end