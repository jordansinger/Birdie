class TopicsController < ApplicationController
	before_filter :set_topic, only: [:destroy]

	def index
		unless params[:query]
			render :json => Topic.all # show all topics
		else
			render :json => Topic.search(params[:query]) # search topics
		end
	end

	def create
		@topic = Topic.new(topic_params)
	end

	def load
		Topic.load_topics
	end

	def destroy
		@topic.destroy
	end

	private
	def set_topic
		@topic = Topic.find(params[:id])
	end

	def topic_params
		params.require(:topic).permit(:name, :query)
	end
end