# OmniAuth: Standardized Multi-Provider Authentication

OmniAuth is a new Rack-based authentication system for multi-provider external authentcation. OmniAuth is built from the ground up on the philosophy that **authentication is not the same as identity**, and is based on two observations:

# OmniAuthChina (omniauth_china) 

OmniAuth China is an extention of OmniAuth, it addes Open ID providers in China such as Douban, Sina, Sohu, 163, Tencent, Renren, etc.

## Installation

To install OmniAuthChina, simply install the gem:

    gem install omniauth_china
    
## Providers

OmniAuth currently supports the following external providers:

* via OAuth
  * Douban (credit: [rainux](http://github.com/rainux))
  * Tsina (credit: [he9qi](http://github.com/he9qi))
  * T163 (credit: [he9qi](http://github.com/he9qi))
  * Tsohu (credit: [he9qi](http://github.com/he9qi))
  * Tqq (credit: [he9qi](http://github.com/he9qi))
* Renren (Renren Connect of renren.com) (credit: [taweili](http://github.com/taweili), [rainux](http://github.com/rainux))

## 人人

Run the generator to generate `xd_receiver.html` and include helper into ApplicationHelper:

    rails g omniauth_renren:install

Place the Renren Connect button on any page by simply call `omniauth_renren_connect_button`:

    <%= omniauth_renren_connect_button %>

Route `/auth/renren` to the page that contain Renren Connect button:

    match '/auth/renren' => 'users#show'

## Usage

OmniAuth is a collection of Rack middleware. To use a single strategy, you simply need to add the middleware:

    require 'oa-oauth'
    use OmniAuth::Strategies::Twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
    
Now to initiate authentication you merely need to redirect the user to `/auth/twitter` via a link or other means. Once the user has authenticated to Twitter, they will be redirected to `/auth/twitter/callback`. You should build an endpoint that handles this URL, at which point you will will have access to the authentication information through the `omniauth.auth` parameter of the Rack environment. For example, in Sinatra you would do something like this:

    get '/auth/twitter/callback' do
      auth_hash = request.env['omniauth.auth']
    end
    
The hash in question will look something like this:

    {
      'uid' => '12356',
      'provider' => 'twitter',
      'user_info' => {
        'name' => 'User Name',
        'nickname' => 'username',
        # ...
      }
    }
    
The `user_info` hash will automatically be populated with as much information about the user as OmniAuth was able to pull from the given API or authentication provider.

## TOTO

Write better tests!!