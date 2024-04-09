defmodule AtivarWeb.UserSessionController do
  use AtivarWeb, :controller

  alias Ativar.Auth
  alias AtivarWeb.UserAuth

  def create(conn, %{"_action" => "registered"} = params) do
    create(conn, params, "Account created successfully!")
  end

  def create(conn, %{"_action" => "password_updated"} = params) do
    conn
    |> put_session(:user_return_to, ~p"/users/settings")
    |> create(params, "Password updated successfully!")
  end

  def create(conn, params) do
    create(conn, params, "Boas vindas de volta!")
  end

  defp create(conn, params, info) do
    %{"email" => email, "password" => password} = params

    if user = Auth.get_user_by_email_and_password(email, password) do
      conn
      |> put_flash(:info, info)
      |> UserAuth.log_in_user(user, params)
    else
      conn
      |> put_flash(:error, "Email ou senha inválidos")
      |> put_flash(:email, String.slice(email, 0, 160))
      |> redirect(to: ~p"/")
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Desconectado com sucesso")
    |> UserAuth.log_out_user()
  end
end