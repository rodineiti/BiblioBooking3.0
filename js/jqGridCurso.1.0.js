$(function() {
    $("#jQGridCursos").jqGrid({
        url: 'Handler/HandlerCurso.ashx?strAcao=L',
        datatype: "json",
        colNames: [
                'Id',
                'Descrição'
            ],
        colModel: [
                { name: 'CurId', index: 'CurId', width: 100 },
                { name: 'CurDescricao', index: 'CurDescricao', width: 700, sortable: true, editable: true, editrules: { required: true} }
            ],
        rowNum: 30,
        mType: 'GET',
        loadonce: true,
        rowList: [10, 20, 30],
        pager: '#jQGridCursosPager',
        sortname: 'CurId',
        viewrecords: true,
        sortorder: "desc",
        caption: "Listagem de cursos",
        editurl: 'Handler/HandlerCurso.ashx?strAcao=L',
        autowidth:true,
        height:400
    });

    $('#jQGridCursos').jqGrid('navGrid', '#jQGridCursosPager',
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
            afterSubmit: function(response, postdata) {
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
                CurId: function() {
                    var sel_id = $('#jQGridCursos').jqGrid('getGridParam', 'selrow');
                    var value = $('#jQGridCursos').jqGrid('getCell', sel_id, 'CurId');
                    return value;
                }
            }
        },
        {
            closeAfterAdd: true, //Closes the add window after add
            afterSubmit: function(response, postdata) {
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
            afterSubmit: function(response, postdata) {
                if (response.responseText == "") {

                    $("#jQGridCursos").trigger("reloadGrid", [{ current: true}]);
                    return [false, response.responseText]
                }
                else {
                    $(this).jqGrid('setGridParam', { datatype: 'json' }).trigger('reloadGrid')
                    return [false, response.responseText]
                }
            },
            delData: {
                CurId: function() {
                    var sel_id = $('#jQGridCursos').jqGrid('getGridParam', 'selrow');
                    var value = $('#jQGridCursos').jqGrid('getCell', sel_id, 'CurId');
                    return value;
                }
            }
        },
        {//SEARCH
            closeOnEscape: true
        }
    );
});