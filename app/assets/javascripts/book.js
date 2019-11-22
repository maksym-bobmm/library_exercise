$(document).on('turbolinks:load', function() {
    $(function() {
        $('body').on('ajax:success', '.rating', function(event) {
            if (event.detail[0].tags != undefined) {
                $('.rating').children().remove();
                $('.rating').append(event.detail[0].tags)
                if(typeof event.detail[0].liked != 'undefined')
                    ++document.getElementsByClassName("likes_count")[0].textContent
            }
        });
        $('body').on('ajax:success', '.button_to', function(event) {
            if (event.detail[0].button != undefined)
               $('.button_to').replaceWith(event.detail[0].button)
        });
    });
});
$(function() {
    $('body').on('ajax:success', '.comment-edit-link', function(event) {
        debugger;
    });
});
function reply_click(event) {
    let form = document.getElementById('create-comment');
    let parent_comment_id = event.currentTarget.dataset.comment_id;
    let input = form.querySelector("input[name='parent_comment_id']")
    if(input == null){
        input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'parent_comment_id';
        input.value = parent_comment_id;
        form.append(input);
    } else {
        input.value = parent_comment_id;
    }
    form.scrollIntoView();
}
function edit_click(event) {
    let form = document.getElementById('update-comment');
    let input = form.querySelector("input[name='comment_id']");
    input.value = event.currentTarget.dataset.comment_id;
    // debugger;

}