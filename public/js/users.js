$(document).ready(function() {
    var img_edit = '<a href="#"><img src="/images/svgs/fi-pencil.svg" class="icon_size2"></a>';
    var img_delete = '<a href="#"><img src="/images/svgs/fi-x.svg" class="icon_size2 user_delete"></a>';
    
    user_list_update();
    
    $("#createUserBtn").click(function(event) {
        var name = $("#name").val();
        var password = $("#password").val();
        var context = $("#context").val();
        var userrole = $("#userrole").val();
        
        $.ajax({
            url: '/user/ext',
            type: 'POST',
            data: {name: name, password: password, context: context, userrole: userrole},
            dataType: "json",
            success: function(data){
                if (data['error']==0) {
                    $("#result").html(data['message']).removeClass().addClass('alert-box success radius');
                    user_list_update();
                } else {
                    $("#result").html(data['message']).removeClass().addClass('alert-box alert radius');
                }
            }
        });
    });
    
    $("#createProvlineBtn").click(function(event) {
        var name = $("#name").val();
        var password = $("#password").val();
        var context = $("#context").val();
        var host = $("#host").val();
        var fromdomain = $("#fromdomain").val();
        var fromuser = $("#fromuser").val();
        var port = $("#port").val();
        
        event.preventDefault();
        
        $.ajax({
            url: '/user/provline',
            type: 'POST',
            data: {name:name, password:password, context:context, host:host, fromdomain:fromdomain, fromuser:fromuser, port:port},
            dataType: "json",
            success: function(data){
                if (data['error']==0) {
                    $("#result").html(data['message']).removeClass().addClass('alert-box success radius');
                } else {
                    $("#result").html(data['message']).removeClass().addClass('alert-box alert radius');
                }
            }
        });
    });

    function user_delete(name) {        
        var confirm = window.confirm("Delete extension No: " + name + "?")
        
        if (confirm == true) {
            $.ajax({
                url: '/user/ext',
                type: 'DELETE',
                data: {name: name},
                dataType: "json",
                success: function(){
                    user_list_update();
                },
                error: function() {
                    alert('Something wrong, extension can not be deleted.');
                }
            });
        }
    };
        
    function user_edit(name,userrole,context) {
        $("#name").val(name);
        $("#userrole").val(userrole);
        $("#context").val(context);
    };
    
    
    $(".provline_delete").click(function(event){
        event.preventDefault();
        
        var name = $(this).closest("tr").attr("id");
        var confirm = window.confirm("Delete provider line No: " + name + "?")
        
        if (confirm == true) {
            var name = $(this).closest("tr").attr("id");
            $.ajax({
                url: '/user/provline',
                type: 'DELETE',
                data: {name: name},
                dataType: "json",
                success: function(){
                    location.reload();
                },
                error: function() {
                    alert('Something wrong, extension can not be deleted.');
                }
            });
        }
    });
    
    function user_list_update() {
        $.ajax({
            url: "/user/ext/list",
            success: function(response) {
                $("#users_body").empty();
                $.each(response.userData, function(i, item) {
                    var userrole;
                    var useragent = 'Unknown';
                    if (item.userrole == 0) {
                        userrole = "Admin";
                    }
                    if (item.userrole == 1) {
                        userrole = "User";
                    }
                    if (item.useragent != null) {
                        useragent = item.useragent
                    }
                    var tr = $('<tr>').attr('id',i).append(
                        $('<td>').text(item.name),
                        $('<td class="context">').text(item.context),
                        $('<td class="userrole">').text(userrole),
                        $('<td>').text(useragent),
                        $('<td>').append(img_edit).click(function() {
                            var name = $(this).closest("tr").attr("id");
                            var userrole = $(this).closest("tr").children('.userrole').text();
                            var context = $(this).closest("tr").children('.context').text();
                            user_edit(name,userrole,context);
                        }),
                        $('<td>').append(img_delete).click(function () {
                            var name = $(this).closest("tr").attr("id");
                            user_delete(name);
                        })
                    );
                    $('#users_body').append(tr);
                });
                
                $('#userreport_body').empty();
                var tr = $('<tr>').append(
                    $('<td>').text(response.report.users_total),
                    $('<td>').text(response.report.users_online),
                    $('<td>').text(response.report.users_never_reg)
                );
                $('#userreport_body').append(tr)
            }
            
        });
    }
});