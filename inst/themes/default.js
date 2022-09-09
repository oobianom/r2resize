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
        }
         );
         observer.observe(document.body, {
             childList: true, subtree: true
        }
         );
    }
     );
}
/*wait for elements of the TOC to show*/
 wFEelm = '.list-group-item';
 waitForElm(wFEelm).then((elm) => {
    /*some code*/
}
 );
 let iconfullscreensvg = '<svg class="svg-icon" viewBox="0 0 20 20"> <path d="M17.391,2.406H7.266c-0.232,0-0.422,0.19-0.422,0.422v3.797H3.047c-0.232,0-0.422,0.19-0.422,0.422v10.125c0,0.232,0.19,0.422,0.422,0.422h10.125c0.231,0,0.422-0.189,0.422-0.422v-3.797h3.797c0.232,0,0.422-0.19,0.422-0.422V2.828C17.812,2.596,17.623,2.406,17.391,2.406 M12.749,16.75h-9.28V7.469h3.375v5.484c0,0.231,0.19,0.422,0.422,0.422h5.483V16.75zM16.969,12.531H7.688V3.25h9.281V12.531z"></path> </svg>';
 let iconclosersvg = '<svg class="svg-icon" viewBox="0 0 20 20"> <path d="M10.185,1.417c-4.741,0-8.583,3.842-8.583,8.583c0,4.74,3.842,8.582,8.583,8.582S18.768,14.74,18.768,10C18.768,5.259,14.926,1.417,10.185,1.417 M10.185,17.68c-4.235,0-7.679-3.445-7.679-7.68c0-4.235,3.444-7.679,7.679-7.679S17.864,5.765,17.864,10C17.864,14.234,14.42,17.68,10.185,17.68 M10.824,10l2.842-2.844c0.178-0.176,0.178-0.46,0-0.637c-0.177-0.178-0.461-0.178-0.637,0l-2.844,2.841L7.341,6.52c-0.176-0.178-0.46-0.178-0.637,0c-0.178,0.176-0.178,0.461,0,0.637L9.546,10l-2.841,2.844c-0.178,0.176-0.178,0.461,0,0.637c0.178,0.178,0.459,0.178,0.637,0l2.844-2.841l2.844,2.841c0.178,0.178,0.459,0.178,0.637,0c0.178-0.176,0.178-0.461,0-0.637L10.824,10z"></path> </svg>';
 let iconminimizersvg = '<svg class="svg-icon" viewBox="0 0 20 20"> <path fill="none" d="M15.608,6.262h-2.338v0.935h2.338c0.516,0,0.934,0.418,0.934,0.935v8.879c0,0.517-0.418,0.935-0.934,0.935H4.392c-0.516,0-0.935-0.418-0.935-0.935V8.131c0-0.516,0.419-0.935,0.935-0.935h2.336V6.262H4.392c-1.032,0-1.869,0.837-1.869,1.869v8.879c0,1.031,0.837,1.869,1.869,1.869h11.216c1.031,0,1.869-0.838,1.869-1.869V8.131C17.478,7.099,16.64,6.262,15.608,6.262z M9.513,11.973c0.017,0.082,0.047,0.162,0.109,0.226c0.104,0.106,0.243,0.143,0.378,0.126c0.135,0.017,0.274-0.02,0.377-0.126c0.064-0.065,0.097-0.147,0.115-0.231l1.708-1.751c0.178-0.183,0.178-0.479,0-0.662c-0.178-0.182-0.467-0.182-0.645,0l-1.101,1.129V1.588c0-0.258-0.204-0.467-0.456-0.467c-0.252,0-0.456,0.209-0.456,0.467v9.094L8.443,9.553c-0.178-0.182-0.467-0.182-0.645,0c-0.178,0.184-0.178,0.479,0,0.662L9.513,11.973z"></path> </svg>';
 document.addEventListener("DOMContentLoaded", function() {
    /*elements with images*/
    let allowimage = true;
    if(allowimage){
     $("p:has(img)").each(function(index, item) {
         $(this).addClass("sliderimagep" + index);
         $(this).prepend('<div class="d-flex font-weight-bold">Resize image: &emsp;
         <input class="sliderimageinput" type="range" min="1" max="100" value="50"><span class="fullscreenicon">'+iconfullscreensvg+'</span><span class="closericon closed">'+iconclosersvg+'</span></div>');
    }
     );
     $(".fullscreenicon").click(function() {
         let mypar = $(this).parent().parent();
         $("#"+jwelemDiv.id).html(mypar.html().replace('fullscreenicon','fullscreenicon closed').replace('closericon closed','closericon'));
         $("#"+jwelemDiv.id).toggle("closed");
         $(".closericon").click(function() {
             $("#"+jwelemDiv.id).toggle("closed");
        }
         );
         $(".sliderimageinput").on('input', function() {
             let newwidth = $(this).val();
             $(this).parent().parent().children("img").each(function(index, val) {
                 $(this).attr('width', newwidth + "%");
            }
             );
        }
         );
    }
     );
     $(".sliderimageinput").on('input', function() {
         let newwidth = $(this).val();
         $(this).parent().parent().children("img").each(function(index, val) {
             $(this).attr('width', newwidth + "%");
        }
         );
    }
     );
    }
    /*elements with tables*/
    let allowtable = true;
    if(allowtable){
     $("table").each(function(index, item) {
         $(this).addClass("slidertable slidertable" + index);
         $('<div class="d-flex font-weight-bold"><div style="padding-right: 10px;">Resize table size:&emsp;
         <input class="slidertableinput" data="' + "slidertable" + index + '" type="range" min="1" max="100" value="100"></div>' + '<div>Resize table font:&emsp;
         <input class="slidertablefont" type="range" min="9" data="' + "slidertable" + index + '" max="50" value="12"></div><span class="fullscreenicon2">'+iconfullscreensvg+'</span><span class="closericon closed">'+iconclosersvg+'</span></div>').insertBefore(this);
    }
     );


      $(".fullscreenicon2").click(function() {
         let mypar = $(this).parent();
         let html1 = mypar.prop('outerHTML').replace('fullscreenicon2','fullscreenicon2 closed').replace('closericon closed','closericon');
         let html2 = mypar.next("table").prop('outerHTML');
         $("#"+jwelemDiv.id).html(html1+html2);
         $("#"+jwelemDiv.id).toggle("closed");

         $(".closericon").click(function() {
             $("#"+jwelemDiv.id).toggle("closed");
        }
         );

         $(".slidertableinput").on('input', function() {
         let newwidth = $(this).val();
         $("." + $(this).attr("data")).css("width", $(this).val() + "%");
    }
     );
     $(".slidertablefont").on('input', function() {
         let newwidth = $(this).val();
         $("." + $(this).attr("data")).css("font-size", $(this).val() + "px");
    }
     );


    }
     );

     $(".slidertableinput").on('input', function() {
         let newwidth = $(this).val();
         $("." + $(this).attr("data")).css("width", $(this).val() + "%");
    }
     );
     $(".slidertablefont").on('input', function() {
         let newwidth = $(this).val();
         $("." + $(this).attr("data")).css("font-size", $(this).val() + "px");
    }
     );
    }

}
 );
/*append to document*/
 let wiheightndow = window.innerHeight;
 let wiwidrthndow = window.innerWidth-10;
 var jwelemDiv = document.createElement('div');
 jwelemDiv.style.cssText = 'width:'+wiwidrthndow+'px;
 height:'+wiheightndow+'px;
 ';
 jwelemDiv.id = 'r2resizeexpanddisplayer';
 jwelemDiv.className = 'closed';
 document.body.appendChild(jwelemDiv);
