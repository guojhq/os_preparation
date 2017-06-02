# =====================
# Enable databag
# =====================
# RENDER_CP

echo "========================================="
echo "(Rails:${rails_version}) rails new myrails -d mysql"
echo "========================================="
cd /home
rails new myrails -d mysql #Create rails project, to verify
cd /home/myrails
chown -R optpass.optpass log tmp

systemctl start mariadb

# Create PROD(require database.yml info. so PROD will failed due to wrong username/password for mysql db server), DEV, TEST env database in mysql
# bundle exec rails db:create:all

bundle exec rails db:create
systemctl stop mariadb

# Cleanup firewall rules which means block all incoming traffice
echo "========================================="
echo "      Add default ignore into myrails"
echo "========================================="
local rails_confs=($(find ${CONFIG_FOLDER} -type f))
local rails_target=""
local rails_target_folder=""
for rails_conf in ${rails_confs[@]}
do
  rails_target="${rails_conf/${CONFIG_FOLDER}/}"
  rails_target_folder="$(dirname $rails_target)"

  test -d $rails_target_folder || mkdir -p $rails_target_folder
  echo "Setting up config file \"${rails_target}\"......"
  \cp -a --backup=t $rails_conf $rails_target
done
