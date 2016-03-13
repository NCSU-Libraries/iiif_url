require "iiif_url/version"

class IiifUrl

  @@base_url = ""

  def initialize(options={})
    @options = options
  end

  def region(region)
    @options[:region] = region
    self
  end

  def size(size)
    @options[:size] = size
    self
  end

  def rotation(rotation)
    @options[:rotation] = rotation
    self
  end

  def quality(quality)
    @options[:quality] = quality
    self
  end

  def format(format)
    @options[:format] = format
    self
  end

  def to_s
    IiifUrl.from_options(@options)
  end

  def self.set_base_url(base_url)
    @@base_url = base_url
  end

  def self.from_options(options={})
    base_url = options[:base_url]
    if base_url == false
      base_url = ''
    elsif base_url.nil?
      base_url = @@base_url
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
