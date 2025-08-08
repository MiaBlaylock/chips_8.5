require 'rails_helper'
require 'spec_helper'

describe Movie do
  describe 'searching Tmdb by keyword' do
    it 'calls Faraday gem' do
      expect(Faraday).to receive(:get)
      Movie.find_in_tmdb('hacker')
    end
    it 'calls Tmdb with valid API key' do
      Movie.find_in_tmdb({title: "hacker", language: "en"})
   end
  end
end
