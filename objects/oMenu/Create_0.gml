/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Criando uma lista de arrays com as variaveis que eu quero
lista_menu = ["JOGAR", "SAIR"];

index_selecionado = 0;
//Criando a variavel de index

//criando as variaveis para voltar para ir a room quintal
transicionando = false;
minha_sequence = noone;


//Criando o metodo para poder se mover no menu
move_menu = function()
{
    //Criando as variaveis dos botoes
    up = keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up);
    down = keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down);
    //criando o botão de confirmação
    enter = keyboard_check_pressed(vk_enter);
    
    //Criando um sistema de if para ver qual o botão eu apertei
    if(down)
    {
        //se eu apertei down entao eu ganho index
        index_selecionado++;
        show_debug_message(index_selecionado)
    }
    if(up)
    {
        //se apertei up então eu perco index
        index_selecionado--;
        show_debug_message(index_selecionado)
       
    }
    //limitando o index do botão
    index_selecionado = clamp(index_selecionado, 0, 1)
    //o valor minimo será zero e o maximo será 1
    
    if(enter)
    {
         //Criando nosso sistema de navegação usando switch
         switch (index_selecionado) 
         {
         	//Informando para o switch que a expressão que quero e o index_selecionado
             
             //criando nosso cases
             case 0:
             {
                //Dentro desse primeiro case iremos nos referir 
                //rodando nosso sistema de transição
                if (room == rm_menu && !transicionando)
                   {
                     //então meu transicionando passará a ser como true ou seja verdadeiro
                     transicionando = true;
                     //rodando o sistema de transição de room
                     minha_sequence = layer_sequence_create("sq_transicao", x, y, sq_transicao_1)
                     //criando a minha sequencia
                   }
                break;
             } 
                
             case 1:
             {
                //se eu apertei baixo e estou no index então
                //estou no meu botão de sair
                //encerrando o jogo
                game_end();
                break;
             }   
         }   
    }
    
}


//Criando o metodo de desenhar o menu
desenha_menu = function()
{
    //Fazendo nosso metodo de desenhar o menu
    //criando variaveis pra nosso menu
    var escala = 1.5;
    //definindo a escala do botão para 3
    var pos_x = display_get_gui_width() / 12;
    var pos_y = display_get_gui_height() / 6;
    //definindo que será no canto nosso botão
    
    //desenhando o botão usando for
    for (var i = 0; i < 2; i++) 
    {
    	var pos_y_botao = pos_y + (i * 55)
        
        //criando um sistema de escala
        var escala_atual;
        
        if (index_selecionado == i)
        {
            //se meu index selecionado for igual ao meu indice
            escala_atual = 1.8; //entao o botão que estiver encima aumenta o tamanho
        }
        else
        {
            //se não estiver encima volta ao normal
            escala_atual = escala; //tamanho normal
        }
        
        //desenhando nosso botão
        draw_sprite_ext(spr_moldura_hud, 1, pos_x, pos_y_botao, escala_atual, escala_atual, 0, c_white, 1)
        
        //fazendo meu texto ficar centralizado ao botão
        draw_set_halign(fa_center)
        draw_set_valign(fa_middle)
        //informando para ele ficar no centro do botão
        //e informando para ele ficar no meio do botão
        
        //chamando nossa fonte 
        draw_set_font(fnt_menu);
        
        draw_text(pos_x, pos_y_botao,lista_menu[i]);
        
    }
    //resentando tudo
    draw_set_font(-1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}


checar_transicao = function()
{
    if (transicionando && layer_sequence_exists("sq_transicao", minha_sequence))
    {
        //se meu transicionando for false e existir uma sq_transicao
        if (layer_sequence_is_finished(minha_sequence))
        {
            //então a minha sequencia e finalizado 
            //e eu sou transportado para room arvore
            room_goto(rm_quintal)
        }
    }
}