module.exports = {
  mode: 'jit',
  purge:  [
    "./js/**/*.js",
    "../lib/*_web/**/*.{heex,eex}",
    "../lib/ttc_alerts_web/live/*.ex",
    "../**/*.html.eex",
    "../**/*.html.leex",
    "../**/views/**/*.ex",
    "../**/live/**/*.ex",
  ],
  theme: {
    extend: {},
  },
  variants: {},
  plugins: [],
}
