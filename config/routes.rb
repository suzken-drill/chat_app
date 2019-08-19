Rails.application.routes.draw do
  get '/contact', to: 'contact#new'
  get '/contact/confirm' => redirect('/contact')
  post '/contact/confirm', to: 'contact#confirm'
  post '/contact', to: 'contact#create'
  root to: 'static_page#index'
  get '/about', to: 'static_page#about'
  get '/rule', to: 'static_page#rule'
  get '/owner', to: 'static_page#owner'
  get '/help', to: 'static_page#help'
  get '/privacy', to: 'static_page#privacy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount ActionCable.server => '/cable'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
