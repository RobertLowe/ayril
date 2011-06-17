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
unless RUBY_ENGINE =~ /macruby/
  raise NotImplementedError, "Ayril only runs on macruby! ;)"
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

framework 'Cocoa'

# core extensions to load right away
require File.dirname(__FILE__) + '/ayril/core_ext/core_ext'

module Ayril
  autoload :Version,       'ayril/version'

  autoload :Selector,      'ayril/selector'

  autoload :XMLNode,       'ayril/xml_node'
  autoload :XMLElement,    'ayril/xml_element'
  autoload :XMLDocument,   'ayril/xml_document'

  class XMLDTD < NSXMLDTD
    include XMLNode::NodeManipulation
  end

  class XMLDTDNode < NSXMLDTDNode
    include XMLNode::NodeManipulation
  end
end

