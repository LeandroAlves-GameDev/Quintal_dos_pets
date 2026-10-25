/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


#region Variaveis 

progresso = 0;
progresso_max = 60;

#endregion

#region Metodos

//Criando o metodo de desenho da barra de progressão
barra_progressao = function()
{
    //realizando o calculo de proporção
    proporcao = (progresso / progresso_max) * sprite_width;
    
    //ajustando o local do interior da progressão
    var eixo_x = x - (sprite_width / 2);
    //meu eixo_x vai ser igual a x - sprite width dividido por 2
    //ajustando o local do interior da progressão
    var eixo_y = y - (sprite_height / 7);
    //meu eixo_x vai ser igual a x - sprite height dividido por 2
    
    
    
    //desenhando nossa barra de preenchimento usando o draw_sprite_stretched
    //que pode ser usado para distorcer a sprite
    draw_sprite_stretched(spr_barra_interacao_interno, image_index, eixo_x, eixo_y, proporcao, 3);
    
    draw_self();
}

#endregion