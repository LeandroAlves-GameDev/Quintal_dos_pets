/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//criando os amiguinhos 
var _total_amigos = calcula_amigos();

//o jogador já comprou o "Início" (_total_amigos maior que 0), criamos os amiguinhos
for (var i = 0; i < _total_amigos; i++)
{
    //Criamos o amiguinho na mesma posição do gato
    instance_create_layer(x, y, "Player", oAumiguinho);
}


inicia_efeito_brilho();

//Criando uma region para melhorar o codigo
#region Variaveis

//Criando o sistema de movimentos do nosso cat
velh = 0;
//definindo a vel dele para zero
velh_max = 2;
//valor da velh dele max será de 3
//dando uma velv pro gato tambem
velv = 0;
velv_max = 2;

//Criando as variaveis de controle pro nosso jogo
right = noone;
left = noone;
up = noone;
down = noone;
select = noone;
fora_loja = noone;
ataque = noone;

//Criando uma variavel de estado para nosso jogo
estado = noone

//usando o sistema de colisão para tiles
_layer = layer_tilemap_get_id("tl_detalhes")


//Criando uma variavel que armazena uma array list
colisoes = [oLoja, oCerca, oCerca_lateral, _layer, oTransporte]

//Criando uma variavel para ver se posso criar a arma
crio_arma = false;

//Criando variaveis para verificar quanto tempo estou segurando o botão la ele
tempo_segurando = 0;
tempo_necessario = 60;

#endregion


#region Metodos


//Criando nosso primeiro metodo para pegar os inputs do player
cata_inputs = function()
{
    //criando o metodo que puxa nossa inputs
    right = keyboard_check(ord("D")) || keyboard_check(vk_right);
    left = keyboard_check(ord("A")) || keyboard_check(vk_left);
    up = keyboard_check(ord("W")) || keyboard_check(vk_up);
    down = keyboard_check(ord("S")) || keyboard_check(vk_down);
    //Criando a tecla de seleção
    select = keyboard_check(ord("E")) || keyboard_check(ord("Q"));
    select_solto = keyboard_check_released(ord("E")) || keyboard_check_released(ord("Q"));
    //criando a tecla de saida da loja
    //fora_loja = keyboard_check(vk_escape);
    //criando nossa tecla/mouse para ataque
    ataque = mouse_check_button(mb_left);
}


//Criando nosso metodo de ganhar velocidade com player
gato_move = function()
{
    //criando nosso metodo de movimentos para o player
    velh = (right - left) * velh_max;
    //o que está sendo feito, ele está somando subtraindo primeiro meu right - left
    //para ver qual posição estou indo e depois ele mutplica por velh_max que meu maximo de velocidade
    //assim ele dará resultado do valor de velh
    
    //criando o sistema para se mover para cima
    velv = (down - up) * velv_max
    //a mesma logica se aplicará o o movimento vertical
    
    
    
    //meu velh será incrementado ao x da room da a sensação de movimento
    move_and_collide(velh, velv, colisoes, 8);
    
    
    //rodando um if para mudar a sprite de direção
    if(velh > 0)
    {
        //se meu velh for maior que 0 entao meu imagem_xsacel passa a ser 1
        //então a sprite passa a andar para a direita
        image_xscale = 1;
    }
    if(velh < 0)
    {
        //se meu velh for menor que 0 entao meu imagem_xsacel passa a ser 0
        //então a sprite passa a andar para a esquerda
        image_xscale = -1;
    }
    //criando um if para mudar a posição da room ao sair dela
    if(x > room_width)
    {
        //se meu x for maior que a room largura
        //então X passa a ser 0
        x = 0;
    }
    if(x < 0)
    {
        //se meu x for menor que zero
        x = room_width;
        //meu x passa a ser a largura da room
    }
    if(y > room_height)
    {
        y = 0;
    }
    if(y < 0)
    {
        y = room_height;
    }
}

//Criando o metodo de colisão
colisoes_metodo = function()
{
    //usamos um array lenght e informamos qual colisão ele se refere
    var _colisor = array_length(colisoes)
    for(var i = 0; i < _colisor; i++)
    {
        //criando laço de repetição usando for
        //ele pediu um indice que será nosso i que por padrão e igual a zero
        //se meu i encontrar uma valor maior que o dele então o loop para
        //valor maior seria o _colisor com o array lista
        //apos isso ele vai olhar e somar i++ e parte para o proximo item da lista
        
        //criando um if para nosso laço de repeticão
        if(colisoes[i])
        {
            if(place_meeting(x + velh, y, colisoes[i]))
            {
                velh = 0;
            }
            if(place_meeting(x, y + velv, colisoes[i]))
            {
                velv = 0;
            }
            
        }
    }
}


//Criando o metodo de segurar a arma
segura_arma = function()
{
    var cria_arma = instance_create_layer(oGato.x, oGato.y + 5, "Arma", oGun)
}


//Criando um metodo para a troca de sprite ser melhor
muda_sprite = function(spr = spr_gato_idle)
{
    //se meu sprite index for diferente do meu argumento spr
    if(sprite_index != spr)
    {
        //então meu sprite index passa a ser igual ao da argumentação
        sprite_index = spr;
        //por padrão nossa image_index e zero
        image_index = 0;
    }
}


