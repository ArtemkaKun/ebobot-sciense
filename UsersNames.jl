using Unicode

_originalData = Vector{String}()
_lowercasedData = Vector{String}()
_normalizedData = Vector{String}()
_clearData = Vector{String}()


function PrepareData(origin_data)::Vector{String}
    global _originalData = origin_data
    global _lowercasedData = _DataToLowercase(_originalData)
    global _normalizedData = _NormalizeData(_lowercasedData)
    global _clearData = _CleanData(_normalizedData)

    return _clearData
end

function _SetOriginalData(new_data)
    global _originalData = new_data
end

function _DataToLowercase(original_data)::Vector{String}
    return _ToLowercase(original_data)
end

function _NormalizeData(lowercased_data)::Vector{String}
    return _NormalizeUTF(lowercased_data)
end

function _CleanData(normalized_data)::Vector{String}
    return collect(_RemoveTrash(normalized_data))
end

function _ToLowercase(names)::Vector{String}
    names_lowercased = Vector{String}()

    for one_name in names
        push!(names_lowercased, lowercase(one_name))
    end

    return names_lowercased
end

function _NormalizeUTF(names)::Vector{String}
    names_normalized = Vector{String}()

    for one_name in names
        push!(names_normalized, Unicode.normalize(one_name, stripmark=true))
    end

    return names_normalized
end

function _RemoveTrash(names)::Vector{String}
    names_without_emojii = Vector{String}()

    for one_name in names
        push!(names_without_emojii, match(r"[а-яёїієґa-z1-9]*", one_name).match)
    end

    names_clear = Vector{String}()

    for one_name in names_without_emojii
        if one_name != "" && length(one_name) > 2
            push!(names_clear, one_name)
        end
    end

    return names_clear
end
