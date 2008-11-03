module Tokboxer
  
  class TokBoxVideo

    attr_reader :jabberId, :secret
    
    def initialize(jabberId, secret, api)
      @jabberId = jabberId
      @secret = secret
      @api = api
    end
    
  end
  
end