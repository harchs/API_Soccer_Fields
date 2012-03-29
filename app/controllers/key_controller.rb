require 'KeysManager'
class KeyController < ApplicationController
	
	#http://prueba.local:3000/key/create?appName=test
  def create
  	keyManager = KeysManager.new

    app_hash = Hash.new
    app_hash['name'] = params[:appName]
    app_hash['url'] = params[:url]

    app = App.find_by_name(params[:appName])||App.save_app(app_hash)

  	publicKey = keyManager.create_PublicKey(params[:appName])
  	privateKey = keyManager.create_SecretKey(params[:appName],publicKey)

  	keys = Hash.new
  	keys['public_key'] = publicKey
  	keys['private_key'] = privateKey
  	keys['app_id'] = app.id

  	@app_data = KeyApp.find_by_app_id(app.id) || KeyApp.save_keys(keys)
  	
    @auth_code = keyManager.secure_digest(publicKey,privateKey)
  end

  def get_auth_code
  end
end