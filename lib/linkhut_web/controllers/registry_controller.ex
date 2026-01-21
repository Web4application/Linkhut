# lib/linkhut_web/controllers/registry_controller.ex

defmodule LinkhutWeb.RegistryController do
  use LinkhutWeb, :controller

  alias Linkhut.Registry
  alias Version

  def versions(conn, %{"repo" => repo, "package" => package}) do
    case Registry.versions(repo, package) do
      {:ok, versions} ->
        json(conn, %{
          repo: repo,
          package: package,
          versions: Enum.map(versions, &Version.to_string/1)
        })

      :error ->
        send_resp(conn, 404, "package not found")
    end
  end

  def dependencies(conn, %{
        "repo" => repo,
        "package" => package,
        "version" => version
      }) do
    with {:ok, v} <- Version.parse(version),
         {:ok, deps} <- Registry.dependencies(repo, package, v) do
      json(conn, %{
        repo: repo,
        package: package,
        version: version,
        dependencies: deps
      })
    else
      _ -> send_resp(conn, 404, "dependencies not found")
    end
  end
end
