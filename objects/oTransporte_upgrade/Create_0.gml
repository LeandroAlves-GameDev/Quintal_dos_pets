/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

transicionando = false;
minha_sequence = noone;


//Criando um metodo para a troca de sprite ser melhor
muda_sprite = function(spr = spr_transporte_upgrades)
{
    //se meu sprite index for diferente do meu argumento spr
    if(sprite_index != spr)
    {
        //então meu sprite index passa a ser igual ao da argumentação
        sprite_index = spr;
        //por padrão nossa image_index e zero
        image_index = 0;
    }
}


//Criando um metodo para checar se o gato ta perto da loja
gato_perto = function()
{
    //ele vai calcular a distancia entre meu objeto loja e o objeto gato
    //se a distancia for menor que 50
    //vendo o gato existe na room
    if(instance_exists(oGato))
    {
        var _margem = 12;
        
        if (collision_rectangle(bbox_left - _margem, bbox_top - _margem, bbox_right + _margem, bbox_bottom + _margem, oGato, false, true))
       {
           //então a sprite mudará para o spr_loja_destaque
           muda_sprite(spr_transporte_destaque_upgrades);
           //se eu apertei o select com o gato e meu transicionando for diferente de false
            if(oGato.select && !transicionando)
            {
                //então meu transicionando passará a ser como true ou seja verdadeiro
                transicionando = true;
                
                //rodando o sistema de transição de room
                minha_sequence = layer_sequence_create("sq_transicao", x, y, sq_transicao)
                //criando a minha sequencia
                
            }
       }
       else
       {
           //caso contrario ou seja o gato está longe da loja então ela volta ao normal
           muda_sprite(spr_transporte_upgrades);
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
            room_goto(rm_arvore);
        }
    }
}