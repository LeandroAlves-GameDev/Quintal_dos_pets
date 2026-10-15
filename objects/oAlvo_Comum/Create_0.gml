/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Passando o metodo que squash 
inicia_efeito_mola();
//chamando o efeito de brilho
inicia_efeito_brilho();

#region Variaveis

//Criando o sistema de alvos no jogo
vida = 3;

//Dando variaveis de velocidade para ele
velh = 3;
velv = 3;


//Criando uma variavel de tempo
tempo_random = random_range(5, 10);
//deixando a variavel tempo aleatoria


#endregion


#region Metodos

//Criando o metodo de muda rota
muda_rota = function()
{
    tempo_random--;
    //fazendo eu perder tempo
    if(tempo_random <= 0)
    {
        velh = random_range(-2, 2);
        velv = random_range(-2, 2);
        
        tempo_random = random_range(60, 180);
    }
    x += velh;
    y += velv;
    //fazendo o inimigo olhar pra direçao certa
    if(velh > 0)
    {
        image_xscale = 1;
    }
    else if(velh < 0)
    {
        image_xscale = -1;
    }
    //Criando um if para caso ele passe do limite da room ele volte por algum outro lado
    if(x > room_width + 32)
    {
        x = -32
    }
    else if (x < -32)
    {
        x = room_width + 32;
    }
    if (y > room_height + 32)
    {
        y = -32;
    }
    else if (y < -32)
    {
        y = room_height + 32;
    }
}

//Criando o metodo de colisão com o tiro
colide_tiro = function()
{
    var _colidir_tiro = instance_place(x, y, oTiro)
    //criando um if para ver colidi com o tiro
    if (_colidir_tiro != noone)
    {
        var _dano_recebido = _colidir_tiro.dano_tiro;
        //chamando o meu efeito de brilho
        aplica_brilho(c_white, 2);
        //fazendo eu perder vida
       vida -= _dano_recebido;
       oScreenshake.treme = 10
        //destruindo o meu tiro
       instance_destroy(_colidir_tiro);
       //Chamando o efeito de mola 
       efeito_mola(.7, 1.3)
       if(vida <= 0)
       {
            oScreenshake.treme = 20;
           //se eu morri então ele cria minha moeda
           var _qtd_moedas = calcula_espolio();
           repeat(_qtd_moedas)
           {
               instance_create_layer(x, y, "Loja", oMoeda);
           }
           //se minha vida for menor ou igual a zero então eu sou destruido
           instance_destroy();
       }
    }
}



#endregion
