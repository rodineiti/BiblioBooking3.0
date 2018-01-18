$(function () {
    var lastSel = -1;
    $("#jQGridAlunos").jqGrid({
        url: 'Handler/HandlerAluno.ashx?strAcao=L',
        datatype: "json",
        colNames: [
                'Id',
                'Curso',
                'Turma',
                'Nome',
                'Email',
                'CPF',
                'Senha',
                'Endereço',
                'Bairro',
                'Cidade',
                'UF',
                'CEP',
                'Fone',
                'Celular',
                'Ativo',
                'Observação'
            ],
        colModel: [
                { name: 'AluId', index: 'AluId', width: 100 },
                {
                    name: 'CurDescricao',
                    index: 'CurDescricao',
                    sortable: true,
                    editable: true,
                    edittype: 'select',
                    editoptions: {
                        dataUrl: "Handler/HandlerCurso.ashx?strAcao=L",
                        buildSelect: function(data) {
                            var response = eval(data);
                            var s = '<select>';
                            s += '<option value"">Selecione</option>';
                            jQuery.each(response, function(i, item) {
                                s += '<option value="' + response[i].CurId + '">' + response[i].CurDescricao + '</option>';
                            });
                            return s + "</select>";
                        }
                    },
                    editrules: { required: true, minValue: 1 }
                },
                {
                    name: 'TurDescricao',
                    index: 'TurDescricao',
                    sortable: true,
                    editable: true,
                    edittype: 'select',
                    editoptions: {
                        dataUrl: "Handler/HandlerTurma.ashx?strAcao=L",
                        buildSelect: function(data) {
                            var response = eval(data);
                            var s = '<select>';
                            s += '<option value"">Selecione</option>';
                            jQuery.each(response, function(i, item) {
                                s += '<option value="' + response[i].TurId + '">' + response[i].TurDescricao + '</option>';
                            });
                            return s + "</select>";
                        }
                    },
                    editrules: { required: true, minValue: 1 }
                },
                { name: 'AluNome', index: 'AluNome', sortable: true, editable: true, editrules: { required: true} },
                { name: 'AluEmail', index: 'AluEmail', sortable: true, editable: true, editrules: { required: true, email:true } },
                { name: 'AluCPF', index: 'AluCPF', sortable: true, editable: true, editrules: { required: true} },
                { name: 'AluSenha', index: 'AluSenha', sortable: true, editable: true, editrules: { required: true} },
                { name: 'AluEndereco', index: 'AluEndereco', sortable: true, editable: true, editrules: { required: true} },
                { name: 'AluBairro', index: 'AluBairro', sortable: true, editable: true, editrules: { required: true} },
                { name: 'AluCidade', index: 'AluCidade', sortable: true, editable: true, editrules: { required: true} },
                { name: 'AluUF', index: 'AluUF', sortable: true, editable: true, editrules: { required: true} },
                { name: 'AluCEP', index: 'AluCEP', sortable: true, editable: true, editrules: { required: true} },
                { name: 'AluFone', index: 'AluFone', sortable: true, editable: true, editrules: { required: true} },
                { name: 'AluCelular', index: 'AluCelular', sortable: true, editable: true, editrules: { required: true} },
                { name: 'AluSituacao', index: 'AluSituacao', sortable: true, edittype: "checkbox", editoptions: { value: "S:N" }, editable: true, editrules: { required: true} },
                { name: 'AluObservacao', index: 'AluObservacao', sortable: true, edittype: 'textarea', editable: true, editrules: { required: false} }
            ],
        rowNum: 30,
        mType: 'GET',
        loadonce: true,
        rowList: [10, 20, 30],
        pager: '#jQGridAlunosPager',
        sortname: 'AluId',
        viewrecords: true,
        sortorder: "desc",
        caption: "Listagem de Alunos",
        editurl: 'Handler/HandlerAluno.ashx?strAcao=L',
        autowidth: true,
        height: 400
    });

    $('#jQGridAlunos').jqGrid('navGrid', '#jQGridAlunosPager',
        {
            edit: true,
            add: true,
            del: true,
            search: true,
            searchtext: "Procurar",
            addtext: "Adicionar",
            edittext: "Editar",
            deltext: "Deletar"
        },
        {
            //EDIT
            //                       height: 300,
            //                       width: 400,
            //                       top: 50,
            //                       left: 100,
            //                       dataheight: 280,
            closeOnEscape: true, //Closes the popup on pressing escape key
            reloadAfterSubmit: true,
            drag: true,
            afterSubmit: function (response, postdata) {
                if (response.responseText == "") {

                    $(this).jqGrid('setGridParam', { datatype: 'json' }).trigger('reloadGrid'); //Reloads the grid after edit
                    return [true, '']
                }
                else {
                    $(this).jqGrid('setGridParam', { datatype: 'json' }).trigger('reloadGrid'); //Reloads the grid after edit
                    return [false, response.responseText]//Captures and displays the response text on th Edit window
                }
            },
            editData: {
                AluId: function () {
                    var sel_id = $('#jQGridAlunos').jqGrid('getGridParam', 'selrow');
                    var value = $('#jQGridAlunos').jqGrid('getCell', sel_id, 'AluId');
                    return value;
                }
            }
        },
        {
            closeAfterAdd: true, //Closes the add window after add
            afterSubmit: function (response, postdata) {
                if (response.responseText == "") {
                    $(this).jqGrid('setGridParam', { datatype: 'json' }).trigger('reloadGrid')//Reloads the grid after Add
                    return [true, '']
                }
                else {
                    $(this).jqGrid('setGridParam', { datatype: 'json' }).trigger('reloadGrid')//Reloads the grid after Add
                    return [false, response.responseText]
                }
            }
        },
        {   //DELETE
            closeOnEscape: true,
            closeAfterDelete: true,
            reloadAfterSubmit: true,
            closeOnEscape: true,
            drag: true,
            afterSubmit: function (response, postdata) {
                if (response.responseText == "") {

                    $("#jQGridAlunos").trigger("reloadGrid", [{ current: true}]);
                    return [false, response.responseText]
                }
                else {
                    $(this).jqGrid('setGridParam', { datatype: 'json' }).trigger('reloadGrid')
                    return [false, response.responseText]
                }
            },
            delData: {
                AluId: function () {
                    var sel_id = $('#jQGridAlunos').jqGrid('getGridParam', 'selrow');
                    var value = $('#jQGridAlunos').jqGrid('getCell', sel_id, 'AluId');
                    return value;
                }
            }
        },
        {//SEARCH
            closeOnEscape: true
        }
    );
});