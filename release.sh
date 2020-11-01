set -eu

mix deps.get --only prod
MIX_ENV=prod mix compile

npm install --prefix ./assets

MIX_ENV=prod mix release
