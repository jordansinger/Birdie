class Topic < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  # Twitter client
  TWITTER_CONFIG = YAML.load_file("#{Rails.root}/config/twitter.yml")
  TWITTER = Twitter::REST::Client.new do |config|
    config.consumer_key = TWITTER_CONFIG['config']['consumer_key']
    config.consumer_secret = TWITTER_CONFIG['config']['consumer_secret']
    config.access_token = TWITTER_CONFIG['config']['access_token']
    config.access_token_secret = TWITTER_CONFIG['config']['access_token_secret']
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

  # Twitter search URL for a given query
  def url
    "http://twitter.com/search/?q=" + self.query
  end

  # Return standard topic JSON
  def serializable_hash(options={})
    options = {
      :only => [:id, :name, :query], :methods => [:url]
    }.update(options)
    super(options)
  end
end
