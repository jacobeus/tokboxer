module TokBoxer
  
  class User
    
    attr_reader :jabberId, :secret
    alias       :id :jabberId
    
    def initialize(jabberId, secret, api)
      @jabberId = jabberId
      @secret = secret
      @api = api
      self.login
    end
    
    # TODO add a method which calls get_request_token from the API
    # to get the jabberId and secret from the email and password
    
    def login
      @api.login_user(self.jabberId,self.secret)
    end
    
    def create_call(full_name,persistent=false)
      result = @api.create_call(@jabberId, full_name, persistent)
      if result['createCall'] and (createCall=result['createCall'].first)
        Call.new createCall['callerName'],
                 createCall['callId'].first,
                 createCall['callerJabberId'],
                 createCall['persistent'],
                 createCall['server'].first,
                 @api
      else
        nil
      end
    end
    
    def access_token_valid?
      result = @api.validate_access_token(@jabberId, @secret)
      result['validateAccessToken'].first["isValid"].first == "true"
    end
    
    # Feeds ============================================================================================
    
    def vmails
      @api.get_feed(@jabberId,"all")["feed"].first["item"].map do |m|
        VMail.new m["videoMail"].first["content"]["messageId"].first
      end
    end
    
    def sent_vmails
      @api.get_feed(@jabberId,"vmailSent")["feed"].first["item"].map do |m|
        VMail.new m["videoMail"].first["content"]["messageId"].first
      end
    end
    
    def received_vmails
      @api.get_feed(@jabberId,"vmailRecv")["feed"].first["item"].map do |m|
        VMail.new m["videoMail"].first["content"]["messageId"].first
      end
    end
    
    def recorder_embed_code(width="322", height="321",vmailToEmail="")
      # TODO: this comes from the PHP api. Not yet implemented here
      # if($isGuest) {
      #   $apiObj = new TokBoxApi(API_Config::PARTNER_KEY, API_Config::PARTNER_SECRET);
      #   $apiObj->updateToken($apiObj->getRequestToken(API_Config::CALLBACK_URL));
      # 
      #   $htmlCode .= "<script language=\"javascript\" src=\"SDK/js/TokBoxScript.js\"></script>\n";
      #   $htmlCode .= "<body onclick=\"setToken('".$apiObj->getAuthToken()."');\">\n";     
      # }
      <<-END
      <object width="#{width}" height="#{height}">
        <param name="movie" value="#{@api.api_server_url}#{API_SERVER_RECORDER_WIDGET}"></param>
        <param name="allowFullScreen" value="true"></param>
        <param name="allowScriptAccess" value="true"></param>
        <param name="FlashVars" value="tokboxPartnerKey=#{@api.api_key}&tokboxJid=#{jabberId}&tokboxAccessSecret=#{secret}&offsiteAuth=true&vmailToEmail=#{vmailToEmail}"></param>
        <embed id="tbx_recorder" src="#{@api.api_server_url}#{API_SERVER_RECORDER_WIDGET}"
          type="application/x-shockwave-flash"
          allowfullscreen="true"
          allowScriptAccess="always"
          width="#{width}"
          height="#{height}"
          FlashVars="tokboxPartnerKey=#{@api.api_key}&tokboxJid=#{jabberId}&tokboxAccessSecret=#{secret}&offsiteAuth=true&vmailToEmail=#{vmailToEmail}"
        >
        </embed>
      </object>
      END
    end

    def player_embed_code(messageId, width="425", height="344")
      <<-END
      <object width="#{width}" height="#{height}">

        <param name="movie" value="#{@api.api_server_url}#{API_SERVER_PLAYER_WIDGET}"></param>
        <param name="allowFullScreen" value="true"></param>
        <param name="allowScriptAccess" value="true"></param>
        <embed id="tbx_player" src="#{@api.api_server_url}#{API_SERVER_PLAYER_WIDGET}"
          type="application/x-shockwave-flash"
          allowfullscreen="true"
          allowScriptAccess="always"
          flashvars="targetVmail=#{messageId}"
          width="#{width}" 
          height="#{height}"
        >
        </embed>
      </object>
      END
    end
    
    def is_online?
      info["isOnline"].first == "true"
    end
    
    def display_name
      info["displayName"].first
    end
    
    def username
      info["username"].first
    end
    
    def userid
      info["userid"].first
    end
    
    def show
      info["show"].first
    end
    
    protected
    
    def info
      @info ||= @api.get_user_profile(self.jabberId)["getUserProfile"].first
    end
    
  end
  
end