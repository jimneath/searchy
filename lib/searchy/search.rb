module Searchy
  module Search
    extend ActiveSupport::Concern
    TYPES = [:string, :text]
    
    module ClassMethods
      def search(query = nil)
        @query = query.to_s.strip.split(/\s+/)
        search_scope
      end
      
      protected 
      
      def search_scope
        @query.present? ? where([search_command, *search_arguments]) : scoped
      end
      
      def search_arguments
        arguments = @query.map do |word|
          Array.new(searchable_columns.length).map{"%#{word}%"}
        end
        
        arguments.flatten
      end
      
      def search_command
        parts = @query.map do
          searchable_columns.map{|f| "#{table_name}.#{f} LIKE ?"}.join(' OR ')
        end
        
        parts.map{|p| "(#{p})"}.join(' AND ')
      end
      
      def searchable_columns
        self.columns.select{|c| TYPES.include?(c.type)}.map(&:name)
      end
    end
  end
end