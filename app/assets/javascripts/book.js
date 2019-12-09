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
                document.getElementsByClassName("average_rating")[0].textContent = event.detail[0].average_rating;
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
            comment_update_date = comment.getElementsByClassName('update-date')[0];
            comment_update_date.innerText = 'updated at ' + event.detail[0].update_date;
            comment_body.firstElementChild.textContent = event.detail[0].body;
            $('#edit-comment').modal('hide')
        });
        body.on('ajax:success', '#create-comment', function(event) {
            let new_comment = event.detail[0];
            let parent_id_input = this.querySelector("input[name='parent_comment_id']");
            let parent_element = parent_id_input !== null ?
                document.getElementById(parent_id_input.value) :
                document.getElementById('comments');
            parent_element.insertAdjacentHTML('beforeend', new_comment);
            document.getElementById('comment_create-text_field').value = '';
            let last_Child = parent_element.lastChild;
            if(parent_id_input !== null)
                this.removeChild(parent_id_input);
            last_Child.scrollIntoView();
            last_Child.style.backgroundColor = "#44aa44";
            setTimeout(function () {
                last_Child.style.backgroundColor = "";
            }, 200);
            $('#new-comment').modal('hide')

        });
        body.on('ajax:success', '.comment-delete-link', function(event) {
            parentDiv = this.parentNode.parentNode;
            parentDiv.parentNode.removeChild(parentDiv);
        });
        body.on('click', '.comment-edit-link', function() {
            let text = document.getElementById('comment_edit-text_field');
            text.value = '';
        });
        $(document).ready(function(){
            $('[data-toggle="popover"]').popover();
        });
    });
});
function reply_click(event) {
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