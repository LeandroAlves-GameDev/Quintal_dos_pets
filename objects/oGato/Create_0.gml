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


alvo = noone;

//Criando uma variavel que armazena uma array list
colisoes = [oLoja, oCerca, oCerca_lateral, _layer, oTransporte, oTransporte_upgrade]

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
    velv = (down - up) * velv_max;
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
    if(room == rm_combate)
    { 
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
            if(place_meeting(x + sign(velh), y, colisoes[i]))
            {
                velh = 0;
            }
            if(place_meeting(x, y + sign(velv), colisoes[i]))
            {
                velv = 0;
            }
            
        }
    }
}

//desenhando o efeito de sombre
desenha_sombra = function()
{
    //chamando a sprite da sombra
    draw_sprite(spr_sombra, 1, x, y)
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
    if(instance_exists(oLoja) && point_distance(x, y, oLoja.x, oLoja.y) < 45 && select)
    {
        //se minha instancia loja existe e eu estou dentro do raio de alcançe da loja
        //e apertei o botão select
        //se meu global.pontos for maior que zero então eu posso interagir
        if(global.pontos > 0)
        {
            estado = estado_interagindo_loja;
            //então meu estado irá para estado_interagindo 
        }
        
    }
    //if(instance_exists(oTransporte) && point_distance(x, y, oTransporte.x, oTransporte.y) < 10 && select)
    //{
        ////se minha instancia oTransporte existe e eu estou dentro do raio de alcançe do oTransporte
        ////e apertei o botão select
        ////estado = estado_interagindo_transporte;
        ////então meu estado irá para estado_interagindo 
    //}
    //if(instance_exists(oTransporte_upgrade) && point_distance(x, y, oTransporte_upgrade.x, oTransporte_upgrade.y) < 35 && select)
    //{
        ////se minha instancia oTransporte existe e eu estou dentro do raio de alcançe do oTransporte
        ////e apertei o botão select
        ////estado = estado_interagindo_transporte_upgrade;
        ////room_goto(rm_arvore)
        ////então meu estado irá para estado_interagindo 
    //}
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
    if(instance_exists(oLoja) && point_distance(x, y, oLoja.x, oLoja.y) < 45 && select)
    {
        //se minha instancia loja existe e eu estou dentro do raio de alcançe da loja
        //e apertei o botão select
        if(global.pontos > 0)
        {
            estado = estado_interagindo_loja; 
            //então meu estado irá para estado_interagindo 
        }
        //então meu estado irá para estado_interagindo 
    }
    
    //if(instance_exists(oTransporte) && point_distance(x, y, oTransporte.x, oTransporte.y) < 10 && select)
    //{
        ////se minha instancia oTransporte existe e eu estou dentro do raio de alcançe do oTransporte
        ////e apertei o botão select
        ////estado = estado_interagindo_transporte;
        ////então meu estado irá para estado_interagindo 
    //}
    //if(instance_exists(oTransporte_upgrade) && point_distance(x, y, oTransporte_upgrade.x, oTransporte_upgrade.y) < 35 && select)
    //{
        ////se minha instancia oTransporte existe e eu estou dentro do raio de alcançe do oTransporte
        ////e apertei o botão select
        ////estado = estado_interagindo_transporte_upgrade;
        ////room_goto(rm_arvore)
        ////então meu estado irá para estado_interagindo 
    //}
    if(room == rm_combate)
    {
        estado = estado_combate;
    }
}

