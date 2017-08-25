defmodule Blog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Accounts.User


  schema "users" do
    field :username, :string
    field :email, :string 
    field :token, :string

    has_many :posts, Blog.Posts.Post

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :email, :token])
    |> validate_required([:username, :email, :token])
  end
end
