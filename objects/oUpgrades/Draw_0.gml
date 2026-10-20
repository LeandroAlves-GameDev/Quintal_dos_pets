/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
//chamando o metodo desenha linha[
desenha_linha();

if (ativo)
{
    draw_self(); // Desenha a sprite normal da habilidade
    
    // Opcional: Desenhar o nome ou nível da habilidade aqui
    draw_text(x, y - 45, "Habilidade Ativa");
}
    
var varaivel = variable_global_get(id_upgrade);
var text = string("{0} {1} \n{2}/{3} ", custo, moedas, varaivel, max_level)
    
draw_text(x, y + 80, text);


desenha_efeito_mola(image_blend, image_alpha);