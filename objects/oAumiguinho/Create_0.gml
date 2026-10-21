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
colisoes = [oLoja, oCerca, oCerca_lateral, _layer, oTransporte]

//Criando uma variavel para ver se posso criar a arma
crio_arma = false;


#endregion



#region Metodos

//Criando um metodo de seguir o gato
amigo_move = function()
{
    if (!instance_exists(oGato)) exit;
    
    // 1. Em vez de inputs de teclado, o "alvo" é a posição atrás do gato
    var _target_x = oGato.x - (8 * oGato.image_xscale); 
    var _target_y = oGato.y - 8;
    
    // 2. Calculamos a velocidade necessária para nos aproximarmos suavemente do alvo (estilo lerp)
    velh = (_target_x - x) * 0.1;
    velv = (_target_y - y) * 0.1;
    
    // 3. Aplicamos o mesmo método de varrimento de colisão por array do player!
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
    
    // 4. Movemos o amiguinho com as velocidades ajustadas pelas colisões
    x += velh;
    y += velv;
    
    // 5. Espelha a sprite para a direção oposta do gato
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
    // Define a sprite de descanso/idle
    muda_sprite(spr_dog_idle); // Substitui pelo nome da tua sprite parado
    
    if (instance_exists(oGato))
    {
        // Alvo atrás do gato
        var _target_x = oGato.x - (12 * oGato.image_xscale); 
        var _target_y = oGato.y - 8;
        
        velh = (_target_x - x) * 0.1;
        velv = (_target_y - y) * 0.1;
        
        // Aplica o movimento e colisões com o array
        executa_colisoes();
        
        x += velh;
        y += velv;
        
        // Espelha a direção oposta do gato
        image_xscale = -oGato.image_xscale;
        
        // Se o amiguinho começou a mexer-se para acompanhar o gato, muda para o estado a andar
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
    // Define a sprite de movimento
    muda_sprite(spr_dog_walk); // Substitui pelo nome da tua sprite a andar
    
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
        
        // Se a velocidade for quase zero (apanhou o gato ou ambos pararam), volta ao estado parado
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
    // 1. O amiguinho continua a seguir o gato suavemente e a respeitar as colisões durante o combate
    if (instance_exists(oGato))
    {
        var _target_x = oGato.x - (8 * oGato.image_xscale); 
        var _target_y = oGato.y - 8;
        
        velh = (_target_x - x) * 0.1;
        velv = (_target_y - y) * 0.1;
        
        // Varre o array de colisões para não atravessar cercas/paredes
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

    // 2. Sistema de troca de sprite de combate (parado vs a mover-se)
    var _parado = (abs(velh) <= 0.2 && abs(velv) <= 0.2);
    
    if(_parado)
    {
        // Altera para a sprite de combate parado (substitui pelo nome real da tua sprite)
        muda_sprite(spr_dog_ataque_idle); 
    }
    else
    {
        // Altera para a sprite de combate a andar (substitui pelo nome real da tua sprite)
        muda_sprite(spr_dog_ataque);
    }
    
    // 3. Criar a arma do amiguinho apenas uma vez ao entrar em combate
    if(!crio_arma)
    {
        // Cria a arma do amiguinho na posição dele (podes criar um objeto oArma_amiguinho ou reutilizar a lógica)
        segura_arma();
        crio_arma = true;
    }
}

#endregion


estado = amigo_parado;