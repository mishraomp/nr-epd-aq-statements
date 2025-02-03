--local pandoc = require(pandoc)
--local quarto = require(quarto)

-- Main Accordion Function Shortcode
return {
  ["callout_start"] = function(args, kwargs, meta)
    local title = pandoc.utils.stringify(kwargs["title"])
    local variant = pandoc.utils.stringify(kwargs["variant"])

    if (variant == "") then
      variant = "lightGrey"
    end

    -- todo: aria-labelledby (generate IDs)

    if quarto.doc.is_format("html:js") then
      local markup = "<div class=\"bcds-Callout " .. variant .. "\" role=\"note\">"
      markup = markup .. "<div class=\"bcds-Callout--Container\">"

      if (title ~= nil) then
        markup = markup .. "<div class=\"bcds-Callout--Title\">"
        markup = markup .. title
        markup = markup .. "</div>"
      end

      markup = markup .. "<div class=\"bcds-Callout--Description\">"

      return pandoc.RawInline("html", markup)
    else
      return pandoc.Null()
    end
  end,

  ["callout_end"] = function(args, kwargs, meta)
    if quarto.doc.is_format("html:js") then
      local markup = "</div></div></div>"
      return pandoc.RawInline("html", markup)
    else
      return pandoc.Null()
    end
  end
}
