# Load another ".iex.exs" file
import_file("~/.iex.exs")

# Import some module from lib that may not yet have been defined
import_if_available(MyApp.Mod)

# Print something before the shell starts
IO.puts("hello world")

# Bind a variable that'll be accessible in the shell
value = 13
