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
  class XMLElement
    module ElementAttributeManipulation
      def attribute
        @attributes.nil? ? (@attributes = XMLElement::XMLAttributeHash.new self) : @attributes
      end
      alias :attr :attribute

      def attribute=(hash); self.setAttributesAsDictionary hash end
      alias :attr= :attribute=
      alias :set :attribute=

      def read_attribute(k); self.attributeForName(k.to_s).maybe(:stringValue) end
      alias :get_attribute :read_attribute
      alias :[] :read_attribute

      def write_attribute(k, v=nil)
        if v.nil? and k.kind_of? Hash
          k.each { |a, b| self.write_attribute a.to_s, b } unless k.empty?
          return self
        end
        attr = self.attributeForName(k)
        if attr.nil?
          self.addAttribute XMLNode.attributeWithName(k.to_s, stringValue: v)
        else
          attr.stringValue = v
        end
        self
      end
      alias :add_attribute :write_attribute
      alias :set_attribute :write_attribute
      alias :[]= :write_attribute

      def remove_attribute(a) self.removeAttributeForName(a.to_s); self.sync end
      alias :delete_attribute :remove_attribute

      def has_attribute?(k); not self.attributeForName(k.to_s).nil? end
    end
  end
end

