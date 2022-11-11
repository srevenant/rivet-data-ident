defmodule Rivet.Data.Auth.UserData do
  @moduledoc """
  Schema for representing and working with a Auth.UserData.
  """
  use TypedEctoSchema
  use Unify.Ecto.Model
  import EctoEnum

  defenum(Types,
    available: 0,
    address: 2,
    profile: 4,
    toggles: 5,
    save: 6
  )

  typed_schema "user_datas" do
    belongs_to(:user, Auth.User, type: :binary_id, foreign_key: :user_id)
    field(:type, Types)
    field(:value, :map)
    timestamps()
  end

  use Unify.Ecto.Collection,
    required: [:user_id, :type, :value],
    update: [:value],
    unique: [:type]
end
