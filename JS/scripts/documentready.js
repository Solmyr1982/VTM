$(document).ready(function () {
    try {
        currentState = new State();
        getAvailableBatches();
        currentState.state = 'none';
        $("#errorMessagePlaceHolder").load("elements/errormessage.html");
        $("#loginFormPlaceholder").load("elements/loginform.html");

        $("#mainMenuPlaceHolder").load("elements/mainmenu.html", function () {
            if (navigator.userAgent.indexOf('AppleWebKit') == -1) {
                $('#selectorControl').css("-webkit-appearance", "none");
                $('#selectorControl').css("appearance", "none");
            }
            // $("p").css("background-color", "yellow"); ???

            $('#voteButton').hide();
            $("#userNamePart").load("elements/username.html", function () {
                getUserPassFromCookies();
                $.get("elements/cardpart.html", function (result) {
                    currentState.blankCard = result;
                    showHideAdminButtons();
                    showAllClick();
                });
            });
        });
    }
    catch (err) {
        showErrorMessage('documentready', err.message);
    }
});