//Criando a maquina de estados do gato
estado_parado = function()
{
    //chamando nosso metodo de troca de sprite dentro do movimentos do gato
    muda_sprite(spr_gato_idle);
    
    //se meu right for diferente de left então eu chamo o estado movendo 
    if(right != left)
    {
        estado = estado_movendo;
        //rodando um debug para ver se estou me movendo
        //show_message("Estou ando para os lados" + string(estado))
    }
    //se meu up for diferente de down então chamo o estado movendo
    if(up != down)
    {
        
        estado = estado_movendo;
        //rodando um debug para ver se estou me movendo
        //show_message("Estou ando para cima ou baixo" + string(estado))
    }
    if(instance_exists(oLoja) && point_distance(x, y, oLoja.x, oLoja.y) < 55 && select)
    {
        //se minha instancia loja existe e eu estou dentro do raio de alcançe da loja
        //e apertei o botão select
        //se meu global.pontos for maior que zero então eu posso interagir
        if(global.pontos > 0)
        {
            estado = estado_interagindo; 
            //então meu estado irá para estado_interagindo 
        }
        
    }
    if(instance_exists(oTransporte) && point_distance(x, y, oTransporte.x, oTransporte.y) < 35 && select)
    {
        //se minha instancia oTransporte existe e eu estou dentro do raio de alcançe do oTransporte
        //e apertei o botão select
        estado = estado_interagindo;
        //então meu estado irá para estado_interagindo 
    }
    if(instance_exists(oTransporte_upgrade) && point_distance(x, y, oTransporte_upgrade.x, oTransporte_upgrade.y) < 35 && select)
    {
        //se minha instancia oTransporte existe e eu estou dentro do raio de alcançe do oTransporte
        //e apertei o botão select
        estado = estado_interagindo;
        room_goto(rm_arvore)
        //então meu estado irá para estado_interagindo 
    }
    //fazendo eu ir pro estado de combate
    if(room == rm_combate)
    {
        estado = estado_combate;
    }
}

//Criando o estado movendo do gato
estado_movendo = function()
{
    
    //chamando nosso metodo de troca de sprite dentro do movimentos do gato
    muda_sprite(spr_gato_walk);
    
    if(velh == 0 && velv == 0)
    {
        
        estado = estado_parado;
        //rodando um debug para ver se estou me movendo
        //show_message("Parei" + string(estado))
    }
    if(instance_exists(oLoja) && point_distance(x, y, oLoja.x, oLoja.y) < 55 && select)
    {
        //se minha instancia loja existe e eu estou dentro do raio de alcançe da loja
        //e apertei o botão select
        if(global.pontos > 0)
        {
            estado = estado_interagindo; 
            //então meu estado irá para estado_interagindo 
        }
        //então meu estado irá para estado_interagindo 
    }
    if(instance_exists(oTransporte) && point_distance(x, y, oTransporte.x, oTransporte.y) < 35 && select)
    {
        //se minha instancia oTransporte existe e eu estou dentro do raio de alcançe do oTransporte
        //e apertei o botão select
        estado = estado_interagindo;
        //então meu estado irá para estado_interagindo 
    }
    if(instance_exists(oTransporte_upgrade) && point_distance(x, y, oTransporte_upgrade.x, oTransporte_upgrade.y) < 35 && select)
    {
        //se minha instancia oTransporte existe e eu estou dentro do raio de alcançe do oTransporte
        //e apertei o botão select
        estado = estado_interagindo;
        room_goto(rm_arvore)
        //então meu estado irá para estado_interagindo 
    }
    if(room == rm_combate)
    {
        estado = estado_combate;
    }
}

//Criando o metodo para interação do player
estado_interagindo = function()
{
    //zero a minha velocidade nesse estado
    velh_max = 0;
    velv_max = 0;
    
    //chamando nosso metodo de troca de sprite dentro do movimentos do gato
    muda_sprite(spr_gato_troca);
    
    //Criando nosso metodo para interagir
    if(select)
    {
        if(global.pontos > 0)
        {
           tempo_segurando++;
           //ganhando tempo segurando o botão E
           
           //rodando o if para ver o tempo e maior que o necessario
           if(tempo_segurando >= tempo_necessario)
           {
            //guardando o valor de pontos do player
            var quantidade_pontos = global.pontos;
            //se meu tempo_segurando e maior ou igual a  tempo_necessario
            //então ele reseta meu tempo segurando
            //reseta meus pontos
               tempo_segurando = 0;
               global.pontos = 0;
                //se minha loja existir
               if(instance_exists(oLoja))
               {
                   repeat(quantidade_pontos)
                   {
                        var pos_x = oLoja.x + irandom_range(-15, 15);
                        var pos_y = oLoja.y + irandom_range(-15, 15);
                        instance_create_layer(pos_x, pos_y, "Moedas", oMoeda);
                   }
               }
            
            
               //ele mantem a minha velocidade
               velh_max = 2; 
               velv_max = 2;
               //e eu troco o meu estado para estado parado
               estado = estado_parado;
           }
        }
        
        
    }
    //se eu soltei o botão select
    if(select_solto)
    {
        //então ele reseta o tempo, velocidade e o estado para parado
        tempo_segurando = 0;
        velh_max = 2; 
        velv_max = 2;
        estado = estado_parado;
    }
}

//Criando nosso estado de combate
estado_combate = function()
{
    //Criando um sistema de melhoria para a sprite
    var _parado = (velh == 0 && velv == 0)
    //se eu estou parado se me mover
    if(_parado)
    {
        //se e confirmado que estou parado durante o combate
        muda_sprite(spr_gato_ataque_idle);
        //então meu sprite muda para o ataque parado
    }
    else
    {
        muda_sprite(spr_gato_ataque);
    }
    
    if(!crio_arma)
    {
        //chamando o metodo de segurar arma apenas uma vez no create
        segura_arma();
        crio_arma = true;
    }
    
}

#endregion

//por padrão nossa variavel estado ela armazena o metodo estado_parado
estado = estado_parado;

