/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

#region Variaveis

//Criando o sistema de moeda
//dando uma velocidade para a moeda
vel = 3;
//Criando uma variavel de alvo pro player
alvo = oGato;

//Criando uma variavel de rang
range = 150;

//Criando um sistema de tempo para que minha moeda fique na room
tempo_vida = 0;
tempo_max_vida = 300;

#endregion

#region Metodo

//Criando o metodo de ir até o player
segue_player = function()
{
    //blindando o codigo
    if(room == rm_quintal)
    {
        vel = 0;
        return;
    }
    
    //ele vai verificar a distancia entre meu objeto moeda com o player se maior que o raio
    var localiza_player = point_distance(x, y, oGato.x, oGato.y) <= range
    if(localiza_player)
    {
        //se for maior então ele fará com que o objeto se mova até o alvo
        move_towards_point(alvo.x, alvo.y, vel)
    }
}

//Criando o metodo de colisão com o player
colide_player = function()
{
    //blindando o codigo
    if(room == rm_quintal)
    {
        vel = 0;
        return;
    }
    var acerta_player = instance_place(x, y, oGato)
    //verificando se ele colidiu com o objeto gato
    if(acerta_player != noone)
    {
        //se ele colidiu com o objeto gato
        with (acerta_player)
        {
            //então será aplicado o efeito brilho dentro do objeto
            //chamando o metodo aplica brilho no gato
            aplica_brilho(c_white, 2);
        }
        //se ele confirmou a colisão com o player
        //então eu ganho um ponto
        global.pontos += 1;
        
        //toda vez que ele tocar no player e for pego
        //roda o som da moeda
        audio_play_sound(snd_moedas, 1, 0);
        //destruindo a moeda
        instance_destroy();
    }
}

//Criando um metodo pra destruir a moeda caso eu não pegue ela
destroi_moeda = function()
{
    //ganhando tempo pra moeda
    tempo_vida++;
    //conforme eu ganho tempo vida ele faz com que a divisão se aproxime de 1, assim o alpha da moeda vai
    //diminuindo
    image_alpha = 1 - (tempo_vida / tempo_max_vida);
    if(tempo_vida >= tempo_max_vida)
    {
        instance_destroy();
    }
}

segue_loja = function()
{
    if (instance_exists(oLoja))
    {
        //verifica a distância até a loja
        var distancia_loja = point_distance(x, y, oLoja.x, oLoja.y);
        
        //se estiver perto o suficiente da loja ela é puxada para o centro dela
        if (distancia_loja > 5)
        {
            move_towards_point(oLoja.x, oLoja.y, 4); // Velocidade que ela voa para a loja
        }
        else
        {
            //quando encosta na loja, a loja "absorve" a moeda!
            vel = 0;
            
            //adiciona 1 moeda na carteira de upgrades do jogador
            global.moedas_loja += 1;
            
            //quando a loja pegar a moeda ele roda o som
            var som_aleatorio = choose(snd_moedas, snd_moedas2, snd_moedas3);
            //ele vai escolher entre esses tres sons
            //feito isso ele vai definir qual som vai tocar naquele momento
            audio_play_sound(som_aleatorio, 1, 0);
            with(oLoja)
            {
                //dentro do objeto loja ele sofre a aplicação do efeito mola
                //rodando o efeito mola da loja
                efeito_mola(1.4, 1.2)
            }
            //Destroi a moeda física
            instance_destroy();
        }
    }
}

#endregion
