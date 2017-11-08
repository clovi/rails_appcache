RailsAppcache::Engine.routes.draw do
  get ':manifest-:version.appcache' => 'manifests#show', format: 'appcache', constraints: { version: /-ART-([a-zA-Z0-9.]+)/ }
end
