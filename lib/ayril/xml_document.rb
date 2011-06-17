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
  class XMLDocument < NSXMLDocument
    include XMLNode::NodeManipulation
    include XMLNode::NodeTraversal

    def self.new(data, error=nil)
      path = data.dup
      path = NSURL.fileURLWithPath data.path if data.kind_of? File
      if path.kind_of? NSURL
        XMLDocument.alloc.initWithContentsOfURL path, options: 0, error: error
      elsif path.kind_of? XMLElement
        XMLDocument.alloc.initWithRootElement path
      elsif path.kind_of? String
        XMLDocument.alloc.initWithXMLString path, options: 0, error: error
      end
    end

    def self.replacementClassForClass(currentClass)
      return {
        NSXMLNode     => XMLNode,
        NSXMLElement  => XMLElement,
        NSXMLDocument => XMLDocument,
        NSXMLDTD      => XMLDTD,
        NSXMLDTDNode  => XMLDTDNode
      }[currentClass]
    end

    forward :to_s, :XMLString

    def inspect
      "#<#{self.class}:0x#{self.object_id.to_s(16)}>"
    end
  end
end