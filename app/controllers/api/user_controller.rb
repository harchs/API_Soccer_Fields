=begin apidoc
  url:: /user/sign_in
  method:: GET
  access:: RESTRICTED by authentication of the app
  return:: [JSON] - list of venues objects

  param:: firs_name: First name of the user 
  param:: last_name: Lasta name of the user
  param:: email: Email of the user
  param:: nick_name: [Optional] Nick name of the user
  param:: uid: uid returned by the outh authentication when this sign in diferentes app (facebook, twitter, ...)
  param:: token: token returned by the outh authentication when this sign in diferentes app (facebook, twitter, ...)
  param:: auth_code: Code generated with private key and modifiers
  param:: valide_date: [Optional] Specifies whether or not to consider the date to generate the auth_code "aaaa/mm/dd hh"
  param:: modifiers: Modifiers used for encode the private key of the app "modifiers=m1,m2,...mn"

  output:: json
    {
      "status": "success",
      "code": "API_SUCCESS",
      "message": "The operation was successful",
      "errors": "",
      "data": {
          "response": {
              "email": "leonardo.sanclemente@koombea.com",
              "first_name": "leo",
              "last_name": "san",
              "user_key": [{
                  "uid": "321323111",
                  "credential": "e2b8bbed163dc2770c49728342163128cb1eb8b9"
              }]
          }
      }
  }
  ::output-end::
=end

=begin apidoc
  url:: /user/sign_out
  method:: GET
  access:: RESTRICTED by authentication of the app
  return:: [JSON] - list of venues objects

  param:: credential: Credential asigned to user
  param:: auth_code: Code generated with private key and modifiers
  param:: valide_date: [Optional] Specifies whether or not to consider the date to generate the auth_code "aaaa/mm/dd hh"
  param:: modifiers: Modifiers used for encode the private key of the app "modifiers=m1,m2,...mn"

  output:: json
    {
      "status": "success",
      "code": "API_SUCCESS",
      "message": "The operation was successful",
      "errors": "",
      "data": {
      }
  }
  ::output-end::
=end
require 'KeysManager'
require 'Time_Local'
class Api::UserController < Api::ApiController

  def sign_in
    #verify params
    unless has_valid_parameters?
      render_response("API_PARAMS_ERROR", nil, {:status => 'failure', :aditional_data => {:errors => "You must provide the user data."}}) and return
    end
    #http://prueba.local:3000/user/sign_up?first_name="first_name_user"&last_name="last_name_user"&nick_name="nick_name_user"&email="email_user"&uid=72357278&token=123456789
    user = User.find_by_email(params[:request][:user][:email]) || create_new_user_instance
    # raise user.to_yaml
    if user
      get_user_keys(user)
      render_response("API_SUCCESS", user.as_api_response(:sign_in), {:sign_in => :user})
    else
      render_response("API_NO_USER_ERROR", nil, {:aditional_data => {:errors => "It looks like the user related to that e-mail does not exist, try again  with another."}, :status => 'failure'})
    end
  end

  def sign_out
  end

  def show
  end

  

  

  private

    def get_user_keys(user)
      user_auth = Hash.new
      user_auth[:uid]=params[:request][:user][:user_keys][:uid]
      user_auth[:token]=params[:request][:user][:user_keys][:token]
      user_auth[:app_id]=app_id
      user_auth[:user]=user
      user_key =  user.user_key.first || UserKey.new_instance(user_auth)

      if user_key.credential.blank?
        keyManager = KeysManager.new
        credential=keyManager.secure_digest(params[:request][:user][:user_keys][:uid],params[:request][:user][:user_keys][:token],Time)
        user_key.update_attribute(:credential, credential)
      end
    end

    def Time
      time = Time_Local.new
      t = time.now
    end 

    def create_new_user_instance
      user = User.create({
          :first_name=>params[:request][:user][:first_name],
          :last_name=>params[:request][:user][:last_name],
          :nick_name=>params[:request][:user][:nick_name],
          :email=>params[:request][:user][:email]
        }) 
    end

    def has_valid_parameters?
      return params[:request] && params[:request][:user] && params[:request][:user][:email] && params[:request][:user][:user_keys] 
    end 


  
end
