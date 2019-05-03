class ShortLink < ApplicationRecord
    validates_presence_of :slug
    validates_presence_of :redirect_link
end
