module.exports = (ctx) => ({
  map: {
    absolute: false,
    sourcesContent: ctx.env === 'development'
  },
  plugins: {
    'postcss-import': { root: ctx.file.dirname },
    // commented out and running tailwindcss as its own watcher for now until a
    // newer release of postcss-cli (v8.0.1 or something) that contains
    // https://github.com/postcss/postcss-cli/pull/383
    // see: https://tailwindcss.com/docs/just-in-time-mode#it-just-doesn-t-seem-to-work-properly
    // tailwindcss: { config: './tailwind.config.js' }
    autoprefixer: {},
    // cssnano: ctx.env === 'production' ? {preset: 'default'} : false
    require("tailwindcss")("./tailwind.config.js"),
  }
})
