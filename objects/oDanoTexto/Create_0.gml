/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


//por padrão dano será zero
dano = 0;

//dando uma velocidade vertical 
velv = -1.5;
//dando uma velocidade horizontal aleatoria
velh = random_range(-1, 1);

//Criando um timer pra letras
tempo_vida = 60;
timer = tempo_vida;
//meu timer será igual ao valor do tempo_vida
alfa = 1;
//informando a opacidade do alfa


//Criando o metodo para desenhar o texto
desenha_texto_dano = function()
{
    draw_set_halign(fa_center);
    //informando que horizontalmente ele e no centro
    draw_set_valign(fa_middle)
    //informando que será no meio
    
    //informando o alpha do desenho
    draw_set_alpha(alfa);
    
    draw_set_font(fnt_texto_dano);
    //informando a fonte do jogo
    
    //desenhando o texto
    draw_text_color(x + 1, y + 1, string(dano), c_black, c_black, c_black, c_black, alfa);
    //fazendo o texto por cima
    draw_text_color(x, y, string(dano), c_white, c_white, c_white, c_white, alfa);
    
    //resentando as variaveis
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
}