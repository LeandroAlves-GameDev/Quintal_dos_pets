/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
//chamando nossos metodos no step
estado();
//chamando meu estado principal

//chamando o metodo de colisão direto no step não dentro do metodo gato_move pois daria bug na animação
//ficaria trocando entra muda sprite parado e movendo rapidamente
colisoes_metodo()

cata_inputs()

gato_move()

retorna_efeito_brilho()

velh_max = calcula_velocidade();
velv_max = calcula_velocidade();

//depth = -y;