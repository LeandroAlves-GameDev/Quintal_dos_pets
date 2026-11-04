/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


//me desenhando
draw_self();

if(!desenha_texto) exit;



/*
draw_set_font(fnt_caixadialogo)
draw_set_halign(0)
draw_set_valign(0)

 */
//criando uma pequena margem para nossa caixa de dialogo
var marg = 4;
//fazendo o texto voltar metade da sprite
var _x = x - sprite_width / 2 + marg;
var _y = y - sprite_height / 2 + marg;
//informando a largura do meu texto
var larg = (sprite_width * 10) - (marg * 20);
var _yy = _y + 5;
////fazendo ele tentar descer de forma fluida

//draw_text_transformed(_x, _yy, nome, 0.1, 0.1, 0);
//

//draw_text_ext_transformed(_x, _yy, descricao, 60, larg, .1, .1, 0);

//
//draw_text_transformed(_x, _yy, "Nível: " + string(nivel), 0.1, 0.1, 0);
//

//draw_text_transformed(_x, _yy, "Custo: " + string(custo), 0.1, 0.1, 0);
//draw_set_font(-1)

//Arrumando a formatação do texto para ficar da maneira certa
var _primeira_letra = string_upper(string_char_at(nome, 1));
var _resto_texto = string_delete(nome, 1, 1);
var _nome_formatado = _primeira_letra + _resto_texto;

draw_set_halign(fa_center);
//alihando o texto do nome
//fazendo o nome da habilidade fica no meio dela
var _centro_x = x - 10;

//Criando o texto usando scribble
var _txt_nome = scribble(_nome_formatado).starting_format("fnt_caixadialogo", c_red).scale(0.1);
_txt_nome.draw(_centro_x, _yy, );
//desenhando meu texto com o scribble

draw_set_halign(fa_left);

_yy += 7;
var _txt_desc = scribble(descricao).starting_format("fnt_caixadialogo", c_white).scale(0.1);
_txt_desc.draw(_x, _yy, typist);
_txt_desc.wrap(sprite_width - marg * 2);

var _altura_desc = _txt_desc.get_height();
_yy += _altura_desc;

var _txt_nivel = scribble("Nível: " + string(nivel)).starting_format("fnt_caixadialogo", c_white).scale(0.1);
_txt_nivel.draw(_x, _yy);

_yy += 6;
var _txt_custo = scribble("Custo: " + string(custo)).starting_format("fnt_caixadialogo", c_white).scale(0.1);
_txt_custo.draw(_x, _yy);

