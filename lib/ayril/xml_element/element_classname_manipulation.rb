module Ayril
  class XMLElement
    module ElementClassnameManipulation
      def has_class_name?(class_name)
        classes = self.read_attribute "class"
        !!(classes.length > 0 and (classes == class_name or 
           classes =~ /(^|\s)#{class_name}(\s|$)/))
      end

      def add_class_name(class_name)
        if not self.has_class_name? class_name
          current = if not self.has_attribute? "class" then ''
                    else self.read_attribute("class") end
        end
        self.write_attribute "class", (current + ((current == '') ? '' : ' ') + class_name)
        self
      end

      def remove_class_name(class_name)
        return self if not self.has_attribute? "class"
        string_value = self.read_attribute("class").sub(/(^|\s+)#{class_name}(\s+|$)/, ' ').strip
        string_value == '' ? self.remove_attribute("class")
                           : self.write_attribute("class", string_value)
        self.tap { |s| s.attribute.sync; s.class_names.sync }
      end

      def toggle_class_name(class_name)
        if self.has_class_name? class_name
        then self.remove_class_name class_name
        else self.add_class_name class_name end
      end
    end
  end
end