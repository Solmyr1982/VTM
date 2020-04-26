function showState() {
    try {
        currentState.prepareDisplay(null);
        currentState.hideList();
        $('#StateContainer').html('');
        $('body').append('<div class="listContainer" id="StateContainer"></div>');
        $('#StateContainer').append('<a class="listItem"</a> State: ' + currentState.state + '<br>');

        $('#StateContainer').append('<a class="listItem"</a> totalCardsQty: ' + currentState.totalCardsQty + '<br>');
        $('#StateContainer').append('<a class="listItem"</a> maxCardsOnScreen : ' + currentState.maxCardsOnScreen + '<br>');
        $('#StateContainer').append('<a class="listItem"</a> currentCardSet length : ' + currentState.currentCardSet.value.length + '<br>');
        $('#StateContainer').append('<a class="listItem"</a> currentPage : ' + currentState.currentPage + '<br>');
        $('#StateContainer').append('<a class="listItem"</a> pageToJump : ' + currentState.pageToJump + '<br>');
        $('#StateContainer').append('<a class="listItem"</a> selectedCards : ' + currentState.selectedCards + '<br>');
        $('#StateContainer').append('<a class="listItem"</a> mouseOverNumber : ' + currentState.mouseOverNumber + '<br>');        

        $('#StateContainer').append('<a class="listItem"</a> selectedMode : ' + currentState.selectedMode + '<br>');
        $('#StateContainer').append('<a class="listItem"</a> relationMode : ' + currentState.relationMode + '<br>');
        $('#StateContainer').append('<a class="listItem"</a> historyMode : ' + currentState.historyMode + '<br>');

        $('#StateContainer').append('<a class="listItem"</a> currentBatch : ' + currentState.currentBatch + '<br>');
        $('#StateContainer').append('<a class="listItem"</a> batchesAndPools length : ' + currentState.batchesAndPools.value.length + '<br>');
        $('#StateContainer').append('<a class="listItem"</a> batchMode : ' + currentState.batchMode + '<br>');
        $('#StateContainer').append('<a class="listItem"</a> currentBatchAndPool : ' + currentState.currentBatchAndPool + '<br>');

        $('#StateContainer').append('<a class="listItem"</a> userIsAdmin : ' + currentState.userIsAdmin + '<br>');        
        $('#StateContainer').append('<a class="listItem"</a> usrLogin : ' + currentState.usrLogin + '<br>');
        $('#StateContainer').append('<a class="listItem"</a> usrPassword : ' + currentState.usrPassword + '<br>');
        $('#StateContainer').append('<a class="listItem"</a> adminURL : ' + currentState.adminURL + '<br>');        
    }
    catch (err) {
        showErrorMessage('showState', err.message);
    }
}

