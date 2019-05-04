# frozen_string_literal: true

require 'base62-rb'

# This module is used for defining helpers
module LinkShortenerHelper
  def short_link_creation
    last_shortened_link = ShortLink.last
    last_link_id = last_shortened_link ? last_shortened_link.id : 0
    Base62.encode(last_link_id + 1)
  end
end
