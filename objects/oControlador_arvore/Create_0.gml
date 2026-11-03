/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//criando as variaveis para voltar para room quintal
transicionando = false;
minha_sequence = noone;

//Criando o metodo de transição
roda_transicao = function()
{
    if (room == rm_arvore && !transicionando)
    {
        
        if (keyboard_check_pressed(vk_backspace))
        {
            //então meu transicionando passará a ser como true ou seja verdadeiro
            transicionando = true;
                
            //rodando o sistema de transição de room
            minha_sequence = layer_sequence_create("sq_transicao", x, y, sq_transicao_2)
            //criando a minha sequencia
            
        }
    }
}


checar_transicao = function()
{
    if (transicionando && layer_sequence_exists("sq_transicao", minha_sequence))
    {
        //se meu transicionando for false e existir uma sq_transicao
        if (layer_sequence_is_finished(minha_sequence))
        {
            //então a minha sequencia e finalizado 
            //e eu sou transportado para room arvore
            room_goto(rm_quintal)
        }
    }
}