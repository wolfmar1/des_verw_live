defmodule DesVerwLive.Repo do
  use Ecto.Repo,
    otp_app: :des_verw_live,
    adapter: Ecto.Adapters.MyXQL
end
