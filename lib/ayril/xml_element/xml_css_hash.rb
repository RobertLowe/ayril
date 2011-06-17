module Ayril
  class XMLElement
    class XMLCSSHash < Hash
      def initialize(element)
        if not (@element = element).has_attribute? "style"
          @element.write_attribute "style", ''
        end
        css = @element.read_attribute "style"
        css.gsub(/\n/, '').split(';').invoke(:strip).compact.each do |property|
          property.split(':').tap { |p| self[p.shift] = p.join(':').strip }
        end.tap { sync }
      end

      def to_css; self.map { |k, v| "#{k}: #{v}" }.join "; " end
      alias :to_s :to_css

      def inspect; "#<#{self.class} {#{self.to_css}}>" end

      def store(k, v) super(k, v).tap { sync } end
      alias :[]= :store

      def fetch(k) super(k).tap { sync } end
      alias :[] :fetch

      def delete(k) super(k).tap { sync } end
      alias :- :delete

      def delete_if(&blk) super(&blk).tap { sync } end
      def reject!(&blk) super(&blk).tap { sync } end
      def replace(h) super(h).tap { sync } end
      def clear; super.tap { sync } end

      def merge!(h) super(h).tap { sync } end
      alias :update! :merge!
      alias :+ :merge!

      def sync
        @element.removeAttributeForName("style") and return if self.size == 0
        @element.write_attribute "style", self.to_css
      end

      alias :include? :has_key?
      alias :key? :has_key?
      alias :member? :has_key?
    end
  end
end