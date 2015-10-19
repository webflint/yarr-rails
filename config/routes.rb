Yarr::Engine.routes.draw do
  match '/page/save', to: 'yarr#save', via: [:post, :get]
end
