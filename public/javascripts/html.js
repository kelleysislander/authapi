$(document).ready(
    function(){
        if ( history.length == undefined || history.length <= 0 )
            $('.back').hide();

        $('.back').click(function(){
            if ( history.length > 0 )
                history.back();

            return false;
        });

        $('.submit').click(function(){
            if ( $('.hiddenSubmit').length > 0 )
            {
                $('.hiddenSubmit').click();
            }

            return false;
        });
    }
);
