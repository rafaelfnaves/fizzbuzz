defmodule FizzBuzz do
  def build(file_name) do
    # --- example  -- #

    # case File.read(file_name) do
    #   {:ok, result} -> result
    #   {:error, reason} -> reason
    # end

    # file = File.read(file_name)
    # handle_file_read(file)
    # --- end  -- #

    # Usando pipe operator
    file_name
    |> File.read()
    |> handle_file_read()
    # obs: Não é preciso passar nenhum argumento pois o resultado da função anterior passa como primeiro argumento para a segunda com o |>
    # ------ end ------ #
  end

  defp handle_file_read({:ok, result}) do
    # --- example -- #
    # list = String.split(result, ",")
    # Enum.map(list, fn number -> String.to_integer(number) end)
    # --- end  -- #

    # Refactor
    result =
      result
      |> String.split(",") #result vem como primeiro argumento e o retorno é => list
      |> Enum.map(&convert_and_evaluate_numbers/1)# list vem como primeiro argumento da funcao anterior e retorna a nova lista

    {:ok, result}
  end

  defp handle_file_read({:error, reason}), do: {:error, "Error reading the file: #{reason}"}

  defp convert_and_evaluate_numbers(elem) do
    elem
    |> String.to_integer()
    |> evaluate_numbers()
  end

  # obs: o Pattern Maching verifica a primeira funcão, se der tudo certo ele é inteligente para não ler as demais (é em sequencia)
  # Por isso se for divisivel por 3 e por 5 tem que ficar em 1 lugar
  defp evaluate_numbers(number) when rem(number, 3) == 0 and rem(number, 5) == 0, do: :fizzbuzz
  defp evaluate_numbers(number) when rem(number, 3) == 0, do: :fizz
  defp evaluate_numbers(number) when rem(number, 5) == 0, do: :buzz
  defp evaluate_numbers(number), do: number
end
