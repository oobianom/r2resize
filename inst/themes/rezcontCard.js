$(document).ready(function(){

  $(".r2resize-rezconcard-controls-small").click(function(event){
    event.preventDefault();
    $(".r2resize-rezconcard-holder").animate({"font-size":"50%", "line-height":"16px"});
    $("h1").animate({"font-size":"24px"});
    $("h2").animate({"font-size":"16px"});

  });

  $(".r2resize-rezconcard-controls-medium").click(function(event){
    event.preventDefault();
    $(".r2resize-rezconcard-holder").animate({"font-size":"100%", "line-height":"20px"});
    $("h1").animate({"font-size":"36px"});
    $("h2").animate({"font-size":"24px"});

  });

  $(".r2resize-rezconcard-controls-large").click(function(event){
    event.preventDefault();
    $(".r2resize-rezconcard-holder").animate({"font-size":"200%", "line-height":"20px"});
    $("h1").animate({"font-size":"48px"});
    $("h2").animate({"font-size":"30px"});

  });

  $( ".r2resize-rezconcard-holder a" ).click(function() {
   $(".r2resize-rezconcard-holder a").removeClass("selected");
  $(this).addClass("selected");

 });

});
