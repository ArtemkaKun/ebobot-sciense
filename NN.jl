include("NNData.jl")
include("RealNames.jl")

using CUDAnative
using Flux
using Flux.Data
using Flux: crossentropy, normalise, onecold, onehotbatch, data
using Statistics: mean
using Plots

function TrainNN()
    model = Chain(Dense(2371, length(GetRealNames())), softmax)

    model = gpu(model)

    loss(x, y) = crossentropy(model(x), y)

    optimiser = ADAM(0.01)

    datas = zip(gpu(_trainDataX), gpu(_trainDataY))

    accu_time = Vector{Float64}()

    for e = 0:5
        println("Epoch: $e")

        Flux.train!(loss, params(model), datas, optimiser)

        push!(accu_time, CalcAccuracy(model))
    end

    plot(0:5, accu_time)
end

function CalcAccuracy(nn)::Float64
    accuracy_buffer = Vector{Int64}()

    for one in _testDataX
        push!(accuracy_buffer, argmax(nn(gpu(one))))
    end

    println(accuracy_buffer)

    accuracy_mean = 0

    i = 1
    for one in accuracy_buffer
        if one == findfirst(isequal(1), _testDataY[i])
            accuracy_mean += 1
        else
            accuracy_mean += 0
        end

        i += 1
    end

    return accuracy_mean / length(_testDataY)
end
