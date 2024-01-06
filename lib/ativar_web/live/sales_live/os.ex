defmodule AtivarWeb.SalesLive.OS do
  use AtivarWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :os, %{title: "teste", customer: "teste"})}
  end
end
