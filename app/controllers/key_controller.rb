require 'KeysManager'
class KeyController < ApplicationController
	
  def create
  	keyManager = KeysManager.new
  	@publicKey = keyManager.create_PublicKey(params[:appName])
  	@secretKey = keyManager.create_SecretKey(params[:appName],@publicKey)
  end

  def destroy
  end
end
