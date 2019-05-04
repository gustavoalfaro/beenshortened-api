# frozen_string_literal: true

# Model for short link creation
class ShortLink < ApplicationRecord
  validates_presence_of :slug
  validates_presence_of :redirect_link
  validate :validate_redirect_link

  scope :top, ->(top) { select(%i[id slug redirect_link page_title]).order(access_count: :desc).limit(top) }

  private

  def validate_redirect_link
    valid_url_regex = %r/^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix

    return errors.add(:redirect_link, :invalid_url) if :redirect_link.match(valid_url_regex)
  end
end
