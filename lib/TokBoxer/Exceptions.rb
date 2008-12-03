module TokBoxer
  class TokBoxerException < RuntimeError; end;
  class EmailAlreadyInUseException < TokBoxerException; end;
  class CouldNotConnectToTokbox < TokBoxerException; end
  class UnknownException < TokBoxerException; end;
end