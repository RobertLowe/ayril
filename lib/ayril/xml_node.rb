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
  class XMLNode < NSXMLNode

    autoload :NodeManipulation, 'ayril/xml_node/node_manipulation'
    autoload :NodeTraversal,    'ayril/xml_node/node_traversal'

    include XMLNode::NodeManipulation
    include XMLNode::NodeTraversal

    # XXX: Why raise NotImplementedError? 
    #   xmldocs with text nodes failed to parse and returned nil..?
    #
    # def initWithKind(kind) raise NotImplementedError end
    # def initWithKind(kind, options: options) raise NotImplementedError end

    def self.document
      XMLDocument.alloc
    end

    def self.documentWithRootElement(element)
      XMLDocument.alloc.initWithRootElement element
    end

    def self.elementWithName(name)
      XMLElement.alloc.initWithName name
    end

    def self.elementWithName(name, stringValue: string)
      XMLElement.alloc.initWithName name, stringValue: string
    end
  
    def self.elementWithName(name, children: children, attributes: attrs)
      self.elementWithName(name).tap do |e|
        attrs.kind_of?(Hash) ? e.setAttributesAsDictionary(attrs)
                             : e.setAttributes(attrs)
        e.setChildren children
      end
    end

    def self.elementWithName(name, URI: uri)
      XMLElement.alloc.initWithName name, URI: uri
    end

    def self.attributeWithName(name, stringValue: string)
      e = XMLElement.alloc.initWithName "r"
      e.setAttributesAsDictionary name => string
      (e.attributeForName name).tap { |a| a.detach }
    end
  
    def self.attributeWithName(name, URI: uri, stringValue: string)
      self.attributeWithName(name, stringValue: string).tap do |n|
        n.URI = uri
      end
    end

    def self.textWithStringValue(string)
      d = XMLDocument.initWithXMLString "<r>#{string}</r>", options: 0, error: nil
      d.rootElement.childAtIndex(0).tap { |n| n.detach }
    end

    def self.commentWithStringValue(string)
      d = XMLDocument.alloc.initWithXMLString "<r><!--#{string}--></r>", options: 0, error: nil
      d.rootElement.childAtIndex(0).tap { |n| n.detach }
    end

    # def self.namespaceWithName(name, stringValue: string) raise NotImplementedError end
    # def self.DTDNodeWithXMLString(string) raise NotImplementedError end
    # def self.predefinedNamespaceForPrefix(prefix) raise NotImplementedError end
    # def self.processingInstructionWithName(name, stringValue: string) raise NotImplementedError end

    def kind?(kind)
      return self.kind == kind if kind.kind_of? Fixnum
      kind = kind.to_sym
      kinds = %w(invalid document element attribute namespace processing_instruction comment text DTD).invoke(:to_sym)
      if kinds.include? kind
        camelcase = kind.to_s.capitalize.gsub(/_([a-z])/) { |m| m[1].upcase }
        return self.kind == Object.const_get(:"NSXML#{camelcase}Kind")
      end
      false
    end
    alias :type? :kind?

    def doc?; self.kind == NSXMLDocumentKind end

    def elem?; self.kind == NSXMLElementKind end
    alias :element? :elem?

    def attr?; self.kind == NSXMLAttributeKind end
    alias :attribute? :attr?
  
    def namespace?; self.kind == NSXMLNamespaceKind end
    def pi?; self.kind == NSXMLProcessingInstructionKind end
    def comment?; self.kind == NSXMLCommentKind end
    def text?; self.kind == NSXMLTextKind end
    def dtd?; self.kind == NSXMLDTDKind end
  end

end