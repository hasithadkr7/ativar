defmodule AtivarWeb.Layouts do
  use AtivarWeb, :html

  embed_templates("layouts/*")

  def navbar(assigns) do
    ~H"""
    <nav class="nav-container">
      <img src={~p"/images/logo_horizontal.svg"} class="logo" />
      <ul class="nav-menu">
        <.link :for={{menu_name, path, icon} <- @menus} navigate={path}>
          <li class={"nav-menu-item #{if should_activate_menu_item(path, @current_path) , do: "active"}"}>
            <.lucide_icon name={icon} /> <%= menu_name %>
          </li>
        </.link>
      </ul>
    </nav>
    """
  end

  attr(:name, :atom, required: true)

  def lucide_icon(%{name: :ativar_logo} = assigns) do
    ~H"""
    <img src={~p"/images/logo_16x16.svg"} class="logo-16x16" />
    """
  end

  def lucide_icon(assigns) do
    assigns = Map.delete(assigns, :__given__)
    apply(Lucideicons, assigns.name, [assigns])
  end

  defp should_activate_menu_item(path, current_path) do
    case Regex.run(~r/(\/\w+)/, current_path) do
      [first_match, _rest] when first_match == path -> true
      _ -> false
    end
  end
end
