require "iiif_url/version"

class IiifUrl

  def initialize(options)
    #code
  end

  def self.from_options(options={})
    base_url = options[:base_url]
    if base_url == false
      base_url = ''
    elsif base_url.nil? && defined?(IIIF_URL_BASE_URL)
      base_url = IIIF_URL_BASE_URL
    end

    region = options[:region] || "full"
    if region.is_a? Hash
      if region[:x]
        region = "#{region[:x]},#{region[:y]},#{region[:w]},#{region[:h]}"
      elsif region[:pctx]
        region = "pct:#{region[:pctx]},#{region[:pcty]},#{region[:pctw]},#{region[:pcth]}"
      end
    end

    size = options[:size] || "full"
    if size.is_a? Hash
      if size[:w] || size[:h]
        size = "#{size[:w]},#{size[:h]}"
      elsif size[:pct]
        size = "pct:#{size[:pct]}"
      end
    end

    rotation = options[:rotation] || 0
    if rotation.is_a? Hash
      if rotation[:mirror]
        rotation = "!#{rotation[:degrees]}"
      else
        rotation = "#{rotation[:degrees]}"
      end
    end

    quality = options[:quality] || "default"
    format = options[:format] || "jpg"
    "#{base_url}/#{region}/#{size}/#{rotation}/#{quality}.#{format}"
  end

  def self.parse(url)
    #code
  end
end
