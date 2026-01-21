defmodule Linkhut.Registry do
  @moduledoc """
  Linkhut implementation of Hex.Solver.Registry.

  This allows Linkhut to act as a Hex-compatible package registry.
  """

  @behaviour Hex.Solver.Registry

  alias Linkhut.Packages
  alias Version

  @impl true
  def versions(repo, package) do
    with {:ok, versions} <- Packages.fetch_versions(repo, package) do
      versions =
        versions
        |> Enum.map(&Version.parse!/1)
        |> Enum.sort(Version)

      {:ok, versions}
    else
      _ -> :error
    end
  end

  @impl true
  def dependencies(repo, package, %Version{} = version) do
    case Packages.fetch_dependencies(repo, package, Version.to_string(version)) do
      {:ok, deps} -> {:ok, deps}
      _ -> :error
    end
  end

  @impl true
  def prefetch(packages) do
    # Example: preload package/version metadata
    Packages.prefetch(packages)
    :ok
  end
end
