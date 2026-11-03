/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if(global.hitstop) exit;

//chamando nossos metodos no step
estado();
//chamando meu estado principal

//chamando o metodo de colisão direto no step não dentro do metodo gato_move pois daria bug na animação
//ficaria trocando entra muda sprite parado e movendo rapidamente
colisoes_metodo();

cata_inputs();

gato_move();

checar_transicao();

retorna_efeito_brilho();

retorna_mola();

//depth = -y;