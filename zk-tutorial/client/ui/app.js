var CurrentSlide = 1;
var MaxSlide = 0;
var isTutorialDisplayed = false;
var isFinishButtonDisplayed = false; 

$(document).ready(function(){
    window.addEventListener('message', function(event) {
        var Data = event.data
        switch(Data.event) {
            case 'show-popup':
                $(".popup-information").html(Data.popUpMessage)
                $(".tutorial-popup").fadeIn(500)
            break;
            case 'buildSlide':
                $("#location-name").text(Data.locationName);
                $("#location-description").text(Data.locationDescription);
                if (isTutorialDisplayed == false && Data.maxSlides) {
                    MaxSlide = Data.maxSlides;
                    $(".tutorial-container").fadeIn(500)
                } 
            break;
        }
    })
    $('#skip').click(function () {
        $(".tutorial-popup").fadeOut(500)
        $.post(`https://zk-tutorial/zK:TriggerAction`, JSON.stringify({event: "skip"}));
    })
    $('#accept').click(function () {
        $(".tutorial-popup").fadeOut(500)
        $.post(`https://zk-tutorial/zK:TriggerAction`, JSON.stringify({event: "start"}));
    })
    $('#back').click(function () {
        if (CurrentSlide !== 1) {
            if (isFinishButtonDisplayed == true) {
                $("#next").text("NEXT")
                isFinishButtonDisplayed = false;
            }
            CurrentSlide = CurrentSlide - 1;
            $.post(`https://zk-tutorial/zK:TriggerAction`, JSON.stringify({event: "back"}));
        }
    })
    $('#next').click(function () {
        if (isFinishButtonDisplayed == true && CurrentSlide == MaxSlide) {
            $(".tutorial-container").fadeOut(500)
            CurrentSlide = 1;
            MaxSlide = 0;
            isTutorialDisplayed = false;
            isFinishButtonDisplayed = false; 
            $.post(`https://zk-tutorial/zK:TriggerAction`, JSON.stringify({event: "finish"}));
            $("#next").text("NEXT")
        } else {
            if (CurrentSlide !== MaxSlide && CurrentSlide < MaxSlide) {
                CurrentSlide = CurrentSlide + 1;
                $.post(`https://zk-tutorial/zK:TriggerAction`, JSON.stringify({event: "next"}));
                if (CurrentSlide == MaxSlide && isFinishButtonDisplayed == false) {
                    $("#next").text("FINISH")
                    isFinishButtonDisplayed = true;
                }
            }
        }
    })
});



