$(function () {
    var lastSel = -1;
    $("#jQGridReservas").jqGrid({
        url: 'Handler/HandlerReserva.ashx?strAcao=L',
        datatype: "json",
        colNames: [
                        'Protocolo',
                        'Aluno'
                  ],
        colModel: [
                        { name: 'ResId', index: 'ResId', width: 100, sorttype: "int", key: true },
                        { name: 'AluNome', index: 'AluNome', width: 500, sorttype: "string", editable: false }
                ],
        rowNum: 10,
        mType: 'GET',
        loadonce: true,
        rowList: [10, 20, 30],
        pager: '#jQGridReservasPager',
        sortname: 'ResId',
        viewrecords: true,
        sortorder: "asc",
        autowidth: true,
        caption: "Listagem de reservas",
        editurl: 'Handler/HandlerReserva.ashx?strAcao=L',
        onSelectRow: function (ids) {
            if (ids == null) {
                ids = 0;
                if ($("#jQGridItemReserva").jqGrid('getGridParam', 'records') > 0) {
                    $("#jQGridItemReserva").jqGrid('setGridParam', { url: "Handler/HandlerItemReserva.ashx?strAcao=L&id=" + ids, page: 1 });
                    $("#jQGridItemReserva").jqGrid('setCaption', "Detalhes da Reserva: " + ids)
                                    .trigger('reloadGrid');
                }
            } else {
                $("#jQGridItemReserva").jqGrid('setGridParam', { url: "Handler/HandlerItemReserva.ashx?strAcao=L&id=" + ids, page: 1 });
                $("#jQGridItemReserva").jqGrid('setCaption', "Detalhes da Reserva: " + ids)
                              .trigger('reloadGrid');
            }
        }
    });
    $('#jQGridReservas').jqGrid('navGrid', '#jQGridReservasPager',
        {
            edit: true,
            add: false,
            del: true,
            search: true
        },
        {
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
                ResId: function () {
                    var sel_id = $('#jQGridReservas').jqGrid('getGridParam', 'selrow');
                    var value = $('#jQGridReservas').jqGrid('getCell', sel_id, 'ResId');
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

                    $("#jQGridReservas").trigger("reloadGrid", [{ current: true}]);
                    return [false, response.responseText]
                }
                else {
                    $(this).jqGrid('setGridParam', { datatype: 'json' }).trigger('reloadGrid')
                    return [true, response.responseText]
                }
            },
            delData: {
                ResId: function () {
                    var sel_id = $('#jQGridReservas').jqGrid('getGridParam', 'selrow');
                    var value = $('#jQGridReservas').jqGrid('getCell', sel_id, 'ResId');
                    return value;
                }
            }
        },
        {//SEARCH
            closeOnEscape: true
        }
    );

    $("#jQGridItemReserva").jqGrid({
        height: 100,
        url: 'Handler/HandlerItemReserva.ashx?strAcao=L&id=0',
        datatype: "json",
        colNames: [
                        'Código',
                        'ISBN',
                        'Título do Livro',
                        'Localização'
                  ],
        colModel: [
                        { name: 'IteId', index: 'IteId', width: 100 },
                        { name: 'LivISBN', index: 'LivISBN', width: 100, sortable: true, editable: false },
                        { name: 'LivTitulo', index: 'LivTitulo', width: 500, sortable: true, editable: false },
                        { name: 'LivLocalizacao', index: 'LivLocalizacao', width: 100, sortable: true, editable: false }
                ],
        rowNum: 5,
        rowList: [5, 10, 20],
        pager: '#jQGridItemReservalPager',
        sortname: 'IteId',
        viewrecords: true,
        sortorder: "asc",
        autowidth: true,
        caption: "Item de Reserva"
    }).navGrid('#jQGridItemReservalPager', { add: false, edit: false, del: false });
});