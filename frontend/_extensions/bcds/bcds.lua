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
  end,

  ["accordion_start"] = function(args, kwargs, meta)
    local title = pandoc.utils.stringify(kwargs["title"])

    if (title == nil) then
      title = "Summary"
    end

    if quarto.doc.is_format("html:js") then
      local markup = "<details class='bcds-disclosure'>"

      markup = markup .. "<summary>"
      markup = markup .. title
      markup = markup .. "</summary>"

      markup = markup .. "<div class='panel'>"

      return pandoc.RawInline("html", markup)
    else
      return pandoc.Null()
    end
  end,

  ["accordion_end"] = function(args, kwargs, meta)
    if quarto.doc.is_format("html:js") then
      local markup = "</div></details>"
      return pandoc.RawInline("html", markup)
    else
      return pandoc.Null()
    end
  end,


  ["card_start"] = function(args, kwargs, meta)
    if quarto.doc.is_format("html:js") then
      local title = pandoc.utils.stringify(kwargs["title"])
      local variant = pandoc.utils.stringify(kwargs["variant"])

      local markup = "<div class='card " .. variant .. "'>"
      markup = markup .. "<div class='card-body'>"

      if (title ~= nil) then
        markup = markup .. "<h5 class='card-title'>"
        markup = markup .. title
        markup = markup .. "</h5>"
      end

      return pandoc.RawInline("html", markup)
    else
      return pandoc.Null()
    end
  end,

  ["card_end"] = function(args, kwargs, meta)
    if quarto.doc.is_format("html:js") then
      local markup = "</div></div>"
      return pandoc.RawInline("html", markup)
    else
      return pandoc.Null()
    end
  end,

  ["inline_alert_start"] = function(args, kwargs, meta)
    local title = pandoc.utils.stringify(kwargs["title"])
    local variant = pandoc.utils.stringify(kwargs["variant"])


    if (variant == "") then
      variant = "info"
    end

    if quarto.doc.is_format("html:js") then
      local markup = "<div class='bcds-Inline-Alert " .. variant .. "'>"
      markup = markup .. "<div class='bcds-Inline-Alert--container'>"

      if (title ~= nil) then
        markup = markup .. "<span class='title'>"
        markup = markup .. title
        markup = markup .. "</span>"
      end

      return pandoc.RawInline("html", markup)
    else
      return pandoc.Null()
    end
  end,

  ["inline_alert_end"] = function(args, kwargs, meta)
    if quarto.doc.is_format("html:js") then
      local markup = "</div></div>"
      return pandoc.RawInline("html", markup)
    else
      return pandoc.Null()
    end
  end,
}
