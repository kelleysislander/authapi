var jQT = new $.jQTouch({});
// handle the loading of ajax links that are outside of ul lis
var lastDivId = 0;
var nextDivId = 1;

// we do a live bind to the tap event to it will continue to work on ajax created pages
$('a[rel="_ajax"]').live('tap', function() { makeAjaxCall($(this)); return false; });
$('a[rel="_ajax"]').live('click', function() { makeAjaxCall($(this)); return false; });

$(document).ready(
    function(){
        if ( $('img#splash').attr('src') ) {
            // the splash page redirects to the login page
            setTimeout( function(){ targetURL = $('<a href=""></a>').attr('href', '/login'); makeAjaxCall(targetURL); }, 2000);
        }
    }
);

function makeAjaxCall(thing){
	loadNewDiv('newdiv'+nextDivId, thing.attr('href'));

	lastDivId++;
	nextDivId++;
}
function loadNewDiv(newDivId, targetURL){
	$("body").append('<div id="'+newDivId+'"><div class="toolbar"><h1>Loading</h1><a class="back" href="#">Back</a></div><div style="text-align:center; font-size: 17px; margin-top: 16px; font-weight: bold;">Loading...<br /><img src="/jqtouch/themes/jqt/img/loading.gif" /></div></div>');

        //fetch data
	$('#'+newDivId).load(
            targetURL,
            function(){
                // remove the active class from any previous screens, so if the user presses the back button they will not see the .active styling
                $('.active').removeClass('active');

                // Replace loading screen with content we just loaded
                jQT.goTo('#'+newDivId, 'slide');
            }
        );
}

