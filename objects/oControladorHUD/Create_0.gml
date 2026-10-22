/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


//criando o metodo de desenho pro icone da moeda
desenha_moeda_icone = function()
{
    var _escala = 3; // Reduzi ligeiramente a escala para não ocupar tanto espaço
    var _x = display_get_gui_width() - 300; // Posição fixa a partir da direita
    var _y = 55;
    
    draw_set_font(fnt_completa);
    draw_set_valign(fa_middle);
    
    // Desenha o ícone
    draw_sprite_ext(spr_moeda_icone, 0, _x, _y, _escala, _escala, 0, c_white, 1);
    
    // Desenha o texto logo à frente do ícone
    var _w_icon = sprite_get_width(spr_moeda_icone) * _escala / 1.5;
    draw_text(_x + _w_icon, _y, string(global.pontos));
    
    draw_set_valign(fa_top);
    draw_set_font(noone);
}


desenha_moeda_habilidade_icone = function()
{
    var _escala = 3; // Reduzi ligeiramente a escala para não ocupar tanto espaço
    var _x = display_get_gui_width() - 150; // Posição fixa a partir da direita
    var _y = 55;
    
    draw_set_font(fnt_completa);
    draw_set_valign(fa_middle);
    
    // Desenha o ícone
    draw_sprite_ext(spr_moeda_habilidades, 0, _x, _y, _escala, _escala, 0, c_white, 1);
    
    // Desenha o texto logo à frente do ícone
    var _w_icon = sprite_get_width(spr_moeda_icone) * _escala / 1.5;
    draw_text(_x + _w_icon, _y, string(global.moedas_loja));
    
    draw_set_valign(fa_top);
    draw_set_font(noone);
}


//criando o metodo de desenhar a vida do player
desenha_vida_player = function()
{
    var _escala = 3;
    //minha escala será o tamanho de 3
    var _y = 55;
    //passando a altura do y
    var _x = 130;
    //passando a largura do x
    
    
    draw_set_font(fnt_completa);
    draw_set_valign(fa_middle);
    
    //rodando nosso for
    for (var i = 0; i < 3; i++) 
    {
        //rodando seguinte calculo
        //pos_x e igual a meu _x soma pelo indice multiplicado por 60
        var _pos_x = _x + (i * 60);
    	//meu indice e igual a 0, se meu indice for menor que o valor de 3
        //então eu somo meu indice
        draw_sprite_ext(spr_vida, 1, _pos_x, _y, _escala, _escala, 0, c_white, 1);
    }
}