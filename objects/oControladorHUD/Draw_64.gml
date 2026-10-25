/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//criando uma forma de esconder o hud quando estiver em transição
var _transicionando = false;

//se meu transporte existe e transicionando ou oTransporte_upgrade e transicionando for falso 
if(instance_exists(oTransporte) && oTransporte.transicionando || 
    instance_exists(oTransporte_upgrade) && oTransporte_upgrade.transicionando)
{
    //ele passa a ser tornar verdadeiro
    _transicionando = true;
}

//se transicionando for diferente de verdadeiro ou seja falso
if(!_transicionando)
{
    desenha_moldura_hud()
    //ele roda os metodos da hud 
    desenha_moeda_habilidade_icone();
    desenha_moeda_icone();
    desenha_vida_player();
    
}

desenha_hud_tempo();


draw_set_font(noone);