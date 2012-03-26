require 'auth_manager'
class Api::V1::ApiController < ApplicationController
  # You can disable csrf protection on controller-by-controller basis.
  # In all the api calls we do not want to protect from forgery.
  skip_before_filter :verify_authenticity_token

  before_filter :authenticate_application
  before_filter :authenticate_user_token

  respond_to  :json, :xml


  rescue_from ActiveRecord::RecordNotFound do |exception|
    render_response("API_404", exception.message, {:status => 'failure'})
  end

  rescue_from ActiveRecord::UnknownAttributeError do |exception|
    render_response("API_PARAMS_ERROR", exception.message, {:status => 'failure'})
  end


  protected

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
    render_response("USER_CREDENTIAL_REQUIRED", nil, {:status => 'failure'}) and return unless params[:credential]
    #replace with authetication 
    user = User_keys.find_by_credential(params[:auth_token]).user
    if user
      sign_in(user) and return
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
      public_key = params[:public_key]
      hash_auth = params[:hash_auth]

      #gets private_token form the bd
      keys_app = KeyApp.find_by_public_key(public_key)
      private_key = keys_app.private_key
      # p "time:"+time_now_trunk_hour

      options = Hash.new 
      options[:valid_date]= params[:valid_date]

      #define the params to generatwe de secret_token
      params_auth= [time_now_trunk_hour, private_key, public_key]

      auditor = Auth_manager.new(public_key, private_key, KeysManager.new ) 
      result = auditor.authenticate(public_key, hash_auth, params_auth, options )
      if result
        true
      else
        render_response("API_401", nil, {:status => "failure"})
      end 
    end
  end 

end
