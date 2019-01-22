require 'twitter'
require 'dropbox_api'
require 'net/http'
require 'uri'
require 'json'
require 'time'
require 'date'

@my_id = 1004213238379130880

@client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "86tasAy3Cj8XToGE5L29opna3"
    config.consumer_secret     = "rfdrTfp5pgMmRd4OWXvCQ2UWD1i8lDEgjaqGVnJolKZUoZZJdy"
    config.access_token        = "1004213238379130880-G4HBMAy0Pb16JjskoR48KV7y4XJS9y"
    config.access_token_secret = "0SWuWZjTK0xsaKF8rvEAduwlsJlyzcpvWHqYgp8Y1zYnU"
end

@dropbox_client = DropboxApi::Client.new(ENV['DROPBOX_ACCESS_TOKEN'])

def randomFromArray(array)
    random = Random.new()
    return array[random.rand(0..(array.length - 1))]
end

def randomWordsWhenCalled
    strs = ["どうしたの〜〜？？", "なにか用あるの？？", "呼んだ？？", "はい！りんごちゃんです！！", "（…呼ばれた気がする…）", "なになに？？"]
    return randomFromArray(strs)
end

def randomWordsToReply
    strs = ["そうだよねー","そうなんだ！！","ふーん","なるほどねーーー","わかった！（わかってない）","すごい","さすが","知らなかった！","それな","わかる","せやな","ありがとう！！","それ好き","天才か？？","それは神","うれしい！！！！！"]
    return randomFromArray(strs)
end

def randomWordsSleepy
    strs = ["おやすみなさい！！", "無理はしないでね！！", "はやく寝なよ！！"]
    return randomFromArray(strs)
end

def randomWordsLike
    strs = ["好き！！", "大好き！！", "わかる！！", "めーっちゃ好き", "えーーーー"]
    return randomFromArray(strs)
end

def randomWordsWhenThanks
    str = ["どういたしまして！！", "えへへ...", "天才なので", "こちらこそ！！！", "うれしい！！！！"]
    return randomFromArray(strs)
end

def weather_yokohama
    uri = URI.parse('http://weather.livedoor.com/forecast/webservice/json/v1?city=140010')
    json = Net::HTTP.get(uri)
    result = JSON.parse(json)
    today_telop = result['forecasts'][0]['telop']
    tomorrow_telop = result['forecasts'][1]['telop']
    min_temp = result['forecasts'][1]['temperature']['min']['celsius']
    max_temp = result['forecasts'][1]['temperature']['max']['celsius']
    return "今日の神奈川県（横浜）の天気は#{today_telop}だよ！\n最低気温は#{min_temp}℃、最高気温は#{max_temp}℃だよ！\n明日の天気は#{tomorrow_telop}だって！！！"
end

