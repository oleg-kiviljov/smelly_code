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
Assembly
Perl
ASP
D
VisualBasic
Delphi
Scala
ActionScript
ColdFusion
Lua
Ada
Pascal
Haskell
Scheme
Lisp
Clojure
Erlang
Fortran
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
