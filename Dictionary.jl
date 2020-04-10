_dictionary = Vector{String}()
_vectorizedDictionary = Vector{Vector{Int64}}()

function PrepareDictionary(data)::Vector{Vector{Int64}}
    global _dictionary = _CreateDictionary(data)
    global _vectorizedDictionary = VectorizeWords(_dictionary)

    return _vectorizedDictionary
end

function GetDictionary()::Vector{String}
    return _dictionary
end

function GetVectorizedDictionary()::Vector{Vector{Int64}}
    return _vectorizedDictionary
end

function _CreateDictionary(names)::Vector{String}
    dictionary = Vector{String}()

    for one_name in names
        syllable = ""

        for i in 1:length(one_name)
            syllable = syllable * string(collect(one_name)[i])

            if length(syllable) == 2
                if findfirst(isequal(syllable), dictionary) == nothing
                    push!(dictionary, syllable)
                end

                syllable = ""
            end
        end

        if syllable != ""
            if findfirst(isequal(syllable), dictionary) == nothing
                push!(dictionary, syllable)
            end
        end
    end

    return dictionary
end

function VectorizeWords(dict)::Vector{Vector{Int64}}
    dict_vectorized = Vector{Vector{Int64}}()

    i = 1
    for one_word in dict
        one_vector = zeros(Int64, size(dict))
        one_vector[i] = 1
        push!(dict_vectorized, one_vector)
        i += 1
    end

    return dict_vectorized
end
