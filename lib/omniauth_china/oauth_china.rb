require 'omniauth/core'

module OmniAuth
  module Strategies
    autoload :Douban,             'omniauth_china/strategies/douban'
    autoload :Tsina,              'omniauth_china/strategies/tsina'
    autoload :T163,               'omniauth_china/strategies/t163'
    autoload :Tsohu,              'omniauth_china/strategies/tsohu'
  end
end
