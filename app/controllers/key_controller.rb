require 'KeysManager'
class KeyController < ApplicationController
	
  def create
  	keyManager = KeysManager.new
  	publicKey = keyManager.create_PublicKey(params[:appName])
  	privateKey = keyManager.create_SecretKey(params[:appName],publicKey)

  	keys = Hash.new(0)
  	keys['public_key'] = publicKey
  	keys['private_key'] = privateKey
  	keys['app_name'] = params[:appName]

  	@app_data = KeyApp.save_keys(keys)
  	
  end

  def destroy
  end
end