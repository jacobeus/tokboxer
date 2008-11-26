$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'net/http'
require 'uri'
require 'digest/md5'
#require 'rest_client'
require 'cgi'
require 'xmlsimple'
require 'pp' # just for debugging purposes

module TokBoxer
  VERSION = '0.1.1'
  
  API_SERVER_LOGIN_URL       = "view/oauth&"
  API_SERVER_METHODS_URL     = "a/v0"
  API_SERVER_CALL_WIDGET     = "vc/"
  API_SERVER_RECORDER_WIDGET = "vr/"
  API_SERVER_PLAYER_WIDGET   = "vp/"
  API_VERSION                = "1.0.0"
  API_SIGNATURE_METHOD       = "SIMPLE-MD5"
end

require 'TokBoxer/Api'
require 'TokBoxer/User'
require 'TokBoxer/Call'
require 'TokBoxer/VMail'