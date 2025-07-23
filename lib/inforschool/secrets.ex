defmodule Inforschool.Secrets do
  use AshAuthentication.Secret

  def secret_for(
        [:authentication, :tokens, :signing_secret],
        Inforschool.Accounts.User,
        _opts,
        _context
      ) do
    Application.fetch_env(:inforschool, :token_signing_secret)
  end
end
