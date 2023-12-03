# Ativar

[![lint](https://github.com/zeeetech/ativar/actions/workflows/ci.yml/badge.svg)](https://github.com/zeeetech/ativar/actions/workflows/ci.yml)

## Dependências

- `nix`
- `elixir`: `v.1.15+`
- `erlang`: OTP `v25+`
- `postgresql`: `v14+`

## Como executar

Caso tenha `direnv` e `nix` instalados, basta executar:

```sh
direnv allow
```

desta forma terá todas as dependências acima instaladas automaticamente.

Para iniciar o servidor, é necessário iniciar o postgresql primeiro, com:

```sh
postgresql
```

Em outro terminal, baixe as dependências e compile o projeto:

```sh
mix do deps.get, compile
```

E por fim, execute as migrations do banco de dados e seeds:

```sh
mix ecto.setup
```

Agora é possível iniciar o servidor com:

```sh
mix phx.server
```

```sh
iex -S mix phx.server
```

caso queria um shell integrado
