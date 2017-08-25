defmodule BlogWeb.Context do
  @behaviour Plug

  import Plug.Conn
  import Ecto.Query, only: [where: 2]

  alias Blog.{Repo, Accounts}

  def init(opts), do: opts
  
  def call(conn, _) do
    with [token] <- get_req_header(conn, "authorization"),
    {:ok, current_user} <- authorize(token) do 
        put_private(conn, :absinthe, %{context: %{current_user: current_user}})
    else
      _ ->
        put_private(conn, :absinthe, %{context: %{current_user: nil, remote_ip: conn.remote_ip}})
    end
  end

  defp authorize(token) do
    Accounts.User
    |> where(token: ^token)
    |> Repo.one
    |> case do
      nil -> {:error, "invalid authorization token"}
      user -> {:ok, user}
    end
  end

end