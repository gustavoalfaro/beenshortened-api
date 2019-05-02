class LinkShortenerController < ApplicationController
  def index
    puts request.env['ORIGINAL_FULLPATH'].last(-1)

    render json: { 'Your short url': "#{request.domain}/slug" }
  end
end
