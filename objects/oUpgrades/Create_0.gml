/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Passando o metodo que squash 
inicia_efeito_mola();


//criando um efeito de linha
sem_pai = noone;
linha_tamanho = 0;


if (variable_struct_exists(global.upgrades, id_upgrade))
{
    level = variable_struct_get(global.upgrades, id_upgrade);
}


mouse_acima = function()
{
    var _mouse_acima = position_meeting(mouse_x, mouse_y, id);
    var _click_mouse = mouse_check_button_pressed(mb_left);
    
    if (_mouse_acima && _click_mouse)
    {
        
        if (level >= max_level)
        {
            show_message("Esta habilidade já está no nível máximo!");
            exit; //Sai imediatamente do método para não fazer mais nada
        }
        
        var _grana = variable_global_get(moedas);
        
        // Verifica se tens dinheiro e se ainda podes subir de nível
        if (_grana >= custo && level < max_level)
        {
            // 1. Desconta o dinheiro
            variable_global_set(moedas, _grana - custo);
            
            // 2. Aumenta o nível local
            level += 1;
            
            // 3. Efeito visual e log
            efeito_mola(1.5, 1.5);
            show_message("Comprado! Nível atual: " + string(level));
            
            variable_struct_set(global.upgrades, id_upgrade, level);
            
            // 5. Libera e ativa todos os filhos (alvos) de uma só vez
            var qtd = array_length(alvos);
            if (qtd > 0)
            {
                for (var i = 0; i < qtd; i++) 
                {
                    var _atual = alvos[i];
                    if (instance_exists(_atual))
                    {
                        if (_atual.ativo == false)
                        {
                            _atual.ativo = true;
                            _atual.sem_pai = id;
                            show_debug_message("Novo caminho liberado na árvore!");
                        }
                    }
                }
            }
        }
        else 
        {
            show_debug_message("COMPRA BLOQUEADA! Dinheiro insuficiente ou nível máximo atingido.");    
        }
    }
}



//Criando um metodo para desenhar uma linha que conecta toda a arvore
desenha_linha = function()
{
    if(instance_exists(sem_pai))
    {
        //se minha instancia sem pai existe
        //então ele pega as direçoes 
        var _dir = point_direction(sem_pai.x, sem_pai.y, x, y)
        
        //pegando as coordenas do sem pai
        var x1 = sem_pai.x + lengthdir_x(32, _dir);
        var y1 = sem_pai.y + lengthdir_y(32, _dir);
        var x2 = sem_pai.x + lengthdir_x(linha_tamanho - 32, _dir);
        var y2 = sem_pai.y + lengthdir_y(linha_tamanho - 32, _dir);
        
        draw_line_width_colour(x1, y1, x2, y2, 6, sem_pai.image_blend, image_blend);
    }
    if(instance_exists(sem_pai))
    {
        var tamanho_ideal = point_distance(sem_pai.x, sem_pai.y, x, y) + 10
        //vendo a distancia da linha do pai
        if(linha_tamanho < tamanho_ideal + 3)
        {
            linha_tamanho = lerp(linha_tamanho, tamanho_ideal, .1)
        }
    }
}


inicia_camera = function()
{
    zoom_atual = 1;
    zoom_alvo = 1;
    
    largura_padrao = camera_get_view_width(view_camera[0]);
    altura_padrao = camera_get_view_height(view_camera[0]);
    
    clique_x = 0;
    clique_y = 0;
    arrastando = false;
}

atualiza_camera = function()
{
    // --- 1. CONTROLO DO ZOOM (Scroll) ---
    if (mouse_check_button(mb_middle)) 
    {
        zoom_alvo = 2.0; // Distância do zoom para longe
    } 
    else 
    {
        zoom_alvo = 1.0; 
    }

    // Suaviza o zoom
    zoom_atual = lerp(zoom_atual, zoom_alvo, 0.1);

    // Calcula as novas dimensões baseadas no zoom
    var _vw = largura_padrao * zoom_atual;
    var _vh = altura_padrao * zoom_atual;


    // --- 2. MOVIMENTAÇÃO POR CLIQUE E ARRASTO (Botão Direito) ---
    if (mouse_check_button_pressed(mb_right))
    {
        clique_x = mouse_x;
        clique_y = mouse_y;
        arrastando = true;
    }
    
    if (mouse_check_button_released(mb_right))
    {
        arrastando = false;
    }
    
    // Pega a posição atual da câmara
    var _vx = camera_get_view_x(view_camera[0]);
    var _vy = camera_get_view_y(view_camera[0]);
    
    if (arrastando)
    {
        // Se estiver a arrastar, desloca com base no movimento do rato
        _vx += (clique_x - mouse_x);
        _vy += (clique_y - mouse_y);
    }
    else
    {
        // SE NÃO ESTIVER A ARRASTAR: Mantém o zoom focado exatamente no centro da tela atual
        var _centro_x = _vx + (camera_get_view_width(view_camera[0]) * 0.5);
        var _centro_y = _vy + (camera_get_view_height(view_camera[0]) * 0.5);
        
        _vx = _centro_x - (_vw * 0.5);
        _vy = _centro_y - (_vh * 0.5);
    }

    // --- 3. APLICA TUDO NA CÂMARA DE UMA SÓ VEZ ---
    camera_set_view_size(view_camera[0], _vw, _vh);
    camera_set_view_pos(view_camera[0], _vx, _vy);
}



inicia_camera()