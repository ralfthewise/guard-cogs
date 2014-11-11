guard-cogs
==========

Guard plugin that uses sprockets to package your coffeescript, javascript, sass, and css files.  Inspired by the guard-sprockets gem.

## Install

Please be sure to have [Guard](https://github.com/guard/guard) installed before continuing.

Install the gem:

```
$ gem install guard-cogs
```

Add it to your Gemfile:

```ruby
group :development, :test do
  gem 'guard-cogs'
end
```

Add guard definition to your Guardfile by running this command:

```
$ guard init cogs
```

## Usage

``` ruby
guard 'cogs', compile: ['app.coffee'], dest: 'public/javascripts', asset_paths: ['assets/scripts', 'assets/vendor/scripts'] do
  watch(%r{^assets/.+\.(js|coffee)$})
end

guard 'cogs', compile: ['app.scss'], dest: 'public/stylesheets', asset_paths: ['assets/stylesheets', 'assets/vendor/stylesheets'] do
  watch(%r{^assets/.+\.(css|scss)$})
end
```

## Options

``` ruby
compile     => ['app.coffee', 'assets/vendor/vendor.js' => 'vendor/deps.js'] # Array of files to generate in "dest".  Use a hash if you want generated filename
                                                                             # to be different than the source filename
dest        => 'public/javascripts'                                          # Output folder
asset_paths => ['assets/scripts', 'assets/vendor/scripts']                   # Array of folders containing assets
minify      => true                                                          # Minify generated files (uglifier for javascript, yui-compressor for stylesheets)
```

## License
(The MIT License)

Copyright (c) 2011-2012 Aaron Cruz

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
