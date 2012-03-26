require 'KeysManager'
require 'Time_Local'
class UserController < ApplicationController

  def sign_in
  	keyManager = KeysManager.new

  	#verification of the app

    #http://prueba.local:3000/user/sign_up?first_name="first_name_user"&last_name="last_name_user"&nick_name="nick_name_user"&email="email_user"&uid=72357278&token=123456789

    hash_user = Hash.new(0)
    hash_user['first_name']=params['first_name']
    hash_user['last_name']=params['last_name']
    hash_user['nick_name']=params['nick_name']
    hash_user['email']=params['email']

    user = Users.find_by_email(hash_user['email']) || Users.save_user(hash_user)
    
    hash_user_auth = Hash.new(0)
    hash_user_auth['uid']=params['uid']
    hash_user_auth['token']=params['token']
    hash_user_auth['app_id']=1
    hash_user_auth['user_id']=user.id

    @user_keys =  UserKeys.find_by_user_id(user.id) || UserKeys.save_keys(hash_user_auth)

    if @user_keys.credential.blank?
      credential=keyManager.secure_digest(params['uid'],params['token'],Time)
      @user_keys.save_credential(credential)
    end

  end

  def sign_out
  end

  private
    def Time
      time = Time_Local.new
      t = time.now
    end 
  
end
