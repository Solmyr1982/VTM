class State {
    totalCardsQty; // overal quantity of the currentCardSet
    maxCardsOnScreen; // max. quantity of cards possible to show on current screen
    currentCardSet; // parsed JSON containing all cards
    currentPage; // currently choosen page
    pageToJump; // next page
    selectedCards = []; // selected cards
    selectedMode; // show all or selected
    relationMode; // show all or relation
    usrLogin; // user login
    usrPassword; // user password
    currentBatch; // tells for itself
    historyMode; // if we are currently looking at the history
    batchesAndPools; //list of available bathes with latest pool details
    batchMode; //batch is selected
    userIsAdmin;
    currentBatchAndPool; //currently selected batch and pool details
    mouseOverNumber; // keeps Card ID when mouse is on, to be able to show the menu
    blankCard; // keeps the blank card template
    // AllBatches; // info of all existing batches (needed for editing/adding card)
    // AllMovieBatches;  // info of all existing movie batches (needed for editing/adding card)
    // AllRelations; // info of all existing relations (needed for editing/adding card)
    adminURL; // BC URL
    noActivePoolMessage = 'There is no active pool for this batch. You can see the winner of the last pool below.';
    currentPoolMessage = 'Pool No.: %1; Started by: %2; Round: %3';
    alreadyVotedMessage = 'You already voted in this pool. You can see your selection below.';
    state; //none,showAll,list,history,batchNoPool,game
    currentUnparsedCardSet; // unparsed JSON 
    filterString; // current filter
    filterMode; // are we filtering or not

    changeState(newState) {
        try {
            switch (newState) {
                case 'showAll':
                    {
                        this.disableAllModes();
                        this.resetValues();
                        this.hideList();
                        this.disableSelectedModeAndClearSelection();
                        break;
                    }
                case 'list':
                    {
                        this.disableAllModes();
                        this.resetValues();
                        this.hideNextPrevBar();
                        this.prepareDisplay(null);
                        this.disableSelectedModeAndClearSelection();
                        break;
                    }
                case 'history':
                    {
                        this.enableHistoryMode();
                        this.resetValues();
                        this.disableSelectedModeAndClearSelection();
                        this.disablerelationMode();
                        this.hideList();
                        break;
                    }
                case 'batchNoPool':
                    {
                        this.disableAllModes();
                        this.hideList();
                        this.disableSelectedModeAndClearSelection();
                        this.enableBatchMode();
                        break;
                    }
                case 'game':
                    {
                        this.disableAllModes();
                        this.hideList();
                        this.disableSelectedModeAndClearSelection();
                        this.enableBatchMode();
                        break;
                    }
                default:
                    {
                        showErrorMessage("Error", "Unknown state.");
                    }
            }
            this.state = newState;
        }
        catch (err) {
            showErrorMessage('changeState', err.message);
        }
    }

    disableAllModes() {
        try {
            this.disableHistoryMode();
            this.disableSelectedMode();
            this.disableBatchMode();
            this.disablerelationMode();
        }
        catch (err) {
            showErrorMessage('disableAllModes', err.message);
        }
    }

    resetValues() {
        try {
            this.totalCardsQty = 0;
            this.maxCardsOnScreen = 0;
            this.currentCardSet = null;

            this.currentPage = 1;
            this.selectedCards = [];
            $('#selectedButton').html('Selected [' + this.selectedCards.length + ']');
            $('#selectedButton').css('color', '');
            $('#selectorControl').val('Batch');
            $('#textInfo').html('');

            this.selectedMode = false;
            this.relationMode = false;

            if ((!this.historyMode) & (!this.batchMode)) {
                currentState.currentBatch = '';
            }
        }
        catch (err) {
            showErrorMessage('resetValues', err.message);
        }
    }

    enablerelationMode() {
        this.relationMode = true;
    }

    disablerelationMode() {
        this.relationMode = false;
    }

    enableBatchMode() {
        this.batchMode = true;
        $('#selectorControl').css('color', 'fcff2f');
    }

    disableBatchMode() {
        this.batchMode = false;
        $('#selectorControl').css('color', '');
    }

    enableselectedMode() {
        this.selectedMode = true;
        $('#selectedButton').css('color', 'fcff2f');
    }

    disableSelectedMode() {
        this.selectedMode = false;
        $('#selectedButton').css('color', '');
    }

    disableSelectedModeAndClearSelection() {
        this.selectedMode = false;
        $('#selectedButton').css('color', '');
        this.selectedCards = [];
        $('#selectedButton').html('Selected [0]');
    }

    disableHistoryMode() {
        this.historyMode = false;
        $('#historyButton').css('color', '');
    }

    enableHistoryMode() {
        this.historyMode = true;
        $('#historyButton').css('color', 'fcff2f');
    }

    hideList() {
        if ($('#listContainer') != null) {
            $('#listContainer').remove();
        }
    }

    hideNextPrevBar() {
        if ($('#nextPrevControl') != null) {
            $('#nextPrevControl').remove();
        }
    }

    prepareDisplay(displayParameters) {
        try {
            $('#gridControl').html('');
            var maxColumns = Math.round(window.innerWidth / 220) - 1;
            var maxRows = Math.round(window.innerHeight / 320);
            document.documentElement.style.setProperty(`--rowNum`, maxRows);
            document.documentElement.style.setProperty(`--colNum`, maxColumns);
            if (displayParameters != null) {
                displayParameters.maxColumns = maxColumns;
                displayParameters.maxRows = maxRows;
            }
        }
        catch (err) {
            showErrorMessage('prepareDisplay', err.message);
        }
    }

    turnOffFilter() {
        try {
            this.filterString = '';
            this.filterMode = false;
            $('#filterInput').val('');
        }
        catch (err) {
            showErrorMessage('turnOffFilter', err.message);
        }
    }
}


