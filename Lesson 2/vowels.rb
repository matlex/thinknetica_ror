# Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

vowels = 'aoeuiy'
alphabet = ('a'..'z')
output_hash = {}

alphabet.each_with_index do |letter, index|
  # Заносим ключ в хеш с одновременным присваиванием значения, если текущая буква является гласной.
  output_hash[letter] = index if vowels.include?(letter)
end

puts output_hash
