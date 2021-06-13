defmodule RumblWeb.LayoutView do
  use RumblWeb, :view

  def locale_selection(conn) do
    for locale <- Gettext.known_locales(RumblWeb.Gettext) do
      if locale == Gettext.get_locale(RumblWeb.Gettext) do
        content_tag("strong", locale)
      else
        link(locale, to: conn.request_path <> "?locale=" <> locale)
      end
    end
  end
end
