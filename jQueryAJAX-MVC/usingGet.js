function getMethod(param1, param2) {
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
