$(function() {
	function fav_count_update(data) {
      data = $.trim(data)
      if( data == '0' )
         $(".fav_count").html("")
      else
         $(".fav_count").html("("+data+")");
    }

    $(".favorites").click( function() {
       var user_id = $(this).parents(".card").attr("user_id")
       var fav_id ="";
       if($.cookie("fav_id")!=undefined) {
          fav_id = $.cookie("fav_id");
       }
       var fav_but = $(this)

       if($(this).hasClass("favorite")) {
         $.get("/favorite/remove?user_id="+user_id+"&fav_id="+fav_id, function(data) {
            fav_count_update(data);
            fav_but.find(".add").show();
            fav_but.find(".remove").hide();
            fav_but.removeClass("favorite");
         });
       } else {
         $.get("/favorite/add?user_id="+user_id+"&fav_id="+fav_id, function(data) {
            if(!fav_id) {
              $.cookie("fav_id",data, {path: "/", expires: 365*1000});
              $(".fav_count").html("(1)");
            } else {
              fav_count_update(data)
            }
            fav_but.addClass("favorite");
            fav_but.find(".add").hide();
            fav_but.find(".remove").show();
         });
       }
      
    });
});