/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//rodando um if para ver room que estou
if(room == rm_combate)
{
    image_angle += 1
    //desenhando o cursor do mouse
    draw_sprite_ext(spr_mira, 0, x, y, 2.5, 2.5, image_angle, c_white, 1);
}
else
{
    draw_sprite_ext(spr_cursor, 0, x, y, 2.5, 2.5, image_angle, c_white, 1);
}
