module TokBoxer
  
  class Call
    
    attr_reader :callerName, :callId, :callerJabberId, :persistent, :server
    alias       :id :callId
    
    def initialize(callerName, callId, callerJabberId, persistent, server, api)
      @callerName     = callerName
      @callId         = callId
      @callerJabberId = callerJabberId
      @persistent     = persistent
      @server         = server
      @api            = api
    end
    
    def embed_code(width="322", height="321")
      <<-END
      <object width="#{width}" height="#{height}">
          <param name="movie" value="#{@api.api_server_url}#{@api.API_SERVER_CALL_WIDGET}#{id}" />
          <param name="allowFullScreen" value="true" />
          <param name="allowScriptAccess" value="true" />
          <param name="flashVars" value="textChat=true&guestList=false&inviteButton=false" />
          <embed src="#{@api.api_server_url}#{@api.API_SERVER_CALL_WIDGET}#{id}"
                 type="application/x-shockwave-flash"
                 allowfullscreen="true"
                 allowScriptAccess="always"
                 width="#{width}"
                 height="#{height}"
                 flashvars="textChat=true&guestList=false&inviteButton=false" >
          </embed>
      </object>
      END
    end
    
    def to_s
      id
    end
    
  end
  
end