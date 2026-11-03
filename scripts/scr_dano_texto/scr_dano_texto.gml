// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações


function cria_texto_dano(_x, _y, _dano)
{
    //Criando o texto na posição mais alta
    var _inst = instance_create_depth(_x, _y, -y, oDanoTexto);
    
    //informando o dano recebido na variavel do objeto
    _inst.dano = _dano;
}