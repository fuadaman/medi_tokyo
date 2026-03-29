Rails.application.routes.draw do

  # HOME PAGE
  # Renders the main landing page with search bar,
  # emergency banner and nearby hospital cards
  root "pages#home"

  # EMERGENCY PAGE
  # Displays tap-to-call emergency numbers (119, 110)
  # and basic first aid guidance for foreigners
  get "/emergency", to: "pages#emergency"

  # INSURANCE GUIDE PAGE
  # Explains the Japanese health insurance system
  # Covers Shakai Hoken, Kokumin Hoken and Travel Insurance
  # in plain foreigner-friendly English and Japanese
  get "/insurance-guide", to: "pages#insurance_guide"

  # LANGUAGE TOGGLE
  # Switches the UI language between English (en) and Japanese (jp)
  # :locale is a dynamic segment — e.g. /set_language/en or /set_language/jp
  # Stores the selected locale in the session
  get "/set_language/:locale", to: "application#set_language"

  # HOSPITALS
  # index → GET /hospitals
  # Lists all hospitals with search, ward filter,
  # specialty filter and insurance type filter
  #
  # show → GET /hospitals/:id
  # Shows full hospital detail including map,
  # services, specialties, insurance coverage and badges
  resources :hospitals, only: [:index, :show]

  # RAILS HEALTH CHECK
  # Built-in Rails 7 route — do not remove
  # Used by load balancers to verify the app is running
  get "up" => "rails/health#show", as: :rails_health_check

end
