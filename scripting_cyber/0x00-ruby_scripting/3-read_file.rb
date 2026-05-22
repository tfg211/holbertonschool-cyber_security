require 'json'

def count_user_ids(path)
  data = JSON.parse(File.read(path))

  counts = Hash.new(0)

  data.each do |item|
    counts[item['userId']] += 1
  end

  counts.each do |user_id, count|
    puts "#{user_id}: #{count}"
  end
end
