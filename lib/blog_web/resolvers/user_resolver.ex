defmodule BlogWeb.UserResolver do
  def find(%{id: id}, _info) do
    case Blog.Accounts.get_user(id) do
      nil  -> {:error, "User id #{id} not found"}
      user -> {:ok, user}
    end
  end
end