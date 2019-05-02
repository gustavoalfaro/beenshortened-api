require 'base62-rb'

class LinkShortenerController < ApplicationController
	def index
		full_path = request.env['ORIGINAL_FULLPATH']
	
		if full_path[/http:\/\/|https:\/\//]
			render json: { 'shortURL': 'Here' }, status: 200
		else
			slug = params[:url]
			short_link = ShortLink.find_by(slug: slug)

			if short_link.nil?
				render json: { 'error': 'Could not found that URL' }, status: 404
			else
				redirect_to short_link.redirect_link
			end
		end
		# ShortLink.find_by(slug: )
		# puts request.env['ORIGINAL_FULLPATH'].last(-1)


		#  render json: { 'Your short url': "#{request.domain}/#{Base62.encode(8640)}" }
	end

	def top
		top_query = "SELECT * FROM short_links WHERE access_count IS NOT NULL ORDER BY access_count DESC LIMIT 100"
		short_links = ShortLink.connection.select_all(top_query).to_hash
		render json: { 'top100': short_links }
	end
end
