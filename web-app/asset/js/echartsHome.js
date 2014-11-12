

      
function back2Top() {
    $("body,html").animate({scrollTop:0},1000);
    return false;
}
$('#footer')[0].style.marginTop = '50px';
$('#footer')[0].innerHTML =
     '<div class="container">'
        + '<p class="pull-right"><a href="javascript:void(0)" onclick="back2Top()" >Back to top</a></p>'
    + '</div>';
