var highlightDelay = 3000;
var paused = false;

function hightlight(index) {
    $("span.line").eq(index).addClass('highlight');
    setTimeout(function () {
               $("span.line").eq(index).removeClass('highlight');
               if(!paused) {
               if(index + 1 < $("span.line").length) {
               hightlight(index + 1)
               }
               }
               }, highlightDelay);
}

function record() {
    paused = false;
    hightlight(0);
}

function pause() {
    paused = true;
}
