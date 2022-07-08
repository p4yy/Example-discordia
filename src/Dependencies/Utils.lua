local Utils = {}

function Utils.ReadFile(Path)
    local File = io.open(Path, "rb")
    if not File then
        return nil
    end
    local Content = File:read("*a")
    File:close()
    return Content
end

function Utils.WriteFile(Path,Text)
	local File = io.open(Path, "w+")
	File:write(Text)
	File:close()
end

return Utils