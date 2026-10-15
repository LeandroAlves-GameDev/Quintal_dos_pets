/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if (level > 0)
{
    ativo = true;
    
    var qtd = array_length(alvos);
    if (qtd > 0)
    {
        for (var i = 0; i < qtd; i++) 
        {
            var _atual = alvos[i];
            if (instance_exists(_atual))
            {
                _atual.ativo = true;
                _atual.sem_pai = id;
            }
        }
    }
}
