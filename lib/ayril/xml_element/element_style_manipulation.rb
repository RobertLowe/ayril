module Ayril
  class XMLElement
    module ElementStyleManipulation
      def style; XMLElement::XMLCSSHash.new self end
      def style=(h) self.style.replace h end

      def get_style(prop) self.style[style] end
      def set_style(style, value) self.style[style] = value end
    end
  end
end