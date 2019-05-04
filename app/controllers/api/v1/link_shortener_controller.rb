# frozen_string_literal: true

module Api
  module V1
    # Creates optimal short links and shows the most used
    class LinkShortenerController < ApplicationController
      include LinkShortenerHelper
      GetPageTitlesJob.set(wait: 10.seconds).perform_later

      def create
        redirect_link = params[:url]
        url_parsed = URI.parse(redirect_link)

        if url_parsed.host.present?
          link_shortened = short_link_creation
          ShortLink.create(slug: link_shortened, redirect_link: redirect_link)
          host_url = "#{request.protocol}#{request.host_with_port}/api/v1/link_shortener/"
          full_shortened_link = "#{host_url}#{link_shortened}"

          render json: { 'shortURL': full_shortened_link }, status: :ok
        else
          render json: { 'error': 'Invalid url provided' }, status: :bad_request
        end
      end

      def show
        slug = params[:id]
        short_link = ShortLink.find_by(slug: slug)

        if short_link.blank?
          render json: { 'error': 'Could not found that URL' }, status: :not_found
        else
          short_link.access_count = short_link.access_count + 1
          short_link.save

          render json: { 'redirect_link': short_link.redirect_link }, status: :ok
        end
      end

      def top
        top_visited_links = ShortLink.top(100).as_json
        has_shortened_links = top_visited_links.any?
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
