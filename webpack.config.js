const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");

const dist = 'client/dist';

module.exports = {
  mode: "development",
  entry: "./client/src/index.js",
  target: 'web',
  output: {
    path: path.resolve(__dirname, dist),
    filename: "index.min.js",
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: "./client/src/index.html",
      filename: "index.html",
      inject: "body",
    }),
  ],
  devServer: {
    hot: true,
    static: {
      directory: path.join(__dirname, dist),
    },
    compress: true,
    port: 80,
  },
};