def responseToTweet (tweet)
    if !tweet.retweeted? && !tweet.text.include?("RT @")
        puts "\e[33m" + tweet.user.name + "\e[32m" + "[ID:" + tweet.user.screen_name + "]"
        puts "\e[0m" + tweet.text
        if (!tweet.text.include?("@") || tweet.text.include?("@apple_chan_bot")) && tweet.user.screen_name != "apple_chan_bot"
            
            if tweet.text.include?("限何時")
                @client.update("@#{tweet.user.screen_name}\n1限9:00-10:30\n2限10:45-12:15\n3限13:05-14:35\n4限14:50-16:20\n5限16:35-18:05\n6限18:15~19:45\n7限19:55~21:25\nですよ〜〜！！", options = {:in_reply_to_status_id => tweet.id})
            elsif tweet.text.include?("食堂何時")
                @client.update("@#{tweet.user.screen_name}\n専修の生田キャンパスの食堂の営業時間です！\nhttp://pic.twitter.com/rVjDU4cODv", options = {:in_reply_to_status_id => tweet.id})
            elsif tweet.text.include?("ば終わ") || tweet.text.include?("バおわ")||tweet.text.include?("バオワ")||tweet.text.include?("ばおわ")
                @client.update("@#{tweet.user.screen_name}\nバイトおつかれさま！！今日もがんばったね！！", options = {:in_reply_to_status_id => tweet.id})
            elsif tweet.text.include?("おはよう")|| tweet.text.include?("いまおきた")|| tweet.text.include?("今起きました")|| tweet.text.include?("いまおきました")
                @client.update("@#{tweet.user.screen_name}\nおはよう！！", options = {:in_reply_to_status_id => tweet.id})
            elsif tweet.text == "ぽ"
                currentTime = Time.now.localtime("+09:00")
                currentHour = currentTime.strftime("%H").to_i
                if(currentHour < 4 || currentHour >= 17)
                    @client.update("@#{tweet.user.screen_name}\nおやすみ！！", options = {:in_reply_to_status_id => tweet.id})
                else
                    @client.update("@#{tweet.user.screen_name}\nおはよう！！", options = {:in_reply_to_status_id => tweet.id})
                end
            elsif tweet.text.include?("ねていい？")|| tweet.text.include?("ねていい?")
                random = Random.new()
                num = random.rand(0..1)
                case num
                when 0
                    @client.update("@#{tweet.user.screen_name}\nいいよ！！おやすみ！！", options = {:in_reply_to_status_id => tweet.id})
                when 1
                    @client.update("@#{tweet.user.screen_name}\nダメだよ！！おきて！！", options = {:in_reply_to_status_id => tweet.id})
                end
            elsif tweet.text.include?("こんにちは")
                @client.update("@#{tweet.user.screen_name}\nこんにちは！！", options = {:in_reply_to_status_id => tweet.id})
            elsif tweet.text.include?("ねむい") || tweet.text.include?("眠い")
                @client.update("@#{tweet.user.screen_name}\n"+randomWordsSleepy, options = {:in_reply_to_status_id => tweet.id})
            elsif tweet.text.include?("おやすみ")
                @client.update("@#{tweet.user.screen_name}\nおやすみ〜〜〜", options = {:in_reply_to_status_id => tweet.id})    
            elsif tweet.text.include?("絶起")
                @client.update("@#{tweet.user.screen_name}\nちゃんと起きましょうね！！！", options = {:in_reply_to_status_id => tweet.id})  
            elsif tweet.text.include?("魔剤")
                @client.update("@#{tweet.user.screen_name}\n美味しいけど飲み過ぎには注意ですよ！", options = {:in_reply_to_status_id => tweet.id})  
            elsif tweet.text.include?("1限チャレンジ") || tweet.text.include?("一限チャレンジ")
                @client.update("@#{tweet.user.screen_name}\nまたギリギリですか？ちゃんと学校間に合ってくださいよ？", options = {:in_reply_to_status_id => tweet.id})
            elsif tweet.text.include?("つかれた") || tweet.text.include?("疲れた")
                @client.update("@#{tweet.user.screen_name}\n今日もお疲れ様！！", options = {:in_reply_to_status_id => tweet.id})
            elsif tweet.text.include?("頑張る") || tweet.text.include?("がんばる")
                @client.update("@#{tweet.user.screen_name}\nがんばれ！！ファイトーーー！！", options = {:in_reply_to_status_id => tweet.id})
            elsif tweet.text.include?("ちんちん") || tweet.text.include?("おっぱい") || tweet.text.include?("ちんこ") || tweet.text.include?("まんこ")
                random = Random.new()
                num = random.rand(0..100)
                case num
                when 0..30
                    @client.update("@#{tweet.user.screen_name}\nそ、そんなエッチなこと言っちゃダメなんだからね！！！", option = {:in_reply_to_status_id => tweet.id}) 
                when 31..100
                    @client.update("@#{tweet.user.screen_name}\nセクハラはよくないと思います……", options = {:in_reply_to_status_id => tweet.id})
                end
            elsif tweet.text.include?("進捗ダメ") || tweet.text.include?("進捗ありません") || tweet.text.include?("進捗ない")
                @client.update("@#{tweet.user.screen_name}\n明日は進捗出るよ！頑張って！！", options = {:in_reply_to_status_id => tweet.id})
            elsif tweet.text.include?("バ行")
                @client.update("@#{tweet.user.screen_name}\nバイト頑張ってください！", options = {:in_reply_to_status_id => tweet.id})
            elsif tweet.text.include?("課題終わった")|| tweet.text.include?("課題おわった")
                @client.update("@#{tweet.user.screen_name}\nおつかれさま！！今日はゆっくり寝よう〜〜！", options = {:in_reply_to_status_id => tweet.id})
            elsif tweet.text.include?("りんごちゃん")
                @client.favorite(tweet, options={})
                @client.update("@#{tweet.user.screen_name}\n"+randomWordsWhenCalled, options = {:in_reply_to_status_id => tweet.id})
            elsif tweet.in_reply_to_user_id == @my_id
                @client.favorite(tweet, options={})
                if tweet.text.include?("天気")
                    @client.update("@#{tweet.user.screen_name}\n#{weather_yokohama}", options = {:in_reply_to_status_id => tweet.id})
                elsif tweet.text.include?("好き")||tweet.text.include?("すき")
                    @client.update("@#{tweet.user.screen_name}\n"+randomWordsLike, options = {:in_reply_to_status_id => tweet.id})
                elsif tweet.text.include?("ありがと")
                    @client.update("@#{tweet.user.screen_name}\n"+randomWordsWhenThanks, options = {:in_reply_to_status_id => tweet.id})
                elsif tweet.text.include?("聞いて") ||tweet.text.include?("きいて")
                    @client.update("@#{tweet.user.screen_name}\n"+randomWordsWhenCalled, options = {:in_reply_to_status_id => tweet.id})
                else
                    @client.update("@#{tweet.user.screen_name}\n"+randomWordsToReply, options = {:in_reply_to_status_id => tweet.id})
                end
            end
        end
    end
end

def homeTimeline_REST
    begin
        @last_tweet_id = "";
        @last_tweet_id_file = @dropbox_client.download "/apple_chan_bot/last_tweet_id.txt" do |chunk|
            @last_tweet_id << chunk
        end
        @last_tweet_id = @last_tweet_id.to_i

        tl_tweets= @client.home_timeline(count: 200, since_id: @last_tweet_id.to_i)
        tl_tweets.reverse.each_with_index do |tweet, index|
            if index == tl_tweets.size - 1
                @last_tweet_id = tweet.id
            end
            responseToTweet(tweet)
        end
        File.open('last_tweet_id.txt',"w") do |file|
            file.print(@last_tweet_id.to_s)
            file.close
        end
        @dropbox_client.upload(
            sprintf("%s","/apple_chan_bot/last_tweet_id.txt"),
            @last_tweet_id.to_s,
            :mode =>:overwrite
        )
    rescue
    end
    sleep(60)
    @followers = @client.follower_ids(@my_id).take(7500)
    
end

loop do
    homeTimeline_REST
end