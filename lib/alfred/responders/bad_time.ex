defmodule Alfred.Responders.BadTime do
  use Hedwig.Responder

  hear ~r/bad time/i, msg do
    send msg, bad_time(:rand.uniform(4))
  end

  defp bad_time(0), do: raise "the roof"
  defp bad_time(1) do
    :timer.sleep(20000)
    "I need a coffee"
  end
  defp bad_time(2) do
    :timer.sleep(60000)
    "I'm sleepy"
  end
  defp bad_time(3), do: "I'm having a great time"
end
