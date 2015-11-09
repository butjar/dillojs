exports.config =
  # See http://brunch.io/#documentation for docs.
  files:
    javascripts:
      joinTo:
        'app.js': /^app/
        'vendor.js': /^(bower_components|vendor)/
    stylesheets:
      defaltExtension: 'less'
      joinTo:
        'app.css': /^app/
        'vendor.css': /^(bower_components|vendor)/
      order: []
    templates:
      joinTo: 'app.js'
  overrides:
    production:
      paths:
        public: '/usr/share/nginx/www/'
      optimize: true
      sourceMaps: false
      plugins: autoReload: enabled: false
