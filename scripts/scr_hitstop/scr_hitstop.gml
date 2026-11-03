// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações


//Criando uma variavel global hitstop
global.hitstop = false; 

//Criando nosso função para checar o hitstop
function checa_hitstop()
{
    var hit = instance_exists(oHitstop);
    //verificando se existe a instancia hitstop
    
    //se ainda não existe uma instancia do hitstop
    if(!hit)
    {
        //então agora ele passa a ser criado
        return instance_create_depth(0, 0, 0, oHitstop)
    }
    //se já existe esse objeto
    //então eu falo o id do hitstop
    return oHitstop.id;
}

//rodando a função de iniciar o hitstop
function inicia_hitstop(timer_ = 1)
{
    //essa função irá receber um tempo como parametro
    var hitstop = checa_hitstop();
    
    //dando o timer para a função
    hitstop.timer = max(hitstop.timer, timer_);
}
