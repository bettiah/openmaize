defmodule Mix.Tasks.Openmaize.Gen.Htmlauth do
  use Mix.Task

  def run(_args) do
    mod_name = Mix.Openmaize.base_name
    Mix.Openmaize.copy_files(
      [{"htmlauth.ex", "web/controllers/auth.ex"}],
      mod_name)
      |> instructions(mod_name)
      |> Mix.shell.info
  end

  defp instructions([], mod_name) do
    """

    The module #{mod_name}.Auth has been installed to web/controllers/auth.ex
    This module contains a custom `authorize_action` and an `id_check` function,
    which can be used for authorization, and it also contains functions for
    handling login, logout, email confirmation and password resetting.
    See the documentation for each function for more details.

    The functions in #{mod_name}.Auth rely on the current_user being
    set by Openmaize.Authenticate. In the `web/router.ex` file, you
    need to add the following line to the pipeline:

        plug Openmaize.Authenticate

    You will also need to configure Openmaize. See the documentation for
    Openmaize.Config for details.
    """
  end
  defp instructions(errors, _) do
    files = Enum.join errors, "\n* "
    """

    The following files could not be installed:
    #{files}
    """
  end
end
