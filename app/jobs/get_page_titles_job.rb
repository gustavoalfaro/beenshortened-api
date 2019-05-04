# frozen_string_literal: true

require 'pismo'

# Gets the tittle of every page in the database
class GetPageTitlesJob < ApplicationJob
  queue_as :default
  RUN_EVERY = 10.minutes

  after_perform do |job|
    self.class.set(wait: RUN_EVERY).perform_later(job.arguments.first)
  end

  def perform(*_args)
    short_links = ShortLink.where(page_title: nil)

    short_links.each do |short_link|
      document = Pismo::Document.new(short_link.redirect_link)
      short_link.page_title = document.title
      short_link.save
    rescue StandardError
      puts "Couldn't retreive page title"
    end
  end
end
