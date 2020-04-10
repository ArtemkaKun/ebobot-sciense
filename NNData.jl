include("Dictionary.jl")
include("RealNames.jl")

using CSV, DataFrames, StatsBase

_classifiedData = DataFrame(CSV.File("data_db\\train_names.csv"))
_classifiedData = _classifiedData[
    sample(axes(_classifiedData, 1), nrow(_classifiedData); replace = false),
    :,
]

_unclassifiedData = DataFrame(CSV.File("data_db\\need_names.csv"))
_unclassifiedData = _unclassifiedData[completecases(_unclassifiedData), :]

_trainData = DataFrame()
_testData = DataFrame()

_needData = Vector{Vector{Int64}}()

_trainDataX = Vector{Vector{Int64}}()
_trainDataY = Vector{Vector{Int64}}()

_testDataX = Vector{Vector{Int64}}()
_testDataY = Vector{Vector{Int64}}()

function PrepareNNData(alpha)
    edge = Int64(floor(nrow(_classifiedData) * alpha))

    global _trainData = _classifiedData[1:edge, :]
    global _testData = _classifiedData[edge:nrow(_classifiedData), :]

    train_data_X = _trainData[:, 1]
    train_data_Y = _trainData[:, 2]

    global _needData = _VectorizeNamesWithDictionary(
        _unclassifiedData[:, 1],
        GetDictionary(),
        GetVectorizedDictionary(),
    )

    global _trainDataX = _VectorizeNamesWithDictionary(
        train_data_X,
        GetDictionary(),
        GetVectorizedDictionary(),
    )

    global _trainDataY = _VectorizeTrainNamesWithDictionary(
        train_data_Y,
        GetVectorizedRealNames(),
    )

    test_data_X = _testData[:, 1]
    test_data_Y = _testData[:, 2]

    global _testDataX = _VectorizeNamesWithDictionary(
        test_data_X,
        GetDictionary(),
        GetVectorizedDictionary(),
    )

    global _testDataY = _VectorizeTrainNamesWithDictionary(
        test_data_Y,
        GetVectorizedRealNames(),
    )
end

function _VectorizeNamesWithDictionary(train_X, dictionary, dict_vectors)::Vector{Vector{Int64}}
    train_X_vectorised = Vector{Vector{Int64}}()

    for one_name in train_X
        syllable = ""
        one_word = zeros(Int64, 2371)

        for i = 1:length(one_name)
            syllable = syllable * string(collect(one_name)[i])

            if length(syllable) == 2
                if findfirst(isequal(syllable), dictionary) != nothing
                    one_word +=
                        dict_vectors[findfirst(isequal(syllable), dictionary)]
                end

                syllable = ""
            end
        end

        if syllable != ""
            if findfirst(isequal(syllable), dictionary) != nothing
                one_word +=
                    dict_vectors[findfirst(isequal(syllable), dictionary)]
            end
        end

        push!(train_X_vectorised, one_word)
        one_word = zeros(Int64, 2371)
    end

    return train_X_vectorised
end

function _VectorizeTrainNamesWithDictionary(train_class, names_vectors)::Vector{Vector{Int64}}
    train_Y = Vector{Vector{Int64}}()

    for one in train_class
        push!(train_Y, names_vectors[one])
    end

    return train_Y
end
