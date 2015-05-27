defmodule Openmaize.Authenticate do
  @moduledoc """
  Module to authenticate users.

  JSON Web Tokens (JWTs) are used to authenticate the user.
  If there is no token or the token is invalid, the user will
  be redirected to the login page.

  """

  import Plug.Conn
  alias Openmaize.Config
  alias Openmaize.Token
  alias Openmaize.Tools

  @behaviour Plug

  def init(opts), do: opts

  def call(conn, _opts) do
    if "login" in conn.path_info or "logout" in conn.path_info do
      conn
    else
      handle_call(conn)
    end
  end

  defp handle_call(conn) do
    if Config.storage_method == "cookie" do
      IO.puts "cookie authentication"
      conn = fetch_cookies(conn)
      Map.get(conn.req_cookies, "access_token") |> IO.inspect |> check_token(conn)
    else
      get_req_header(conn, "authorization") |> check_token(conn)
    end
  end

  defp check_token(["Bearer " <> token], conn), do: check_token(token, conn)
  defp check_token(token, conn) when is_binary(token) do
    IO.puts "checking token"
    case Token.decode(token) do
      {:ok, data} -> assign(conn, :authenticated_user, data)
      {:error, _message} -> Tools.redirect_to_login(conn)
    end
  end
  defp check_token(_, conn), do: Tools.redirect_to_login(conn)
end
