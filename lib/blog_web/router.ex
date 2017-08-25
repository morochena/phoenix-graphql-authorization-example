defmodule BlogWeb.Router do
  use BlogWeb, :router

  pipeline :graphql do
    plug BlogWeb.Context
  end

  scope "/" do
    pipe_through :graphql

    get "/graphiql", Absinthe.Plug.GraphiQL, schema: BlogWeb.Schema
    post "/graphiql", Absinthe.Plug.GraphiQL, schema: BlogWeb.Schema
    forward "/", Absinthe.Plug, schema: BlogWeb.Schema
  end
end
