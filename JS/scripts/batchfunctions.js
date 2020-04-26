function getAvailableBatches() {
    if (!currentState.usrLogin) {
        sendAPIRequest('batchPoolEntity?$filter=UserID eq \'' + appConfig.anonUserName + '\'', 'showAllBatches');
    }
    else {
        sendAPIRequest('batchPoolEntity?$filter=UserID eq \'' + currentState.usrLogin + '\'', 'showAllBatches');
    }
}

function showAllBatches(batchesJSON) {
    try {
        showHideAdminButtons();
        currentState.batchesAndPools = JSON.parse(batchesJSON);
        var totalBatches = currentState.batchesAndPools.value.length;
        $('#selectorControl').html('<option selected disabled hidden>Batch</option>');
        for (i = 0; i < totalBatches; i++) {
            $('#selectorControl').html($('#selectorControl').html() + '<option value="' +
                currentState.batchesAndPools.value[i].Name + '">' + currentState.batchesAndPools.value[i].Name + '</option>');
        }
    }
    catch (err) {
        showErrorMessage('showAllBatches', err.message);
    }
}

function mouseLeaveSelector() {
    if (navigator.userAgent.indexOf('AppleWebKit') != -1) {
        $('#selectorControl').blur(); //doesn't work properly in FF :(    
    }
}