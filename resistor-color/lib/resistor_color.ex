defmodule ResistorColor do
  @moduledoc false
  @resistor_code [
    {:black,0},
    {:brown,1},
    {:red,2},
    {:orange,3},
    {:yellow,4},
    {:green,5},
    {:blue,6},
    {:violet,7},
    {:grey,8},
    {:white,9}
  ]

  @spec colors() :: list(String.t())
  def colors do
    for {key,_value} <- @resistor_code, do: Atom.to_string(key)
  end

  @spec code(String.t()) :: integer()
  def code(color) do
    String.to_atom(color)
    |> (&(@resistor_code[&1])).()
  end
end
