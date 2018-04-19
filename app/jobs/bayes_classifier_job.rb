class BayesClassifierJob < ApplicationJob
  queue_as :default

  def perform

  end

  def self.likehood(user, video)
    bayes_classifier = NBayes::Base.new
    user.user_videos.liked.each do |v|1
      bayes_classifier.train v.video.tags.split(' '), 'like'
    end
    user.user_videos.disliked.each do |v|
      bayes_classifier.train v.video.tags.split(' '), 'dislike'
    end
    puts bayes_classifier.classify(video.tags.split(' '))
  end
end
