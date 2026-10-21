/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

window_set_cursor(cr_none)
//desativando o cursor do mouse


//criando um metodo de mirar
mira_mouse = function()
{
    x = device_mouse_x_to_gui(0)
    y = device_mouse_y_to_gui(0)
    image_angle += 1
}