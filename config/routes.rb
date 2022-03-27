Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "git_hub_user_stats#index", defaults: { username: "mward-sudo" }

  get "/:username", to: "git_hub_user_stats#index"
end
