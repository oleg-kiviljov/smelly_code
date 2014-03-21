# Seed programming languages
LANGUAGE_LIST = %w{ ruby python php }
LANGUAGE_LIST.each do |language|
  Language.create(name: language)
end
p 'Seeded languages'

10.times do
  fq = Faq.new
  fq.question = 'Filler question to test out faq'
  fq.answer = 'Very long answer filled with some details about site and some other hints that may lead to better understanding of the topic itself. And this will get us more users and more money and profit muhahahahah'
  fq.save
end
