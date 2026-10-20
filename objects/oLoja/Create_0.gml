/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


#region Metodos

//Criando um metodo para a troca de sprite ser melhor
muda_sprite = function(spr = spr_loja)
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



gato_perto = function()

{

    //ele vai calcular a distancia entre meu objeto loja e o objeto gato

    //se a distancia for menor que 50

    if(point_distance(x, y, oGato.x, oGato.y) < 55 && oGato.y >= (y - 10))

    {

        //então a sprite mudará para o spr_loja_destaque

        muda_sprite(spr_loja_destaque);

    }

    else

    {

        //caso contrario ou seja o gato está longe da loja então ela volta ao normal

        muda_sprite(spr_loja);

    }

}





#endregion

