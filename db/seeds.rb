# Seed programming languages
LANGUAGE_LIST = %w{ ruby python php }
LANGUAGE_LIST.each do |language|
  Language.create(name: language)
end
p 'Seeded languages'