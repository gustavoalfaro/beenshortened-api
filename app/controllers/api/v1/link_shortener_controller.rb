require 'base62-rb'

module Api
  module V1
    class LinkShortenerController < ApplicationController
      GetPageTitlesJob.set(wait: 10.minutes).perform_later

      def create
        redirect_link = params[:url]
        url_parsed = URI.parse(redirect_link)

        if url_parsed.host.present?
          last_shortened_link = ShortLink.last
          last_link_id = last_shortened_link ? last_shortened_link.id : 0
          next_short_link_slug = Base62.encode(last_link_id + 1)
          ShortLink.create(slug: next_short_link_slug, redirect_link: redirect_link)
          shortened_full_url = "#{request.protocol}#{request.host_with_port}/#{next_short_link_slug}"

          render json: { 'shortURL': shortened_full_url  }, status: :ok
        else
          render json: { 'error': 'Invalid url provided'  }, status: :bad_request
        end
      end

      def show
        slug = params[:id]
        short_link = ShortLink.find_by(slug: slug)

        if short_link.nil?
          render json: { 'error': 'Could not found that URL' }, status: :not_found
        else
          short_link.access_count = short_link.access_count + 1
          short_link.save

          render json: { 'redirect_link': short_link.redirect_link }, status: :ok
        end
      end

      def top
        query_attributes = 'id, slug, redirect_link, page_title'
        top_visited_links = ShortLink.select(query_attributes).order(access_count: :desc).limit(100).as_json
        has_shortened_links = top_visited_links.length != 0
        result = has_shortened_links ? top_visited_links : 'No shortened URLs found'

        if has_shortened_links
          render json: { 'top': result  }, status: :ok
        else
          render json: { 'top': result  }, status: :not_found
        end
      end
    end
  end
end