/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


//criando variaveis
cooldown = 0;
//fazendo o nosso sistema de cooldown da arma
cooldown_max = 30;

//criando um sistema de recoil para nosso jogo
recoil_dist = 0;
//por padrão começa zerado

#region Metodos

//Criando o metodo de mirar
mira_arma = function()
{
    //fazendo ele pegar o x e y do gato
    x = oGato.x;
    y = oGato.y - 7;
    
    var mira = point_direction(x, y, mouse_x, mouse_y)
    //fazendo ele pegar a direção que estou olhando pelo mouse
    image_angle = mira
    if (mouse_x < x)
    {
        
        oGato.image_xscale = -1;
        image_yscale = -1;      
    }
    else
    {
        oGato.image_xscale = 1; 
        image_yscale = 1;       
    }
    depth = oGato.depth - 1
}


//Criando o metodo do tiro
atirando = function()
{
    //criando o sistema tiro 
    atira = mouse_check_button_pressed(mb_left)
    //se eu apertei o lado esquerdo do mouse
    cooldown++;
    
    //ganhando cooldown
    if(atira && cooldown >= cooldown_max)
    {
        //resetando o cooldown e fazendo todo o resto acontencer
        cooldown = 0;
        //rodando o som do tiro
        audio_play_sound(snd_tiro, 1, 0)
        
        //quando eu atiro eu ganho recoil 
        recoil_dist = 5;
        with (oGato) 
        {
            //dentro do gato 
            //ele vai somar x += o lengthdir_x que vai calcular o valor de retorno
            //ou seja o valor de desloque
            //mais o angulo, então o calculo seria x + minha direção e com isso teremos um sistema de recoil
        	x += lengthdir_x(5, other.image_angle + 180);
            y += lengthdir_y(5, other.image_angle + 180);
            
        }
        //quando eu atiro eu tambem aplico o screenshake
        oScreenshake.treme = 5;
        var pos_x = x + lengthdir_x(20, image_angle)
        var pos_y = y + lengthdir_y(20, image_angle);
        //fazendo o tiro nascer em uma posição mais confortavel
        var cria_efeito_bala = instance_create_layer(pos_x, pos_y, "Arma", oEfeito_tiro)
        var cria_bala = instance_create_layer(pos_x, pos_y, "Arma", oTiro)
        //criando a minha instancia do tiro
        cria_bala.image_angle = image_angle;
    }
    recoil_dist = lerp(recoil_dist, 0, 0.1);
}


#endregion