//Criando o metodo para interação do player
estado_interagindo_loja = function()
{
    //definindo a vel como 0
    velh_max = 0;
    velv_max = 0;
    muda_sprite(spr_gato_troca);
    //mudando a sprite comb base no metodo muda sprite
    if(select)
    {
        //se eu apertei select
        if(!instance_exists(oBarra_progresso))
        {
            //ele vai verificar se a minha instancia barra de progressão existe
            //se não existe então ele cria a barra
            cria_barra = instance_create_layer(x, y - 35, "Efeito", oBarra_progresso);
        }
        //com a barra criada
        //ele vai verificar se existe novamente ela para evitar bugs
        if (instance_exists(cria_barra))
        {
            //se existe então ele pega o progresso do objeto barra progressão
            //e faz com a variavel progresso se torne igual ao tempo segurando
            cria_barra.progresso = tempo_segurando;
            cria_barra.x = x;
            //ele vai informar o x e y da onde esssa barra deve ficar
            cria_barra.y = y - 35;
        }
        
        //a cada 10 unidades de tempo segurando, o jogador perde pontos e gera moedas na loja
        if(tempo_segurando % 10 == 0) 
        { 
            //diminuindo o valor de global pontos
            global.pontos--;
            if(instance_exists(oLoja)) 
            {
                //se minha instancia loja existe
                var pos_x = oLoja.x + irandom_range(-15, 15);
                var pos_y = oLoja.y + irandom_range(-15, 15);
                //então ele vai calcular uma posição aleatorio dentro -15 e 15 e definir onde vai nascer a moeda
                instance_create_layer(pos_x, pos_y, "Moedas", oMoeda);
            }
        }
        
        //se meu global pontos for maior que zero
        if(global.pontos > 0)
        {
            //eu ganho tempo segurando
            tempo_segurando++;
            
            //se meu tempo segurando for maior ou igual o tempo necessario ou global pontos for menor ou igual que zero
            if(tempo_segurando >= tempo_necessario || global.pontos <= 0)
            {
                tempo_segurando = 0;
                //ele reseta o meu tempo
                
                if(instance_exists(cria_barra)) 
                {
                    //se minha instancia cria barra existe
                    //então ele destroi ela
                    instance_destroy(cria_barra); 
                }
                
                //resetando os valores para o numero original que e 2
                velh_max = 2; 
                velv_max = 2;
                //voltando ao estado de parado
                estado = estado_parado;
            }
        }
    }
    
    //se eu soltei a tecla E então ele ativa o select solto
    if(select_solto)
    {
        //com isso ele reseta meu tempo segurando
        tempo_segurando = 0;
        //minha vel max para o valor original
        velh_max = 2; 
        velv_max = 2;
        //volto para o estado parado
        estado = estado_parado;
        if(instance_exists(oBarra_progresso)) 
        { 
            //ele verifica se existe ainda a instancia barra progresso
            //se existe ele destroi ela
            instance_destroy(cria_barra); 
        }
    }
}


//criando esses estados para caso seja necessario
//estado_interagindo_transporte = function()
//{
    ////por padrão minha vel será zero nesse estado
    //velh_max = 0;
    //velv_max = 0;
    //muda_sprite(spr_gato_troca);
    ////mudando a sprite comb base no metodo muda sprite
    //if(select)
    //{
        ////se eu apertei select
        ////quer dizer que eu estou ganhando tempo
        //tempo_segurando++;
        //
        ////se meu tempo for maior ou igual ao necessario
        //if(tempo_segurando >= tempo_necessario)
        //{
            ////ele reseta o valor tempo segurando pra zero
            //tempo_segurando = 0;
            //
            ////ele reseta o vel para 2 que valor original 
            //velh_max = 2; 
            //velv_max = 2;
            ////ele muda o estado para parado
            //estado = estado_parado;
        //}
    //}
    //
    //if(select_solto)
    //{
        //tempo_segurando = 0;
        //velh_max = 2; 
        //velv_max = 2;
        //estado = estado_parado;
    //}
//}

//criando esses estados para caso seja necessario
//estado_interagindo_transporte_upgrade = function()
//{
    //velh_max = 0;
    //velv_max = 0;
    //muda_sprite(spr_gato_troca);
    //
    //if(select)
    //{
        //tempo_segurando++;
        //
        //if(tempo_segurando >= tempo_necessario)
        //{
            //tempo_segurando = 0;
            //
            //velh_max = 2; 
            //velv_max = 2;
            //estado = estado_parado;
        //}
    //}
    //
    //if(select_solto)
    //{
        //tempo_segurando = 0;
        //velh_max = 2; 
        //velv_max = 2;
        //estado = estado_parado;
    //}
//}

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
