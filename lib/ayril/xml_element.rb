# Copyright (C) 2011 by Wilson Lee <kourge[!]gmail.com>, Robert Lowe <rob[!]iblargz.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

module Ayril
  class XMLElement < NSXMLElement

    autoload :XMLCSSHash,                   'ayril/xml_element/xml_css_hash'
    autoload :XMLAttributeHash,             'ayril/xml_element/xml_attribute_hash'

    autoload :ElementManipulation,          'ayril/xml_element/element_manipulation'
    autoload :ElementAttributeManipulation, 'ayril/xml_element/element_attribute_manipulation'
    autoload :ElementClassnameManipulation, 'ayril/xml_element/element_classname_manipulation'
    autoload :ElementStyleManipulation,     'ayril/xml_element/element_style_manipulation'

    include XMLNode::NodeManipulation
    include XMLNode::NodeTraversal

    include ElementManipulation
    include ElementAttributeManipulation
    include ElementClassnameManipulation
    include ElementStyleManipulation

    @@id_counter = 0
    attr_accessor :id_counter

    def self.new(name, attributes={})
      if attributes.empty? and name.include? "<"
        self.alloc.initWithXMLString name, error: nil
      else
        XMLNode.elementWithName name, children: nil, attributes: attributes
      end
    end

    def kind; NSXMLElementKind end

    def initWithName(name)
      self.class.alloc.tap { |e| e.name = name }
    end

    def initWithName(name, stringValue: string)
      self.initWithName(name).tap { |e| e.stringValue = string }
    end

    def initWithName(name, URI: uri)
     self.initWithName(name).tap { |e| e.URI = uri }
    end

    def initWithXMLString(string, error: error)
      d = XMLDocument.alloc.initWithXMLString(string, options: 0, error: nil)
      d.maybe(:rootElement).tap { |n| n.maybe :detach }
    end

    def inspect
      attributes = self.attribute.tap { |a| a.sync }
      "#<#{self.class}<#{self.name}#{attributes.maybe(:empty?) ? '' : ' '}#{attributes}>>"
    end
  end
end