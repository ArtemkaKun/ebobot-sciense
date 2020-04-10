include("UsersNames.jl")
include("Dictionary.jl")
include("NNData.jl")
include("NN.jl")

using CSV, DataFrames

users_table = DataFrame(CSV.File("data_db\\users.csv"))

users_names = PrepareData(users_table[:, 2])

dictionary = PrepareDictionary(users_names)

PrepareNNData(0.7)

TrainNN()
