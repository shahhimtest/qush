module SocialHelper
  def facebook_share_link(link)
    params = {
      u: link
    }

    "https://www.facebook.com/sharer/sharer.php?#{params.to_param}"
  end

  def twitter_share_link(link)
    params = {
      status: "#{link} @qushworth"
    }

    "https://twitter.com/home?#{params.to_param}"
  end

  def linkedin_share_link(link)
    params = {
      url: link
    }

    "https://www.linkedin.com/shareArticle?#{params.to_param}"
  end
end
