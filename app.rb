#debugging settings, disable on production as needed
enable :logging, :dump_errors, :raise_errors
#set :raise_errors, 
#set :show_exceptions, false
set :partial_template_engine, :erb

FACEBOOK_SCOPE = 'email'

unless ENV["FACEBOOK_APP_ID"] && ENV["FACEBOOK_SECRET"]
  abort("missing env vars: please set FACEBOOK_APP_ID and FACEBOOK_SECRET with your app credentials")
end

use Rack::Session::Cookie
use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'], :scope => FACEBOOK_SCOPE
end

def invalidate_session
  session[:omniauth_auth] = nil
end

before /^(?!\/(login|auth\/facebook\/*|auth\/facebook\/failure))/ do    
  #validate facebook session  
  begin
    if session[:omniauth_auth]
      @access_token = session[:omniauth_auth][:credentials][:token]    
      @graph = Koala::Facebook::API.new(@access_token)
      @profile = @graph.get_object("me");
    else
      redirect '/login'
    end      
  rescue Koala::Facebook::APIError => e
    if e.fb_error_type == 'OAuthException'
      warn e.message
      invalidate_session
      redirect '/login'
    end
  end
end

get '/login' do  
  erb :login
end

get '/welcome' do
  @user = session[:omniauth_auth][:info]
  @userExtra = session[:omniauth_auth][:extra][:raw_info]  
  erb :welcome
end

get '/auth/facebook/token' do 
  @access_token = nil
  if session[:omniauth_auth]
    @access_token = session[:omniauth_auth][:credentials][:token]
  end
end

get '/auth/failure' do
    content_type 'application/json'
    MultiJson.encode(request.env)
end

get '/auth/facebook/callback' do
  session[:omniauth_auth] = request.env['omniauth.auth']
  redirect '/welcome'  
end

get '/logout' do
  session[:omniauth_auth] = nil
  redirect '/'
end