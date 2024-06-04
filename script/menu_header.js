$(document).ready(function () {



$(".menu-btn a").click(function () {
        var scroll = $(window).scrollTop();
        $(".overlay").fadeToggle(200);
        $(this).toggleClass('btn-open').toggleClass('btn-close');

        if( $(this).hasClass('btn-close')) { 
           $("body").addClass("noscroll");
        } 
        else if( $(this).hasClass('btn-open')) {
             $("body").removeClass('noscroll');
        }
    });
});