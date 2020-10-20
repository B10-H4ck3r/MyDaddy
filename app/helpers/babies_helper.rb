module BabiesHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(baby, size: 80)
    gravatar_id  = Digest::MD5::hexdigest(baby.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: baby.name, class: "gravatar")
  end

end
