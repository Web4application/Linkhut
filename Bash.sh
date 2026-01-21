cd /var/lib/linkhut
sudo -Hu linkhut bin/linkhut_ctl user new <web4app> <kubulee.kl@gmail.com> --admin
sudo apt update
sudo apt full-upgrade
sudo apt install git build-essential postgresql postgresql-sudo apt update
sudo apt install elixir erlang-dev erlang-nox
sudo useradd -r -s /bin/false -m -d /var/lib/linkhut -U sudo mkdir -p /opt/linkhut
sudo chown -R linkhut:linkhut /opt/linkhut
sudo -Hu linkhut git clone https://git.sr.ht/~mlb/linkhut /opt/sudo -Hu linkhut mix deps.get
sudo -Hu linkhut mix sudo -Hu linkhut mix deps.get
cat << EOF >
git clone https://github.com/qmk/qmk_firmware.git
cd qmk_firmware
git reset --hard ddcb1794fa
echo "LAYOUTS = gergo" >> ./keyboards/gergo/rules.mk
mkdir ./layouts/community/gergo/
EOF
sudo -Hu linkhut MIX_ENV=prod mix ecto.setup
sudo -Hu linkhut MIX_ENV=prod mix ecto.migrate
sudo -Hu linkhut MIX_ENV=prod mix phx.server
git submodule add https://git.sr.ht/~mlb/gergo_replicant ./layouts/community/gergo/replicant
make git-submodule
make gergo:replicant:dfu
sudo mkdir -p /opt/linkhut
sudo chown -R linkhut:linkhut /opt/linkhut
sudo -Hu linkhut git clone https://git.sr.ht/~mlb/linkhut /opt/linkhut
gem build google-apis-drive_v3.gemspec
gem install ./google-apis-drive_v3-0.x.x.gem
ruby -e "require 'google/apis/drive_v3'; require 'google/apis/calendar_v3'; puts 'Success!'"
$ git clone https://github.com/elixir-lang/elixir.git
$ cd elixir
$ make clean compile
https://builds.hex.pm/builds/elixir/${ELIXIR_VERSION}-otp-${OTP_VERSION}.zip
https://builds.hex.pm/builds/elixir/v1.13.3-otp-24.zip
https://builds.hex.pm/builds/elixir/main-otp-25.zip
https://builds.hex.pm/builds/elixir/builds.txt
curl.exe -fsSO https://elixir-lang.org/install.bat
.\install.bat elixir@1.19.5 otp@28.1
$installs_dir = "$env:USERPROFILE\.elixir-install\installs"
$env:PATH = "$installs_dir\otp\28.1\bin;$env:PATH"
$env:PATH = "$installs_dir\elixir\1.19.5-otp-28\bin;$env:PATH"
iex.bat
curl -fsSO https://elixir-lang.org/install.sh
sh install.sh elixir@1.19.5 otp@28.1
installs_dir=$HOME/.elixir-install/installs
export PATH=$installs_dir/otp/28.1/bin:$PATH
export PATH=$installs_dir/elixir/1.19.5-otp-28/bin:$PATH
iex
scoop install erlang
choco install elixir
$ sudo add-apt-repository ppa:rabbitmq/rabbitmq-erlang
$ sudo apt update
$ sudo apt install git elixir erlang
brew install elixir
sudo port install elixir
sudo dnf --repo=rawhide install elixir elixir-doc erlang erlang-doc
install elixir-doc erlang-doc
