defmodule Inforschool.Accounts do
  use Ash.Domain, otp_app: :inforschool, extensions: [AshAdmin.Domain]

  admin do
    show? true
  end

  resources do
    resource Inforschool.Accounts.Token
    resource Inforschool.Accounts.User
  end
end
