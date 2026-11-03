/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


//me desenhando
draw_self();

if(!desenha_texto) exit;

draw_set_font(fnt_caixadialogo)
draw_set_halign(0)
draw_set_valign(0)

//criando uma pequena margem para nossa caixa de dialogo
var marg = 3;
//fazendo o texto voltar metade da sprite
var _x = x - sprite_width / 2 + marg;
var _y = y - sprite_height / 2 + marg;
//informando a largura do meu texto
var larg = (sprite_width * 10) - (marg * 20);

//fazendo ele tentar descer de forma fluida
var _yy = _y + 5;
draw_text_transformed(_x, _yy, nome, 0.1, 0.1, 0);

_yy += 7;
draw_text_ext_transformed(_x, _yy, descricao, 60, larg, .1, .1, 0);

var _altura_desc = string_height_ext(descricao, 60, larg) * 0.1;
_yy += _altura_desc + 3;

draw_text_transformed(_x, _yy, "Nível: " + string(nivel), 0.1, 0.1, 0);

_yy += 7;
draw_text_transformed(_x, _yy, "Custo: " + string(custo), 0.1, 0.1, 0);
draw_set_font(-1)