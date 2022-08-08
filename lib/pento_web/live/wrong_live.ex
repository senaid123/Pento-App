defmodule PentoWeb.WrongLive do
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}

  def mount(_params, session, socket) do
    {
      :ok,
      assign(
        socket,
        score: 0,
        message: "Guess a number.",
        session_id: session["live_socket_id"]
      )
    }
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
      <h2>
          <%= @message %>
          It's  <%=time() %>
      </h2>
      <h2>
        <%= for n <- 1..10 do %>
          <a href="#" phx-click="guess" phx-value-number = {n} ><%= n %></a>
        <% end %>
    </h2>

    <button phx-click="restart" >Restart Game</button>
    """
  end

  def handle_event("restart", socket) do
    message = "Start new game"
    score = 0

    {:noreply,
     assign(socket,
       message: message,
       score: score
     )}
  end

  def handle_event("guess", %{"number" => guess} = data, socket) do
    if to_string(socket.assigns.rand_number) == guess do
      message = "Your guess: #{is_binary(guess)} is RIGHTTT!!. Guess again. "
      score = socket.assigns.score + 1

      {
        :noreply,
        assign(
          socket,
          message: message,
          score: score
        )
      }
    else
      message = "Your guess: #{guess}. Wrong. Guess again. "
      score = socket.assigns.score - 1

      {
        :noreply,
        assign(
          socket,
          message: message,
          score: score
        )
      }
    end
  end

  def time do
    DateTime.utc_now() |> to_string()
  end
end
