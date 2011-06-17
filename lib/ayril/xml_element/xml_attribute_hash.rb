module Ayril
  class XMLElement
    class XMLAttributeHash < Hash
      def initialize(element)
        @element = element
        self.sync
      end

      def sync
        cache = {}
        @element.attributes.each { |a| cache[a.name] = a.stringValue } if not @element.attributes.nil?
        self.delete_if { true }.merge! cache
      end

      def store(k, v)
        attr = @element.attributeForName k
        if not attr.nil?
          attr.stringValue = v
        else
          @element.addAttribute XMLNode.attributeWithName(k, stringValue: v)
        end
        super k, v
      end
      alias :set :store
      alias :[]= :store

      def fetch(k); @element.attributeForName(k).maybe :stringValue end
      alias :get :fetch
      alias :[] :fetch

      def has_key?(k); not @element.attributeForName(k).nil? end
      alias :has? :has_key?
      alias :include? :has_key?
      alias :key? :has_key?
      alias :member? :has_key?

      def delete(k); @element.removeAttributeForName k; super k end
      alias :remove :delete
      alias :- :delete

      def _delete_if(&blk); self.each { |k, v| self.delete k if blk.call k, v } end
      def delete_if(&blk); self._delete_if &blk; self end

      def reject!(&blk)
        old = self.dup; self._delete_if &blk
        (self == old) ? nil : self
      end

      def replace(hash); @element.setAttributesAsDictionary hash; super hash end
      def clear; self.replace {} end

      def merge!(hash); hash.each { |k, v| self[k] = v }; self end
      alias :update! :merge!
      alias :+ :merge!

      def to_s; self.map { |k, v| "#{k}=\"#{v}\"" }.join ' ' end
      def inspect; "#<#{self.class} #{self.to_s}>" end
    end
  end
end