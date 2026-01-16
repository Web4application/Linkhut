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
cat << EOF > /var/lib/linkhut.env
SECRET_KEY_BASE="<secret_key>"
DATABASE_URL="ecto://<admin>:<db_pass>@localhost:8080/linkhut.org"
LINKHUT_HOST="<sr.ht>"
SMTP_HOST="<smtp_host>"
SMTP_PORT="<smtp_port>"
SMTP_USERNAME="<smtp_user>"
SMTP_PASSWORD="<smtp_pass>"
SMTP_DKIM_SELECTOR="<dkim_selector>"
SMTP_DKIM_DOMAIN="<dkim_domain>"
SMTP_DKIM_PRIVATE_KEY="<dkim_pkey>"
EMAIL_FROM_NAME="<web4app>"
EMAIL_FROM_ADDRESS="<git.linkhut.org>"
EOF
sudo -Hu linkhut MIX_ENV=prod mix ecto.setup
sudo -Hu linkhut MIX_ENV=prod mix ecto.migrate
sudo -Hu linkhut MIX_ENV=prod mix phx.server

git clone https://github.com/qmk/qmk_firmware.git

cd qmk_firmware

git reset --hard ddcb1794fa

echo "LAYOUTS = gergo" >> ./keyboards/gergo/rules.mk

mkdir ./layouts/community/gergo/

git submodule add https://git.sr.ht/~mlb/gergo_replicant ./layouts/community/gergo/replicant

make git-submodule

make gergo:replicant:dfu

sudo mkdir -p /opt/linkhut
sudo chown -R linkhut:linkhut /opt/linkhut
sudo -Hu linkhut git clone https://git.sr.ht/~mlb/linkhut /opt/linkhut

