# spec/controllers/link_shortener_controller_spec.rb

require 'rails_helper'

RSpec.describe 'Link Shortener Controller', :type => :request do

    it 'is converting a valid http url to a shorten url' do
        get '/http://wwww.google.com'
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response.keys).to match_array(['shortURL'])
    end

    it 'is converting a valid https url to a shorten url' do
        get '/https://wwww.google.com'
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response.keys).to match_array(['shortURL'])
    end

    it 'is converting a long domain url to a shorten url' do
        get '/http://www.thelongestdomainnameintheworldandthensomeandthensomemoreandmore.com/'
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response.keys).to match_array(['shortURL'])
    end

    it 'makes short a url with subroutes' do
        get '/https://stackoverflow.com/questions/11828270/how-to-exit-the-vim-editor'
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response.keys).to match_array(['shortURL'])
    end
  
    it 'returns an error if request for a invalid url' do
        get '/not-found-example'
        expect(response).to have_http_status(:not_found)
        json_response = JSON.parse(response.body)
        expect(json_response.keys).to match_array(['error'])
    end

    it 'returns top 100 most visited links' do
        get '/top.json'
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)
        expect(json_response.keys).to match_array(['top100'])
    end
end