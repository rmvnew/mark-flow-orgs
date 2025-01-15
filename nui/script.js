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


function openConfigMeta(){
    $('.meta_config_modal').show()
    $('#orgName').val(orgName)

    $.post('http://flow_orgs/getMetaConfig',JSON.stringify({orgName: orgName}), function(response){

        console.log("DEBUG: Dados retornados do servidor:", response);

        if(response && response.dailyMeta){
           
            response.dailyMeta.forEach((item,index)=>{
                console.log(`DEBUG: Preenchendo produto ${index + 1}:`, item);
                $(`#produto_${index + 1}`).val(item.nome || '')
                $(`#quantidade_${index + 1}`).val(item.quantidade || '')
            })
        }

        if(response.paymentMeta){
            console.log("DEBUG: Preenchendo pagamento:", response.paymentMeta);
            $('#payment_meta').val(response.paymentMeta)
        }
    })
}


function checkPermission(){
    $.post('http://flow_orgs/checkPermission',(result)=>{
        if(result){
            openConfigMeta() 
        }
    })
}

function saveMeta(){
    const meta = {
        orgName: $('#orgName').val(),
        produtos: [
            {nome: $('#produto_1').val(),quantidade: $('#quantidade_1').val()},
            {nome: $('#produto_2').val(),quantidade: $('#quantidade_2').val()},
            {nome: $('#produto_3').val(),quantidade: $('#quantidade_3').val()},
            {nome: $('#produto_4').val(),quantidade: $('#quantidade_4').val()},
        ],
        pagamento: $('#payment_meta').val()
    }

    meta.produtos = meta.produtos.filter(p=> p.name || p.quantidade)

    $.post('http://flow_orgs/configurarMeta',JSON.stringify(meta),function(response){
        if(response.success){
            alert('Meta configurada com sucesso')
            closeModal()
        }else{
            alert('Erro ao configurar meta.')
        }
    })
}



function openMetaModal() {
    $('.meta_view_modal').show(); // Exibe o modal

    // Define o valor de orgName no input hidden com ID único
    $('#metaOrgName').val(orgName);

    // console.log("DEBUG: Enviando orgName para getMetaDetails:", orgName);

    // Solicita os dados da meta e do progresso
    $.post('http://flow_orgs/getMetaDetails', JSON.stringify({ orgName: orgName }), function(response) {
        // console.log("DEBUG: Dados da meta retornados:", JSON.stringify(response, null, 2));
        // console.log("DEBUG: Valor de data.infos[0]:", data.infos[0]);

        if (!response || !response.dailyMeta || !response.paymentMeta) {
            $('#meta_details').html('<p>Erro ao carregar os dados da meta.</p>');
            $('#farm_progress').html('<p>Erro ao carregar o progresso do jogador.</p>');
            return;
        }

        // Exibir os detalhes da meta
        let metaHTML = `<p class ="section_title"><strong>Produtos:</strong></p><ul>`;
        response.dailyMeta.forEach((item, index) => {
            metaHTML += `<li>${item.nome || 'Produto ' + (index + 1)} - Meta: ${item.quantidade || 0}</li>`;
        });
        metaHTML += `</ul><p><strong>Pagamento:</strong> R$ ${response.paymentMeta}</p>`;
        $('#meta_details').html(metaHTML);

        // Exibir o progresso do farm do jogador
        const farm = response.farm || [];
        let farmHTML = `<p class ="section_title"><strong>Progresso:</strong></p><ul>`;
        response.dailyMeta.forEach((item, index) => {
            const farmed = farm.find(f => f.item_name === item.nome)?.amount || 0;
            farmHTML += `<li>${item.nome || 'Produto ' + (index + 1)} - Farmado: ${farmed}</li>`;
        });
        farmHTML += '</ul>';
        $('#farm_progress').html(farmHTML);

        
        // Calcular o valor proporcional
        const totalFarm = farm.reduce((sum, f) => sum + f.amount, 0);
        const totalQuantidade = response.dailyMeta.reduce((sum, item) => sum + (parseInt(item.quantidade) || 0), 0);
        // const paymentMeta = response.paymentMeta
        
        // console.log('farm_feito: ',totalFarm);
        // console.log('farm_configurado: ',totalQuantidade);
        // console.log('farm_payment: ',paymentMeta);
        
        
        
        const paymentValue = (totalFarm / totalQuantidade) * response.paymentMeta;

        $('#payment_value').text(isNaN(paymentValue) ? 0 : paymentValue.toFixed(2));
       

        // Habilitar o botão de pagamento se a meta for alcançada
        $('#pay_button').prop('disabled', totalFarm < totalQuantidade);

        // // Passar automaticamente o ID do jogador
        // $('#player_id').val(userId); // Preenche o campo com o ID
    });
}


function payMeta() {

    const current_payment = parseFloat( $('#payment_value').text())

   
    
    // Envia o pagamento para o servidor
    $.post('http://flow_orgs/payMeta', JSON.stringify({ orgName: orgName,payment: current_payment }), function(response) {
        if (response.success) {
            
            closeModal();
        } else {
            closeModal();
            // alert("Falha ao realizar o pagamento: " + response.error);
        }
    });
}

function closeMetaModal() {
    console.log("DEBUG: Fechando o modal...");
    $('.meta_view_modal').hide(); // Esconde o modal
    $('#meta_details').html(''); // Limpa os detalhes da meta
    $('#farm_progress').html(''); // Limpa o progresso do jogador
    $('#player_id').val(''); // Reseta o campo do ID do jogador
    $('#payment_value').text('0'); // Reseta o valor do pagamento
    $('#pay_button').prop('disabled', true); // Desabilita o botão de pagamento
}

$(document).ready(function(){
    window.addEventListener('message',function(event){
        const data = event.data

        if(data.action === "closeMetaModal"){
            console.log("DEBUG: Recebido comando para fechar o modal.");
            closeMetaModal(); // Chama a função existente
        }
    })
})