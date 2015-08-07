$(document).ready(function() {
    $("#addExtenBtn").click(function() {
        var extenTemplate = $("#exten0-div");
        // Detect last exten Id and incement to next
        var extenLastBlock = $("#extensions").children().last('.row');
        var extenLastId = extenLastBlock.attr('id');
        var id = extenLastId.match(/exten(\d+)/)[1];
        id++;
        
        // Clone new exten from template
        var newExten = extenTemplate.clone().attr('id','exten' + id + '-div').css('display','');
        $(newExten).find('.exten-input').attr('id','exten' + id + '-input');
        $(newExten).find('.cdr').attr('id','cdr' + id);
        $(newExten).insertAfter('#'+extenLastId);
    });
    
    $("#createContextBtn").click(function(event) {
        var name = $("#name").val();
        var extens = [];
        
        $("#extensions").children('.row').each(function(){
            var extenCurrentId = $(this).attr('id');
            var id = extenCurrentId.match(/exten(\d+)/)[1];

            if (id == 0) {
                return true;
            }
            
            var exten = $("#exten"+id+"-input").val();
            var cdr;
            if ($("#cdr"+id).prop('checked')) {
                cdr = 'on';
            }
            extens.push({'exten': exten, 'cdr': cdr});
        });
        
        $.ajax({
            url: '/context',
            type: 'POST',
            data: JSON.stringify({'name': name, 'extens': extens}),
            //dataType: "json",
            success: function(data){
                if (data['error']==0) {
                    $("#result").html(data['message']).removeClass().addClass('alert-box success radius');
                } else {
                    $("#result").html(data['message']).removeClass().addClass('alert-box alert radius');
                }
            }
        });
    });
    
    $("body").on('click', 'a.deleteExten', function() {
        var currentExten = this.closest('.row').remove();
    });
    
    $(".context_delete").click(function(event){
    var context = $(this).closest("tr").attr("id");
    var confirm = window.confirm("Delete context: " + context + "?")
    
    if (confirm == true) {
        $.ajax({
            url: '/context',
            type: 'DELETE',
            data: {context: context},
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
});