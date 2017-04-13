require 'active_resource'

require_relative 'collections/base'
require_relative 'user'
require_relative 'group'

module RedmineRest
  module Models
    #
    # Wiki model
    #
    class Wiki < ActiveResource::Base
      self.format = :xml
      self.collection_parser = Collections::Base
      self.prefix = '/projects/:project_id/'

      #
      # Overrides parent method.
      # When we want to fetch one wiki, we need not to use prefix
      #
      def self.element_path(id, prefix_options = {}, query_options = nil)
        check_prefix_options(prefix_options)
        prefix_options, query_options = split_options(prefix_options) if query_options.nil?
        "#{prefix(prefix_options)}#{collection_name}/#{URI.parser.escape id.to_s}.#{format.extension}#{query_string(query_options)}"
      end
      
      def self.collection_path(prefix_options = {}, query_options = nil)
        check_prefix_options(prefix_options)
        prefix_options, query_options = split_options(prefix_options) if query_options.nil?
        "#{prefix(prefix_options)}wiki/index.#{format.extension}#{query_string(query_options)}"
      end
    end
  end
end
