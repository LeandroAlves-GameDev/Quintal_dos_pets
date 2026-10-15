/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

dano_tiro = calcula_dano_tiro();

#region Variaveis

//Criando o sistema de tiro
//dando a velocidade do tiro
velh = 3;
velv = 3;


#endregion


#region Metodos

//criando o metodo de velocidade da bala e angulo dela
move_tiro = function()
{
    x += lengthdir_x(velh, image_angle) 
    y += lengthdir_y(velv, image_angle) 
    
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


#endregion