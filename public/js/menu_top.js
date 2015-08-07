$(document).ready(function() {
    // Detect active tab
    var currentPath = window.location.pathname;
    var pathArray = currentPath.split('/');
    var currentTab = pathArray[1];
    $("#"+currentTab).addClass("active");
    
    
    $("#user,#queue,#context,#provline").click(function(){
        if ($(this).hasClass("open")) {
            $(this).removeClass("open");
        }
        else {
            $(this).addClass("open");
        }
    });
    
});
    