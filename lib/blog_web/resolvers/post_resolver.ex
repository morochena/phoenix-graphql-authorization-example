defmodule BlogWeb.PostResolver do
  def all(_args, _info) do
    {:ok, Blog.Posts.list_posts}
  end

  def create(args, info) do
    user_id = info.context.current_user.id
    args = Map.put(args, :user_id, user_id)

    Blog.Posts.create_post(args)
  end
end