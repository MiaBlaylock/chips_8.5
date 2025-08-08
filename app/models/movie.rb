class Movie < ActiveRecord::Base
  def self.all_ratings
    %w[G PG PG-13 R]
  end

  def self.find_in_tmdb(search_terms, api_key = 'YOUR_API_KEY')
    url = "https://api.themoviedb.org/3/search/movie?api_key=#{api_key}&query=#{search_terms}"
    response = Faraday.get(url)

    return [] unless response && response.respond_to?(:body) && response.respond_to?(:success?) && response.success?
    parsed_response = JSON.parse(response.body)
    parsed_response['results']
  end


  def self.with_ratings(ratings, sort_by)
    if ratings.nil?
      all.order sort_by
    else
      where(rating: ratings.map(&:upcase)).order sort_by
    end
  end

  def self.find_in_tmdb(search_terms, api_key = 'YOUR_API_KEY')
    url = "https://api.themoviedb.org/3/search/movie?api_key=#{api_key}&query=#{search_terms}"
    
    # make api call and parse
    response = Faraday.get(url)
    data = JSON.parse(response.body)
    movies = data['results'] || []
    
    # return movies not already in database
    movies.reject { |movie| Movie.exists?(title: movie['title']) }.map do |movie|
      {
        title: movie['title'],
        rating: 'R',
        release_date: movie['release_date']
      }
    end
  end
end
