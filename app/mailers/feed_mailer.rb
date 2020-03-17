class FeedMailer < ApplicationMailer
  def feed_mail(feed)
    @feed = feed
    mail to: "ten.r0619@gmail.com", subject: "投稿の確認メール"
  end
end
