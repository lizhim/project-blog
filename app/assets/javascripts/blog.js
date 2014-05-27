$(document).ready(function(){

})

function save_script() {
    var account = $('.header-right').text().trim().slice(3,-2).trim()
    var title = $('#title').find("input").val()
    var sort = $('#sort').find("input").val()
    var essay = $('#essay').find("textarea").val()
    $.ajax({
        url: '/blog/save_script',
        type: 'POST',
        data: {'account': account, 'title': title, 'sort': sort, 'essay': essay},
        success: function (data) {
            $('#_script_essay').children().text("草稿箱("+ data +')')
            window.location.href = '/blog/script';
        },
        error: function (err) {}
    })
}

function publish() {
    var account = $('.header-right').text().trim().slice(3,-2).trim()
    var title = $('#title').find("input").val()
    var sort = $('#sort').find("input").val()
    var essay = $('#essay').find("textarea").val()
    $.ajax({
        url: '/blog/publish',
        type: 'POST',
        data: {'account': account, 'title': title, 'sort': sort, 'essay': essay},
        success: function (data) {
            $('#_message_essay').children().text("全部博客("+ data +")")
            window.location.href = '/blog/manager';
        },
        error:function (err) {}
    })
}

function delete_publish(account_id) {
    localStorage.setItem('delete_publish', account_id);
}

function confirm_delete_publish() {
    var account_id = localStorage.getItem('delete_publish');
    $.ajax({
        url: '/blog/destroy_publish/' + account_id,
        type: 'POST',
        success: function (data) {
            window.location.reload()
        },
        error: function (err) {
        }
    });
}

function delete_script(account_id) {
    localStorage.setItem('delete_script', account_id);
}

function confirm_delete_script() {
    var account_id = localStorage.getItem('delete_script');
    $.ajax({
        url: '/blog/destroy_script/' + account_id,
        type: 'POST',
        success: function (data) {
            window.location.reload()
        },
        error: function (err) {
        }
    });
}

function delete_recycle(account_id) {
    localStorage.setItem('delete_recycle', account_id);
}

function confirm_delete_recycle() {
    var account_id = localStorage.getItem('delete_recycle');
    $.ajax({
        url: '/blog/destroy_recycle/' + account_id,
        type: 'POST',
        success: function (data) {
            window.location.reload()
        },
        error: function (err) {
        }
    });
}

function edit_publish(article_id) {
    var account = $('.header-right').text().trim().slice(3,-2).trim()
    var title = $('#title').find("input").val()
    var sort = $('#sort').find("input").val()
    var essay = $('#essay').find("textarea").val()
    $.ajax({
        url: '/blog/edit_publish_save',
        type: 'POST',
        data: {'article_id': article_id, 'account': account, 'title': title, 'sort': sort, 'essay': essay},
        success: function (data) {
            window.location.href = '/blog/manager';
        },
        error:function (err) {}
    })
}

function edit_script(article_id) {
    var account = $('.header-right').text().trim().slice(3,-2).trim()
    var title = $('#title').find("input").val()
    var sort = $('#sort').find("input").val()
    var essay = $('#essay').find("textarea").val()
    $.ajax({
        url: '/blog/edit_script_save',
        type: 'POST',
        data: {'article_id': article_id, 'account': account, 'title': title, 'sort': sort, 'essay': essay},
        success: function (data) {
            window.location.href = '/blog/script';
        },
        error:function (err) {}
    })
}

function publish_script(article_id) {
    var account = $('.header-right').text().trim().slice(3,-2).trim()
    var title = $('#title').find("input").val()
    var sort = $('#sort').find("input").val()
    var essay = $('#essay').find("textarea").val()
    $.ajax({
        url: '/blog/publish_script',
        type: 'POST',
        data: {'article_id': article_id, 'account': account, 'title': title, 'sort': sort, 'essay': essay},
        success: function (data) {
            window.location.href = '/blog/manager';
        },
        error:function (err) {}
    })
}

function blog_restore(account_id) {
    $.ajax({
        url: '/blog/restore/' + account_id,
        type: 'POST',
        success: function (data) {
            window.location.reload()
        },
        error: function (err) {
        }
    });
}

function add_category() {
    var category_name = $("#category_input").val()
    $.ajax({
        url: '/blog/add_category',
        type: 'POST',
        data: {'category_name': category_name},
        success: function (data) {
            window.location.reload()
        },
        error: function (err) {
        }
    });
}

function delete_category(name) {
    localStorage.setItem('category_name', name);
}

function confirm_delete_category() {
    var sort = localStorage.getItem('category_name');
    $.ajax({
        url: '/blog/delete_category',
        type: 'DELETE',
        data: {sort: sort},
        success: function (data) {
            window.location.reload()
        },
        error: function (err) {
        }
    });
}

function edit_category(name){
    localStorage.setItem('category', name);
    $("#edit_category_input").val(name) ;
}

function save_category(){
    var new_category = $("#edit_category_input").val()
    var old_category = localStorage.getItem('category')
    $.ajax({
        url: '/blog/edit_category',
        type: 'POST',
        data: {new_category: new_category,old_category: old_category},
        success: function (data) {
            window.location.reload()
        },
        error: function (err) {
        }
    });
}

function handle_search_button() {
    return $("#search_input").val() == ""
}

function search_blog() {
    $('#search_button').attr('disabled', handle_search_button())
    var search_content = $("#search_input").val()
    if (search_content != "") {
        $.ajax({
            url: '/blog/search',
            type: 'POST',
            data: {'content': search_content},
            success: function (data) {
                $.each(data,function(index,el){
                    console.log(JSON.stringify(data))
                    var html =  '<div> ' +' <p> ' + ' <a href="/blog/detail">' + el.title + '</a>' +
                        ' </p> ' +
                        ' <div class=\'td-character-show\'>' + el.essay +
                        ' </div> ' +
                        '<span class=\'time_display\'>' + el.created_at   + '</span>' +
                        '<span class=\'sort\'>分类：</span>' +
                        ' <span class=\'content\'>' + el.sort + '</span>' +
                        '</div>'+ '<hr>'
                    $('#search_info').append(html)
                })
            },
            error: function (err) {
            }
        });
    }
}