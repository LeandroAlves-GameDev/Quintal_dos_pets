/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Criando as variaveeis para montagem da caixa de dialogo
nome = "";
descricao = "";
nivel = 0;
custo = 0;


//Criando uma variavel de controle para desenhar o texto
desenha_texto = false;

//fazendo a minha caixa de dialogo ser destruida
destroi_caixa = false;


//rodando nosso sistema de wave
scribble_anim_wave(1, 0.3, 0.1);


//scribble_sprite_add("spr_moeda_habilidades");

//Criando nosso sistema de maquina de escrever
typist = scribble_typist();

typist.in(.3, 2);
//o typist consiste em desenhar o texto apos um determinado tempo

//Criando um metodo de inicio da caixa de dialogo
inicia_caixa_dialogo = function()
{
    //fazendo a caixa de dialogo esticar
    image_xscale = lerp(image_xscale, 2.5, .1);
    
    //fazendo a caixa subir
    y = lerp(y, ystart - 50, .1);
    
    
    //vendo se o y chegou proximo do limite dele
    if(y <= ystart - 49.9)
    {
        desenha_texto = true;
    }
}

finaliza_caixa_dialogo = function()
{
    //fazendo a caixa de dialogo ficar menor
    image_xscale = lerp(image_xscale, 0, .1);
    
    //deixando invisivel
    image_alpha = lerp(image_alpha, 0, .1);
    
    //fazendo voltar para baixo
    y = lerp(y, ystart, .2);
    
    desenha_texto = false;
    //resetando a variavel para falso
    
    //rodando um if para destruir a caixa ao ficar transparente
    if(image_alpha <= 0.01)
    {
        instance_destroy();
    }
}