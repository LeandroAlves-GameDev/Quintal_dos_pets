// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações


function calcula_velocidade()
{
    var _vel_base = 2;
    var _bonus = 0;
    
    // Soma todos os níveis de velocidade do struct
    if (variable_struct_exists(global.upgrades, "velocidade"))  _bonus += global.upgrades.velocidade * 0.5;
    if (variable_struct_exists(global.upgrades, "velocidade1")) _bonus += global.upgrades.velocidade1 * 0.5;
    if (variable_struct_exists(global.upgrades, "velocidade2")) _bonus += global.upgrades.velocidade2 * 0.5;
    if (variable_struct_exists(global.upgrades, "velocidade3")) _bonus += global.upgrades.velocidade3 * 0.5;
    if (variable_struct_exists(global.upgrades, "velocidade4")) _bonus += global.upgrades.velocidade4 * 0.5;
    
    return _vel_base + _bonus;
}

function calcula_tempo_fase()
{
    var _tempo_base = 3000;
    var _bonus = 0;
    
    // Soma todos os níveis de tempo do struct (cada nível adiciona 1000)
    if (variable_struct_exists(global.upgrades, "tempo"))  _bonus += global.upgrades.tempo * 1000;
    if (variable_struct_exists(global.upgrades, "tempo1")) _bonus += global.upgrades.tempo1 * 1000;
    if (variable_struct_exists(global.upgrades, "tempo2")) _bonus += global.upgrades.tempo2 * 1000;
    if (variable_struct_exists(global.upgrades, "tempo3")) _bonus += global.upgrades.tempo3 * 1000;
    if (variable_struct_exists(global.upgrades, "tempo4")) _bonus += global.upgrades.tempo4 * 1000;
    
    return _tempo_base + _bonus;
}

function calcula_espolio()
{
    var _qtd_base = 1;
    var _bonus = 0;
    
    // Soma todos os níveis de espólio do struct
    if (variable_struct_exists(global.upgrades, "espolio"))  _bonus += global.upgrades.espolio;
    if (variable_struct_exists(global.upgrades, "espolio1")) _bonus += global.upgrades.espolio1;
    if (variable_struct_exists(global.upgrades, "espolio2")) _bonus += global.upgrades.espolio2;
    if (variable_struct_exists(global.upgrades, "espolio3")) _bonus += global.upgrades.espolio3;
    if (variable_struct_exists(global.upgrades, "espolio4")) _bonus += global.upgrades.espolio4;
    
    return _qtd_base + _bonus;
}

function calcula_dano_tiro()
{
    var _dano_base = 1;
    var _bonus = 0;
    
    // Soma todos os níveis de dano do struct
    if (variable_struct_exists(global.upgrades, "dano"))  _bonus += global.upgrades.dano;
    if (variable_struct_exists(global.upgrades, "dano1")) _bonus += global.upgrades.dano1;
    if (variable_struct_exists(global.upgrades, "dano2")) _bonus += global.upgrades.dano2;
    if (variable_struct_exists(global.upgrades, "dano3")) _bonus += global.upgrades.dano3;
    if (variable_struct_exists(global.upgrades, "dano4")) _bonus += global.upgrades.dano4;
    
    return _dano_base + _bonus;
}

function calcula_amigos()
{
    var _base_amigos = 0; // Começa com 0 amiguinhos se não comprou o "Início"
    var _bonus = 0;
    
    // Verifica se a propriedade "inicio" existe na struct e soma o valor dela
    if (variable_struct_exists(global.upgrades, "inicio")) 
    {
        _bonus += global.upgrades.inicio; // Se comprou (ex: 1), adiciona 1 amiguinho
    }
    
    return _base_amigos + _bonus;
}
