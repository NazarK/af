$(function() {
	function onAfter(curr,next,opts) {
	  $(this).attr("curSlide",opts.currSlide);
	  var num = opts.currSlide+1;
	  $(this).parents(".card").find(".slideshownav .slide").removeClass("active");
	  $(this).parents(".card").find(".slideshownav .slide[num="+num+"]").addClass("active");
	}

	$('.slideshow').cycle({
	  timeout: 0,
	  fx: 'scrollHorz',
	  prev:   '#prev', 
	  next:   '#next', 
	  after:   onAfter,
	  speed: 200
	});

	$('.slideshownav .next').mousedown( function() {
	   $(this).parents('.card').find(".slideshow").cycle("next");
	});

	$('.slideshownav .prev').mousedown( function() {
	   $(this).parents('.card').find(".slideshow").cycle("prev");
	});

	$('.slideshownav .slide').mousedown( function() {
	   $(this).parents(".slideshownav").find(".slide").removeClass("active");
	   $(this).addClass("active");
	   $(this).parents('.card').find(".slideshow").cycle(parseInt($(this).attr("num"))-1);
	});
});