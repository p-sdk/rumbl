defmodule RumblWeb.LocaleTest do
  use RumblWeb.ConnCase, async: true
  alias RumblWeb.Locale

  setup %{conn: conn} do
    conn =
      conn
      |> bypass_through(RumblWeb.Router, :browser)

    {:ok, %{conn: conn}}
  end

  test "gettext locale defaults to en", %{conn: conn} do
    conn
    |> get("/")
    |> Locale.call(Locale.init([]))

    assert Gettext.get_locale(RumblWeb.Gettext) == "en"
  end

  test "sets gettext locale from params", %{conn: conn} do
    conn =
      conn
      |> get("/?locale=pl")
      |> Locale.call(Locale.init([]))

    assert get_session(conn, :locale) == "pl"
    assert Gettext.get_locale(RumblWeb.Gettext) == "pl"
  end

  test "sets gettext locale from session", %{conn: conn} do
    conn
    |> get("/")
    |> put_session(:locale, "pl")
    |> Locale.call(Locale.init([]))

    assert Gettext.get_locale(RumblWeb.Gettext) == "pl"
  end
end
