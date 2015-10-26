activate :blog do |blog|
  blog.permalink = "/{title}.html"
  blog.layout = "article"
end
activate :directory_indexes

activate :autoprefixer, browsers: [
  "last 2 versions"
]

activate :external_pipeline,
         name: :webpack,
         command: build? ? "./node_modules/webpack/bin/webpack.js --bail" : "./node_modules/webpack/bin/webpack.js --watch -d --progress --color",
         source: ".tmp/dist",
         latency: 1

# Reload the browser automatically whenever files change
configure :development do
  set :domain_name, "http://localhost:4567"
  activate :livereload
end

# Build-specific configuration
configure :build do
  # "Ignore" JS and CSS so webpack has full control.
  ignore { |path| path =~ /\/(.*)\.js|css$/ && $1 != "all" && $1 != "vendor" }

  # Minify Javascript on build
  activate :minify_javascript

  # For example, change the Compass output style for deployment
  activate :minify_css

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  activate :relative_assets

  config[:relative_links] = true

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

configure :server do
  ready do
    files.on_change :source do |changed|
      changed_js = changed.select do |f|
        f[:full_path].extname === ".js" && !f[:full_path].to_s.include?(".tmp")
      end

      if changed_js.length > 0
        puts "== Linting Javascript"

        changed_js.each do |file|
          puts `./node_modules/eslint/bin/eslint.js #{file[:full_path]}`
        end
      end
    end
  end
end
