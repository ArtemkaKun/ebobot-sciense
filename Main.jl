include("UsersNames.jl")
include("Dictionary.jl")
include("NNData.jl")
include("NN.jl")

using CSV, DataFrames

users_table = DataFrame(CSV.File("data_db\\users.csv"))

users_names = PrepareData(users_table[:, 2])

dictionary = PrepareDictionary(users_names)

PrepareNNData(1)

new_data_buffer = TrainNN()

outfile = "Names.txt"
f = open(outfile, "w")
for i in new_data_buffer # or for note in notes
    println(f, i)
end

close(f)

train_names = countmap(_classifiedData[:, 2])
names_count = countmap(new_data_buffer)

names_count

class = Dict{String, Int64}()

a = 1

for i in _realNames # or for note in notes
    sum = get(train_names, a, 0) + get(names_count, a, 0)
    get!(class, i, sum)

    global a += 1
end
