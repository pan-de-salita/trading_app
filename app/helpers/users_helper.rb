module UsersHelper
  def identicon_for(user, grid_size_default: 5, square_size_default: 15)
    base64_identicon = RubyIdenticon.create_base64(
      user.email,
      grid_size: grid_size_default,
      square_size: square_size_default
    )
    image_tag("data:image/png;base64,#{base64_identicon}", alt: user.email,
                                                           class: 'border border-white w-25 rounded-circle')
  rescue StandardError => e
    Rails.logger.error("Failed to generate identicon for #{user}: #{e.message}")

    fallback_identicon = RubyIdenticon.create_base64(
      'default identicon',
      grid_size: grid_size_default,
      square_size: square_size_default
    )
    image_tag("data:image/png;base64,#{fallback_identicon}", alt: 'default identicon', class: 'identicon')
  end
end
