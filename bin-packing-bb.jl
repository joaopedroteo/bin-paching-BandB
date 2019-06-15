using JuMP
using Gurobi
# Dados do problema

# Numero de itens
n = 20

# Capacidade da mochila
C = 80
cont = 0
# Lucro da mochila
u = [40, 64, 11, 84, 47, 34, 97, 22, 29, 58, 25, 72, 89, 68, 98, 94, 50, 63, 35, 32]

# Peso da mochila
p = [9, 36, 36, 17, 23, 29, 23, 50, 36, 38, 33, 43, 49, 6, 31, 30, 11, 8, 21, 49]

n = collect(1:20)

model = Model(with_optimizer(Gurobi.Optimizer))

# Variável indica se o item foi adicionado na mochila(1) ou não(0)
@variable(model, 1>= x[n] >= 0)

# O objetivo do modelo é maximizar a soma dos lucros de cada item adicionado à mochila
@objective(model, Max, sum(x[i] * u[i] for i in n))

# A única restrição diz que a soma dos pesos dos itens selecionados não pode ultrapassar o limite máximo da mochila
@constraints(model, 
    begin
        sum(x[i]*p[i] for i in n) <= C
    end)


for k in collect(1:2)
    optimize!(model)
    println("Função ótima: ", JuMP.objective_value(model))

    # peso_total = 0
    for i in n
        # println("x", i, ": ", JuMP.value(x[i]))
        # println(JuMP.value(x[i]) % 1)
        if(JuMP.value(model, x[i]) % 1 != 0)
            model1 = model
            @constraint(model1, x[i] >= 1)
            model2 = model
            @constraint(model2, x[i] <= 0)
            optimize!(model1)
            optimize!(model2)
        end
        # if(JuMP.value(x[i]) == 1)
        #    peso_total =  peso_total + p[i]
        # end
    end
    println("Função ótima: ", JuMP.objective_value(model))
end
# println("Peso total = ", peso_total)

println("Função ótima: ", JuMP.objective_value(model))

