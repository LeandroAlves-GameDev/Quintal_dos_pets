/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

#region Variaveis

//Criando a variavel de tempo da fase
tempo_fase = calcula_tempo_fase();
tempo_fase_max = tempo_fase;

verificar_vitoria = false;
//variavel para se ganhei ou não


//Criando nosso sistema de tempo para os inimigos
tempo = 100;
//por padrão os inimigos nascem a cada 1 segundo
//criando uma variavel com lista de inimigos
inimigos = [oAlvo_Comum, oAlvo_Incomum] 
//por padrão teremos apenas um no momento
total_gerados = 0;
limite_total_fase = 15;

#endregion


#region Metodos

cria_inimigos = function()
{
    //criando um limite de spawn dos inimigos
    var limite_max = 15;
    //dando um valor limite para os inimigos
    quantidade_atual = instance_number(inimigos[0]);
    
    tempo--;
    if(tempo < 0 && quantidade_atual < limite_max && total_gerados < limite_total_fase)
    {
       //Criando um sistema para fazer o inimigos nascer nos cantos do mapa
       var lado = choose(1, 2, 3, 4);
       if(lado == 1)
       {
          spawn_x = -32;
          spawn_y = random_range(0, room_height);
       }
       else if(lado == 2)
       {
          spawn_y = -32;
          spawn_x = random_range(0, room_width); 
       } 
       else if(lado == 3)
       {
          spawn_y = room_height + 32;
          spawn_x = random_range(0, room_width); 
       }
       else if(lado == 4)
       {
          spawn_x = room_width + 32;
          spawn_y = random_range(0, room_height); 
       } 
       var criando_inimigos = instance_create_layer(spawn_x, spawn_y, "Inimigos", inimigos[0]);
       //ele vai criar inimigos na layer inimigos e usar o array list como base
       tempo = 100;
       //resetando o tempo 
       total_gerados++;
       verificar_vitoria = true 
    }
    
}


//Criando o metodo de verificar o fim da fase
verifica_fim_fase = function()
{
    //metodo responsavel por diminuir o tempo e ver os inimigos
    tempo_fase--;
    //fazendo o tempo regredir 
    //fazendo o if do tempo e inimigos
    if(verificar_vitoria)
    {
       if(tempo_fase < 0 || instance_number(inimigos[0]) == 0)
       {
           room_goto(rm_quintal)
       }
    }
    
}


#endregion
