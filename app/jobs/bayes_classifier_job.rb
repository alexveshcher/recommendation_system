class BayesClassifierJob < ApplicationJob
  queue_as :default

  def perform

  end

  def self.likehood(user, video)
    bayes_classifier = NBayes::Base.new
    user.user_videos.liked.each do |v|
      bayes_classifier.train v.video.tags.split(' '), 'like'
    end
    user.user_videos.disliked.each do |v|
      bayes_classifier.train v.video.tags.split(' '), 'dislike'
    end
    bayes_classifier.classify(video.tags.split(' '))
  end

  def self.fill_recommendendations_for_user(user)
    results = []
    Video.all.each do |v|
      likehood = BayesClassifierJob.likehood(user, v)['like']
      Recommendation.create!(user: user, video: v, importance: likehood)
      results << { likehood: likehood, video_id: v.id }
    end

    # puts results.sort_by { |hsh| hsh[:likehood]  }
  end

end
