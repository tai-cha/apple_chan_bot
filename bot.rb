require 'twitter'

@last_tweet_id_REST = [(ENV['REST_last_tweet']).to_i, 1].max
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

def randomWordsWhenCalled
    random = Random.new()
    num = random.rand(0..5)
    case num
    when 0
        return "どうしたの〜〜？？"
    when 1
        return "なにか用あるの？？"
    when 2
        return "呼んだ？？"
    when 3
        return "はい！りんごちゃんです！！"
    when 4
        return "（…呼ばれた気がする…）"      
    else
        return "なになに？？"
    end
end

def randomWordsToReply
    random = Random.new()
    num = random.rand(0..15)
    case num
    when 0
        return "そうだよねー"
    when 1
        return "そうなんだ！！"
    when 2
        return "ふーん"
    when 3
        return "なるほどねーーー"
    when 4
        return "わかった！（わかってない）"      
    when 5
        return "すごい"
    when 6
        return "さすが"
    when 7
        return "知らなかった！"
    when 8
        return "それな"
    when 9
        return "わかる"
    when 10
        return "せやな"
    when 11
        return "ありがとう！！"
    when 12
        return "それ好き"
    when 13
        return "天才か？？"
    when 14
        return "それは神"
    when 15
        return "うれしい！！！！！"
    end
end

def randomWordsSleepy
    random = Random.new()
    num = random.rand(0..2)
    case num
    when 0
        return "おやすみなさい！！"
    when 1
        return "無理はしないでね！！"
    when 2
        return "はやく寝なよ！！"
    end
end

def randomWordsLike
    random = Random.new()
    num = random.rand(0..4)
    case num
    when 0
        return "好き！！"
    when 1
        return "大好き！！"
    when 2
        return "わかる！！"
    when 3
        return "めーっちゃ好き"
    when 4
        return "えーーーー"
    end
end

def randomWordsWhenThanks
    random = Random.new()
    num = random.rand(0..4)
    case num
    when 0
        return "どういたしまして！！"
    when 1
        return "えへへ..."
    when 2
        return "天才なので"
    when 3
        return "こちらこそ！！！"
    when 4
        return "うれしい！！！！"
    end
end

def responseToTweet (tweet)
    puts "\e[33m" + tweet.user.name + "\e[32m" + "[ID:" + tweet.user.screen_name + "]"
    puts "\e[0m" + tweet.text
    
    if tweet.text.include?("限何時")
        @client.update("@#{twet.user.screen_name}\n1限9:00-10:30\n2限10:45-12:15\n3限13:05-14:35\n4限14:50-16:20\n5限16:35-18:05\nですよ〜〜！！", options = {:in_reply_to_status_id => tweet.id})
    elsif tweet.text.include?("ば終わ") || tweet.text.include?("バおわ")||tweet.text.include?("バオワ")||tweet.text.include?("ばおわ")
        @client.update("@#{tweet.user.screen_name}\nバイトおつかれさま！！今日もがんばったね！！", options = {:in_reply_to_status_id => tweet.id})
    elsif tweet.text.include?("おはよう")|| tweet.text.include?("いまおきた")|| tweet.text.include?("今起きました")|| tweet.text.include?("いまおきました")
        @client.update("@#{tweet.user.screen_name}\nおはよう！！", options = {:in_reply_to_status_id => tweet.id})
    elsif tweet.text.include?("こんにちは")
        @client.update("@#{tweet.user.screen_name}\nこんにちは！！", options = {:in_reply_to_status_id => tweet.id})
    elsif tweet.text.include?("ねむい") || tweet.text.include?("眠い")
        @client.update("@#{tweet.user.screen_name}\n"+randomWordsSleepy, options = {:in_reply_to_status_id => tweet.id})
    elsif tweet.text.include?("1限チャレンジ") || tweet.text.include?("一限チャレンジ")
        @client.update("@#{tweet.user.screen_name}\nまたギリギリですか？ちゃんと学校間に合ってくださいよ？", options = {:in_reply_to_status_id => tweet.id})
    elsif tweet.text.include?("つかれた") || tweet.text.include?("疲れた")
        @client.update("@#{tweet.user.screen_name}\n今日もお疲れ様！！", options = {:in_reply_to_status_id => tweet.id})
    elsif tweet.text.include?("ちんちん") || tweet.text.include?("おっぱい") || tweet.text.include?("ちんこ") || tweet.text.include?("まんこ")
        @client.update("@#{tweet.user.screen_name}\nセクハラはよくないと思います……", options = {:in_reply_to_status_id => tweet.id})
    elsif tweet.text.include?("進捗ダメ") || tweet.text.include?("進捗ありません") || tweet.text.include?("進捗ない")
        @client.update("@#{tweet.user.screen_name}\n明日は進捗出るよ！頑張って！！", options = {:in_reply_to_status_id => tweet.id})
    elsif tweet.text.include?("りんごちゃん")
        @client.update("@#{tweet.user.screen_name}\n"+randomWordsWhenCalled, options = {:in_reply_to_status_id => tweet.id})
    elsif tweet.in_reply_to_user_id == @my_id
        if tweet.text.include?("好き")
            @client.update("@#{tweet.user.screen_name}\n"+randomWordsLike, options = {:in_reply_to_status_id => tweet.id})
        elsif tweet.text.include?("ありがと")
            @client.update("@#{tweet.user.screen_name}\n"+randomWordsWhenThanks, options = {:in_reply_to_status_id => tweet.id})
        elsif tweet.text.include?("聞いて") ||tweet.text.include?("きいて")
            @client.update("@#{tweet.user.screen_name}\n"+randomWordsWhenCalled, options = {:in_reply_to_status_id => tweet.id})
        else
            @client.update("@#{tweet.user.screen_name}\n"+randomWordsToReply, options = {:in_reply_to_status_id => tweet.id})
    end
end

def homeTimeline_REST
    tl_tweets= @client.home_timeline(count: 200,since_id: @last_tweet_id_REST)
    tl_tweets.reverse.each_with_index do |tweet, index|
        if index == tl_tweets.size - 1
            @last_tweet_id_REST = tweet.id
            ENV['REST_last_tweet'] = @last_tweet_id_REST.to_s
        end
        if tweet.user.protected?
            responseToTweet(tweet)
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
        if tweet.is_a?(Twitter::Tweet) && tweet.user.id != @my_id
            responseToTweet(tweet)
        end
    end 
end

fork do
    loop do
        homeTimeline_REST
    end
end

streaming