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
    module ElementManipulation
      def insert(insertions)
        insertions = { :bottom => insertions } if insertions.kind_of? String or
          insertions.kind_of? Integer or insertions.kind_of? XMLElement or 
          (insertions.respond_to? :to_element or insertions.respond_to? :to_html)

        insertions.each do |position, content|
          position.downcase! if position.kind_of? String
          insert = {
            :before => lambda { |element, node|
              element.parent.insertChild node, atIndex: element.index
            },
            :top => lambda { |element, node|
              element.insertChild node, atIndex: 0
            },
            :bottom => lambda { |element, node|
              element.addChild node
            },
            :after => lambda { |element, node|
              element.parent.insertChild node, atIndex: element.index + 1
            }
          }[position = position.to_sym]

          content = content.to_element if content.respond_to? :to_element
          (insert.call(self, content); next) if content.kind_of? XMLElement

          content = content.respond_to?(:to_html) ? content.to_html : content.to_s
          children = XMLElement.alloc.initWithXMLString("<root>#{content}</root>", error: nil).children
      
          children.reverse! if position == :top or position == :after
          children.each { |child| child.detach; insert.call self, child }
        end
        self
      end

      def append(e) self.insert :bottom => e end
      def prepend(e) self.insert :top => e end

      def wrap(wrapper=nil, attributes={})
        if wrapper.kind_of? XMLElement
          wrapper.write_attribute attributes
        elsif wrapper.kind_of? String
          wrapper = XMLElement.new wrapper, attributes
        else
          wrapper = XMLElement.new 'div', attributes
        end
        self.replace wrapper if self.parent
        wrapper.addChild self
        wrapper
      end

      def identify
        id = self.read_attribute "id"
        return id unless id.nil?
        begin
          id = "anonymous_element_#{XMLElement::id_counter += 1}"
        end while !self.rootDocument.select("##{id}").empty?
        self.write_attribute "id", id
        id
      end
    end
  end
end