/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//informando que meu x da room e mais igual ao meu velh
x += velh;
y += velv;
//replicando o mesmo conceito para o y


//Diminuindo o meu timer
timer--;

//realizando o calculo de divisão 
alfa = timer / tempo_vida;

//se meu timer for menor ou igual a 0 
if(timer <= 0)
{
    //então ele destroi
    instance_destroy();
} 