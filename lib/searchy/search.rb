module Searchy
  module Search
    extend ActiveSupport::Concern
    TYPES = [:string, :text]
    attr_accessor :query_parts
    
    module ClassMethods
      def search(query = nil)
        self.query = query
        search_scope
      end
      
      protected 
      
      def query=(str)
        self.query_parts = str.strip.split(/\s+/)
      end
      
      def search_scope
        query.present? ? where([search_command, *search_arguments]) : scoped
      end
      
      def search_arguments
        arguments = Array.new(searchable_columns.length).map{"%#{query}%"}
        Array.new(self.query_parts.length).map{arguments}.flatten
      end
      
      def search_command
        parts = self.query_parts.map do
          searchable_columns.map{|f| "#{table_name}.#{field} LIKE ?"}.join(' OR ')
        end
        
        parts.map{|p| "(#{p})"}.join(' AND ')
      end
      
      def searchable_columns
        self.columns.select{|c| TYPES.include?(c.type)}.map(&:name)
      end
    end
  end
end