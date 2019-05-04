# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GetPageTitlesJob, type: :job do
  let(:job) { described_class.new }

  it 'updates the page title of a shortened link' do
    ShortLink.create(slug: '1', redirect_link: 'https://www.beenverified.com')
    job.perform
    short_link = ShortLink.last
    expect(short_link.page_title).to eq 'Background Checks, Public Records & People Search | BeenVerified'
  end
end
