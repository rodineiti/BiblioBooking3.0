$(function () {
    $("#jQGridLivros").jqGrid({
        url: 'Handler/HandlerLivro.ashx?strAcao=L',
        datatype: "json",
        colNames: [
                'Id',
                'Autor',
                'Editora',
                'Categoria',
                'Tipo',
                'ISBN',
                'Titulo',
                'Ano',
                'Edicao',
                'Local',
                'Páginas',
                'Disponível',
                'Observação'
            ],
        colModel: [
                { name: 'LivId', index: 'LivId', width: 100 },
                {
                    name: 'AutNome',
                    index: 'AutNome',
                    sortable: true,
                    editable: true,
                    edittype: 'select',
                    editoptions: {
                        dataUrl: "Handler/HandlerAutor.ashx?strAcao=L",
                        buildSelect: function (data) {
                            var response = eval(data);
                            var s = '<select>';
                            s += '<option value"">Selecione</option>';
                            jQuery.each(response, function (i, item) {
                                s += '<option value="' + response[i].AutId + '">' + response[i].AutNome + '</option>';
                            });
                            return s + "</select>";
                        }
                    },
                    editrules: { required: true, minValue: 1 }
                },
                {
                    name: 'EdiNome',
                    index: 'EdiNome',
                    sortable: true,
                    editable: true,
                    edittype: 'select',
                    editoptions: {
                        dataUrl: "Handler/HandlerEditora.ashx?strAcao=L",
                        buildSelect: function (data) {
                            var response = eval(data);
                            var s = '<select>';
                            s += '<option value"">Selecione</option>';
                            jQuery.each(response, function (i, item) {
                                s += '<option value="' + response[i].EdiId + '">' + response[i].EdiNome + '</option>';
                            });
                            return s + "</select>";
                        }
                    },
                    editrules: { required: true, minValue: 1 }
                },
                {
                    name: 'CatDescricao',
                    index: 'CatDescricao',
                    sortable: true,
                    editable: true,
                    edittype: 'select',
                    editoptions: {
                        dataUrl: "Handler/HandlerCategoria.ashx?strAcao=L",
                        buildSelect: function (data) {
                            var response = eval(data);
                            var s = '<select>';
                            s += '<option value"">Selecione</option>';
                            jQuery.each(response, function (i, item) {
                                s += '<option value="' + response[i].CatId + '">' + response[i].CatDescricao + '</option>';
                            });
                            return s + "</select>";
                        }
                    },
                    editrules: { required: true, minValue: 1 }
                },
                {
                    name: 'TipDescricao',
                    index: 'TipDescricao',
                    sortable: true,
                    editable: true,
                    edittype: 'select',
                    editoptions: {
                        dataUrl: "Handler/HandlerTipoLivro.ashx?strAcao=L",
                        buildSelect: function (data) {
                            var response = eval(data);
                            var s = '<select>';
                            s += '<option value"">Selecione</option>';
                            jQuery.each(response, function (i, item) {
                                s += '<option value="' + response[i].TipId + '">' + response[i].TipDescricao + '</option>';
                            });
                            return s + "</select>";
                        }
                    },
                    editrules: { required: true, minValue: 1 }
                },
                { name: 'LivISBN', index: 'LivISBN', sortable: true, editable: true, editrules: { required: true} },
                { name: 'LivTitulo', index: 'LivTitulo', sortable: true, editable: true, editrules: { required: true} },
                { name: 'LivAno', index: 'LivAno', sortable: true, editable: true, editrules: { required: true} },
                { name: 'LivEdicao', index: 'LivEdicao', sortable: true, editable: true, editrules: { required: true} },
                { name: 'LivLocalizacao', index: 'LivLocalizacao', sortable: true, editable: true, editrules: { required: true} },
                { name: 'LivPaginas', index: 'LivPaginas', sortable: true, editable: true, editrules: { required: true, integer:true } },
                { name: 'LivStatus', index: 'LivStatus', sortable: true, edittype: "checkbox", editoptions: { value: "S:N" }, editable: true, editrules: { required: true} },
                { name: 'LivObservacao', index: 'LivObservacao', sortable: true, edittype: 'textarea', editable: true, editrules: { required: false} }
            ],
        rowNum: 30,
        mType: 'GET',
        loadonce: true,
        rowList: [10, 20, 30],
        pager: '#jQGridLivrosPager',
        sortname: 'LivId',
        viewrecords: true,
        sortorder: "desc",
        caption: "Listagem de Livros",
        editurl: 'Handler/HandlerLivro.ashx?strAcao=L',
        autowidth: true,
        height: 400
    });

    $('#jQGridLivros').jqGrid('navGrid', '#jQGridLivrosPager',
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
                LivId: function () {
                    var sel_id = $('#jQGridLivros').jqGrid('getGridParam', 'selrow');
                    var value = $('#jQGridLivros').jqGrid('getCell', sel_id, 'LivId');
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

                    $("#jQGridLivros").trigger("reloadGrid", [{ current: true}]);
                    return [false, response.responseText]
                }
                else {
                    $(this).jqGrid('setGridParam', { datatype: 'json' }).trigger('reloadGrid')
                    return [false, response.responseText]
                }
            },
            delData: {
                LivId: function () {
                    var sel_id = $('#jQGridLivros').jqGrid('getGridParam', 'selrow');
                    var value = $('#jQGridLivros').jqGrid('getCell', sel_id, 'LivId');
                    return value;
                }
            }
        },
		{
			beforeRefresh: function () {
				$(this).jqGrid('setGridParam', { datatype: 'json' }).trigger('reloadGrid')
			}
		},
        {//SEARCH
            closeOnEscape: true
        }
    );
});