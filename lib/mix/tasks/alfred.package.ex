defmodule Mix.Tasks.Alfred.Package do
  use Mix.Task

  @recursive false

  def run(_opts) do
    make_working_appdir
    make_working_confdir
    unpack_release
    move_config_to_confdir
    symlink_config
    build_package
  end

  defp appname do
    Mix.Project.config
    |> Keyword.get(:app)
    |> to_string
  end

  defp version do
    Mix.Project.config
    |> Keyword.get(:version)
  end

  defp source_tarball_path do
    versioned_release_path
    |> Path.join("#{appname}.tar.gz")
  end

  def versioned_release_path do
    ["rel", appname, "releases", version]
    |> Path.join
  end

  defp working_parentdir, do: "packaging"

  defp working_appdir do
    [working_parentdir, "opt", appname]
    |> Path.join
  end

  defp working_confdir do
    [working_parentdir, "etc"]
    |> Path.join
  end

  defp make_working_appdir do
    File.mkdir_p! working_appdir
  end

  defp make_working_confdir do
    File.mkdir_p! working_confdir
  end

  defp unpack_release do
    System.cmd "tar", ["-x", "-C", working_appdir, "-f", source_tarball_path]
  end

  defp original_config_path do
    [working_appdir, "releases", version, "#{appname}.conf"]
    |> Path.join
  end

  defp new_config_path do
    Path.join(working_confdir, "#{appname}.conf")
  end

  defp move_config_to_confdir do
    File.rename(original_config_path, new_config_path)
  end

  defp final_config_path do
    Path.join("/etc", "#{appname}.conf")
  end

  defp symlink_config do
    File.ln_s(final_config_path, original_config_path)
  end

  def build_package do
    System.cmd("fpm", [
      "-t", "deb",
      "-s", "dir",
      "-n", appname,
      "-v", version,
      "--deb-init", "#{appname}.init",
      "--deb-no-default-config-files",
      "--config-files", final_config_path,
      "-C", working_parentdir,
    ])
    |> IO.inspect
  end

end
