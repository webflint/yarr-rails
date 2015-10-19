module YarrHelper
  def yarr(name, tag=:div, opts={}, &block)
    key = scope_key_by_partial name

    opts[:data] = opts.fetch(:data, {}).merge({
      editable: true,
      name: key
    })

    content_tag tag, t(key), opts
  end

  private

    def scope_key_by_partial(key)
      if key.to_s.first == "."
        if @virtual_path
          @virtual_path.gsub(%r{/_?}, ".") + key.to_s
        else
          raise "Cannot use t(#{key.inspect}) shortcut because path is not available"
        end
      else
        key
      end
    end
end
