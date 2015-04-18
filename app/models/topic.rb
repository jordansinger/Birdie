class Topic < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  # Twitter client
  TWITTER = Twitter::REST::Client.new do |config|
    config.consumer_key = "uOkHhUZFnTKUL8yHMYVQ"
    config.consumer_secret = "pviGp2WzX7l0rhMX2G9DkeBrCya8NeoR7br1kjPgV8k"
    config.access_token = "35623579-xUvaXUafxBFEhkkowJoOTBkcT17JJr4hdaXsE5IVI"
    config.access_token_secret = "khnTAZzRbLUzjTdPwAmjdhtmBXCTBZkYVOokp61hKo"
  end

  # Fetches trends from Twitter, stores them
  def self.load_topics
    trends = TWITTER.trends
    trends.each do |trend|
      self.create(name: trend.name, query: trend.query) # store each topic
    end
  end

  # Searches data store for provided query
  def self.search(query)
    self.where(["name LIKE ?", "#{query}%"])
  end
end