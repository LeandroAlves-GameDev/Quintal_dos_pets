/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


//criando o metodo de desenho pro icone da moeda
desenha_moeda_icone = function()
{
    var _escala = 3; //definindo o tamanho da escala
    var _x = display_get_gui_width() - 370; //deixando a posição fixa
    var _y = 55;
    //definindo a altura 
    
    draw_set_font(fnt_completa);
    draw_set_valign(fa_middle);
    
    //desenhando nosso icone 
    draw_sprite_ext(spr_moeda_icone, 0, _x, _y, _escala, _escala, 0, c_white, 1);
    
    //desenhando nosso texto
    var texto_icone = sprite_get_width(spr_moeda_icone) * _escala / 1.5;
    draw_text(_x + texto_icone, _y, string(global.pontos));
    
    draw_set_valign(fa_top);
    draw_set_font(noone);
}


desenha_moeda_habilidade_icone = function()
{
    var _escala = 3; //definindo o tamanho da escala
    var _x = display_get_gui_width() - 210; //deixando a posição fixa
    //definindo a altura 
    var _y = 55;
    
    draw_set_font(fnt_completa);
    draw_set_valign(fa_middle);
    
    //desenhando nosso icone 
    draw_sprite_ext(spr_moeda_habilidades, 0, _x, _y, _escala, _escala, 0, c_white, 1);
    
    //desenhando nosso texto
    var texto_icone = sprite_get_width(spr_moeda_icone) * _escala / 1.5;
    draw_text(_x + texto_icone, _y, string(global.moedas_loja));
    
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
    var _x = 200;
    //passando a largura do x
    
    
    draw_set_font(fnt_completa);
    draw_set_valign(fa_middle);
    
    draw_sprite_ext(spr_icone_vida, 0, _x - 155, _y, _escala, _escala, 0, c_white, 1);
    draw_sprite_ext(spr_vida, 1, _x, _y, _escala, _escala, 0, c_white, 1);
    draw_sprite_ext(spr_moldura_barra_vida, 0, _x, _y, _escala, _escala, 0, c_white, 1);
}

//Criando um metodo para desenhar a moldura da hud
desenha_moldura_hud = function()
{
    var _escala = 3;
    //minha escala será o tamanho de 3
    var _y = 55;
    //passando a altura do y
    var _x = 180;
    //passando a largura do x
    
    for (var i = 0; i < 2; i++) 
    {
    	//realizando o calculo de posição
        var pos_x = _x + (i * 860)
        
        draw_sprite_ext(spr_moldura_hud, 1, pos_x, _y, _escala, _escala, 0, c_white, 1)
    }
}


//criando nossa hud do tempo
desenha_hud_tempo = function()
{
    if(instance_exists(oGame_manager))
    {
        var _escala = 3;
        //minha escala será o tamanho de 3
        var _y = display_get_gui_height() - 55;
        //passando a altura do y
        var _x = display_get_gui_width() / 2;
        //passando a largura do x
        
        //criando uma variavel temporaria que vai pegar oGame_manager e chamar a variavel tempo_fase dentro dele
        var _tempo_atual = oGame_manager.tempo_fase; 
        //criando a variavel temporaria max que pega o tempo fase max do oGame_manager
        var _tempo_max = oGame_manager.tempo_fase_max;
        var _porcentagem = 0;
        //criando a variavel porcentagem que leva 0
        if (_tempo_max > 0)
        {
            //se meu tempo max for maior que zero
            //então ele roda o seguinte calculo
            //tempo atual dividido por tempo max será o resultado de porcentagem
           _porcentagem = _tempo_atual / _tempo_max;
        }
        draw_sprite_ext(spr_barra_tempo, 0, _x - (sprite_get_width(spr_barra_tempo) * _escala / 2), _y, _escala * _porcentagem, _escala, 0, c_white, 1);
        draw_sprite_ext(spr_moldura_tempo, 0, _x, _y, _escala, _escala, 0, c_white, 1);
    }
    
    
}