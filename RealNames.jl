include("Dictionary.jl")

_realNames = ["nill_name", "Sania", "Sofia", "Maria", "Maksim", "Miha", "Artem", "Ania",
                "Danik", "Ivan", "Viktoria", "Alisa", "Nastia", "Dimka", "Polina",
                "Liza", "Aleksandra", "Dasha", "Katia", "Kiril", "Ksenia", "Andrei",
                "Matwei", "Arina", "Egor", "Mark", "Timka", "Veronika", "Roman",
                "Nikita", "Aleksei", "Lev", "Vova", "Vlad", "Vladislava", "Zenia",
                "Viktor", "Sergiei", "Anton", "Kostia", "Boris", "Rostik", "Slavik", "Igor",
                "Yurii", "Stas", "Vitalii", "Tolik", "Yarik", "Ira", "Denis", "Lena", "Karina",
                "Pavel", "Alina", "Artur", "David", "Gleb", "Grysza", "Yulia", "Leonid",
                "Olga", "Taras", "Ilia", "Nataliia", "Kolia", "Oleg", "Alena", "Tonia",
                "Bodia", "Diana", "Galina", "Ilona", "Ina", "Ivanka", "Lerka", "Nazar", "Petia",
                "Ruslan", "Sewa", "Stepan", "Sveta", "Tania", "Vadim", "Valera", "Yan",
                "Yaroslava", "Arsen", "Vasia", "German", "Kristina", "Myroslava", "Rita", "Arkadii",
                "Dana", "Lana", "Lidia", "Lili", "Luda", "Margo", "Marta", "Nadia", "Viola", "Yana",
                "Rodion"]

_vectorisedRealNames = VectorizeWords(_realNames)

function GetRealNames()::Vector{String}
    return _realNames
end

function GetVectorizedRealNames()::Vector{Vector{Int64}}
    return _vectorisedRealNames
end
