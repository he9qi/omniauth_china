require 'omniauth/core'

module OmniAuth
  module Strategies
    autoload :Douban,             'omniauth_china/strategies/douban'
    autoload :Tsina,              'omniauth_china/strategies/tsina'
    autoload :T163,               'omniauth_china/strategies/t163'
    autoload :Tsohu,              'omniauth_china/strategies/tsohu'
    autoload :Tqq,                'omniauth_china/strategies/tqq'
    autoload :Renren,             'omniauth_china/strategies/renren'
    autoload :Qzone,              'omniauth_china/strategies/qzone'
  end
end
