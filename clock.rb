require 'clockwork'
require './bot.rb'
require 'active_support/all'
require 'time'
include Clockwork

every(1.minute, 'upTweet.job') do
    homeTimeline_REST
    checkFollowers
end