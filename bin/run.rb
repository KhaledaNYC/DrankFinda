require 'rest-client'
require 'json'

require_relative '../config/environment'
require_relative '../app/runners/drank_finda_cli.rb'
require_relative '../app/data_fetchers/drank_finda_wrapper.rb'
DrankFindaCLI.new.call