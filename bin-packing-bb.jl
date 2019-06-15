# Dados do problema

# Numero de itens
n = 20

# Capacidade da mochila
C = 80

# Lucro da mochila
u = [40, 64, 11, 84, 47, 34, 97, 22, 29, 58, 25, 72, 89, 68, 98, 94, 50, 63, 35, 32]

# Peso da mochila
p = [9, 36, 36, 17, 23, 29, 23, 50, 36, 38, 33, 43, 49, 6, 31, 30, 11, 8, 21, 49]

x = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0]

function lucro(p, u, x)
    soma = 0
    for i in collect(1:n)
        soma += u[i] * x[i]
    end
    return soma
end

lucro(p, u, x)

