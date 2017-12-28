# See: https://github.com/matthodan/jekyll-asset-pipeline#getting-started

require 'jekyll_asset_pipeline'

module JekyllAssetPipeline
    
    # Tag Templates

    class CssTagTemplate < JekyllAssetPipeline::Template
        def self.filetype
            '.css'
        end
    
        def html
            "<link rel='stylesheet' type='text/css' media='all' href='#{output_path}/#{@filename}' />\n"
        end
      end

    # Converters

    class SassConverter < JekyllAssetPipeline::Converter
        require 'sass'
  
      def self.filetype
          '.scss'
      end
  
      def convert
          return Sass::Engine.new(@content, syntax: :scss, load_paths: [@dirname]).render
      end
    end

    # Compressors

    class CssCompressor < JekyllAssetPipeline::Compressor
        require 'sass'
    
        def self.filetype
            '.css'
        end
    
        def compress
            return Sass::Engine.new(@content, syntax: :scss, style: :compressed, load_paths: [@dirname]).render
        end
    end

    class JavaScriptCompressor < JekyllAssetPipeline::Compressor
        require 'uglifier'
    
        def self.filetype
          '.js'
        end
    
        def compress
          return Uglifier.new(:harmony => false).compile(@content)
        end
      end
end