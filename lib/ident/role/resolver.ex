defmodule Rivet.Ident.Role.Resolver do
  @moduledoc false
  alias Rivet.Ident
  alias Rivet.Auth

  def query_roles(%{name: name}, info) do
    with {:ok, _} <- Auth.authz_action(info, %Auth.Assertion{action: :user_admin}, "listRoles"),
         {:ok, role} <- Ident.Role.one(name: name) do
      {:ok, [role]}
    else
      _ -> {:error, "cannot find role: #{name}"}
    end
  end

  def query_roles(_args, info) do
    with {:ok, _} <- Auth.authz_action(info, %Auth.Assertion{action: :user_admin}, "listRoles") do
      Ident.Role.all()
    end
  end
end
