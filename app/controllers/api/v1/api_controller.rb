require 'auth_manager'
require 'KeysManager'
class Api::V1::ApiController < ApplicationController
  # You can disable csrf protection on controller-by-controller basis.
  # In all the api calls we do not want to protect from forgery.

  attr_accessor :app_id  


  before_filter :authenticate_application
  # before_filter :authenticate_user_token

  respond_to  :json, :xml


  rescue_from ActiveRecord::RecordNotFound do |exception|
    render_response("API_404", exception.message, {:status => 'failure'})
  end

  rescue_from ActiveRecord::UnknownAttributeError do |exception|
    render_response("API_PARAMS_ERROR", exception.message, {:status => 'failure'})
  end



  # protected

  # renders a response, using our Response object.
  def render_response(code, object, options = {})
    options = default_render_options(options)

    response = Response.new(
      code,
      object.is_a?(ActiveRecord::Relation) ? object.all : object,
      options[:status],
      options[:aditional_data],
      options[:data_root]
    )

    respond_with do |format|
      format.xml { render :xml => response.to_xml }
      format.json { render :json => response.to_json }
    end
  end

  # Checks wheter the received auth_token is valid.
  def authenticate_user_token
    render_response("USER_CREDENTIAL_REQUIRED", nil, {:status => 'failure'}) and return unless params[:user_credential]
    #replace with authetication 
    user = UserKey.find_by_credential(params[:user_credential]).user
    if user
      true
    else
      render_response("USER_CREDENTIAL_INVALID", nil, {:status => 'failure'})
    end
  end

  # Initializes the default options with the ones passed by the user.
  def default_render_options(options)
    {
      :status => nil,
      :data_root => :response,
      :aditional_data => {:errors => ""}
    }.merge(options)
  end


  private
    # Checks wheter the received api_auth_token is valid.
    def authenticate_application
      if has_missing_params?
         render_response("API_PARAMS_ERROR", nil, {:status => 'failure', :aditional_data => {:errors => "You must provide the auth data."}}) and return
         # render_response("API_PARAMS_ERROR", nil, {:status => 'failure', :aditional_data => {:errors => "You must provide auth data"}}) and return
      end
      #gets private_token form the bd
      keys_app = KeyApp.find_by_public_key(params[:public_key])
      unless keys_app.blank?
        if auth_hashes_match?(keys_app)
          app_id=keys_app.app_id
          true
        else
          render_response("API_401", nil, {:status => "failure", :aditional_data => {:errors => "Auth hashes mismatch."}})
        end
      else
        render_response("API_401", nil, {:status => "failure", :aditional_data => {:errors => "Public Key is invalid"}})
      end 
  end

  def has_missing_params?
    params[:public_key].blank? || params[:auth_code].blank? 
  end

  def auth_hashes_match? (keys_app)
        public_key = params[:public_key]
        hash_auth = params[:auth_code]
        private_key = keys_app.private_key
        # define options for the auth
        options = Hash.new 
        options[:valid_date]= params[:valid_date]

        #define the params to generatwe de secret_token
        params_auth= [public_key, private_key]

        auditor = Auth_manager.new(public_key, private_key, KeysManager.new ) 
        result = auditor.authenticate(public_key, hash_auth, params_auth, options )
  end

  def create_new_user_instance
    user = User.create({
        :first_name=>params[:first_name],
        :last_name=>params[:last_name],
        :nick_name=>params[:nick_name],
        :email=>params[:email]
      }) 
  end

  def create_new_user_key_instance(user)
    UserKey.create({
    :uid => params[:user_uid],
    :token => params[:user_token],
    :app_id => app_id,
    :user => user
    })
  end
   

end
