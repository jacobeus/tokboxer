module Tokboxer
  
  class TokBoxUser
    
    attr_reader :jabberId, :secret
    
    def initialize(jabberId, secret, api)
      @jabberId = jabberId
      @secret = secret
      @api = api
    end
    
    def generate_recorder_embed_code(width="322", height="321")
      #htmlCode = ""

      # if($isGuest) {
      #   $apiObj = new TokBoxApi(API_Config::PARTNER_KEY, API_Config::PARTNER_SECRET);
      #   $apiObj->updateToken($apiObj->getRequestToken(API_Config::CALLBACK_URL));
      # 
      #   $htmlCode .= "<script language=\"javascript\" src=\"SDK/js/TokBoxScript.js\"></script>\n";
      #   $htmlCode .= "<body onclick=\"setToken('".$apiObj->getAuthToken()."');\">\n";     
      # }

      <<-END
      <object width="#{width}" height="#{height}">
        <param name="movie" value="#{@api.api_server_url}#{api.API_SERVER_RECORDER_WIDGET}"></param>
        <param name="allowFullScreen" value="true"></param>
        <param name="allowScriptAccess" value="true"></param>
        <embed id="tbx_recorder" src="#{@api.api_server_url}#{api.API_SERVER_RECORDER_WIDGET}"
          type="application/x-shockwave-flash"
          allowfullscreen="true"
          allowScriptAccess="always"
          width="#{width}"
          height="#{height}"
        >
        </embed>
      </object>
      END
    end

    def generate_player_embed_code(messageId, width="425", height="344")
      <<-END
      <object width="#{width}" height="#{height}">

        <param name="movie" value="#{@api.api_server_url}#{api.API_SERVER_PLAYER_WIDGET}"></param>
        <param name="allowFullScreen" value="true"></param>
        <param name="allowScriptAccess" value="true"></param>
        <embed id="tbx_player" src="#{@api.api_server_url}#{api.API_SERVER_PLAYER_WIDGET}"
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
    
  end
  
end