module TokBoxer
  
  class VMail
    
    attr_reader :id
    
    def initialize(id)
      @id = id
    end

    def to_s
      id
    end
    
  end
  
end