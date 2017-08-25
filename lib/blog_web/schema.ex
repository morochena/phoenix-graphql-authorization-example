defmodule BlogWeb.Schema do
  use Absinthe.Schema
  import_types BlogWeb.Schema.Types
  use Blanka

  # anyone can see a list of posts, but they will only be able to access body, title and author's username
  authorize :posts, %{}, [:body, :title, {:user, [:username]}]
  # anyone can request a user, but will only be able to access username and posts
  authorize :user, %{}, [:username, :posts]
  # users have full access to their own user
  authorize :user, &BlogWeb.Schema.owns_resource/2  
  # only users can create posts
  authorize :create_post, %Blog.Accounts.User{}

  def owns_resource(resource, info) do
    if is_map(info.context.current_user) do
      resource.id == info.context.current_user.id
    else
      false
    end
  end

  query do
    @desc "Get all blog posts"
    field :posts, list_of(:post) do
      resolve fn attributes, info -> 
        with_auth(:posts, attributes, info, &BlogWeb.PostResolver.all/2)
      end 
    end

    @desc "Get a user of the blog"
    field :user, type: :user do
      arg :id, non_null(:id)
      resolve fn attributes, info -> 
        with_auth(:user, attributes, info, &BlogWeb.UserResolver.find/2)
      end 
    end
  end

  mutation do
    @desc "Create a post"
    field :create_post, type: :post do
      arg :title, non_null(:string)
      arg :body, non_null(:string)
  
      resolve fn attributes, info ->
        with_auth(:create_post, attributes, info, &BlogWeb.PostResolver.create/2)
      end
    end
  end

end