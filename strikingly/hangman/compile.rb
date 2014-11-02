require_relative "word"

def compile_tree chars, words
  if words.empty?
    return 0
  elsif chars.empty?
    return 1
  end

  c = chars.max_by do |c|
    words.count do |word|
      word.indices c
    end
  end
  chars -= [c]

  r = words.group_by do |word|
    word.indices c
  end
  if r.size == 1 and r.keys.first.nil?
    # edge case: no other chars fit
    return 0
  end
  r.keys.each do |k|
    r[k] = compile_tree(chars, r[k])
  end
  r
end

words = File.read(__dir__ + '/words.txt').downcase.strip.split
words = words.group_by(&:size)

tree = {}
words.each do |sz, list|
  puts "#{sz}: #{list.size}"
  list.map! {|w| Word.new w }
  tree[sz] = compile_tree ('a'..'z').to_a, list
end

require "json"
File.open __dir__ + '/tree.json', 'w' do |f|
  f << tree.to_json
end
