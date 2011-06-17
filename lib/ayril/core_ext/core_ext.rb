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

class NilClass
  def maybe(*a); self; end if not NilClass.method_defined? :maybe
  def intern; self; end if not NilClass.method_defined? :intern
end


class Object
  alias :maybe :send
end

class Module
  # MacRuby still cannot alias some Cocoa methods.
  def forward(new, old) define_method(new) { |*args| self.send old, *args } end
end


class Array
  def any?; not self.empty? end
  def invoke(*args) self.map { |item| item.send *args } end
  def invoke!(*args) self.map! { |item| item.send *args } end

  alias :send_all :invoke
  alias :send_all! :invoke!
  alias :pluck :invoke
  alias :pluck! :invoke!
end


class String
  def interpolate(object, pattern=/(^|.|\r|\n)(#\{(.*?)\})/)
    self.gsub(pattern) do |match|
      return '' if object.nil?

      before = $1 || ''
      return $2 if before == '\\'

      ctx = object; expr = $3
      pattern = /^([^.\[]+|\[((?:.*?[^\\])?)\])(\.|\[|$)/
      match = pattern.match(expr)
      return before if match.nil?
      
      while not match.nil?
        comp = match[1].start_with?('[') ? match[2].gsub('\\\\]', ']') : match[1]
        if ctx.kind_of?(Array) or ctx.kind_of?(MatchData)
          ctx = ctx[comp.to_i]
        elsif ctx.kind_of?(Hash)
          types = ctx.keys.invoke(:class)
          
          major_type = types.uniq.map do |type| 
            [type, types.find_all { |i| i == type }.length]
          end.max { |a, b| a[1] <=> b[1] }[0]
          
          method = {
            Symbol => :to_sym,
            String => :to_s
          }[major_type]

          ctx = ctx[comp.send method]
        else
          ctx = ctx[comp]
        end
        break if ctx.nil? or match[3] == ''
        expr = expr[(match[3] == '[' ? match[1].length : match[0].length)..-1]
        match = pattern.match expr
      end
      
      before + ctx.to_s
    end
  end

  def start_with?(string) self.index(string) == 0 end
  def end_with?(string) self.index(string) == (self.length - string.length) end

  def to_elem; Ayril::XMLElement.new self end
end

