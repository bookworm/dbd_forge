ForgeApiV1.helpers do    
  def oauth_check()       
    oauth_header = ROAuth.parse(@env['HTTP_AUTHORIZATION'])  

    # Implementation specific
    @key = AccessKey.first(:shared => oauth_header[:consumer_key])
    oauth = {
      :consumer_key  => @key.shared,
      :access_secret => @key.secret,
      :token         => ''  
    }  

    oauth[:signature_method] ||= "HMAC-SHA1"  
    uri = "http://#{ENV['DOMAIN']}/#{@env['REQUEST_URI']}"

    unless ROAuth.verify(oauth, oauth_header, uri, request.params) #=> true/false
      halt 403
    end
  end
end                     