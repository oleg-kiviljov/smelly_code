# Seed programming languages
LEXERS = %w{
C
Java
PHP
JavaScript
C++
Python
Shell
Ruby
Objective-C
C#
Perl
D
Delphi
Scala
ActionScript
ColdFusion
Lua
Pascal
Haskell
Lisp
Clojure
Erlang
 }

LEXERS.sort! {|a, z| a <=> z}

LEXERS.each do |lexer|
  Lexer.create(name: lexer)
end
p 'Seeded languages'

#10.times do
#  fq = Faq.new
#  fq.question = 'Filler question to test out faq'
#  fq.answer = 'Very long answer filled with some details about site and some other hints that may lead to better understanding of the topic itself. And this will get us more users and more money and profit muhahahahah'
#  fq.save
#end
