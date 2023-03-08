defmodule Rivet.Ident.Access do
  @moduledoc """
  Schema for representing and working with a Ident.Access.
  """
  use TypedEctoSchema
  use Rivet.Ecto.Model, id_type: :int
  alias Rivet.Ident
  import EctoEnum

  # Access domains are per table type so you can map accesses to individual
  # rows in a table (such as different accesses for different groups in the db),
  # where :global is ... global and not tied to another data type, and for others
  # they enum key should be the module atom: :"Elixir.Module.Name"
  defenum(Domains, global: 0)

  typed_schema "ident_accesses" do
    belongs_to(:user, Ident.User, type: :binary_id, foreign_key: :user_id)
    belongs_to(:role, Ident.Role, foreign_key: :role_id)
    field(:domain, Domains, default: 0)
    field(:ref_id, :binary_id)
  end

  use Rivet.Ecto.Collection,
    required: [:user_id, :role_id],
    update: [:domain, :ref_id],
    unique: [:role_id]
end
