defmodule Ativar.Colors do
  def random_hexadecimal do
    random_color = generate_random_color()

    if is_light_color?(random_color) do
      random_hexadecimal()
    else
      random_color
    end
  end

  defp generate_random_color do
    :rand.uniform(16_777_215)
    |> Integer.to_string(16)
    |> String.pad_leading(6, "0")
  end

  defp is_light_color?(hex_color) when is_binary(hex_color) and byte_size(hex_color) == 6 do
    luminance = (0.299 * r(hex_color) + 0.587 * g(hex_color) + 0.114 * b(hex_color)) / 255

    luminance > 0.5
  end

  defp is_light_color?(_), do: false

  defp r(hex_color) do
    String.slice(hex_color, 0..1)
    |> String.to_integer(16)
    |> Kernel.div(256 * 256)
    |> rem(256)
    |> Kernel.-(1)
  end

  defp g(hex_color) do
    String.slice(hex_color, 2..3)
    |> String.to_integer(16)
    |> Kernel.div(256)
    |> rem(256)
    |> Kernel.-(1)
  end

  defp b(hex_color) do
    String.slice(hex_color, 4..5)
    |> String.to_integer(16)
    |> Kernel.div(1)
    |> rem(256)
    |> Kernel.-(1)
  end
end
