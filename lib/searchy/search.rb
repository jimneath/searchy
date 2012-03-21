module Searchy
  module Search
    extend ActiveSupport::Concern
    TYPES = [:string, :text]
    
    module ClassMethods
      def search(query = nil)
        if query.present?
          fields = columns.select{|c| TYPES.include?(c.type)}.map(&:name)
          command = fields.map{|f| "#{table_name}.#{f} LIKE ?"}.join(' OR ')

          where([command, *Array.new(fields.length).map{"%#{query}%"}])
        else
          scoped
        end
      end
    end
  end
end