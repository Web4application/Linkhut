# lib/linkhut_web/router.ex

scope "/api/registry", LinkhutWeb do
  pipe_through :api

  get "/:repo/:package/versions", RegistryController, :versions
  get "/:repo/:package/:version/dependencies", RegistryController, :dependencies
end
