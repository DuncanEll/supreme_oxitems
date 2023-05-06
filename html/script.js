var up = false;

function image1function(source) {
    if(!up){
        $('#image1').fadeIn('slow');
        $('.image1class').fadeIn('slow');
        $('<img  src='+source+' style = "width:100%; height: 100%;">').appendTo('.image1class')
        up = true
    }
}

function popdownfunction() { 
    if(up){
        $('#image1').fadeOut('slow');
        $('.image1class').fadeOut('slow');
        $('.image1class').html("");
        up = false
        $.post('https://supreme_oxitems/Close', JSON.stringify({}));
    }
}


$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: // ESCAPE
            popdownfunction()
            break;
    }
});

$(document).ready(function(){
    window.addEventListener('message', function(event) {
        switch(event.data.action) {
            case "Show":
                image1function(event.data.photo);
                break;
        }
    })
});

$(document).ready(function(){
    window.addEventListener('message', function(event) {
        var node = document.createElement('textarea');
        var selection = document.getSelection();
  
        node.textContent = event.data.coords;
        document.body.appendChild(node);
  
        selection.removeAllRanges();
        node.select();
        document.execCommand('copy');
  
        selection.removeAllRanges();
        document.body.removeChild(node);
    });
  });
