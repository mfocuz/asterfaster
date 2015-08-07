$(document).ready(function() {
    $("#queueCreateForm").submit(function(event) {
        var name = $("#name").val();
        var timeout = $("#timeout").val();
        var strategy = $("#strategy").val();
        var members = $("#queue_members").val();
        event.preventDefault();
        
        $.ajax({
            url: '/queue',
            type: 'POST',
            data: {'name': name, 'timeout': timeout, 'strategy': strategy, 'members': members},
            dataType: "json",
            success: function(data){
                if (data['error']==0) {
                    $("#result").html(data['message']).removeClass().addClass('alert alert-success');
                } else {
                    $("#result").html(data['message']).removeClass().addClass('alert alert-danger');
                }
            }
        });
    });
    
    $("#users,#queues,#contexts").click(function(){
        if ($(this).hasClass("open")) {
            $(this).removeClass("open");
        }
        else {
            $(this).addClass("open");
        }
    });
    
    $("#include").click(function(){
        var selectedUsers = $("#user_list").val();
        var length = selectedUsers.length;
        for (var i=0; i<length; i++) {
            var user = selectedUsers[i];
            user = $("#user_list>option[value="+user+"]").detach();
            user.appendTo("#queue_members");
        }
    });
    
    $("#exclude").click(function(){
        var selectedUsers = $("#queue_members").val();
        var length = selectedUsers.length;
        for (var i=0; i<length; i++) {
            var user = selectedUsers[i];
            user = $("#queue_members>option[value="+user+"]").detach();
            user.appendTo("#user_list");
        }
    });
    
    $(".delete").click(function(event){
        event.preventDefault();
        
        var name = $(this).closest("tr").attr("id");
        var confirm = window.confirm("Delete queue: " + name + "?")
        
        if (confirm == true) {
            var name = $(this).closest("tr").attr("id");
            $.ajax({
                url: '/queue',
                type: 'DELETE',
                data: {name: name},
                dataType: "json",
                success: function(){
                    location.reload();
                },
                error: function() {
                    alert('Something wrong, queue can not be deleted.');
                }
            });
        }
    });
});