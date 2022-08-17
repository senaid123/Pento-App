defmodule PentoWeb.WrongLive do
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}

  alias Pento.Accounts

  def mount(_params, session, socket) do
    random_number = Enum.random(1..10)

    socket =
      assign(socket,
        score: 0,
        session_id: session["live_socket_id"],
        random_number: random_number,
        message: "Make g guess:"
      )

    {:ok, assign(socket, score: 0, message: "Make a guess:")}
  end

  def render(assigns) do
    ~H"""
      <h1>Your score: <%= @score %></h1>
        <h2>
          <%= @message %>
        </h2>
        <h2>
          <%= for n <- 1..10 do %>
          <a href="#" phx-click="guess" phx-value-number={n} ><%= n %></a>
        <% end %>
      </h2>
      <pre>
        <%= @current_user.email %>
        <%= @session_id %>
      </pre>

      <button phx-click="restart"> Restart GAME </button>
    """
  end

  def handle_event("restart", socket) do
    message = "Here is your new game!!"
    score = 0

    socket = assign(socket, message: message, score: score)

    {:noreply, socket}
  end

  def handle_event("guess", %{"number" => guess} = data, socket) do
    case String.to_integer(guess) == socket.assigns.random_number do
      true ->
        message = "Your guess: #{guess}. Fantastic. YOU WINN!. "
        score = socket.assigns.score + 1

        socket =
          assign(socket,
            score: score,
            message: message
          )

        {:noreply, socket}

      false ->
        message = "Your guess: #{guess}. Wrong. Guess again. "
        score = socket.assigns.score - 1

        socket =
          assign(socket,
            score: score,
            message: message
          )

        {:noreply, socket}
    end
  end
end
