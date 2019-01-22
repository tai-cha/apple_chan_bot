require 'twitter'
require 'dropbox_api'
require 'net/http'
require 'uri'
require 'json'
require 'time'
require 'date'

MY_ID = ENV['MY_ID'].to_i

@client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['TWITTER_CK']
    config.consumer_secret     = ENV['TWITTER_CS']
    config.access_token        = ENV['TWITTER_TOKEN']
    config.access_token_secret = ENV['TWITTER_SECRET']
end

@dropbox_client = DropboxApi::Client.new(ENV['DROPBOX_ACCESS_TOKEN'])

WHEN_CALLED = ["どうしたの〜〜？？", "なにか用あるの？？", "呼んだ？？", "はい！りんごちゃんです！！", "（…呼ばれた気がする…）", "なになに？？"].freeze
WHEN_REPLYED = ["そうだよねー","そうなんだ！！","ふーん","なるほどねーーー","わかった！（わかってない）","すごい","さすが","知らなかった！","それな","わかる","せやな","ありがとう！！","それ好き","天才か？？","それは神","うれしい！！！！！"].freeze
WHEN_SLEEPY = ["大丈夫？", "無理はしないでね！！"].freeze
WHEN_LIKE = ["好き！！", "大好き！！", "わかる！！", "めーっちゃ好き", "えーーーー"].freeze
WHEN_THANKS = ["どういたしまして！！", "えへへ...", "天才なので", "こちらこそ！！！", "うれしい！！！！"].freeze

def randomFromArray(array)
    random = Random.new()
    return array[random.rand(0..(array.length - 1))]
end

def reply(tweet,message="")
    tweet_text = "@#{tweet.user.screen_name}\n#{message}"
    @client.update(tweet_text, options = {:in_reply_to_status_id => tweet.id})
end

def weather_yokohama
    uri = URI.parse('http://weather.livedoor.com/forecast/webservice/json/v1?city=140010')
    json = Net::HTTP.get(uri)
    result = JSON.parse(json)
    today_telop = result['forecasts'][0]['telop']
    tomorrow_telop = result['forecasts'][1]['telop']
    min_temp = result['forecasts'][0]['temperature']['min']['celsius']
    max_temp = result['forecasts'][0]['temperature']['max']['celsius']
    return "今日の神奈川県（横浜）の天気は#{today_telop}だよ！\n最低気温は#{min_temp}℃、最高気温は#{max_temp}℃だよ！\n明日の天気は#{tomorrow_telop}だって！！！"
end

