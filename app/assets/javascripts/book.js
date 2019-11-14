$(document).on('turbolinks:load', function() {
    $(function() {
        $('body').on('ajax:success', '.rating', function(event) {
            $('.rating').children().remove();
            $('.rating').append(event.detail[0].tags)
            if(typeof event.detail[0].liked != 'undefined')
                ++document.getElementsByClassName("likes_count")[0].textContent
        });
        $('body').on('ajax:success', '.button_to', function(event) {
            debugger
           $('.button_to').replaceWith(event.detail[0].button)
        });
    });
});