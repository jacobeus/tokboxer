module TokBoxer
  
  class VMail
    
    attr_reader :id, :message_id
    
    def initialize(options={})
      @id = options[:id]
      @message_id = options[:message_id]
    end

    def to_s
      @id
    end
    
  end
  
end