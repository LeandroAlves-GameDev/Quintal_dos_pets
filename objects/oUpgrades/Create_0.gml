/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Passando o metodo que squash 
inicia_efeito_mola();

audio_stop_sound(Devonshire_Waltz_Moderato)

//criando um efeito de linha
sem_pai = noone;
linha_tamanho = 0;

//criando um sistema de feedback melhorado
mouse_ta_acima = false;

cria_caixa_dialogo = noone;
//criando a variavel da caixa de dialogo

if (variable_struct_exists(global.upgrades, id_upgrade))
{
    level = variable_struct_get(global.upgrades, id_upgrade);
}


mouse_acima = function()
{
    var _mouse_acima = position_meeting(mouse_x, mouse_y, id);
    var _click_mouse = mouse_check_button_pressed(mb_left);
    
    //rodando um if para rodar o efeito
    if(_mouse_acima && !mouse_ta_acima)
    {
        //se meu mouse estiver acima e se mouse ta acima for true
        efeito_mola(1.5, 1.5);
        //ele roda o efeito da mola
        
        //se não existe minha caixa de dialogo, então agora ela e criada
        if (!instance_exists(cria_caixa_dialogo))
        {
            //se eu estou encima da habilidade, então ele cria a minha caixa de dialogo 
            cria_caixa_dialogo = instance_create_layer(x, y, "Dialogo", oCaixaDialogo);
            cria_caixa_dialogo.image_xscale = .5;
            cria_caixa_dialogo.image_yscale = 1.5;
            cria_caixa_dialogo.nome = id_upgrade;
            cria_caixa_dialogo.descricao = descricao;
            cria_caixa_dialogo.nivel = global.upgrades[$ id_upgrade];
            cria_caixa_dialogo.custo = custo;
        }
    }
    else
    {
        if(instance_exists(cria_caixa_dialogo))
        {
            //se meu mouse não está mais acima da habilidae
            //então eu informo que a condição destroi caixa e verdadeira 
            cria_caixa_dialogo.destroi_caixa = true;
        }
    }
    mouse_estava_acima = _mouse_acima;
    
    if (_mouse_acima && _click_mouse)
    {
        if (!ativo)
        {
            //show_debug_message("Esta habilidade ainda não está desbloqueada na árvore!");
            exit;
        }
        
        
        if (level >= max_level)
        {
            //show_message("Esta habilidade já está no nível máximo!");
            exit; 
            //vou sair imediatamente do método para não fazer mais nada
        }
        
        var _grana = variable_global_get(moedas);
        
        //se eu tenho grana e ela maior ou igual ao custo
        if (_grana >= custo)
        {
            //então eu perco o dinheiro
            variable_global_set(moedas, _grana - custo);
            
            //e ganho nivel 
            level += 1;
            //show_message("Comprado! Nível atual: " + string(level));
            //mensagem de debug 
            
            variable_struct_set(global.upgrades, id_upgrade, level);
            
            //ativando os arrays
            var qtd = array_length(alvos);
            if (qtd > 0)
            {
                //se minha quantidade for maior que zero
                for (var i = 0; i < qtd; i++) 
                {
                    //ele vai rodar o laço de repetição 
                    var _atual = alvos[i];
                    if (instance_exists(_atual))
                    {
                        if (_atual.ativo == false)
                        {
                            _atual.ativo = true;
                            _atual.sem_pai = id;
                            //show_debug_message("Novo caminho liberado na árvore!");
                        }
                    }
                }
            }
        }
        else 
        {
            //show_debug_message("COMPRA BLOQUEADA! Dinheiro insuficiente ou nível máximo atingido.");    
        }
    }
}



//Criando um metodo para desenhar uma linha que conecta toda a arvore
desenha_linha = function()
{
    //verificando se o pai existe na room
    if(instance_exists(sem_pai))
    {
        //verificando a direção do pai e do meu x 
        var _dir = point_direction(sem_pai.x, sem_pai.y, x, y);
        //calculando a distancia do pai e do meu x 
        var _distancia_real = point_distance(sem_pai.x, sem_pai.y, x, y);
        
        //o tamanho ideal vai ser igual o valor da distancia
        var tamanho_ideal = _distancia_real;
        if(linha_tamanho < tamanho_ideal)
        {
            //se minha linha tamanho for menor que a o tamanho ideal
            linha_tamanho = lerp(linha_tamanho, tamanho_ideal, 0.1);
            //então ele suaviza
        }
        
        //dando limites para que essa linha não entre na nossa sprite
        var _margem_pai = 16; 
        //dando a distancia dela e do pai
        var _margem_filho = 16; 
        //dando a distancia dela e do filho
        
        //ele vai verificar a ponta da minha sprite e somar com o lengthdir_x
        var x1 = sem_pai.x + lengthdir_x(_margem_pai, _dir);
        var y1 = sem_pai.y + lengthdir_y(_margem_pai, _dir);
        
        //dando o limite para ele não ultrapassar o filho
        var _tamanho_atual_desenho = min(linha_tamanho, _distancia_real - _margem_filho);
        
        var x2 = sem_pai.x + lengthdir_x(_tamanho_atual_desenho, _dir);
        var y2 = sem_pai.y + lengthdir_y(_tamanho_atual_desenho, _dir);
        
        //desenhando a linha
        draw_line_width_colour(x1, y1, x2, y2, 1, sem_pai.image_blend, image_blend);
        
        ////mexendo na profundidade 
        depth = 10; 
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
    //controlando o zoom 
    if (mouse_check_button(mb_middle)) 
    {
        zoom_alvo = 2.0; 
        //deixando ele longe 
    } 
    else 
    {
        zoom_alvo = 1.0; 
    }

    //fazendo uma forma de suavizar o zoom
    zoom_atual = lerp(zoom_atual, zoom_alvo, 0.1);

    //fazendo um calculo para ver as dimensoes do zoom
    //largura_padrao * zoom_atual vai ser o resultado de _vw
    //o mesmo se aplica para vh
    var _vw = largura_padrao * zoom_atual;
    var _vh = altura_padrao * zoom_atual;


    //arrastando com o botão do mouse
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
    
    //fazendo ele pegar a posição da camera para se mover
    var _vx = camera_get_view_x(view_camera[0]);
    var _vy = camera_get_view_y(view_camera[0]);
    
    if (arrastando)
    {
        ////fazendo o movimento de arrastar do mouse
        _vx += (clique_x - mouse_x);
        _vy += (clique_y - mouse_y);
        
    }
    else
    {
        //se não estou arrastando dai ele faz voltar ao norkmal
        var _centro_x = _vx + (camera_get_view_width(view_camera[0]) * 0.5);
        var _centro_y = _vy + (camera_get_view_height(view_camera[0]) * 0.5);
        
        _vx = _centro_x - (_vw * 0.5);
        _vy = _centro_y - (_vh * 0.5);
    }

    //aplicando na camera de uma vez
    camera_set_view_size(view_camera[0], _vw, _vh);
    camera_set_view_pos(view_camera[0], _vx, _vy);
}



inicia_camera()