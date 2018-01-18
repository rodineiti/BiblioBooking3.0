$(function () {
    $("#jQGridTipoLivros").jqGrid({
        url: 'Handler/HandlerTipoLivro.ashx?strAcao=L',
        datatype: "json",
        colNames: [
                'Id',
                'Descrição'
            ],
        colModel: [
                { name: 'TipId', index: 'TipId', width: 100 },
                { name: 'TipDescricao', index: 'TipDescricao', width: 700, sortable: true, editable: true, editrules: { required: true} }
            ],
        rowNum: 30,
        mType: 'GET',
        loadonce: true,
        rowList: [10, 20, 30],
        pager: '#jQGridTipoLivrosPager',
        sortname: 'TipId',
        viewrecords: true,
        sortorder: "desc",
        caption: "Listagem de Tipo de Livros",
        editurl: 'Handler/HandlerTipoLivro.ashx?strAcao=L',
        autowidth: true,
        height: 400
    });

    $('#jQGridTipoLivros').jqGrid('navGrid', '#jQGridTipoLivrosPager',
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
                TipId: function () {
                    var sel_id = $('#jQGridTipoLivros').jqGrid('getGridParam', 'selrow');
                    var value = $('#jQGridTipoLivros').jqGrid('getCell', sel_id, 'TipId');
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

                    $("#jQGridTipoLivros").trigger("reloadGrid", [{ current: true}]);
                    return [false, response.responseText]
                }
                else {
                    $(this).jqGrid('setGridParam', { datatype: 'json' }).trigger('reloadGrid')
                    return [false, response.responseText]
                }
            },
            delData: {
                TipId: function () {
                    var sel_id = $('#jQGridTipoLivros').jqGrid('getGridParam', 'selrow');
                    var value = $('#jQGridTipoLivros').jqGrid('getCell', sel_id, 'TipId');
                    return value;
                }
            }
        },
        {//SEARCH
            closeOnEscape: true
        }
    );
});