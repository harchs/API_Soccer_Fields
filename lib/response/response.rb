require "ostruct"

class Response
  MESSAGES = {
    'API_SUCCESS' => "The operation was successful",
    'API_ERROR' => "The operation was unsuccessful",
    'API_PARAMS_ERROR' => "Operation not completed due to missing parameters",
    'API_USER_CREATED' => "A new user was created",
    'API_NO_USER_ERROR' => "The user could not be found on the server",
    'API_CARD_ERROR' => "There is a problem with the provided payment information",

    'API_AUTHENTICATION_ERROR' => "The combination of user and password was not found",

    'API_INVALID_TOKEN' => "Authentication token is invalid",
    'API_TOKEN_REQUIRED' => "Authentication token required",
    'API_ERROR_TRANSACTION' => "General error has occurred trying to execute action, please try again later.",

    'USER_CREDENTIAL_INVALID' => "User Authentication credential is invalid",
    'USER_CREDENTIAL_REQUIRED' => "User Authentication credential required",

    #html codes
    'API_401' => "Unauthorized request. Please check your credentials.",
    'API_404' => "Resource was not found on the server",
    'API_522' => "Unprocessable entity",
    'API_422' => "Acces denied"
  }

  def self.message(code)
    MESSAGES[code]
  end

  #Creates the object error based on a status_code and an object
  #@param [String] code a response mensage code to match with Response.MESSAGES
  #@param [String] object an object to serialize on the data attribute of the response
  #@param [String] status the status to send with the response
  #@param [String] aditional_data a hash to merge with the hash
  def initialize(code, object = nil, status = nil, aditional_data = nil, data_root = :message)
    aditional_data = {} unless aditional_data
    response = {
      :status => status || "success",
      :code => code,
      :message => Response::message(code)
    }.merge(aditional_data)

    if object
      @_object = object
      response[:data] = {data_root => @_object}
    end

    @object = OpenStruct.new(response)
  end

  #returns an xml representation of the error
  def to_xml
    @object.marshal_dump.to_xml(:root => :response)
  end

  #returns an json representation of the error
  def to_json
    @object.marshal_dump.to_json
  end

 #def to_hash
 #  @object.marshal_dump
 #end
end
