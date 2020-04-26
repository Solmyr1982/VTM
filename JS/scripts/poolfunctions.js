// in case of manual selection of the batch:
// validateSelectedBatch -> preparePool() -> if response == '' -> (poolMovieEntity,showAllCards)

// in case if press Vote:
// Vote -> (voteForMovie,Vote) -> preparePool(response) -> if response != '' -> (batchPoolEntity,revalidateBatch) -> validateSelectedBatch()

function validateSelectedBatch() {
    try {
        $('#textInfo').html('');
        if (!currentState.currentBatch) {
            return;
        }

        if (!currentState.usrLogin) {
            currentState.changeState('history');
            sendAPIRequest('batchHistoryEntity?$filter=BatchName eq \'' + currentState.currentBatch + '\'&$orderby=FinishedAt', 'showHistory');
        }
        else {
            currentState.currentBatchAndPool = currentState.batchesAndPools.value.filter(item => item.Name === currentState.currentBatch);
            if (currentState.currentBatchAndPool[0].PoolNumber != 0) {
                if (currentState.currentBatchAndPool[0].WinnerMovieNumber != 0) {
                    currentState.changeState('batchNoPool');
                    sendAPIRequest('movieEntity?$filter=MovieNumber eq ' + currentState.currentBatchAndPool[0].WinnerMovieNumber, 'showAllCards');
                    $('#textInfo').html(currentState.noActivePoolMessage);

                }
                else {
                    if (currentState.currentBatchAndPool[0].Movie1 != 0) {
                        currentState.changeState('batchNoPool');
                        sendAPIRequest('movieEntity?$filter=MovieNumber eq ' + currentState.currentBatchAndPool[0].Movie1 +
                            'or MovieNumber eq ' + currentState.currentBatchAndPool[0].Movie2 +
                            'or MovieNumber eq ' + currentState.currentBatchAndPool[0].Movie3 +
                            'or MovieNumber eq ' + currentState.currentBatchAndPool[0].Movie4 +
                            'or MovieNumber eq ' + currentState.currentBatchAndPool[0].Movie5, 'showAllCards');
                        $('#textInfo').html(currentState.alreadyVotedMessage);
                    }
                    else {
                        currentState.changeState('game');
                        var infoMessage = currentState.currentPoolMessage.replace("%1", currentState.currentBatchAndPool[0].PoolNumber).replace('%2', currentState.currentBatchAndPool[0].InitiatedByUserID).replace('%3', currentState.currentBatchAndPool[0].CurrentRound);
                        $('#textInfo').html(infoMessage);
                        preparePool();
                    }
                }
            }
            else {
                currentState.changeState('batchNoPool');
                $('#textInfo').html(currentState.noActivePoolMessage);
            }
        }
    }
    catch (err) {
        showErrorMessage('validateSelectedBatch', err.message);
    }
}

function startPoolClick() {
    try {
        if (currentState.state != 'batchNoPool') {
            showErrorMessage('Error', 'Current state is not applicable for starting new pool.');
            return;
        }
        var body = { batchName: currentState.currentBatch }
        sendAPIRequest('RequestProcessor(00000000-0000-0000-0000-000000000000)/Microsoft.NAV.startNewPool', 'startNewPool', body);
    }
    catch (err) {
        showErrorMessage('startPoolClick', err.message);
    }
}

function preparePool(replyJson) {
    try {
        if (replyJson) {
            // var reply = JSON.parse(replyJson);
            // value currently is not used, only to check if empty or not
            sendAPIRequest('batchPoolEntity?$filter=UserID eq \'' + currentState.usrLogin + '\'', 'revalidateBatch');
        }
        else {
            currentState.currentPage = 1;
            sendAPIRequest('poolMovieEntity?$filter=PoolHeaderNumber eq ' + currentState.currentBatchAndPool[0].PoolNumber, 'showAllCards');
        }
    }
    catch (err) {
        showErrorMessage('preparePool', err.message);
    }
}

function vote() {
    try {
        if (currentState.state != 'game') {
            showErrorMessage('Error', 'There is nothing to vote for.');
            return;
        }

        switch (currentState.currentBatchAndPool[0].CurrentRound) {
            case 1:
                {
                    if (currentState.selectedCards.length != 5) {
                        showErrorMessage('Error', 'Please select five cards.');
                        return;
                    }
                    var body = {
                        poolNumber: currentState.currentBatchAndPool[0].PoolNumber,
                        movie1: currentState.selectedCards[0],
                        movie2: currentState.selectedCards[1],
                        movie3: currentState.selectedCards[2],
                        movie4: currentState.selectedCards[3],
                        movie5: currentState.selectedCards[4]
                    };
                    sendAPIRequest('RequestProcessor(00000000-0000-0000-0000-000000000000)/Microsoft.NAV.voteForMovie', 'vote', body);
                    break;
                }
            case 2:
                {
                    if (currentState.selectedCards.length != 2) {
                        showErrorMessage('Error', 'Please select two cards.');
                        return;
                    }
                    var body = {
                        poolNumber: currentState.currentBatchAndPool[0].PoolNumber,
                        movie1: currentState.selectedCards[0],
                        movie2: currentState.selectedCards[1],
                        movie3: 0,
                        movie4: 0,
                        movie5: 0
                    };
                    sendAPIRequest('RequestProcessor(00000000-0000-0000-0000-000000000000)/Microsoft.NAV.voteForMovie', 'vote', body);
                    break;
                }
            case 3:
                {
                    if (currentState.selectedCards.length != 1) {
                        showErrorMessage('Error', 'Please select one card.');
                        return;
                    }
                    var body = {
                        poolNumber: currentState.currentBatchAndPool[0].PoolNumber,
                        movie1: currentState.selectedCards[0],
                        movie2: 0,
                        movie3: 0,
                        movie4: 0,
                        movie5: 0
                    };
                    sendAPIRequest('RequestProcessor(00000000-0000-0000-0000-000000000000)/Microsoft.NAV.voteForMovie', 'vote', body);
                    break;
                }
        }
    }
    catch (err) {
        showErrorMessage('vote', err.message);
    }
}