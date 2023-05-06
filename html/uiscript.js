$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })

    document.onkeyup = function(data) {
        if (data.which == 27) {
            $.post("https://supreme_oxitems/exit", JSON.stringify({}));
            return
        }
    };
    $("#close").click(function () {
        $.post("https://supreme_oxitems/exit", JSON.stringify({}));
        return
    })

    $("#itemCreate").click(function () {
        let nameValue = $("#input1").val()
        let labelValue = $("#input2").val()
        let weightValue = $("#input3").val()
        let stackValue = $("#input4").val()
        let closeValue = $("#input5").val()
        let descriptionValue = $("#input6").val()
        let imageValue = $("#input7").val()
        $.post("https://supreme_oxitems/itemCreate", JSON.stringify({
            name: nameValue,
            label: labelValue,
            weight: weightValue,
            stack: stackValue,
            close: closeValue,
            description: descriptionValue,
            image: imageValue,
        }));
        return;
    })

    $("#urlViewer").click(function () {
        let urlValue = $("#input").val()
        $.post("https://supreme_oxitems/image", JSON.stringify({
            url: urlValue,
        }));
        return;
    })

    $("#carModel").click(function () {
        let carValue = $("#inputCar").val()
        $.post("https://supreme_oxitems/carModel", JSON.stringify({
            model: carValue,
        }));
        return;
    })

    
})

function showPage(pageId) {
    const page = document.getElementById(pageId);
    page.style.display = 'block';
}

function hideAllPages() {
    const pages = document.getElementsByClassName('page');
    for (let i = 0; i < pages.length; i++) {
        pages[i].style.display = 'none';
    }
}

document.getElementById('navPage1').addEventListener('click', function(event) {
    event.preventDefault();
    hideAllPages();
    showPage('page1');
});

document.getElementById('navPage2').addEventListener('click', function(event) {
    event.preventDefault();
    hideAllPages();
    showPage('page2');
});

document.getElementById('navPage3').addEventListener('click', function(event) {
    event.preventDefault();
    hideAllPages();
    showPage('page3');
});