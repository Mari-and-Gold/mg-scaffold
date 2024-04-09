// webpack.mix.js

let mix = require("laravel-mix");

// compile sass
mix.sass("sass/theme.scss", "dist").options({
  processCssUrls: false,
});

// combine & minify
mix.scripts(
  ["src/js/bootstrap5/bootstrap.bundle.js", "src/js/skip-link-focus-fix.js"],
  "dist/library.js"
);

mix.js("src/js/custom.js", "dist");

mix.scripts(["dist/library.js", "dist/custom.js"], "dist/theme.js");
