defmodule AtivarWeb.LoginLive do
  use AtivarWeb, :verified_routes
  use Phoenix.LiveView

  import AtivarWeb.CoreComponents

  @impl true
  def mount(_session, _params, socket) do
    changeset = to_form(%{"email" => nil}, as: "user")
    {:ok, assign(socket, changeset: changeset)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <link rel="stylesheet" href={~p"/assets/css/app.css"} />
    <main
      class="login-background"
      id="app"
      style="display: flex; justify-content: center; align-items: center;"
    >
      <div class="login-container">
        <.simple_form :let={f} for={@changeset} action={~p"/login"} class="login-form">
          <h1 class="title">Boas-vindas novamente!</h1>
          <.input
            field={f[:email]}
            type="email"
            label="E-mail"
            placeholder="joaodasilva@farm2trader.com"
            required
          />
          <.input field={f[:password]} type="password" label="Senha" placeholder="********" required />
          <:actions>
            <.button phx-disable-with="Acessando..." type="submit" style="primary">
              Entrar
            </.button>
          </:actions>
        </.simple_form>
      </div>
    </main>
    """
  end
end
