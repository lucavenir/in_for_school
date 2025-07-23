defmodule InforschoolWeb.PageController do
  use InforschoolWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
