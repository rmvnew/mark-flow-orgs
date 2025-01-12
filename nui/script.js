let memberSelecioned = null;
let orgName = null;
let delay = false;

$(document).ready(function () {
    window.addEventListener('message', function (event) {
        let data = event.data

        if (!data.show) {
            $("#container").fadeOut()
            delay = false
            return
        }

        if (data.update) {
            $(".containerMembers").html('');
            memberSelecioned = null;
        }

        if (data.show) {
            $(".containerMembers").html('');
            $("#container").fadeIn()
            $('.team_name').html(`${data.infos[0]}™`);

            let formatMembers = data.infos[2];
            if (formatMembers >= 999) {
                formatMembers = `∞`
            } else {
                formatMembers = `${data.infos[2] - data.infos[1]}`
            }
            
            $('.list_bank').html('');
            Object.values(data.infos[7]).map((item,index)=>{

                $('.list_bank').append(`
                    <div class="item_member">
                    <div class="stats">
                            <div class="${item.tipo}"></div>
                        </div>
                        <div class="content_list name_members">${item.nome}</div>
                        <div class="content_list carge_members">${item.tipo.toUpperCase()}</div>
                        <div class="content_list last_login">R$${item.valor}</div>
                    </div>
                `)
            })

            $('.infos').html(`
                <div class="item_info">
                    <div class="title_info members_online">ONLINE</div>
                    <div class="result_info">${data.infos[4]}</div>
                </div>
                <div class="item_info">
                    <div class="title_info slot">VAGAS</div>
                    <div class="result_info">${formatMembers}</div>
                </div>
                <div class="item_info">
                    <div class="title_info members">MEMBROS</div>
                    <div class="result_info">${data.infos[1]}</div>
                </div>
                <div class="item_info saldo">
                    <div class="title_info">SALDO</div>
                    <div class="result_info">${data.infos[6]}</div>
                </div>
            `);

            $('#membros').html(`Membros: ${formatMembers}`);
            $('#escrita').val(data.infos[3]);
            orgName = data.infos[0]
            let members = data.members
            $('.list_painel').html('');
            for (let item in members) {
                let color = 'on'

                if (members[item].status > 1) {
                    color = 'off'
                }

                $('.list_painel').append(`
                    <div class="item_member" onclick="openModal('member', '${item}', '${members[item].nome}')">
                        <div class="stats">
                            <div class="${color}"></div>
                        </div>
                        <div class="content_list name_members">[${item}] ${members[item].nome}</div>
                        <div class="content_list carge_members">${members[item].cargo}</div>
                        <div class="content_list last_login">${members[item].last_login}</div>
                    </div>
                `)
            }

            let cargos = data.infos[5];
            $('.promove').html('');
            for (let id in cargos) {
                $('.promove').append(`
                        <option value="${Number(id) + 1}">${cargos[id].prefix}</option>
                `);
            }
        }

        $("#container").on('click', '.closeButton', function () {
            $.post('http://flow_orgs/closeNUI', JSON.stringify({}));
        });

        $("#container").on('click', '#promover', function () {
            $('.member_modal').hide()

            if (!memberSelecioned || delay) return
            delay = true
            let cargo = $('#promove_cargo').val();
            
            $.post('http://flow_orgs/promove', JSON.stringify({ user_id: memberSelecioned, orgName: orgName, cargo: cargo }))

            setTimeout(function () { delay = false }, 3000);
        });

        $("#container").on('click', '#demitir', function () { // OK
            if (!memberSelecioned || delay) return
            delay = true

            $.post('http://flow_orgs/demitir', JSON.stringify({ user_id: Number(memberSelecioned), orgName: orgName }))
            setTimeout(function () { delay = false }, 5000);
        });

        $("#container").on('click', '.pedircontas', function () { // Ok            
            if (delay) return
            delay = true

            $.post('http://flow_orgs/pedircontas', JSON.stringify({ orgName: orgName }))
            setTimeout(function () { delay = false }, 5000);
        });

        $("#container").on('click', '#sacar', function () {
            $('.withdraw_modal').hide()
            
            if (delay) return
            delay = true
            let value = $('#qtd_withdraw').val();
            
            $.post('http://flow_orgs/sacar', JSON.stringify({ orgName: orgName, value: value }))

            setTimeout(function () { delay = false }, 6000);
        });

        $("#container").on('click', '#depositar', function () {
            $('.deposit_modal').hide()
            
            if (delay) return
            delay = true
            let value = $('#qtd_deposit').val();
            
            $.post('http://flow_orgs/depositar', JSON.stringify({ orgName: orgName, value: value }))

            setTimeout(function () { delay = false }, 6000);
        });

    });
});

$(document).keyup(function (e) {
    if (e.key === "Escape") {
        $.post('http://flow_orgs/closeNUI', JSON.stringify({}));
    }
});

function contract(){
    let value = parseInt($("#inviteId").val());
    let cargo = $('#contract_cargo').val();
    
    if (!value | !value > 0 || delay) return
    delay = true

    $("#inviteId").val('');
    $.post('http://flow_orgs/invite', JSON.stringify({ user_id: value, orgName: orgName, cargo: cargo }))
    setTimeout(function () { delay = false }, 5000);
}

function openSection(attr) {
    $('.section').hide();
    $('.section_' + attr).show();
}

function openModal(attr, id, member, cargos) {
    if(attr == 'member'){
        memberSelecioned = id
        $('.modal').hide();
        $('.passaport span').html('[' + id + ']' + ' ' + member)
    }
    if(attr == 'deposit' || attr == 'withdraw'){
        $('.' + attr + '_modal').css('display', 'flex');
        
    }
    $('.' + attr + '_modal').show();
    
}

function closeModal() {
    $('.modal').hide();
}



$(document).ready(function () {
    window.addEventListener("offline", function () {
        $.post('http://flow_orgs/closeNUI', JSON.stringify({}));
    });
});