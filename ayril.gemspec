require 'lib/ayril/version'

Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=

  s.name = %q{ayril}
  s.version = "#{Ayril::Version::STRING}"
  s.authors = ["Wilson Lee", "Rob Lowe"]
  s.date = %q{2011-06-16}
  s.description = %q{An XML library for MacRuby that is built on top of Cocoa NSXML classes}
  s.email = ['kourge@gmail.com', 'rob@iblargz.com']
  s.extra_rdoc_files = [
    "LICENSE",
    "CHANGES",
    "README.md"
  ]
  s.files = [
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.md",
    "Rakefile",
    "ayril.gemspec",
    "lib/ayril.rb",
    "lib/ayril/version.rb",
    "lib/ayril/core_ext/core_ext.rb",
    "lib/ayril/selector.rb",
    "lib/ayril/xml_document.rb",
    "lib/ayril/xml_node.rb",
    "lib/ayril/xml_node/node_traversal.rb",
    "lib/ayril/xml_node/node_manipulation.rb",
    "lib/ayril/xml_element.rb",
    "lib/ayril/xml_element/element_attribute_manipulation.rb",
    "lib/ayril/xml_element/element_classname_manipulation.rb",
    "lib/ayril/xml_element/element_style_manipulation.rb",
    "lib/ayril/xml_element/element_manipulation.rb",
    "lib/ayril/xml_element/xml_attribute_hash.rb",
    "lib/ayril/xml_element/xml_css_hash.rb",
    "test/test_sanity.rb",
    "test/sanity.xml",
    "test/invoke_ayril_selector.rb",
    "test/invoke_prototype_selector.js",
    "test/selector.js",
    "test/test_selector.rb"
  ]
  s.homepage = %q{http://github.com/RobertLowe/ayril}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.4.2}
  s.summary = %q{An XML library for MacRuby built on top of Cocoa NSXML classes}
  s.add_development_dependency(%q<rake>, [">= 0"])
  s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
  s.add_development_dependency(%q<MacSpec>, ["~> 0.4.5"])
end 