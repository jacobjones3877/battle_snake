defmodule BattleSnakeServer.Snake.Api do
  alias BattleSnake.{Snake, Move}

  use HTTPoison.Base

  @spec load(BattleSnakeServer.Snake, BattleSnakeServer.Game) :: BattleSnake.Snake
  def load(snake, game) do
    url = snake.url <> "/start"

    payload = Poison.encode! %{
      game_id: game.id,
      height: game.height,
      width: game.width,
    }

    response = post! url, payload, headers

    Poison.decode!(response.body, as: %Snake{url: snake.url})
  end

  def move(snake, world) do
    url = snake.url <> "/move"

    payload = Poison.encode!(world)

    response = post! url, payload, headers

    Poison.decode!(response.body, as: %Move{})
  end

  def headers() do
    [{"content-type", "application/json"}]
  end
end
