function waitForElm(selector) {
    return new Promise(resolve => {
        if (document.querySelector(selector)) {
            return resolve(document.querySelector(selector));
        }

        const observer = new MutationObserver(mutations => {
            if (document.querySelector(selector)) {
                resolve(document.querySelector(selector));
                observer.disconnect();
            }
        });

        observer.observe(document.body, {
            childList: true,
            subtree: true
        });
    });
}
/*wait for elements of the TOC to show*/
wFEelm = '.list-group-item';
waitForElm(wFEelm).then((elm) => {
    /*some code*/
});

document.addEventListener("DOMContentLoaded", function() {

    /*elements with images*/

    $("p:has(img)").each(function(index, item) {
        $(this).addClass("sliderimagep" + index);
        $(this).prepend('<div class="d-flex font-weight-bold">Resize image: &emsp;<input class="sliderimageinput" type="range" min="1" max="100" value="50"><span class="fullscreenicon">&#10063;</span><span class="closericon">&#9746;</span></div>');
    });

    $(".sliderimageinput").on('input', function() {
        let newwidth = $(this).val();
        $(this).parent().parent().children("img").each(function(index, val) {
            $(this).attr('width', newwidth + "%");
        });
    });



    /*elements with tables*/

    $("table").each(function(index, item) {
        $(this).addClass("slidertable slidertable" + index);
        $('<div class="d-flex font-weight-bold"><div>Resize table size:&emsp;<input class="slidertableinput" data="' + "slidertable" + index + '" type="range" min="1" max="100" value="100"></div>' +
            '<div>Resize table font:&emsp;<input class="slidertablefont" type="range" min="9" data="' + "slidertable" + index + '" max="50" value="12"></div><span class="fullscreenicon">&#10063;</span><span class="closericon">&#9746;</span></div>').insertBefore(this);
    });

    $(".slidertableinput").on('input', function() {
        let newwidth = $(this).val();
        $("." + $(this).attr("data")).css("width", $(this).val() + "%");
    });

    $(".slidertablefont").on('input', function() {
        let newwidth = $(this).val();
        $("." + $(this).attr("data")).css("font-size", $(this).val() + "px");
    });

});
