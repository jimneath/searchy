require 'searchy/search'
require 'searchy/version'

module Searchy
  
end

module ActiveRecord
  class Base
    include Searchy::Search
  end
end