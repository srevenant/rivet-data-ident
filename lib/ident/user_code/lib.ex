defmodule Rivet.Ident.UserCode.Lib do
  alias Rivet.Ident
  alias Ident.UserCode
  use Rivet.Ecto.Collection.Context, model: UserCode

  def reset_generate(for_user_id, type, meta \\ %{}) do
    clear_all_codes(for_user_id, type)
    expire = Application.get_env(:core, :user_code_expires)[type] || 60
    generate_code(for_user_id, type, expire, meta)
  end

  def generate_code(for_user_id, type, expiration_minutes, meta \\ %{}) when is_atom(type) do
    code =
      Ecto.UUID.generate()
      |> String.replace(~r/[-IO0]+/i, "")
      |> String.slice(1..8)
      |> String.upcase()

    case UserCode.one(code: code) do
      {:ok, _} ->
        generate_code(for_user_id, type, expiration_minutes)

      {:error, _} ->
        case UserCode.create(%{
               user_id: for_user_id,
               code: code,
               type: type,
               meta: meta,
               expires: Timex.now() |> Timex.shift(minutes: expiration_minutes)
             }) do
          {:ok, code} ->
            {:ok, code}

          {:error, chgset} ->
            IO.inspect(chgset, label: "Cannot generate code?")
            {:error, "cannot generate code"}
        end
    end
  end

  def get_valid(code) do
    with {:ok, code} <- UserCode.one(code: code) do
      if Timex.diff(Timex.now(), code.expires) < 0 do
        {:ok, code}
      else
        {:error, "Code Expired"}
      end
    end
  end

  # housekeeper
  def clear_expired_codes() do
    now = Timex.now()

    from(c in UserCode, where: c.expires < ^now)
    |> Ident.UserCode.delete_all()
  end

  def clear_all_codes(for_user_id, type) do
    from(c in UserCode,
      where:
        c.user_id == ^for_user_id and
          c.type == ^type
    )
    |> Ident.UserCode.delete_all()
  end
end
