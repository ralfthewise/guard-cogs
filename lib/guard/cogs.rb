require 'guard'
require 'guard/plugin'
require 'sprockets'

module Guard
  class Cogs < Plugin

    def initialize(options = {})
      super

      @compile = options[:compile]
      @dest = options[:dest] || '.'

      if options[:sprockets].nil?
        @sprockets = ::Sprockets::Environment.new
        @sprockets.cache = {}
        if options[:minify] == true
          begin
            require 'uglifier'
            @sprockets.js_compressor = ::Uglifier.new
          rescue LoadError
            throw 'Uglifier cannot be loaded. Please include "uglifier" in your Gemfile.'
          end
          begin
            require 'yui/compressor'
            @sprockets.css_compressor = ::YUI::CssCompressor.new
          rescue LoadError
            throw 'YUI Compressor cannot be loaded. Please include "yui/compressor" in your Gemfile.'
          end
        end
      else
        @sprockets = options[:sprockets]
      end

      asset_paths = options[:asset_paths] ? Array(options[:asset_paths]) : ['.']
      asset_paths.each {|p| @sprockets.append_path(p)}
    end

    def start
       UI.info 'Starting guard-cogs'
       run_sprockets
    end

    def run_all
      run_sprockets
    end

    def run_on_modifications(paths)
      run_sprockets(paths)
    end

    private

    def run_sprockets(paths = [])
      paths = @compile unless @compile.nil?
      [paths].flatten.each do |path|
        begin
          case path
          when String
            path = Pathname.new(path)
            output_filename = output_basename(path.basename.to_s)
            output_path = Pathname.new(File.join(@dest, path.parent, output_filename))
            compile_asset(path, output_path)
          when Hash
            path.each {|p,op| compile_asset(Pathname.new(p), Pathname.new(File.join(@dest, op)))}
          else
            raise 'Items in ":compile" option must either be a String or Hash'
          end
        end
      end
    end

    def compile_asset(path, output_path)
      begin
        FileUtils.mkdir_p(output_path.parent) unless output_path.parent.exist?
        asset = @sprockets.find_asset(path.cleanpath)
        raise "'#{path.cleanpath}' could not be found" if asset.nil?
        asset.write_to(output_path.cleanpath)
        UI.info("Compiled '#{path.cleanpath}' -> '#{output_path.cleanpath}'")
        Notifier.notify("Compiled '#{path.cleanpath}' -> '#{output_path.cleanpath}'", title: "Compiled #{path.cleanpath}", image: :success)
      rescue Exception => e
        UI.error("Failed to compile '#{path}': #{e}")
        Notifier.notify("Failed to compile '#{path}': #{e}", title: "Failed to compile #{path}", image: :failed)
        throw :task_has_failed
      end
    end

    def output_basename(filename)
      result = filename.gsub(/^(.*\.(js|coffee|css|scss|sass))(\.(js|coffee|css|scss|sass|erb))*$/, '\1')
      return result.gsub(/(.*)(\.coffee)$/, '\1.js').gsub(/(.*)(\.scss)$/, '\1.css').gsub(/(.*)(\.sass)$/, '\1.css')
    end
  end
end
