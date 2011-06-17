require "rubygems"
require "MacSpec"

require File.dirname(__FILE__) + '/../lib/ayril'

# Goes without saying that this test is not enough, it's a start since the gemification.
#
# Also, thanks for some xml freshbooks ;)

describe "Ayril" do
  before do
    @document = Ayril::XMLDocument.new(File.read(File.dirname(__FILE__) + '/sanity.xml'))
  end

  it "should parse!" do
    @document.should_not  be_nil
    @document.class.should == Ayril::XMLDocument
  end

  it "should have selectors by css" do
    @document.select(".can_i_has_selector").first.text.should == "4"
  end

  it "should have selectors by xpath" do
    @document.select_by_xpath("//tax2_percent[@id='can_i_has_id']").first.text == "8"
  end
end