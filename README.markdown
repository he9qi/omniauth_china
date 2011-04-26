# OmniAuth: Standardized Multi-Provider Authentication

OmniAuth is a new Rack-based authentication system for multi-provider external authentcation. OmniAuth is built from the ground up on the philosophy that **authentication is not the same as identity**.

## Apparently, oauth providers of China have already been merged into [intridea/omniauth](https://github.com/intridea/omniauth). Go take a look.


# OmniAuthChina (omniauth_china) 

OmniAuth China is an extention of OmniAuth, it addes Open ID providers in China such as Douban, Sina, Sohu, 163, Tencent, Renren, Qzone, etc.

## Note

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
  * Renren (credit: [quake](http://github.com/quake))
  * Qzone (credit: [quake](http://github.com/quake))

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

## Contributors (thanks!)
  * [huacnlee](http://github.com/huacnlee)

