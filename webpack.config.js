var autoprefixer = require('autoprefixer');

module.exports = {
  entry: {
    index: './source/javascripts/index.js',
    application: './source/stylesheets/application.scss',
    vendor: ['babel/polyfill'],
  },

  resolve: {
    root: __dirname + '/source/javascripts',
  },

  output: {
    path: __dirname + '/.tmp/dist',
    filename: 'javascripts/[name].js',
  },

  module: {
    loaders: [{
      test: /source\/javascripts\/.*\.js$/,
      exclude: /node_modules|\.tmp|vendor/,
      loaders: ['babel'],
    }, {
      test: /\.scss/,
      loader: Ext
    }]
  },
};
