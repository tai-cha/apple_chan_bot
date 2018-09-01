require 'twitter'

@last_tweet_id_REST = 1
@my_id = 1004213238379130880

@client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "86tasAy3Cj8XToGE5L29opna3"
    config.consumer_secret     = "rfdrTfp5pgMmRd4OWXvCQ2UWD1i8lDEgjaqGVnJolKZUoZZJdy"
    config.access_token        = "1004213238379130880-G4HBMAy0Pb16JjskoR48KV7y4XJS9y"
    config.access_token_secret = "0SWuWZjTK0xsaKF8rvEAduwlsJlyzcpvWHqYgp8Y1zYnU"
end

@client_Stream = Twitter::Streaming::Client.new do |config|
    config.consumer_key        = "86tasAy3Cj8XToGE5L29opna3"
    config.consumer_secret     = "rfdrTfp5pgMmRd4OWXvCQ2UWD1i8lDEgjaqGVnJolKZUoZZJdy"
    config.access_token        = "1004213238379130880-G4HBMAy0Pb16JjskoR48KV7y4XJS9y"
    config.access_token_secret = "0SWuWZjTK0xsaKF8rvEAduwlsJlyzcpvWHqYgp8Y1zYnU"
end

@followers = @client.follower_ids(@my_id).take(7500)

def homeTimeline_REST
    tl_tweets= @client.home_timeline(count: 200,since_id: @last_tweet_id_REST)
    tl_tweets.reverse.each_with_index do |tweet, index|
        if index == tl_tweets.size - 1
            @last_tweet_id_REST = tweet.id
        end
        if tweet.user.protected?
            puts "\e[33m" + tweet.user.name + "\e[32m" + "[ID:" + tweet.user.screen_name + "]"
            puts "\e[0m" + tweet.text
            
            if tweet.text.include?("りんごちゃん")
                @client.update("@#{tweet.user.screen_name}\nどうしたの〜〜？？", options = {:in_reply_to_status_id => tweet.id})
            end
            if tweet.text.include?("限何時")
                @client.update("@#{tweet.user.screen_name}\n1限9:00-10:30\n2限10:45-12:15\n3限13:05-14:35\n4限14:50-16:20\n5限16:35-18:05\nですよ〜〜！！", options = {:in_reply_to_status_id => tweet.id})
            end
            if tweet.text.include?("ば終わ") || tweet.text.include?("バおわ")||tweet.text.include?("バオワ")||tweet.text.include?("ばおわ")
                @client.update("@#{tweet.user.screen_name}\nバイトおつかれさま！！今日もがんばったね！！", options = {:in_reply_to_status_id => tweet.id})
            end
        end
    end
    @followers = @client.follower_ids(@my_id).take(7500)
    sleep(60)
end


def arrayToCSV (array)
    objs = ""
    array.each_with_index do |value, index|
        if index == array.size - 1
            objs += value.to_s
            break
        end
        objs += value.to_s+","
    end
    return objs
end

def streaming
    @client_Stream.filter(follow:arrayToCSV(@followers)) do |tweet|
        if tweet.is_a?(Twitter::Tweet) &&tweet.user.id != @my_id
            puts "\e[33m" + tweet.user.name + "\e[32m" + "[ID:" + tweet.user.screen_name + "]"
            puts "\e[0m" + tweet.text
            
            if tweet.text.include?("りんごちゃん")
                @client.update("@#{tweet.user.screen_name}\nどうしたの〜〜？？", options = {:in_reply_to_status_id => tweet.id})
            end
            if tweet.text.include?("限何時")
                @client.update("@#{tweet.user.screen_name}\n1限9:00-10:30\n2限10:45-12:15\n3限13:05-14:35\n4限14:50-16:20\n5限16:35-18:05\nですよ〜〜！！", options = {:in_reply_to_status_id => tweet.id})
            end
            if tweet.text.include?("ば終わ") || tweet.text.include?("バおわ")||tweet.text.include?("バオワ")||tweet.text.include?("ばおわ")
                @client.update("@#{tweet.user.screen_name}\nバイトおつかれさま！！今日もがんばったね！！", options = {:in_reply_to_status_id => tweet.id})
            end
        end
    end 
end

fork do
    loop do
        homeTimeline_REST
    end
end

streaming
