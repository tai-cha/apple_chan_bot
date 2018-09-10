@followers_str = File.read('followers.txt')
@followers = @followers_str[2..-2].split(", ")
@followers = @followers.map(&:to_i)

puts @followers.to_s