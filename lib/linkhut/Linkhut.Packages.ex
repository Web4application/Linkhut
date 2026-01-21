defmodule Linkhut.Packages do
  alias Hex.Solver.Dependency

  def fetch_versions(repo, package) do
    # Example DB result:
    # ["0.1.0", "0.2.0", "1.0.0"]
    case Repo.get_versions(repo, package) do
      [] -> :error
      versions -> {:ok, versions}
    end
  end

  def fetch_dependencies(repo, package, version) do
    deps =
      Repo.get_dependencies(repo, package, version)
      |> Enum.map(fn dep ->
        %Dependency{
          repo: dep.repo,
          name: dep.name,
          constraint: dep.constraint,
          optional: dep.optional || false
        }
      end)

    {:ok, deps}
  end

  def prefetch(packages) do
    Repo.preload_packages(packages)
    :ok
  end
end
