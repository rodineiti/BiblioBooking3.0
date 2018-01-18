$(function () {
    $("#jQGridEditoras").jqGrid({
        url: 'Handler/HandlerEditora.ashx?strAcao=L',
        datatype: "json",
        colNames: [
                'Id',
                'Nome',
                'Endereço',
                'Bairro',
                'Cidade',
                'UF',
                'CEP',
                'Fone'
            ],
        colModel: [
                { name: 'EdiId', index: 'EdiId', width: 100 },
                { name: 'EdiNome', index: 'EdiNome', sortable: true, editable: true, editrules: { required: true} },
                { name: 'EdiEndereco', index: 'EdiEndereco', sortable: true, editable: true, editrules: { required: true} },
                { name: 'EdiBairro', index: 'EdiBairro', sortable: true, editable: true, editrules: { required: true} },
                { name: 'EdiCidade', index: 'EdiCidade', sortable: true, editable: true, editrules: { required: true} },
                { name: 'EdiUF', index: 'EdiUF', sortable: true, editable: true, editrules: { required: true } },
                { name: 'EdiCEP', index: 'EdiCEP', sortable: true, editable: true, editrules: { required: true} },
                { name: 'EdiFone', index: 'EdiFone', sortable: true, editable: true, editrules: { required: true} }
            ],
        rowNum: 30,
        mType: 'GET',
        loadonce: true,
        rowList: [10, 20, 30],
        pager: '#jQGridEditorasPager',
        sortname: 'EdiId',
        viewrecords: true,
        sortorder: "desc",
        caption: "Listagem de Editoras",
        editurl: 'Handler/HandlerEditora.ashx?strAcao=L',
        autowidth: true,
        height: 400
    });

    $('#jQGridEditoras').jqGrid('navGrid', '#jQGridEditorasPager',
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
                EdiId: function () {
                    var sel_id = $('#jQGridEditoras').jqGrid('getGridParam', 'selrow');
                    var value = $('#jQGridEditoras').jqGrid('getCell', sel_id, 'EdiId');
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

                    $("#jQGridEditoras").trigger("reloadGrid", [{ current: true}]);
                    return [false, response.responseText]
                }
                else {
                    $(this).jqGrid('setGridParam', { datatype: 'json' }).trigger('reloadGrid')
                    return [false, response.responseText]
                }
            },
            delData: {
                EdiId: function () {
                    var sel_id = $('#jQGridEditoras').jqGrid('getGridParam', 'selrow');
                    var value = $('#jQGridEditoras').jqGrid('getCell', sel_id, 'EdiId');
                    return value;
                }
            }
        },
        {//SEARCH
            closeOnEscape: true
        }
    );
});