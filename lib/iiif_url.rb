require "iiif_url/version"

class IiifUrl

  @@base_url = ""

  def initialize(options={})
    @options = options
  end

  def identifier(identifier)
    @options[:identifier] = identifier
    self
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

    path = "/#{region}/#{size}/#{rotation}/#{quality}.#{format}"
    if options[:identifier]
      File.join(base_url, options[:identifier], path)
    else
      path
    end
  end

  def self.parse(url)
    url_parts = url.split('/')
    quality_format = url_parts.pop
    quality, format = quality_format.split('.')

    rotation_string = url_parts.pop
    rotation = if rotation_string.include?('!')
      degrees = rotation_string.sub('!', '')
      {degrees: degrees.to_i, mirror: true}
    else
      {degrees: rotation_string.to_i, mirror: false}
    end

    size_string = url_parts.pop
    size = if size_string.include?(',')
      w, h = size_string.split(',')
      w = w.to_i if !w.nil?
      h = h.to_i if !h.nil?
      {w: w, h: h}
    elsif size_string.include?('pct')
      pct, size = size_string.split(':')
      {pct: size.to_f}
    else
      size_string
    end

    region_string = url_parts.pop
    region = if region_string.include?(',')
      if region_string.include?('pct')
        pctx, pcty, pctw, pcth = region_string.split(',')
        pct, pctx = pctx.split(':')
        {pctx: pctx.to_f, pcty: pcty.to_f, pctw: pctw.to_f, pcth: pcth.to_f}
      else
        x, y, w, h = region_string.split(',')
        {x: x.to_i, y: y.to_i, w: w.to_i, h: h.to_i}
      end
    else
      region_string
    end

    identifier = url_parts.pop
    identifier = nil if identifier == ''

    {
      identifier: identifier,
      region: region,
      size: size,
      rotation: rotation,
      quality: quality,
      format: format
    }
  end
end
