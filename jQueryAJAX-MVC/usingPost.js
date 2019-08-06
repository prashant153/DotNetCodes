function postMethod(param1) {        
        var actionUrl = '@Url.Action("ActionMethod", "ControllerName")';
        $.ajax({
            type: "POST",
            url: actionUrl,
            datatype: "json",
            traditional: true,
            data: $.param({ id1: id1Val, id2: id2Val,  }),
            success: function (data, status, xhr) {
                //Onsuccess functions
            },
            error: function (xhr, status, error) {
               //OnError functions
            }
        });
    }
