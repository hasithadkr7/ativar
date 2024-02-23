defmodule Ativar.Locale do
  use Cldr,
    locales: ["pt"],
    default_locale: "pt",
    otp_app: :ativar,
    providers: [Cldr.Number, Money]
end
