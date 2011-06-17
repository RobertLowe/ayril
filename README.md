# Ayril

Ayril is an XML library in MacRuby that uses Cocoa NSXML classes. It thus has a 
very specific audience; for now, Cocoa developers on Mac OS X Leopard. This may
change in the future as MacRuby expands its targeted platforms.

Ayril subclasses all NSXML classes (with the exception of NSXMLParser) and 
enhances them with useful methods and paradigms inspired by the Prototype 
JavaScript framework and other Ruby XML libraries such as Hpricot and REXML.

MacRuby developers have had numerous options when it comes to processing XML. 
One could use REXML, the pure Ruby core library; Hpricot, the mostly-C library; 
LibXML, a Ruby binding for the libxml2 toolkit written in C; or the Cocoa NSXML 
classes, written in pure Objective-C and accessible directly through MacRuby. 
Now, developers have yet another option: Ayril, which takes advantage of the 
speed of NSXML classes and employs more Ruby-isms than the NSXML classes do.

## Copyright (C) 2009-2011 by Wilson Lee <kourge[!]gmail.com>, Robert Lowe <rob[!]iblargz.com> - MIT

* Programming by Wilson Lee on May 03, 2009
* Packaging by Robert Lowe on June 16, 2011

## Tests (not many right now):

To test sanity:

Install macruby 0.10

1. Run in a terminal: `macruby test/test_sanity.rb`

To test selectors:

Install rhino
Install macruby 0.10

1. Run in a terminal: `macruby test/test_selector.rb`

        PASS "body"
        PASS "div"
        PASS "body div"
        PASS "div p"
        PASS "div > p"
        PASS "div + p"
        PASS "div ~ p"
        PASS "div[class^=exa][class$=mple]"
        PASS "div p a"
        PASS "div, p, a"
        PASS ".note"
        PASS "div.example"
        PASS "div.dialog.emphatic"
        PASS "ul .tocline2"
        PASS "div.example, div.note"
        PASS "#title"
        PASS "h1#title"
        PASS "div #title"
        PASS "ul.toc li.tocline2"
        PASS "ul.toc > li.tocline2"
        PASS "h1#title + div > p"
        PASS "h1[id]:contains(Selectors)"
        PASS "a[href][lang][class]"
        PASS "div[class]"
        PASS "div[class=example]"
        PASS "div[class^=exa]"
        PASS "div[class$=mple]"
        PASS "div[class*=e]"
        PASS "div[class|=dialog]"
        PASS "div[class!=made_up]"
        PASS "div[class~=example]"
        PASS "div:not(.example)"
        PASS "p:contains(selectors)"
        PASS "p:nth-child(even)"
        PASS "p:nth-child(2n)"
        PASS "p:nth-child(odd)"
        PASS "p:nth-child(2n+1)"
        PASS "p:nth-child(n)"
        PASS "p:only-child"
        PASS "p:last-child"
        PASS "p:first-child"


===

TODOS:

 * Passing tests for sets of xml docs (valid, invalid and the ugly.)
 * Passing tests for utility methods
 * Handle delegation of errors

