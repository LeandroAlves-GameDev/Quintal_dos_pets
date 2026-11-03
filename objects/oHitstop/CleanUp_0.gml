/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//informando que o hitstop acabou
global.hitstop = false;

//Aplicando o sistema em todos os objetos de combate
if(instance_exists(oGato) && instance_exists(oInimigo_Pai))
{
    with (oGato) 
    {
        image_speed = 1;	
    }
    with (oInimigo_Pai) 
    {
        image_speed = 1;	
    }
}