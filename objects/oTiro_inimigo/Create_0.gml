/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


#region Variaveis

//Criando o sistema de tiro
//dando a velocidade do tiro
velh = 3;
velv = 3;

direcao = 0;

#endregion


//criando o metodo de velocidade da bala e angulo dela
move_tiro = function()
{
    x += lengthdir_x(velh, direcao) 
    y += lengthdir_y(velv, direcao) 
    
}

//Criando um metodo para destruir o tiro ao sair da room
destroi_tiro = function()
{
    if(x > room_width + 16)
    {
        instance_destroy();
    }
    if(x < -16)
    {
        instance_destroy();
    }
    if(y > room_height + 16)
    {
        instance_destroy();
    }
    if(y < -16)
    {
        instance_destroy();
    }
    
}


//Criando o sistema de colisão do tiro
aplica_colisao = function()
{
    //se meu gato existe e o estado dele e diferente ou igual a estado morte
    if(instance_exists(oGato) && oGato.estado != oGato.estado_morte)
    {
        //dai ele roda tudo isso
        var alvo = instance_place(x, y, oGato);
        //verificando a o tiro pegou no gato
        //rodando um if de verificação
        if(alvo != noone)
        {
            //se meu alvo for igual ou diferente de nada
            //ele roda o som do dano
            audio_play_sound(snd_dano, 1, 0);
            oScreenshake.treme = 10
            //ele aplica o sistema de Screenshake
            //então: 
            with (alvo)
            {
                //então será aplicado o efeito brilho dentro do objeto
                //chamando o metodo aplica brilho no gato
                aplica_brilho(c_white, 2);
                alvo.toma_dano(5);
            }
            //se colidiu então ele destroi
            instance_destroy()
        }
    }    
}

