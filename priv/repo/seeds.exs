# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Ativar.Repo.insert!(%Ativar.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Ativar.Shared.{Cliente, Endereco}
alias Ativar.Faturamento.{Banco, Invoice}
alias Ativar.Repo
alias Ativar.Vendas.Registro

endereco_attrs = %{
  rua: "Rua Teste",
  pais: "Teste do Sul",
  estado: "Teste",
  cidade: "Teste",
  codigo_postal: "1111",
  numero: "123"
}

endereco =
  endereco_attrs
  |> Endereco.changeset()
  |> Repo.insert!()

cliente_attrs = %{
  email_principal: "teste@teste.com",
  nome: "Teste",
  telefone: "9999999",
  registro: "Teste",
  acronimo: "Teste",
  endereco: Map.from_struct(endereco)
}

cliente =
  cliente_attrs
  |> Cliente.changeset()
  |> Repo.insert!()

banco_attrs = %{
  nome: "Banco Teste",
  agencia: "0001",
  swift: "ABC",
  iban: "0101",
  conta: "9999"
}

banco =
  banco_attrs
  |> Banco.changeset()
  |> Repo.insert!()

registro_attrs = %{
  nota_fiscal: "ABC",
  prazo_chegada: DateTime.utc_now(),
  data_partida: DateTime.utc_now(),
  data_chegada: DateTime.utc_now(),
  incoterm: :fob,
  documento: :sem_fito,
  produto: :baby_ginger,
  importador_id: cliente.id
}

registro =
  registro_attrs
  |> Registro.changeset()
  |> Repo.insert!()

invoice_attrs = %{
  codigo: "ATV",
  pagador_id: cliente.id,
  banco_recebedor_id: banco.id,
  banco_intermediario_id: banco.id,
  notificador_id: cliente.id,
  registro_id: registro.id
}

invoice_attrs
|> Invoice.changeset()
|> Repo.insert!()
