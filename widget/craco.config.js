module.exports = {
  babel: {
    presets: [],
    plugins: [['babel-plugin-styled-components', { displayName: true }]],
    loaderOptions: (babelLoaderOptions) => {
      return babelLoaderOptions;
    },
  },
  webpack: {
    configure: {
      output: {
        filename: 'static/js/khulnasoft-widget.js',
      },
      optimization: {
        runtimeChunk: false,
        splitChunks: {
          cacheGroups: {
            default: false,
            vendors: false,
            // vendor chunk
          },
        },
      },
    },
  },
};
