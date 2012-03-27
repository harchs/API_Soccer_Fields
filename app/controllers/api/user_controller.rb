require 'KeysManager'
require 'Time_Local'
class Api::UserController < Api::ApiController

  def sign_in
    #verify params
    unless has_valid_parameters?
      render_response("API_PARAMS_ERROR", nil, {:status => 'failure', :aditional_data => {:errors => "You must provide the user data."}}) and return
    end
    #http://prueba.local:3000/user/sign_up?first_name="first_name_user"&last_name="last_name_user"&nick_name="nick_name_user"&email="email_user"&uid=72357278&token=123456789

    user = Users.find_by_email(hash_user['email']) || Users.save_user(params[:request][:user])
    if user
      user_auth = Hash.new(0)
      user_auth['uid']=params[:request][:user][:user_keys][:uid]
      user_auth['token']=params[:request][:user][:user_keys][:token]
      user_auth['app_id']=app_id
      user_auth['user_id']=user.id
      user_keys =  user.user_keys.blank? || user.user_keys.save_keys(user_auth)

      if user_keys.credential.blank?
        keyManager = KeysManager.new
        credential=keyManager.secure_digest(params[:request][:user][:user_keys][:uid],params[:request][:user][:user_keys][:token],Time)
        user_keys.save_credential(credential)
      end
      render_response("API_SUCCESS", user.as_api_response(:customer_info), {:sign_in => :user})
    else
      render_response("API_NO_USER_ERROR", nil, {:aditional_data => {:errors => "It looks like the user related to that e-mail does not exist, try again  with another."}, :status => 'failure'})
    end
  end

  def sign_out
  end

  def has_valid_parameters?
    return params[:request] && params[:request][:user] && params[:request][:user][:email] && params[:request][:user][:user_keys] 
  end 

  def show
  end

  private
    def Time
      time = Time_Local.new
      t = time.now
    end 


  
end
