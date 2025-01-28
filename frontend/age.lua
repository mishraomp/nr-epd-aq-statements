function Meta (meta)
  local pattern = "(%w+) (%d+), (%d+)"

  local MONTHS={January=1,February=2,March=3,April=4,May=5,June=6,July=7,August=8,September=9,October=10,November=11,December=12}

  if (meta["date"] ~= nil) then
    local ds = pandoc.utils.stringify(meta["date"])

    local metaMonth, metaDay, metaYear = string.match(ds, pattern)
    local parsedDate = os.time({year = metaYear, month=MONTHS[metaMonth], day=metaDay})
    local age = os.time() - parsedDate;

    local recent = age < (24 * 3600 * 14) -- 14 days or less is "recent"

    meta["recent"] = recent
    meta["age"] = age
  end

  return meta
end
