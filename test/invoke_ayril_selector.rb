require File.dirname(__FILE__) + '/../lib/ayril'

puts Ayril::Selector.new($*[0]).xpath
