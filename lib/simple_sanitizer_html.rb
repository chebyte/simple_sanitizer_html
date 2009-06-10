# SimpleHtmlSanitizer
module Chebyte
  module SimpleSanitizerHtml

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def simple_sanitizer_html
        #html_escape
        include Rack::Utils
        include Chebyte::SimpleSanitizerHtml::InstanceMethods
        #filters
        before_save :sanitize_fields
      end
    end

    module InstanceMethods

      def sanitize_fields
       self.class.columns.each do |column|
         next unless (column.type == :string || column.type == :text)

         field = column.name.to_sym
         value = self[field]

         next if value.nil?

         self[field] = escape_html(value)
       end
      end

    end

  end
end

