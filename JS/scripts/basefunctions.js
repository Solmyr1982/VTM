function showAllClick() {
  try {
    currentState.changeState('showAll');
    sendAPIRequest('movieEntity', 'showAllCards');
  }
  catch (err) {
    showErrorMessage('showAllClick', err.message);
  }
}

function showSelectedClick() {
  try {
    if ((currentState.selectedCards.length == 0) & (!currentState.selectedMode)) {
      return;
    }
    showProgressBar();
    setTimeout(showSelectedAsync(), 0);
  }
  catch (err) {
    showErrorMessage('showSelectedClick', err.message);
  }
}

function showStateClick() {
  try {
    showState();
  }
  catch (err) {
    showErrorMessage('showStateClick', err.message);
  }
}

function showListClick() {
  try {
    currentState.changeState('list');
    sendAPIRequest('movieEntity', 'showList');
  }
  catch (err) {
    showErrorMessage('showListClick', err.message);
  }
}

function showHistoryClick() {
  try {
    if (!currentState.currentBatch) {
      showErrorMessage('Error', 'Please select the batch first.');
      return;
    }
    currentState.changeState('history');
    sendAPIRequest('batchHistoryEntity?$filter=BatchName eq \'' + currentState.currentBatch + '\'&$orderby=FinishedAt', 'showHistory');
  }
  catch (err) {
    showErrorMessage('showHistoryClick', err.message);
  }
}

function selectBatchClick() {
  try {
    currentState.currentBatch = $('#selectorControl').val();
    validateSelectedBatch();
  }
  catch (err) {
    showErrorMessage('selectBatchClick', err.message);
  }
}

