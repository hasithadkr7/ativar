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
alias Ativar.Logistica.{Carregamento, Galpao, Transporte}
alias Ativar.Repo
alias Ativar.Vendas.Registro

Ativar.Auth.register_user(%{
  email: "john@example.com",
  name: "John Doe",
  password: "Senha!123",
  password_confirmation: "Senha!123"
})

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
  importador_id: cliente.id,
  cotacao_venda: 1_000.0,
  cotacao_recebimento: 900.0
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

transporte_attrs = %{
  origem: "A",
  destino: "B",
  tipo: :aereo,
  registro_id: registro.id
}

transporte_attrs
|> Transporte.changeset()
|> Repo.insert!()

galpao_attrs = %{
  nome: "Teste",
  responsavel: "Fulano",
  global_gap: "ABC"
}

galpao =
  galpao_attrs
  |> Galpao.changeset()
  |> Repo.insert!()

carregamento_attrs = %{
  data: DateTime.utc_now(),
  numero_pallets: 10,
  numero_caixas: 100,
  peso_bruto: 1_000.0,
  peso_liquido: 957.0,
  embalagem: 1_000.0,
  galpao_id: galpao.id,
  registro_id: registro.id,
  termo: %{
    valor_total: 1_000.0,
    moeda: :BRL,
    registro_id: registro.id,
    parcelas: [
      %{
        valor: 1_000.0,
        porcentagem: 10.0,
        data_vencimento: DateTime.utc_now(),
        comentario: "1111",
        status: :pendente
      }
    ]
  }
}

carregamento_attrs
|> Carregamento.changeset()
|> Repo.insert!()
