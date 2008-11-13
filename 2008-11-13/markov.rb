require 'enumerator'

words = File.read('source.txt').split

# => ['a', 'ball', 'a', 'ball', 'a', 'red', 'ball']

counts = Hash.new do |hash, key|
  hash[key] = Hash.new(0)
end

words.each_cons(2) do |first, second|
  counts[first][second] += 1
end

# => {'a'    => {'ball' => 2, 'red' => 1},
#     'red'  => {'ball' => 1},
#     'ball' => {'a' => 2}}

choices = {}
counts.each do |word, succ|
  choices[word] = succ.inject([]) do |memo, obj|
    item, times = obj
    memo + ([item] * times)
  end
end

# => {'a'    => ['ball', 'ball', 'red'],
#     'red'  => ['ball'],
#     'ball' => ['a', 'a']}

victim = words.first

50.times do
  print victim + ' '
  candidates = choices[victim] || [words.first]
  victim = candidates[rand(candidates.length)]
end

puts
