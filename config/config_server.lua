allGroups = module("cfg/groups")
config = {}


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- QUERYS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("flow_orgs/getOrg", "SELECT * FROM flow_orgs WHERE org = @org")
vRP.prepare("flow_orgs/updateMembers", "UPDATE flow_orgs SET membros = @membros WHERE org = @org")
vRP.prepare("flow_orgs/updateBanco", "UPDATE flow_orgs SET banco = @banco, bancoHistorico = @bancoHistorico WHERE org = @org")
vRP.prepare("flow_orgs/updateText", "UPDATE flow_orgs SET anotacao = @anotacao WHERE org = @org")
vRP.prepare("flow_orgs/initGroups", "INSERT IGNORE INTO flow_orgs(org,maxMembros) VALUES(@org, @maxMembros)")
vRP.prepare("flow_orgs/initTable", "CREATE TABLE IF NOT EXISTS `flow_orgs` ( `org` varchar(50) NOT NULL, `membros` text NOT NULL DEFAULT '{}', `maxMembros` int(11) NOT NULL DEFAULT 0, `anotacao` text DEFAULT NULL, PRIMARY KEY (`org`) ) ENGINE=InnoDB DEFAULT CHARSET=latin1;")
vRP.prepare("flow_orgs/clearArmazem", "UPDATE vrp_srv_data SET dvalue = @dvalue WHERE dkey = @dkey")

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONFIGS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
config.createTable = false -- Criar Tabela Automaticamente (Depois de startar o script pela primeira vez coloque false)
config.automaticGroups = true -- INSERIR CATEGORIA DE GRUPOS AUTOMATICAMENTE NO BANCO DE DADOS
config.adminPermission = "admin.permissao" -- Permissao de ADM
config.blackList = 3 -- dia(s) Configura o tempo que o jogador não pode entrar em uma organização quando pedir contas/demitido

