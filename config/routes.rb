Rottenpotatoes::Application.routes.draw do
  get 'movies/search_tmdb', to: 'movies#search_tmdb'
  post 'movies/search_tmdb', to: 'movies#search_tmdb'
  post 'add_movie', to: 'movies#add_movie'

  resources :movies
  # map '/' to be a redirect to '/movies'
  root to: redirect('/movies')
end
