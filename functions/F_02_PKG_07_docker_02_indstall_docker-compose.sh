# ----------------------------------
# Fetch latest docker-compose version
# ref. https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
# ref. https://linustechtips.com/main/topic/740384-how-can-i-programmatically-download-the-latest-github-release-from-a-repo/
# ----------------------------------
local docker_compose_version="$(curl -s "https://github.com/docker/compose/releases/latest" | grep -o 'tag/[v.0-9]*' | awk -F/ '{print $2}')"


# ----------------------------------
# Install latest version of docker-comopose
# ----------------------------------
local docker_compose_url="https://github.com/docker/compose/releases/download/${docker_compose_version}/docker-compose-$(uname -s)-$(uname -m)"
curl -L "${docker_compose_url}" -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

docker-compose --version
