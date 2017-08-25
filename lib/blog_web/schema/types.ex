defmodule BlogWeb.Schema.Types do
  use Absinthe.Schema.Notation

  @desc "A user of the blog"
  object :user do
    field :id, :id
    field :username, :string
    field :email, :string
    field :posts, list_of(:post)
  end
  
  @desc "A blog post"
  object :post do
    field :title, :string
    field :body, :string
    field :user, :user
  end
end