$(document).on('turbolinks:load', function() {
    $(function() {
        $('body').on('ajax:success', '.rating', function(event) {
            $('.rating').children().remove();
            $('.rating').append(event.detail[0].tags)
        });
    });
});