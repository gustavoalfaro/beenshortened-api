# spec/controllers/api/v1/link_shortener_controller_spec.rb

require 'rails_helper'

RSpec.describe Api::V1::LinkShortenerController, :type => :request do
    it 'is converting a valid http url to a shorten url' do
        test_url = 'http://wwww.google.com'
        ShortLink.create(slug: '1', redirect_link: test_url)

        post '/api/v1/link_shortener', params: { url: test_url }
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response.keys).to match_array(['shortURL'])
    end

    it 'is converting a valid https url to a shorten url' do
        test_url = 'https://wwww.google.com'
        ShortLink.create(slug: '1', redirect_link: test_url)

        post '/api/v1/link_shortener', params: { url: test_url }
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response.keys).to match_array(['shortURL'])
    end

    it 'is converting a long domain url to a shorten url' do
        test_url = 'http://www.thelongestdomainnameintheworldandthensomeandthensomemoreandmore.com/'
        ShortLink.create(slug: '1', redirect_link: test_url )

        post '/api/v1/link_shortener', params: { url: test_url }
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response.keys).to match_array(['shortURL'])
    end

    it 'makes short a url with subroutes' do
        test_url = 'https://stackoverflow.com/questions/11828270/how-to-exit-the-vim-editor'
        ShortLink.create(slug: '1', redirect_link: test_url )

        post '/api/v1/link_shortener', params: { url: test_url }

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response.keys).to match_array(['shortURL'])
    end
  
    it 'returns an error if request for a invalid url' do
        get '/api/v1/link_shortener/not-valid-slug'
        
        expect(response).to have_http_status(:not_found)
        json_response = JSON.parse(response.body)
        expect(json_response.keys).to match_array(['error'])
    end
    
    it 'returns top 100 most visited links' do
        test_url = 'http://wwww.google.com'
        ShortLink.create(slug: '1', redirect_link: test_url )

        get '/api/v1/link_shortener/top'

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response.keys).to match_array(['top'])
    end

    it 'request to a valid shorten url and redirects to the right url' do
        test_url = 'http://wwww.google.com'
        ShortLink.create(slug: '1', redirect_link: test_url )
        
        get '/api/v1/link_shortener/1'
        
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response.keys).to match_array(['redirect_link'])
    end
end