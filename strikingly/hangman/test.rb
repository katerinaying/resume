require "json"
require_relative "word"

TREE = JSON.parse File.read __dir__ + '/tree.json'
WORDS = File.read(__dir__ + '/words.txt').strip.split

def guess_word word, fail
  print word, ': '

  tree = TREE[word.size.to_s]
  word = Word.new word
  while fail > 0
    c = tree.find{|k,v|k.size > 0}.first[0]
    k = word.indices(c)
    if k
      print k[0]
    else
      fail -= 1
      print "#{c}!"
    end
    tree = tree[k.to_s]
    if tree == 1 or tree == 0
      puts
      return true
    end
  end
  puts ' -- FAIL'
  false
end

all_correct = 0
100.times do
  correct = WORDS.sample(80).count do |word|
    guess_word word, 10
  end
  puts '-' * 70
  puts "correct: #{correct}/80"
  all_correct += correct
end

puts
puts '-' * 70
puts "tested 8000 samples, correct rate: #{all_correct.to_f / 80}%"