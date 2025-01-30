-- Main Accordion Function Shortcode
return {
  ["callout_start"] = function(args, kwargs, meta)
      local title = pandoc.utils.stringify(kwargs["title"])
      local variant = pandoc.utils.stringify(kwargs["variant"])

      print(variant)

      if (variant == "") then
        variant = "lightGrey"
       end

      if quarto.doc.is_format("html:js") then
        local start_code = "<div class=\"bcds-Callout ".. variant .."\">"
        start_code = start_code .. "<div class=\"bcds-Callout--Container\">"

        if (title ~= nil) then
          start_code = start_code .. "<div class=\"bcds-Callout--Title\">"
          start_code = start_code .. title
          start_code = start_code .. "</div>"
         end

        start_code = start_code .. "<div class=\"bcds-Callout--Description\">"

        return pandoc.RawInline("html", start_code)
      else
        return pandoc.Null()
      end
  end,

  ["callout_end"] = function(args, kwargs, meta)
      if quarto.doc.is_format("html:js") then
        local end_code = "</div></div></div>"
        return pandoc.RawInline("html", end_code)
      else
        return pandoc.Null()
      end
  end

}
