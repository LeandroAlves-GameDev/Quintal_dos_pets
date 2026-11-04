/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

#region Variaveis


//Criando o sistema de movimentos do nosso cat
velh = 0;
//definindo a vel dele para zero
velh_max = 2;
//valor da velh dele max será de 3
//dando uma velv pro gato tambem
velv = 0;
velv_max = 2;

//usando o sistema de colisão para tiles
_layer = layer_tilemap_get_id("tl_detalhes")

//Criando uma variavel que armazena uma array list
colisoes = [oLoja, oCerca, oCerca_lateral, _layer, oTransporte, oTransporte_upgrade]

//Criando uma variavel para ver se posso criar a arma
crio_arma = false;


#endregion



#region Metodos

//Criando um metodo de seguir o gato
amigo_move = function()
{
    if (!instance_exists(oGato)) exit;
    
    
    var _target_x = oGato.x - (8 * oGato.image_xscale); 
    var _target_y = oGato.y - 8;
    
    
    velh = (_target_x - x) * 0.1;
    velv = (_target_y - y) * 0.1;
    
    
    var _colisor = array_length(colisoes);
    for(var i = 0; i < _colisor; i++)
    {
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
    
    
    x += velh;
    y += velv;
    
    image_xscale = -oGato.image_xscale;
}

muda_sprite = function(spr = spr_dog_idle)
{
    if(sprite_index != spr)
    {
        sprite_index = spr;
        image_index = 0;
    }
}

//Criando o metodo de segurar a arma
segura_arma = function()
{
    var cria_arma = instance_create_layer(oAumiguinho.x, oAumiguinho.y + 5, "Arma", oGun_osso)
}

//desenhando o efeito de sombre
desenha_sombra = function()
{
    draw_sprite(spr_sombra, 1, x, y)
}


executa_colisoes = function()
{
    var _colisor = array_length(colisoes);
    for(var i = 0; i < _colisor; i++)
    {
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


amigo_parado = function()
{
    
    muda_sprite(spr_dog_idle); 
    
    if (instance_exists(oGato))
    {
        
        var _target_x = oGato.x - (12 * oGato.image_xscale); 
        var _target_y = oGato.y - 8;
        
        velh = (_target_x - x) * 0.1;
        velv = (_target_y - y) * 0.1;
        
       
        executa_colisoes();
        
        x += velh;
        y += velv;
        
        
        image_xscale = -oGato.image_xscale;
        
       
        if (abs(velh) > 0.2 || abs(velv) > 0.2)
        {
            estado = amigo_movendo;
        }
        if (room == rm_combate)
        {
        estado = estado_combate;
        }
    }
}

amigo_movendo = function()
{
    
    muda_sprite(spr_dog_walk); 
    
    if (instance_exists(oGato))
    {
        var _target_x = oGato.x - (8 * oGato.image_xscale); 
        var _target_y = oGato.y - 8;
        
        velh = (_target_x - x) * 0.1;
        velv = (_target_y - y) * 0.1;
        
        executa_colisoes();
        
        x += velh;
        y += velv;
        
        image_xscale = -oGato.image_xscale;
        
        
        if (abs(velh) <= 0.2 && abs(velv) <= 0.2)
        {
            estado = amigo_parado;
        }
        if (room == rm_combate)
        {
           estado = estado_combate;
        }
    }
}

//Criando nosso estado de combate para o amiguinho
estado_combate = function()
{
    
    if (instance_exists(oGato))
    {
        var _target_x = oGato.x - (8 * oGato.image_xscale); 
        var _target_y = oGato.y - 8;
        
        velh = (_target_x - x) * 0.1;
        velv = (_target_y - y) * 0.1;
        
        
        var _colisor = array_length(colisoes);
        for(var i = 0; i < _colisor; i++)
        {
            if(colisoes[i])
            {
                if(place_meeting(x + velh, y, colisoes[i])) velh = 0;
                if(place_meeting(x, y + velv, colisoes[i])) velv = 0;
            }
        }
        
        x += velh;
        y += velv;
        image_xscale = -oGato.image_xscale;
    }

    
    var _parado = (abs(velh) <= 0.2 && abs(velv) <= 0.2);
    
    if(_parado)
    {
        
        muda_sprite(spr_dog_ataque_idle); 
    }
    else
    {
        
        muda_sprite(spr_dog_ataque);
    }
    
   
    if(!crio_arma)
    {
        
        segura_arma();
        crio_arma = true;
    }
}

#endregion


estado = amigo_parado;