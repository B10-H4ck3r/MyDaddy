module BabiesHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(baby, options = { size: 80 })
    size         = options[:size]
    gravatar_id  = Digest::MD5::hexdigest(baby.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: baby.name, class: "gravatar")
  end

end
