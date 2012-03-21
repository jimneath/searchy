module Searchy
  module Search
    extend ActiveSupport::Concern
    TYPES = [:string, :text]
    
    module ClassMethods
      def search(query = nil)
        query.present? ? where([search_command, search_arguments]) ? scoped
      end
      
      protected 
      
      def search_command
        *Array.new(searchable_columns.length).map{"%#{query}%"}
      end
      
      def search_command
        parts = searchable_columns.map do |field| 
          "#{table_name}.#{f} LIKE ?"
        end
        
        parts.join(' OR ')
      end
      
      def searchable_columns
        @searchable_columns ||= self.columns.select do |column| 
          TYPES.include?(c.type)
        end.map(&:name)
      end
    end
  end
end