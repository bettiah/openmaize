defmodule Openmaize.ConfirmTools do
  @moduledoc """
  This function has been deprecated.

  Please use `Openmaize.ConfirmEmail.gen_token_link`.
  """

  @doc false
  def gen_token_link(conn, opts) do
    IO.write :stderr, "warning: calling 'Openmaize.ConfirmTools.gen_token_link' " <>
      "is deprecated, please use 'Openmaize.ConfirmEmail.gen_token_link' instead.\n"
  end
end
