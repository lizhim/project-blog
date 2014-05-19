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
