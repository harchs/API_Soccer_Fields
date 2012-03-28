require 'KeysManager'
require 'Time_Local'
class Api::UserController < Api::ApiController

  def sign_in
    #verify params
    unless has_valid_parameters?
      render_response("API_PARAMS_ERROR", nil, {:status => 'failure', :aditional_data => {:errors => "You must provide the user data."}}) and return
    end
    #http://prueba.local:3000/user/sign_up?first_name="first_name_user"&last_name="last_name_user"&nick_name="nick_name_user"&email="email_user"&uid=72357278&token=123456789
    user = User.find_by_email(params[:user_email]) || create_new_user_instance
    # if user  exist or if didnt have validations problem in the model
    if user && user.errors.full_messages.blank?
      get_user_keys(user)
      render_response("API_SUCCESS", user.as_api_response(:sign_in), {:sign_in => :user})
    else
      if user.errors.full_messages.blank?  
        render_response("API_NO_USER_ERROR", nil, {:aditional_data => {:errors => "It looks like the user related to that e-mail does not exist, try again  with another."}, :status => 'failure'})
      else
        render_response("API_NO_USER_ERROR", nil, {:aditional_data => {:errors => user.errors.full_messages.to_s}, :status => 'failure'})
      end 
    end
  end

  def sign_out
  end

  def show
  end

  

  

  private

    def get_user_keys(user)
      user_auth = Hash.new
      user_auth[:uid]=params[:user_uid]
      user_auth[:token]=params[:user_token]
      user_auth[:app_id]=app_id
      user_auth[:user]=user
      user_key =  user.user_key.first || UserKey.new_instance(user_auth)

      if user_key.credential.blank?
        keyManager = KeysManager.new
        credential=keyManager.secure_digest(params[:user_uid],params[:user_token],Time)
        user_key.update_attribute(:credential, credential)
      end
    end

    def Time
      time = Time_Local.new
      t = time.now
    end 

    def create_new_user_instance
      user = User.create({
          :first_name=>params[:user_first_name],
          :last_name=>params[:user_last_name],
          :nick_name=>params[:user_nick_name],
          :email=>params[:user_email]
        }) 
      p "any errors:"+user.errors.full_messages.blank?.to_s
      user
    end

    def has_valid_parameters?
      return  params[:user_email] && params[:user_uid] && params[:user_uid]
    end 


  
end
