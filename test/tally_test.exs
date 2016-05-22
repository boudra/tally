defmodule Reports do

  use Tally.Reporter

  @sales [
    %{ amount: 12.4, currency: "GBP" },
    %{ amount: 85.3, currency: "EUR" },
    %{ amount: 15.2, currency: "EUR" },
    %{ amount: 25.1, currency: "USD" },
  ]

  def sales do
    @sales
  end

  def currency_avg(sales) do
    sales
    |> Enum.group_by(&(Map.get(&1, :currency)))
    |> Enum.map(fn({currency, sales}) ->
      [{currency, Enum.reduce(sales, 0, &(&1.amount + &2)) / Enum.count(sales)}] |> Map.new
    end)
  end

  report "sales", :sales
  report "currency averages", [ :sales, :currency_avg ]
end

defmodule TallyTest do
  use ExUnit.Case
  doctest Tally

  test "layers" do
    assert Tally.report(Reports, "sales") == Reports.sales
    assert Tally.report(Reports, "currency averages") |> Enum.count == 3
    assert Tally.report(Reports, "currency averages") == [%{"EUR" => 50.25}, %{"GBP" => 12.4}, %{"USD" => 25.1}]
  end

end
