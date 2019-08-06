function getMethod(param1, param2) {
        var actionUrl = '@Url.Action("ViewName", "ControllerName",new { param = "__param__" })';
        actionUrl = actionUrl.replace('__param__', param1);
        $.ajax({
            type: "GET",
            url: actionUrl,
            datatype: "json",
            traditional: true,
            data: { },
            success: function (data, status, xhr) {
                //OnSuccess functions
            },
            error: function (xhr, status, error) {
            }
        });

    }
