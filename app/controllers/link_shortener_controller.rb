require 'base62-rb'

class LinkShortenerController < ApplicationController
	def index
		full_path = request.env['ORIGINAL_FULLPATH']
	
		if full_path[/http:\/\/|https:\/\//]
			last_link_id = ShortLink.last.id
			next_short_link_slug = Base62.encode(last_link_id + 1)
			next_redirect_link = full_path.last(-1)
			ShortLink.create(slug: next_short_link_slug, redirect_link: next_redirect_link)

			render json: { 'shortURL': "#{request.domain}/#{next_short_link_slug}" }, status: 200
		else
			slug = params[:url]
			short_link = ShortLink.find_by(slug: slug)

			if short_link.nil?
				render json: { 'error': 'Could not found that URL' }, status: 404
			else
				redirect_to short_link.redirect_link
			end
		end
	end

	def top
		top_query = "SELECT * FROM short_links ORDER BY access_count DESC LIMIT 100"
		short_links = ShortLink.connection.select_all(top_query).to_hash
		render json: { 'top100': short_links }
	end
end
