$(function () {
    $("#jQGridAutores").jqGrid({
        url: 'Handler/HandlerAutor.ashx?strAcao=L',
        datatype: "json",
        colNames: [
                'Id',
                'Nome',
                'Nome Científico',
                'Bibliografia'
            ],
        colModel: [
                { name: 'AutId', index: 'AutId', width: 100 },
                { name: 'AutNome', index: 'AutNome', width: 500, sortable: true, editable: true, editrules: { required: true} },
                { name: 'AutNomeCientifico', index: 'AutNomeCientifico', width: 500, sortable: true, editable: true, editrules: { required: true} },
                { name: 'AutBibliografia', index: 'AutBibliografia', edittype: 'textarea', width: 500, sortable: true, editable: true, editrules: { required: false} }
            ],
        rowNum: 30,
        mType: 'GET',
        loadonce: true,
        rowList: [10, 20, 30],
        pager: '#jQGridAutoresPager',
        sortname: 'AutId',
        viewrecords: true,
        sortorder: "desc",
        caption: "Listagem de Autores",
        editurl: 'Handler/HandlerAutor.ashx?strAcao=L',
        autowidth: true,
        height: 400
    });

    $('#jQGridAutores').jqGrid('navGrid', '#jQGridAutoresPager',
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
                AutId: function () {
                    var sel_id = $('#jQGridAutores').jqGrid('getGridParam', 'selrow');
                    var value = $('#jQGridAutores').jqGrid('getCell', sel_id, 'AutId');
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

                    $("#jQGridAutores").trigger("reloadGrid", [{ current: true}]);
                    return [false, response.responseText]
                }
                else {
                    $(this).jqGrid('setGridParam', { datatype: 'json' }).trigger('reloadGrid')
                    return [false, response.responseText]
                }
            },
            delData: {
                AutId: function () {
                    var sel_id = $('#jQGridAutores').jqGrid('getGridParam', 'selrow');
                    var value = $('#jQGridAutores').jqGrid('getCell', sel_id, 'AutId');
                    return value;
                }
            }
        },
        {//SEARCH
            closeOnEscape: true
        }
    );
});