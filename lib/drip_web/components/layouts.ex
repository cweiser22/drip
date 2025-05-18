defmodule DripWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.

  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is set as the default
  layout on both `use DripWeb, :controller` and
  `use DripWeb, :live_view`.
  """
  use DripWeb, :html

  import DripWeb.Components.ServerSidebar
  import DripWeb.Components.ChannelsSidebar

  embed_templates "layouts/*"
end