config.weebhook = {
    color = 6356736,
    logo = "https://media.discordapp.net/attachments/871769750710149140/1001895906515361843/01_9.png?width=1370&height=683",
    footer = "© Curso Fast Fivem"
}
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONFIG GROUPS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
config.groups = {
    ["Policia"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Aluno", grupo = "Aluno", permLider = false },
            [2] = { prefix = "Soldado", grupo = "Soldado", permLider = false },
            [3] = { prefix = "Cabo", grupo = "Cabo", permLider = false },
            [4] = { prefix = "Terceiro Sargento", grupo = "Terceiro Sargento", permLider = false },
            [5] = { prefix = "Segundo Sargento", grupo = "Segundo Sargento", permLider = false },
            [6] = { prefix = "Primeiro Sargento", grupo = "Primeiro Sargento", permLider = false },
            [7] = { prefix = "Sub Tenente", grupo = "Sub Tenente", permLider = false },
            [8] = { prefix = "Segundo Tenente", grupo = "Segundo Tenente", permLider = false },
            [9] = { prefix = "Primeiro Tenente", grupo = "Primeiro Tenente", permLider = false },
            [10] = { prefix = "Capitao", grupo = "Capitao", permLider = false },
            [11] = { prefix = "Comando Rocam", grupo = "Comando Rocam", permLider = true, maxMembers = 10, permBanco = true },
            [12] = { prefix = "Rocam", grupo = "Rocam", permLider = false },
            [13] = { prefix = "Major", grupo = "Major", permLider = false },
            [14] = { prefix = "Tenente Coronel", grupo = "Tenente Coronel", permLider = true, maxMembers = 4, permBanco = true },
            [15] = { prefix = "Coronel", grupo = "Coronel", permLider = true, maxMembers = 2, permBanco = true },
        }
    },

    ["Bope"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            -- [1] = { prefix = "EstagiarioBope", grupo = "EstagiarioBope", permLider = false },
            -- [2] = { prefix = "EliteBope", grupo = "EliteBope", permLider = true, permBanco = true },
            -- [3] = { prefix = "SupervisorBope", grupo = "SupervisorBope", permLider = true, permBanco = true },
            -- [4] = { prefix = "SubComandoBope", grupo = "SubComandoBope", permLider = true, permBanco = true },
            -- [5] = { prefix = "ComandoBope", grupo = "ComandoBope", permLider = true, permBanco = true },
            [1] = { prefix = "Coronel Bope", grupo = "Coronel Bope", permLider = true, maxMembers = 6, permBanco = true },
            [2] = { prefix = "Tenente Coronel Bope", grupo = "Tenente Coronel Bope", permLider = true, maxMembers = 6, permBanco = true },
            [3] = { prefix = "Major Bope", grupo = "Major Bope", permLider = true, maxMembers = 6, permBanco = true },
            [4] = { prefix = "Capitao Bope", grupo = "Capitao Bope",permLider = true, maxMembers = 6, permBanco = true },
            [5] = { prefix = "Primeiro Tenente Bope", grupo = "Primeiro Tenente Bope", permLider = false },
            [6] = { prefix = "Segundo Tenente Bope", grupo = "Segundo Tenente Bope", permLider = false },
            [7] = { prefix = "Terceiro Tenente Bope", grupo = "Terceiro Tenente Bope", permLider = false },
            [8] = { prefix = "SubTenente Bope", grupo = "SubTenente Bope", permLider = false },
            [9] = { prefix = "Primeiro Sargento Bope", grupo = "Primeiro Sargento Bope", permLider = false },
            [10] = { prefix = "Segundo Sargento Bope", grupo = "Segundo Sargento Bope", permLider = false },
            [11] = { prefix = "Terceiro Sargento Bope", grupo = "Terceiro Sargento Bope", permLider = false },
            [12] = { prefix = "Cabo Bope", grupo = "Cabo Bope", permLider = false },
            [13] = { prefix = "Soldado Bope", grupo = "Soldado Bope", permLider = false },
            [14] = { prefix = "Aluno Bope", grupo = "Aluno Bope", permLider = false },
        }
    },

    ["PoliciaCivil"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Investigador", grupo = "Investigador", permLider = false },
            [2] = { prefix = "Escrivao", grupo = "Escrivao", permLider = false },
            [3] = { prefix = "Perito", grupo = "Perito", permLider = false },
            [4] = { prefix = "Core", grupo = "Core", permLider = false },
            [5] = { prefix = "Delegado", grupo = "Delegado", permLider = true, permBanco = true },
            [6] = { prefix = "DelegadoGeral", grupo = "DelegadoGeral", permLider = true, permBanco = true },
        }
    },


    ["Hospital"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Socorrista", grupo = "Socorrista", permLider = false },
            [2] = { prefix = "Enfermeiro", grupo = "Enfermeiro", permLider = false },
            [3] = { prefix = "Medico", grupo = "Medico", permLider = false },
            [4] = { prefix = "Psiquiatra", grupo = "Medico Psiquiatra", permLider = true },
            [5] = { prefix = "Gestao", grupo = "Gestao", permLider = true, permBanco = true },
            [6] = { prefix = "Vice Diretor", grupo = "Vice Diretor", permLider = true, permBanco = true },
            [7] = { prefix = "Diretor", grupo = "Diretor", permLider = true, permBanco = true },
        }
    },

    ["Mecanica"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [Mecanica]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [Mecanica]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [Mecanica]", permLider = true },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [Mecanica]", permLider = true, permBanco = true },
            [5] = { prefix = "Lider", grupo = "Lider [Mecanica]", permLider = true, permBanco = true },
        }
    },

    ["LS"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [LS]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [LS]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [LS]", permLider = true },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [LS]", permLider = true, permBanco = true },
            [5] = { prefix = "Lider", grupo = "Lider [LS]", permLider = true, permBanco = true },
        }
    },

    ["Roxos"] = {
        maxMembers = 60, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [ROXOS]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [ROXOS]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [ROXOS]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [ROXOS]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [ROXOS]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Anonymous"] = {
        maxMembers = 999, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [ANONYMOUS]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [ANONYMOUS]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [ANONYMOUS]", permLider = true, maxMembers = 8 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [ANONYMOUS]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [ANONYMOUS]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Medelin"] = {
        maxMembers = 999, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [MEDELIN]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [MEDELIN]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [MEDELIN]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [MEDELIN]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [MEDELIN]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Vagos"] = {
        maxMembers = 999, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [VAGOS]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [VAGOS]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [VAGOS]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [VAGOS]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [VAGOS]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Mafia01"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [MAFIA01]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [MAFIA01]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [MAFIA01]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [MAFIA01]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [MAFIA01]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Mafia02"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [MAFIA02]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [MAFIA02]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [MAFIA02]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [MAFIA02]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [MAFIA02]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Mafia03"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [MAFIA03]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [MAFIA03]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [MAFIA03]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [MAFIA03]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [MAFIA03]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["China"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [CHINA]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [CHINA]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [CHINA]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [CHINA]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [CHINA]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Vanilla"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [VANILLA]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [VANILLA]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [VANILLA]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [VANILLA]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [VANILLA]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Furious"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [FURIOUS]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [FURIOUS]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [FURIOUS]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [FURIOUS]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [FURIOUS]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Bahamas"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [BAHAMAS]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [BAHAMAS]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [BAHAMAS]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [BAHAMAS]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [BAHAMAS]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Cassino"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [CASSINO]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [CASSINO]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [CASSINO]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [CASSINO]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [CASSINO]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Galaxy"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [GALAXY]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [GALAXY]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [GALAXY]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [GALAXY]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [GALAXY]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Bratva"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "884502014225186876/1FPr4pryLav-x4aWNii6QZMY_P5W0Gt1GajhOqnLMTJ1aQoMRU92WsYG7Hn3wM3fcaa8", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [BRATVA]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [BRATVA]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [BRATVA]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [BRATVA]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [BRATVA]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Turquia"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [TURQUIA]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [TURQUIA]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [TURQUIA]", permLider = true, maxMembers = 8 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [TURQUIA]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [TURQUIA]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Israel"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [ISRAEL]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [ISRAEL]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [ISRAEL]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [ISRAEL]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [ISRAEL]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Nigeria"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [NIGERIA]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [NIGERIA]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [NIGERIA]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [NIGERIA]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [NIGERIA]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Russia"] = {
        maxMembers = 999, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [RUSSIA]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [RUSSIA]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [RUSSIA]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [RUSSIA]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [RUSSIA]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },
    
    ["CostaRica"] = {
        maxMembers = 999, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [COSTA RICA]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [COSTA RICA]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [COSTA RICA]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [COSTA RICA]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [COSTA RICA]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Escocia"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [ESCOCIA]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [ESCOCIA]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [ESCOCIA]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [ESCOCIA]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [ESCOCIA]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Suecia"] = {
        maxMembers = 999, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [SUECIA]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [SUECIA]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [SUECIA]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [SUECIA]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [SUECIA]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Yakuza"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [YAKUZA]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [YAKUZA]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [YAKUZA]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [YAKUZA]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [YAKUZA]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Franca"] = {
        maxMembers = 999, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [FRANCA]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [FRANCA]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [FRANCA]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [FRANCA]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [FRANCA]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Colombia"] = {
        maxMembers = 50, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [COLOMBIA]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [COLOMBIA]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [COLOMBIA]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [COLOMBIA]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [COLOMBIA]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Egito"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [EGITO]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [EGITO]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [EGITO]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [EGITO]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [EGITO]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Elements"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [ELEMENTS]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [ELEMENTS]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [ELEMENTS]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [ELEMENTS]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [ELEMENTS]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Bloods"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [BLOODS]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [BLOODS]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [BLOODS]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [BLOODS]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [BLOODS]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Crips"] = {
        maxMembers = 999, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [CRIPS]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [CRIPS]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [CRIPS]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [CRIPS]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [CRIPS]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Cartel"] = {
        maxMembers = 999, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [CARTEL]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [CARTEL]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [CARTEL]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [CARTEL]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [CARTEL]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Grecia"] = {
        maxMembers = 999, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [GRECIA]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [GRECIA]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [GRECIA]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [GRECIA]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [GRECIA]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Triade"] = {
        maxMembers = 999, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [TRIADE]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [TRIADE]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [TRIADE]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [TRIADE]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [TRIADE]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Brasil"] = {
        maxMembers = 999, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [BRASIL]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [BRASIL]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [BRASIL]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [BRASIL]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [BRASIL]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Paraguai"] = {
        maxMembers = 999, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Novato", grupo = "Novato [PARAGUAI]", permLider = false },
            [2] = { prefix = "Membro", grupo = "Membro [PARAGUAI]", permLider = false },
            [3] = { prefix = "Gerente", grupo = "Gerente [PARAGUAI]", permLider = true, maxMembers = 5 },
            [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [PARAGUAI]", permLider = true, permBanco = true, maxMembers = 3 },
            [5] = { prefix = "Lider", grupo = "Lider [PARAGUAI]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },

    ["Milicia"] = {
       maxMembers = 50, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
       weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
       groups = {
           [1] = { prefix = "Novato", grupo = "Novato [MILICIA]", permLider = false },
           [2] = { prefix = "Membro", grupo = "Membro [MILICIA]", permLider = false },
           [3] = { prefix = "Gerente", grupo = "Gerente [MILICIA]", permLider = true, maxMembers = 5 },
           [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [MILICIA]", permLider = true, permBanco = true, maxMembers = 3 },
           [5] = { prefix = "Lider", grupo = "Lider [MILICIA]", permLider = true, permBanco = true, maxMembers = 2 },
       }
    },

    ["Judiciario"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
            [1] = { prefix = "Advogado", grupo = "Advogado", permLider = false },
            [2] = { prefix = "Promotor", grupo = "Promotor", permLider = false },
            [3] = { prefix = "Juiz", grupo = "Juiz", permLider = true }
        }
    },
    ["CatCafe"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
           [1] = { prefix = "Novato", grupo = "Novato [CATCAFE]", permLider = false },
           [2] = { prefix = "Membro", grupo = "Membro [CATCAFE]", permLider = false },
           [3] = { prefix = "Gerente", grupo = "Gerente [CATCAFE]", permLider = true, maxMembers = 5 },
           [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [CATCAFE]", permLider = true, permBanco = true, maxMembers = 3 },
           [5] = { prefix = "Lider", grupo = "Lider [CATCAFE]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },
    ["STO"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
           [1] = { prefix = "Novato", grupo = "Novato [STO]", permLider = false },
           [2] = { prefix = "Membro", grupo = "Membro [STO]", permLider = false },
           [3] = { prefix = "Gerente", grupo = "Gerente [STO]", permLider = true, maxMembers = 5 },
           [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [STO]", permLider = true, permBanco = true, maxMembers = 3 },
           [5] = { prefix = "Lider", grupo = "Lider [STO]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },
    ["Turtle"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
           [1] = { prefix = "Novato", grupo = "Novato [TURTLE]", permLider = false },
           [2] = { prefix = "Membro", grupo = "Membro [TURTLE]", permLider = false },
           [3] = { prefix = "Gerente", grupo = "Gerente [TURTLE]", permLider = true, maxMembers = 5 },
           [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [TURTLE]", permLider = true, permBanco = true, maxMembers = 3 },
           [5] = { prefix = "Lider", grupo = "Lider [TURTLE]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },
    ["Bennys"] = {
        maxMembers = 30, -- Defina Esse Valor Apenas 1x proxima vez alterar direto no banco de dados
        weebhook = "Sua Webhook aqui", -- DEFINA O WEEBHOOK PARA AS TRANSACOES FEITAS NESSA ORGANIZACAO
        groups = {
           [1] = { prefix = "Novato", grupo = "Novato [BENNYS]", permLider = false },
           [2] = { prefix = "Membro", grupo = "Membro [BENNYS]", permLider = false },
           [3] = { prefix = "Gerente", grupo = "Gerente [BENNYS]", permLider = true, maxMembers = 5 },
           [4] = { prefix = "Sub-Lider", grupo = "Sub-Lider [BENNYS]", permLider = true, permBanco = true, maxMembers = 3 },
           [5] = { prefix = "Lider", grupo = "Lider [BENNYS]", permLider = true, permBanco = true, maxMembers = 2 },
        }
    },
}

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LANGS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
config.langs = {
    jogadorOffline = function(source) return TriggerClientEvent("Notify",source, "negado","Este Jogador não se encontra na cidade.", 5) end,
    invitePlayer = function(source, playerID) return TriggerClientEvent("Notify",source, "sucesso","Você convidou o <b>(ID: "..playerID..")</b> para sua organização.", 5) end,
    requestInvite = function(source, orgName) return vRP.request(source, "Você está sendo convidado para a <b>"..orgName.."</b> deseja aceitar?", 30) end,
    acceptInvite = function(source) return TriggerClientEvent("Notify",source, "sucesso","O Jogador <b>aceitou</b> o convite da sua organização.", 5) end,
    acceptNInvite = function(source, orgName) return TriggerClientEvent("Notify",source, "sucesso","Parabens!!! Você acaba de entrar para a organização <b>"..orgName.."</b>", 5) end,
    notMember = function(source, orgName) return TriggerClientEvent("Notify",source, "negado","Você não faz parte de nenhuma organização.", 5) end,
    maxCargo = function(source) return TriggerClientEvent("Notify",source, "negado","Este jogador já atingiu o cargo maximo.", 5) end,
    promoted = function(source, playerID, cargo) return TriggerClientEvent("Notify",source, "sucesso","Você atualizou o <b>(ID: "..playerID..")</b> para <b>"..cargo.."</b>.", 5) end,
    youPromoted = function(source, cargo) return TriggerClientEvent("Notify",source, "sucesso","Você acaba de ser promovido para <b>"..cargo.."</b>.", 5) end,
    notThis = function(source) return TriggerClientEvent("Notify",source, "negado","Você não pode fazer isso em si mesmo.", 5) end,
    notPermission = function(source) return TriggerClientEvent("Notify",source, "negado","Você não possui permissão para isso.", 5) end,
    demitir = function(source, playerID) return TriggerClientEvent("Notify",source, "negado","Você demitiu o <b>(ID: "..playerID..")</b> da sua organização...", 5) end,
    demitirN = function(source, orgName) return TriggerClientEvent("Notify",source, "negado","Você foi demitido da organização: <b>"..orgName.."</b>", 5) end,
    attInfo = function(source, orgName) return TriggerClientEvent("Notify",source, "sucesso","Você atualizou as informaçoes de sua organização.", 5) end,
    pedirContas = function(source, orgName) 
        if orgName == "Policia" or orgName == "PoliciaCivil" or orgName == "Bope" or orgName == "Hospital" or orgName == "Mecanica" or orgName == "LS" then
            vRPclient._giveWeapons(source, {} ,true) 
        end

  
        
        
        return TriggerClientEvent("Notify",source, "sucesso","Você saiu da organização <b>"..orgName.."</b>.", 5) 
    end,
    notThisMember = function(source, orgName) return TriggerClientEvent("Notify",source, "negado","Você não faz mais parte da organização: <b>"..orgName.."</b>.", 5) end,
    haveGroup = function(source) return TriggerClientEvent("Notify",source, "negado","Este Jogador já possui uma organização.", 5) end,
    isBlackList = function(source, tempo) return TriggerClientEvent("Notify",source, "negado","Atenção: Você está proibido de entrar em uma organização até <b>"..tempo.."</b>.", 5) end,
    haveBlackList = function(source, tempo) return TriggerClientEvent("Notify",source, "negado","Este jogador está proibido de entrar em qualquer organização até <b>"..tempo.."</b>", 5) end,
    fullLoads = function(source, total) return TriggerClientEvent("Notify",source, "negado","Está organização permite no maximo <b>"..total.."</b> pessoa(s) nesse cargo.", 5) end,
    withdraw = function(source, total) return TriggerClientEvent("Notify",source, "sucesso","Você Sacou <b>R$ "..vRP.format(total).."</b>", 5) end,
    notWithdraw = function(source, total) return TriggerClientEvent("Notify",source, "negado","O Cofre não possui esse valor..", 5) end,
    deposit = function(source, total) return TriggerClientEvent("Notify",source, "sucesso","Você Depositou <b>R$ "..vRP.format(total).."</b>", 5) end,
    notMoney = function(source, total) return TriggerClientEvent("Notify",source, "sucesso","Você não possui <b>R$ "..vRP.format(total).."</b> para depositar.", 5) end,
    metaConfigurada = function(source) return TriggerClientEvent("Notify",source,"sucesso","Meta configurada com sucesso!!",5) end,
    metaNaoConfigurada = function(source) return TriggerClientEvent("Notify",source,"negado","Meta não configurada!!",5) end,

}

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OPEN MENU
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('org', function(source,args)
    local user_id = vRP.getUserId(source)
    if user_id then
        vCLIENT.openNui(source, src.getMyOrg(user_id))
    end
end)

RegisterCommand('orgadm', function(source,args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, config.adminPermission) then
            if config.groups[args[1]] then
                vCLIENT.openNui(source, args[1])
            end
        end
    end
end)

RegisterCommand('clearorg', function(source,args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "developer.permissao") then
            vRP._execute("flow_orgs/updateMembers", { org = args[1], membros = json.encode({})})
            vRP._execute("flow_orgs/clearArmazem", { dkey = "armazem:"..args[1], dvalue = json.encode({})})
            TriggerClientEvent("Notify",source, "sucesso","Você limpou a organização: "..args[1], 5)
        end
    end
end)

RegisterCommand('rbl', function(source,args)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, config.adminPermission) then
            local id = tonumber(args[1])
            if id ~= nil then
                vRP.setUData(id, "fl0w:BlackList", 0)
                TriggerClientEvent("Notify",source, "sucesso","Você tirou a blacklist do id: "..id, 5)
            end
        end
    end
end)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
src.identity = function(user_id)
    local identity = vRP.getUserIdentity(user_id)
    return identity.nome,identity.sobrenome
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- INSERIR GRUPOS AUTOMATICAMENTE NO BANCO DE DADOS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    if config.createTable then
        vRP.execute("flow_orgs/initTable", {})
    end

    if config.automaticGroups then
        for k,v in pairs(config.groups) do
            vRP.execute("flow_orgs/initGroups", { org = k, maxMembros = v.maxMembers})
        end
    end
end)