var path = require('path');

module.exports = {
    mode: 'development',
    entry: path.join(__dirname, 'srcjs', 'amChart4.jsx'),
    output: {
        path: path.join(__dirname, 'inst/htmlwidgets'),
        filename: 'amChart4.js'
    },
    module: {
      rules: [
        {
          test: /\.jsx?$/,
          loader: 'babel-loader',
          options: {
            presets: [
              [
                '@babel/preset-env',
                {
                  targets: {
                    esmodules: true
                  }
                }
              ],
              '@babel/preset-react'
            ],
            plugins: ["@babel/plugin-syntax-dynamic-import"]
          }
        }
      ]
    },
    externals: [
      {
        'react': 'window.React',
        'react-dom': 'window.ReactDOM',
        'reactR': 'window.reactR'
      },
      function (context, request, callback) {
        if (/xlsx|canvg|pdfmake/.test(request)) {
          return callback(null, "commonjs " + request);
        }
        callback();
      }
    ],
    stats: {
      colors: true
    },
    devtool: 'source-map'
};
