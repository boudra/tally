defmodule Tally do

  defp do_report(module, layer, args \\ :empty) do
    apply(module, layer, [args] |> Enum.reject(&(&1 == :empty)))
  end

  def report(module, name) do
    { ^name, layers } = List.keyfind(module.__reports__, name, 0)
    Enum.reduce(layers, :empty, fn(current, acc) ->
      do_report(module, current, acc)
    end)
  end

end

defmodule Tally.Reporter do

  defmacro __before_compile__(_) do
    quote do
      def __reports__ do
        @reports
      end
    end
  end

  defmacro __using__(_) do
    quote do
      import Tally.Reporter
      Module.register_attribute(__MODULE__, :reports, accumulate: true)
      @before_compile Tally.Reporter
    end
  end

  defmacro report(name, layers) do
    layers = [ layers ] |> List.flatten
    quote do
      @reports { unquote(name), unquote(layers) }
    end
  end

end
