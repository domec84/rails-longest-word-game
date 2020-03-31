Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/game', to: 'longest_word#game', as: :game
  get '/score', to: 'longest_word#score', as: :score
end
