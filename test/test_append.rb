require "rubygems"
require "MacSpec"

class ErrorDelegate
  attr_reader :pointer
  alias_method :to_pointer, :pointer
  def initialize
    @pointer = Pointer.new_with_type '@'
  end
  def method_missing method, *args
    @pointer[0].send method, *args
  end
end

require File.dirname(__FILE__) + '/../lib/ayril'

# Goes without saying that this test is not enough, it's a start since the gemification.
#
# Also, thanks for some xml freshbooks ;)

describe "Ayril" do
  before do
    # Creating an XMLDocument must have a root element!
    @document = Ayril::XMLDocument.new('<?xml version="1.0" encoding="UTF-8"?><request method="attribute.value"></request>')
  end

  it "should parse!" do
    @document.should_not  be_nil
    @document.class.should == Ayril::XMLDocument
    lambda { 
      @document.root
    }.should_not raise_error
    @document.root.attribute['method'].should == 'attribute.value'
  end

  it "should have an NSError without a root element!" do
    error = ErrorDelegate.new
    lambda { 
      Ayril::XMLDocument.new('<?xml version="1.0" encoding="UTF-8"?>', error.to_pointer)
    }.should_not raise_error
    error.localizedDescription.should =~ /Line 1: Extra content at the end of the document/
  end

  it "should append an element" do
    lambda { 
      @document.root.append('<invoice_id>123</invoice_id>')
    }.should_not raise_error
    @document.root.text.should == "123"
  end
end