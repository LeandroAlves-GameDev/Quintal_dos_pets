/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//diminuindo o timer
timer--;

//Aplicando o sistema em todos os objetos de combate
if(instance_exists(oGato) && instance_exists(oInimigo_Pai))
{
    with (oGato) 
    {
        image_speed = 0;	
    }
    with (oInimigo_Pai) 
    {
        image_speed = 0;	
    }
}


//se meu timer for zerado então deve ser destruido
if(timer <= 0)
{
    //se meu timer for menor ou igual a zero
    instance_destroy()
    //então meu objeto e destruido
}