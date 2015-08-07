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
        $(newExten).children().children().children('.exten-input').attr('id','exten' + id + '-input');
        $(newExten).children().children('.step-div').attr('id','exten' + id + '-step1-div');
        $(newExten).children().children().children('.step-input').attr('id','exten' + id + '-step1-input');
        $(newExten).insertAfter('#'+extenLastId);
    });
    
    $("#contextCreateForm").submit(function(event) {
        event.preventDefault();
        var name = $("#name").val();
        var exten = $("#exten").val();
        var steps = [];
        for(var i = 1; i <= stepCounter; i++) {
            var step = $("#step" + i).val();
            steps.push(step);
        }
        
        $.ajax({
            url: '/context',
            type: 'POST',
            data: {'name': name, 'exten': exten, 'steps[]': steps},
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
    
    $("body").on('click', 'button.addNextStep', function() {
        var currentExten = this.closest('.row');
        var currentExtenId = $(currentExten).attr('id');
        var extenId = currentExtenId.match(/(exten\d+)-div/)[1];
        var lastStep = $(currentExten).children().children('.step-div').last();
        var stepId = lastStep.attr('id');
        var step = stepId.match(/exten\d+-step(\d+)-div/)[1];
        step++;
        var nextStep = lastStep.clone().attr('id', extenId + '-step' + step + '-div');
        nextStep.children('.step').attr('id',extenId + '-step' + step);
        nextStep.children('span').html(step);
        $(nextStep).insertAfter(lastStep);
    });
    
    $("body").on('click', 'button.deleteLastStep', function() {
        var currentExten = this.closest('.row');
        $(currentExten).children().children('.step-div').last().remove();
    });
    
    $("body").on('click', 'button.deleteExten', function() {
        var currentExten = this.closest('.row').remove();
    });
});