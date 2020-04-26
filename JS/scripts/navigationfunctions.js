
function highlightcurrentPage(prevPageID, currentPageID) {
  try {
    var pageQty = Math.ceil(currentState.totalCardsQty / currentState.maxCardsOnScreen);
    if (pageQty == 1)
      return;

    if (prevPageID != 0) {
      if ($('#naviPage' + prevPageID) != null) {
        $('#naviPage' + prevPageID).css('color', '#2efffe');
      }
    }
    $('#naviPage' + currentPageID).css('color', '#fcff2f');
  }
  catch (err) {
    showErrorMessage('highlightcurrentPage', err.message);
  }
}

function firstPage() {
  jumpToPage(1);
}


function lastPage() {
  try {
    var pageQty = Math.ceil(currentState.totalCardsQty / currentState.maxCardsOnScreen);
    jumpToPage(pageQty);
  }
  catch (err) {
    showErrorMessage('lastPage', err.message);
  }
}

function nextFive() {
  try {
    var pageQty = Math.ceil(currentState.totalCardsQty / currentState.maxCardsOnScreen);
    var firstPageNo;
    if (currentState.currentPage % 5 == 0) {
      firstPageNo = ((currentState.currentPage / 5) * 5) - 4;
    }
    else {
      firstPageNo = (((Math.floor(currentState.currentPage / 5))) * 5) + 1;
    }
    if ((firstPageNo + 5) > pageQty)
      return;
    jumpToPage(firstPageNo + 5);
  }
  catch (err) {
    showErrorMessage('nextFive', err.message);
  }
}

function prevFive() {
  try {
    var firstPageNo;
    if (currentState.currentPage % 5 == 0) {
      firstPageNo = ((currentState.currentPage / 5) * 5) - 4;
    }
    else {
      firstPageNo = (((Math.floor(currentState.currentPage / 5))) * 5) + 1;
    }
    if ((firstPageNo - 5) <= 0)
      return;
    jumpToPage(firstPageNo - 1);
  }
  catch (err) {
    showErrorMessage('prevFive', err.message);
  }
}

function jumpToPage(pageNumber) {
  try {
    currentState.pageToJump = pageNumber;
    showProgressBar();
    setTimeout(jumpToPageAsync(), 0);
  }
  catch (err) {
    showErrorMessage('jumpToPage', err.message);
  }
}

function jumpToPageAsync() {
  try {
    var pageQty = Math.ceil(currentState.totalCardsQty / currentState.maxCardsOnScreen);
    if ((currentState.pageToJump > pageQty) | (currentState.pageToJump == 0)) {
      currentState.pageToJump = 0;
      return;
    }

    currentState.prepareDisplay(null);

    var showFrom = (currentState.maxCardsOnScreen * currentState.pageToJump) - currentState.maxCardsOnScreen + 1;
    var qtyToShow;
    if (currentState.pageToJump < pageQty) {
      qtyToShow = currentState.maxCardsOnScreen - 1;
    }
    else {
      if (currentState.totalCardsQty / currentState.maxCardsOnScreen == currentState.maxCardsOnScreen) {
        qtyToShow = currentState.maxCardsOnScreen - 1;
      }
      else {
        qtyToShow = (currentState.totalCardsQty - (currentState.maxCardsOnScreen * (pageQty - 1))) - 1;
      }
    }

    for (i = showFrom; i <= showFrom + qtyToShow; i++) {
      showSingleCard(currentState.currentCardSet.value[i]);
    }

    var prevPage = currentState.currentPage;
    currentState.currentPage = currentState.pageToJump;
    showNextPrevBar();
    highlightcurrentPage(prevPage, currentState.pageToJump);
    currentState.pageToJump = 0;
    hideProgressBar();
  }
  catch (err) {
    showErrorMessage('jumpToPageAsync', err.message);
  }
}

function showNextPrevBar() {
  try {
    currentState.hideNextPrevBar();
    var pageQty = Math.ceil(currentState.totalCardsQty / currentState.maxCardsOnScreen);
    if (pageQty <= 1)
      return;

    maxPageQty = pageQty;
    if (maxPageQty > 5)
      maxPageQty = 5;

    var firstPageNo;
    if (currentState.currentPage % 5 == 0) {
      firstPageNo = ((currentState.currentPage / 5) * 5) - 4;
    }
    else {
      firstPageNo = (((Math.floor(currentState.currentPage / 5))) * 5) + 1;
    }

    if (pageQty - (firstPageNo - 1) < 5)
      maxPageQty = pageQty - (firstPageNo - 1);

    var nextPrevBarText = '<div id="nextPrevControl">';

    if ((pageQty > 5) & (currentState.currentPage > 5))
      nextPrevBarText += `
    <a class="smallButton" title="First" onclick="firstPage();"><<</a>
    <a class="smallButton" title="Previous five" onclick="prevFive();"><</a>
    `;

    for (i = firstPageNo; i < maxPageQty + firstPageNo; i++) {
      nextPrevBarText += '<a class="smallButton" id="naviPage' + i + '" onclick="jumpToPage(' + i + ');">' + i + '</a>';
      
    }

    if ((pageQty > 5) & ((firstPageNo + maxPageQty - 1) != pageQty))
      nextPrevBarText += `
    <a class="smallButton" title="Next five" onclick="nextFive();">></a>
    <a class="smallButton" title="Last" onclick="lastPage();">>></a>                    
    `;

    nextPrevBarText += '</div>';

    $('#nextPrevBar').html(nextPrevBarText);

    if (currentState.currentBatch.toString() != '') {
      $('#selectorControl').val(currentState.currentBatch.toString());
    }

  }
  catch (err) {
    showErrorMessage('showNextPrevBar', err.message);
  }
}
