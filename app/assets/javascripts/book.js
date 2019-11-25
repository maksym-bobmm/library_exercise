$(document).on('turbolinks:load', function() {
    $(function() {
        let body = $('body')
        body.on('ajax:success', '.rating', function(event) {
            if (event.detail[0].tags != undefined) {
                let rating = $('.rating');
                rating.children().remove();
                rating.append(event.detail[0].tags);
                if(typeof event.detail[0].liked != 'undefined')
                    ++document.getElementsByClassName("likes_count")[0].textContent;
            }
        });
        body.on('ajax:success', '.button_to', function(event) {
            if (event.detail[0].button != undefined)
               $('.button_to').replaceWith(event.detail[0].button);
        });
        body.on('ajax:success', '#update-comment', function(event) {
            let comment_id = this.querySelector("input[name='comment_id']").value;
            let comment = document.getElementById(comment_id);
            comment_body = comment.getElementsByClassName('comment-body')[0];
            comment_body.firstElementChild.textContent = event.detail[0].body;
            $('#edit-comment').modal('hide')
        });
        body.on('click', '.comment-edit-link', function() {
            let text = document.getElementById('comment_edit-text_field');
            text.value = '';
        });
        // body.on('click', '.Reply', reply_click);
    });
});
// $(document).ready(function() {
//     return $(".update-comment").on("ajax:success", function (event) {
//         var data, ref, status, xhr;
//         ref = event.detail, data = ref[0], status = ref[1], xhr = ref[2];
//         return $("#new_article").append(xhr.responseText);
//     });
// });
function reply_click(event) {
    // debugger;
    let form = document.getElementById('create-comment');
    let parent_comment_id = event.currentTarget.dataset.comment_id;
    let input = form.querySelector("input[name='parent_comment_id']");
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
}