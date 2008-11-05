module TokBoxer

  class Api

    API_SERVER_LOGIN_URL       = "view/oauth&"
    API_SERVER_METHODS_URL     = "a/v0"
    API_SERVER_CALL_WIDGET     = "vc/"
    API_SERVER_RECORDER_WIDGET = "vr/"
    API_SERVER_PLAYER_WIDGET   = "vp/"
    API_VERSION                = "1.0.0"
    API_SIGNATURE_METHOD       = "SIMPLE-MD5"

    attr_reader :api_server_url, :API_SERVER_RECORDER_WIDGET, :API_SERVER_PLAYER_WIDGET, :API_SERVER_CALL_WIDGET

    # Call API actions =================================================================================

    def create_call(callerJabberId, callerName, persistent=false, features="")
      method = "POST"
      call = "/calls/create"
      params = { :callerJabberId => callerJabberId, :callerName => callerName, :persistent => persistent, :features => features }
      result = request(method, call, params)
    end

    def create_invite(callerJabberId, calleeJabberId, call_id)
      method = "POST"
      call = "/calls/invite"
      params = { :callerJabberId => callerJabberId, :calleeJabberId => calleeJabberId, :call_id => call_id }
      result = request(method, call, params)
    end

    def join_call(invite_id)
      method = "POST"
      call = "/calls/join"
      params = { :invite_id => invite_id }
      result = request(method, call, params)
    end

    # Contacts API Actions =============================================================================

    def add_contact(jabberId, remoteJabberId)
      method = "POST"
      call = "/contacts/request"
      params = { :jabberId => jabberId, :remoteJabberId => remoteJabberId }
      result = request(method, call, params)
    end

    def is_friend(jabberId, remoteJabberId)
      method = "POST"
      call = "/contacts/getRelation"
      params = { :jabberId => jabberId, :remoteJabberId => remoteJabberId }
      result = request(method, call, params)
    end

    def remove_contact(jabberId, remoteJabberId)
      method = "POST"
      call = "/contacts/remove"
      params = { :jabberId => jabberId, :remoteJabberId => remoteJabberId }
      result = request(method, call, params)
    end

    def reject_contact(jabberId, remoteJabberId)
      method = "POST"
      call = "/contacts/reject"
      params = { :jabberId => jabberId, :remoteJabberId => remoteJabberId }
      result = request(method, call, params)
    end

    # Feed API actions =================================================================================

    def add_comment(posterjabberId, vmailmessageid, commenttext, vmailcontentid)
      method = "POST"
      call = "/vmail/addcomment"
      params = { :posterjabberId => posterjabberId, :vmailmessageid => vmailmessageid, :commenttext => commenttext, :vmailcontentid => vmailcontentid }
      result = request(method, call, params)
    end

    def delete_missed_call_from_feed(jabberId, invite_id)
      method = "POST"
      call = "/callevent/delete"
      params = { :jabberId => jabberId, :invite_id => invite_id }
      result = request(method, call, params)
    end

    def delete_vmail_from_feed(message_id, type)
      method = "POST"
      call = "/vmail/delete"
      params = { :message_id => message_id, :type => type }
      result = request(method, call, params)
    end

    def get_all_of_the_comments_on_a_post(message_id, start = nil, count = nil)
      method = "POST"
      call = "/vmail/getcomments"
      params = { :message_id => message_id, :start => start, :count => count }
      result = request(method, call, params)
    end

    def get_feed(jabberId, filter=nil, start=nil, count=nil, sort=nil, dateRange=nil)
      method = "POST"
      call = "/feed/getFeed"
      params = { :jabberId => jabberId, :filter => filter, :start => start, :count => count, :sort => sort, :dateRange => nil }
      result = request(method, call, params)
    end

    def get_feed_unread_count(jabberId)
      method = "POST"
      call = "/feed/unreadCount"
      params = { :jabberId => jabberId }
      result = request(method, call, params)
    end

    def mark_missed_call_as_read_in_feed(jabberId, invite_id)
      method = "POST"
      call = "/callevent/markasviewed"
      params = { :jabberId => jabberId, :invite_id => invite_id }
      result = request(method, call, params)
    end

    def mark_vmail_as_read(message_id)
      method = "POST"
      call = "/vmail/markasviewed"
      params = { :message_id => message_id }
      result = request(method, call, params)
    end

    # Token API actions ================================================================================

    def get_access_token(jabberId, password)
      method = "POST"
      call = "/auth/getAccessToken"
      params = { :jabberId => jabberId, :password => password }
      result = request(method, call, params, @api_secret)
    end

    def get_request_token(callbackUrl)
      method = "POST"
      call = "/auth/getRequestToken"
      params = { :callbackUrl => callbackUrl }
      result = request(method, call, params, @api_secret)
    end

    def validate_access_token(jabberId, accessSecret)
      method = "POST"
      call = "/auth/validateAccessToken"
      params = { :jabberId => jabberId, :accessSecret => accessSecret }
      result = request(method, call, params)#, @api_secret)
    end

    # User API actions =================================================================================

    def login_user(jabberId, secret)
      @jabberId = jabberId
      @secret = secret
    end
    
    def create_user(jabberId, secret)
      TokBoxer::User.new(jabberId, secret, self)
    end

    def create_guest_user
      method = "POST"
      call = "/users/createGuest"
      params = { :partnerKey => @api_key }
      result = request(method, call, params)
      if result['error']
        return nil # error
      else
        return create_user(result["createGuest"].first["jabberId"].first, result["createGuest"].first["secret"].first)
      end
    end

    def register_user(firstname,lastname,email)
      method = "POST"
      call = "/users/register"
      params = { :firstname => firstname, :lastname => lastname, :email => email }
      result = request(method, call, params)
      if result['error']
        return nil # error
      else
        return create_user(result["registerUser"].first["jabberId"].first, result["registerUser"].first["secret"].first)
      end
    end

    def get_user_profile(jabberId)
      @jabberId = jabberId
      method = "POST"
      call = "/users/getProfile"
      params = { :jabberId => jabberId }
      result = request(method, call, params)
    end

    # VMail API actions ================================================================================

    def forward_vmail(vmail_id, senderJabberId, text="", tokboxRecipients="", emailRecipients="")
      method = "POST"
      call = "/vmail/forward"
      params = { :vmail_id => vmail_id, :senderJabberId => senderJabberId, :text => text, :tokboxRecipients => tokboxRecipients, :emailRecipients => emailRecipients }
      result = request(method, call, params)
    end

    def forward_vmail_to_all_friends(vmail_id, senderJabberId, text="")
      method = "POST"
      call = "/vmail/forwardToFriends"
      params = { :vmail_id => vmail_id, :senderJabberId => senderJabberId, :text => text }
      result = request(method, call, params)
    end

    def get_vmail(message_id)
      method = "POST"
      call = "/vmail/getVmail"
      params = { :message_id => message_id }
      result = request(method, call, params)
    end

    def post_public_vmail(vmail_id, scope, senderJabberId, text)
      method = "POST"
      call = "/vmail/postPublic"
      params = { :vmail_id => vmail_id, :scope => scope, :senderJabberId => senderJabberId, :text => text }
      result = request(method, call, params)
    end

    def send_vmail(vmail_id, senderJabberId, text="", tokboxRecipients="", emailRecipients="")
      method = "POST"
      call = "/vmail/send"
      params = { :vmail_id => vmail_id, :senderJabberId => senderJabberId, :text => text, :tokboxRecipients => tokboxRecipients, :emailRecipients => emailRecipients }
      result = request(method, call, params)
    end

    def send_vmail_to_alL_friends(vmail_id, senderJabberId, text="")
      method = "POST"
      call = "/vmail/sendToFriends"
      params = { :vmail_id => vmail_id, :senderJabberId => senderJabberId, :text => text }
      result = request(method, call, params)
    end

    private # ==========================================================================================

    def initialize(api_key, api_secret, api_server_url = 'http://sandbox.tokbox.com/')
        @api_key = api_key
        @api_secret = api_secret
        @api_server_url = api_server_url
    end

    def generate_nonce
      (0...16).map { "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"[rand(62)] }.join
    end

    def generate_request_string(hash)
      hash.reject{ |k,v| k=~/^_/ or v.nil? or v.to_s == "" }.
               map{|k,v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}".gsub("+","%20")}.sort.join("&")
    end

    def build_signed_request(method, uri, nonce, timestamp, paramList, secret)
      signed_auth_fields = { 'oauth_partner_key'      => @api_key,
                             'oauth_signature_method' => API_SIGNATURE_METHOD,
                             'oauth_timestamp'        => timestamp,
                             'oauth_version'          => API_VERSION,
                             'oauth_nonce'            => nonce,
                             'tokbox_jabberid'        => @jabberId }.merge(paramList)
      request_string = method + "&" + uri + "&" + generate_request_string(signed_auth_fields)
      Digest::MD5.hexdigest(request_string + secret)
    end

    def request(method, apiURL, paramList, secret = nil)
      nonce = generate_nonce
      timestamp = Time.now.to_i
      request_url = @api_server_url + API_SERVER_METHODS_URL + apiURL
      authfields = { 'oauth_partner_key'      => @api_key,
                     'oauth_signature_method' => API_SIGNATURE_METHOD,
                     'oauth_timestamp'        => timestamp,
                     'oauth_version'          => API_VERSION,
                     'oauth_nonce'            => nonce,
                     'oauth_signature'        => build_signed_request(method,request_url,nonce,timestamp,paramList, secret || @secret),
                     'tokbox_jabberid'        => @jabberId }
      datastring = generate_request_string(paramList)+"&"+generate_request_string(authfields)
      datastring += '&_AUTHORIZATION='
      datastring += authfields.map{|k,v|"#{CGI.escape(k.to_s)}=\"#{CGI.escape(v.to_s)}\""}.join(",").gsub("+","%20")
      if @debug
        puts "=========================v"
        puts "Call   : #{method} #{request_url}"
        puts "Params : #{paramList.inspect}"
        puts "-------------------------"
      end
      url        = URI.parse(request_url)
      request    = Net::HTTP.new(url.host,url.port)
      response   = request.post(url.path,datastring)
      result     = response.body
      xml_result = XmlSimple.xml_in(result)
      if @debug
        pp xml_result
        puts "=========================^"  
      end
      xml_result
    end

  end

end