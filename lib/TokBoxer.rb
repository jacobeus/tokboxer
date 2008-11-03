$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'digest/md5'
require 'rest_client'
require 'cgi'
require 'xmlsimple'
require 'pp' # just for debugging purposes

module TokBoxer
  VERSION = '0.0.1'
end

require 'TokBoxer/TokBox'
require 'TokBoxer/TokBoxUser'
require 'TokBoxer/TokBoxVideo'