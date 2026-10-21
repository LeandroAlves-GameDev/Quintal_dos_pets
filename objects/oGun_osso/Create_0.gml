/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//criando variaveis

cooldown = 0;

//fazendo o nosso sistema de cooldown da arma

cooldown_max = 30;



//criando um sistema de recoil para nosso jogo

recoil_dist = 0;



mira_amiguinho = function()
{
    if (!instance_exists(oAumiguinho)) exit;
    
    // Segue a posição do amiguinho
    x = oAumiguinho.x; // (ou a posição atualizada do amiguinho)
    y = oAumiguinho.y - 7;
    
    // Se o gato olha para a direita, a arma aponta para a esquerda e vice-versa
    // Podes basear o ângulo na rotação da arma do gato invertida (+ 180 graus)
    if (instance_exists(oGun)) // Assumindo que a arma do gato se chama oArma
    {
        var _angulo_oposto = oGun.image_angle + 180;
        
        // Normaliza o ângulo para ficar sempre entre 0 e 360 graus
        image_angle = _angulo_oposto mod 360;
        
        // Espelha a escala vertical da arma do amiguinho se necessário
        if (image_angle > 90 && image_angle < 270)
        {
            image_yscale = -1;
        }
        else
        {
            image_yscale = 1;
        }
        image_xscale = 1;
    }
    
    depth = oAumiguinho.depth - 1;
}

// 2. Método de tiro sincronizado com o gato
tiro_amiguinho = function()
{
    cooldown++;
    
    // O tiro SÓ ocorre se o gato apertou o botão de tiro (mouse_check_button_pressed(mb_left)) e o cooldown permitiu
    // Podes verificar se o gato disparou olhando para a variável de tiro ou detetando o clique do rato mas disparando em conjunto
    var _gatilho_gato = mouse_check_button_pressed(mb_left);
    
    if (_gatilho_gato && cooldown >= cooldown_max)
    {
        cooldown = 0;
        
        // Som do tiro do amiguinho (podes usar o mesmo ou outro)
        audio_play_sound(snd_tiro, 1, 0);
        
        // Posição de saída da bala na ponta da arma do amiguinho
        var pos_x = x + lengthdir_x(30, image_angle);
        var pos_y = y + lengthdir_y(25, image_angle);
        
        // Cria o efeito visual e o projétil na direção oposta
        instance_create_layer(pos_x, pos_y, "Arma", oEfeito_tiro);
        var cria_bala = instance_create_layer(pos_x, pos_y, "Arma", oTiro);
        
        // A bala do amiguinho segue o ângulo para onde ele está a apontar
        cria_bala.image_angle = image_angle;
        // Se a tua bala usa velocidade em direção ao ângulo (direction / speed):
        cria_bala.direction = image_angle;
        cria_bala.speed = 8; // Velocidade do tiro
    }
}