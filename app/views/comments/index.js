$("#comments_area").html("<%= j(render 'index', { comments: @comment }) %>")
$("textarea").val('')