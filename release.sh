set -eu

mix deps.get --only prod
MIX_ENV=prod mix compile

npm install --prefix ./assets
npm run deploy --prefix ./assets

MIX_ENV=prod mix phx.digest

MIX_ENV=prod mix release