def responseToTweet (tweet)
    if !tweet.retweeted? && !tweet.text.include?("RT @")
        puts "\e[33m" + tweet.user.name + "\e[32m" + "[ID:" + tweet.user.screen_name + "]"
        puts "\e[0m" + tweet.text
        if (!tweet.text.include?("@") || tweet.text.include?("@apple_chan_bot")) && tweet.user.screen_name != "apple_chan_bot"
            
            if tweet.text.include?("限何時")
                reply(tweet, "1限9:00-10:30\n2限10:45-12:15\n3限13:05-14:35\n4限14:50-16:20\n5限16:35-18:05\n6限18:15~19:45\n7限19:55~21:25\nですよ〜〜！！")
            elsif tweet.text.include?("食堂何時")
                reply(tweet, "専修の生田キャンパスの食堂の営業時間です！\nhttp://pic.twitter.com/rVjDU4cODv")
            elsif tweet.text.include?("ば終わ") || tweet.text.include?("バおわ")||tweet.text.include?("バオワ")||tweet.text.include?("ばおわ")
                reply(tweet, "バイトおつかれさま！！今日もがんばったね！！")
            elsif tweet.text.include?("おはよう")|| tweet.text.include?("いまおきた")|| tweet.text.include?("今起きました")|| tweet.text.include?("いまおきました")
                reply(tweet, "おはよう！！")
            elsif tweet.text == "ぽ"
                currentTime = Time.now.localtime("+09:00")
                currentHour = currentTime.strftime("%H").to_i
                if(currentHour < 4 || currentHour >= 17)
                    reply(tweet, "おやすみ！！")
                else
                    reply(tweet, "おはよう！！")
                end
            elsif tweet.text.include?("ねていい？")|| tweet.text.include?("ねていい?")
                random = Random.new()
                num = random.rand(0..1)
                case num
                when 0
                    reply(tweet, "いいよ！！おやすみ！！")
                when 1
                    reply(tweet, "ダメだよ！！おきて！！")
                end
            elsif tweet.text.include?("こんにちは")
                reply(tweet, "こんにちは！！")
            elsif tweet.text.include?("ねむい") || tweet.text.include?("眠い")
                reply(tweet, randomFromArray(WHEN_SLEEPY))
            elsif tweet.text.include?("おやすみ")
                reply(tweet, "おやすみ〜〜〜")    
            elsif tweet.text.include?("絶起")
                reply(tweet, "ちゃんと起きましょうね！！！")  
            elsif tweet.text.include?("魔剤")
                reply(tweet, "美味しいけど飲み過ぎには注意ですよ！")  
            elsif tweet.text.include?("1限チャレンジ") || tweet.text.include?("一限チャレンジ")
                reply(tweet, "またギリギリですか？ちゃんと学校間に合ってくださいよ？")
            elsif tweet.text.include?("つかれた") || tweet.text.include?("疲れた")
                reply(tweet, "今日もお疲れ様！！")
            elsif tweet.text.include?("頑張る") || tweet.text.include?("がんばる")
                reply(tweet, "がんばれ！！ファイトーーー！！")
            elsif tweet.text.include?("ちんちん") || tweet.text.include?("おっぱい") || tweet.text.include?("ちんこ") || tweet.text.include?("まんこ")
                random = Random.new()
                num = random.rand(0..100)
                case num
                when 0..30
                    reply(tweet, "そ、そんなエッチなこと言っちゃダメなんだからね！！！", option = {:in_reply_to_status_id => tweet.id}) 
                when 31..100
                    reply(tweet, "セクハラはよくないと思います……")
                end
            elsif tweet.text.include?("進捗ダメ") || tweet.text.include?("進捗ありません") || tweet.text.include?("進捗ない")
                reply(tweet, "明日は進捗出るよ！頑張って！！")
            elsif tweet.text.include?("バ行")
                reply(tweet, "バイト頑張ってください！")
            elsif tweet.text.include?("課題終わった")|| tweet.text.include?("課題おわった")
                reply(tweet, "おつかれさま！！今日はゆっくり寝よう〜〜！")
            elsif tweet.text.include?("りんごちゃん") && tweet.text.include?("お前もそう思うだろ")
                @client.favorite(tweet, options={})
                reply(tweet, "そうなのだ！！！")
            elsif tweet.text.include?("りんごちゃん")
                @client.favorite(tweet, options={})
                reply(tweet, randomFromArray(WHEN_CALLED))
            elsif tweet.in_reply_to_user_id == MY_ID
                @client.favorite(tweet, options={})
                if tweet.text.include?("天気")
                    reply(tweet, weather_yokohama)
                elsif tweet.text.include?("好き")||tweet.text.include?("すき")
                    reply(tweet, randomFromArray(WHEN_LIKE))
                elsif tweet.text.include?("ありがと")
                    reply(tweet, randomFromArray(WHEN_THANKS))
                elsif tweet.text.include?("聞いて") ||tweet.text.include?("きいて")
                    reply(tweet, randomFromArray(WHEN_CALLED))
                else
                    reply(tweet, randomFromArray(WHEN_REPLYED))
                end
            end
        end
    end
end

def homeTimeline_REST
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

    @dropbox_client.upload(
        sprintf("%s","/apple_chan_bot/last_tweet_id.txt"),
        @last_tweet_id.to_s,
        :mode =>:overwrite
    )
    sleep(60)
    checkFollowers
end

def checkFollowers
    current_followers = @client.follower_ids(MY_ID).take(7500)
    older_followers = ""
    last_tweet_id_file = @dropbox_client.download "/apple_chan_bot/followers.txt" do |chunk|
        older_followers << chunk
    end
    older_followers = older_followers.gsub("[","").gsub("]","").split(", ").map(&:to_i)
    newFollowers = current_followers - older_followers
    unFollowed = older_followers - current_followers

    @client.follow(newFollowers)
    @client.unfollow(unFollowed)

    @dropbox_client.upload(
        sprintf("%s","/apple_chan_bot/followers.txt"),
        current_followers.to_s,
        :mode =>:overwrite
    )
end

loop do
    homeTimeline_REST
end