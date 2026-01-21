.\install.bat
elixir@1.19.5 otp@28.1
https://builds.hex.pm/builds/elixir/${ELIXIR_VERSION}-otp-${OTP_VERSION}.zip
https://builds.hex.pm/builds/elixir/v1.13.3-otp-24.zip
https://builds.hex.pm/builds/elixir/main-otp-25.zip
https://builds.hex.pm/builds/elixir/builds.txt
curl.exe -fsSO https://elixir-lang.org/install.bat
$installs_dir = "$env:USERPROFILE\.elixir-install\installs"
$env:PATH = "$installs_dir\otp\28.1\bin;$env.PATH"
$env:PATH = "$installs_dir\elixir\1.19.5-otp-28\bin;$env.PATH"
