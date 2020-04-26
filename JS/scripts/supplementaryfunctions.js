function showCardDetailsClick(cardID) {
    try {
        if (!currentState.userIsAdmin) {
            return;
        }
        if (cardID.includes("List")) {
            cardID = cardID.substring(4);
        }
        openNewWindow(currentState.adminURL + '?company=VTM&page=50386&filter=\'Number\' IS \'' + cardID + '\'');
    }
    catch (err) {
        showErrorMessage('showCardDetailsClick', err.message);
    }
}

function addMovieClick() {
    openNewWindow(currentState.adminURL + '?company=VTM&page=50386&mode=Create');
}

function openNewWindow(URL) {
    var win = window.open(URL, '_blank');
    if (win) {
        win.focus();
    } else {
        showErrorMessage('Error', 'Please allow popups for this website');
    }
}

function passwordKeyed(event) {
    if (event.keyCode === 13) {
        loginLogoff();
    }

    if (event.keyCode === 27) {
        loginCloseClick();
    }
}

function loginKeyed(event) {
    if (event.keyCode === 13) {
        $("#passwordInptControl").focus();
    }
    if (event.keyCode === 27) {
        loginCloseClick();
    }
}

function errorCloseKeyed(event) {
    if ((event.keyCode === 13) | (event.keyCode === 27)) {
        closeErrorClick();
    }
}

function showProgressBar() {
    $("#loadingPart").show();
}

function hideProgressBar() {
    $("#loadingPart").hide();
}

function showModalCover() {
    $("#modalCover").show();
}

function hideModalCover() {
    $("#modalCover").hide();
}

function showErrorMessage(title, description) {
    showModalCover();
    $('#errorMessageTitle').html(title);
    $('#errorrMessageDescription').html(description);
    $('#errorMessage').show();
    $("#errorMessageButton").attr("tabindex", -1).focus();
}

function closeErrorClick() {
    if ($('#loginForm').is(":visible")) {
        $('#passwordInptControl').focus();
    }
    else {
        hideModalCover();
    }


    $('#errorMessage').hide();
}

function bypassSelection(event) {
    event.stopPropagation();
}

function sortJSON(data, key) {
    try {
        return data.sort(function (a, b) {
            var x = a[key]; var y = b[key];
            return ((x < y) ? -1 : ((x > y) ? 1 : 0));
        });
    }
    catch (err) {
        showErrorMessage('sortJSON', err.message);
    }
}

function shuffleArray(array, seed) {
    var currentIndex = array.length, temporaryValue, randomIndex;
    while (0 !== currentIndex) {
        randomIndex = Math.floor(mulberry32(seed) * currentIndex);
        currentIndex -= 1;
        temporaryValue = array[currentIndex];
        array[currentIndex] = array[randomIndex];
        array[randomIndex] = temporaryValue;
    }
    return array;
}

function mulberry32(a) {
    var t = a += 0x6D2B79F5;
    t = Math.imul(t ^ t >>> 15, t | 1);
    t ^= t + Math.imul(t ^ t >>> 7, t | 61);
    var result = ((t ^ t >>> 14) >>> 0) / 4294967296;
    return random(result);
}

function random(seed) {
    var x = Math.sin(seed++) * 10000;
    return x - Math.floor(x);
}

Array.prototype.remove = function () {
    var what, a = arguments, L = a.length, ax;
    while (L && this.length) {
        what = a[--L];
        while ((ax = this.indexOf(what)) !== -1) {
            this.splice(ax, 1);
        }
    }
    return this;
};