class TopicsController < ApplicationController
  before_filter :set_topic, only: [:destroy]
  skip_before_filter :verify_authenticity_token

  def index
    unless params[:query]
      render :json => Topic.all # show all topics
    else
      render :json => Topic.search(params[:query]) # search topics
    end
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      render :json => @topic
    else
      render :json => @topic.errors
    end
  end

  def load
    @topics = Topic.load_topics
    render :json => @topics
  end

  def destroy
    @topic.destroy
    head :no_content
  end

  private
  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:name, :query)
  end
end
