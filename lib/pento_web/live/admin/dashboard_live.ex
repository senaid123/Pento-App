defmodule PentoWeb.Admin.DashboardLive do
  use PentoWeb, :live_view

  def mount(_session, _params, socket) do
    {:ok ,socket
    |> assign(:survey_results_component_id, "survey-results")}
  end
end
