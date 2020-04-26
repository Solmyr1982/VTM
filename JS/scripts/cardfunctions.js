function showAllCards(cardsJson) {
  try {
    var displayParameters = { maxColumns: 0, maxRows: 0 };
    currentState.prepareDisplay(displayParameters);
    var cards = JSON.parse(cardsJson);

    var currentRound;
    var currentPool;
    if (currentState.currentBatchAndPool != null) {
      currentRound = currentState.currentBatchAndPool[0].CurrentRound;
      currentPool = currentState.currentBatchAndPool[0].PoolNumber;
    }

    switch (true) {
      case (currentState.state == 'history'):
        {
          break;
        }
      case ((currentRound == 1) & (currentState.state == 'game')) == true:
        {
          cards.value = shuffleArray(cards.value, currentPool);
          break;
        }
      default:
        {
          cards.value = sortJSON(cards.value, "MovieNumber");
          break;
        }
    }

    var maxCards = 0;
    if (cards.value.length > (displayParameters.maxColumns * displayParameters.maxRows)) {
      maxCards = (displayParameters.maxColumns * displayParameters.maxRows);
    }
    else {
      maxCards = cards.value.length;
    }
    cards.value.unshift('empty');

    for (i = 1; i <= maxCards; i++) {
      showSingleCard(cards.value[i]);
    }

    currentState.totalCardsQty = cards.value.length - 1;
    currentState.maxCardsOnScreen = maxCards;
    currentState.currentCardSet = cards;
    showNextPrevBar();
    highlightcurrentPage(0, 1);
  }
  catch (err) {
    showErrorMessage('showAllCards', err.message);
  }
}

function showSelectedAsync() {
  try {
    currentState.prepareDisplay(null);
    if (currentState.selectedMode == false) {
      for (var i = 0; i < currentState.selectedCards.length; i++) {
        var filteredCardSet = currentState.currentCardSet.value.filter(item => item.MovieNumber === parseInt(currentState.selectedCards[i], 10));
        showSingleCard(filteredCardSet[0]);
      }
      currentState.enableselectedMode();
      currentState.hideNextPrevBar();
    }
    else {
      currentState.disableSelectedMode();
      jumpToPage(currentState.currentPage);
    }
  }
  catch (err) {
    showErrorMessage('showSelectedAsync', err.message);
  }
  hideProgressBar();
}

function showRelations(event, sender) {
  try {
    event.stopPropagation();
    currentState.prepareDisplay(null);
    if (!currentState.relationMode) {
      currentState.hideNextPrevBar();
      var filteredCardSet = currentState.currentCardSet.value.filter(item => item.RelationNumber === parseInt(sender.id, 10));
      filteredCardSet = sortJSON(filteredCardSet, "Part");
      for (var i = 0; i < filteredCardSet.length; i++) {
        showSingleCard(filteredCardSet[i]);
      }
      currentState.relationMode = true;
    }
    else {
      currentState.relationMode = false;
      if (currentState.selectedMode) {
        disableSelectedMode();
        showSelectedClick();
      }
      else {
        jumpToPage(currentState.currentPage);
      }
    }
  }
  catch (err) {
    showErrorMessage('showRelations', err.message)
  }
}

function showSingleCard(cardArray) {
  try {
    var currCardHtml = currentState.blankCard;
    var newCardID = 'Card' + cardArray.MovieNumber;
    $('#gridControl').html($('#gridControl').html() + '<div class="gridItem" id="' + newCardID +
      '" onclick="javascript:gridItemOnClick(this);">' + currCardHtml + '</div>');

    $('#' + newCardID + ' .posterImage').attr('src', cardArray.Poster);
    $('#' + newCardID + ' #cardNo').attr('id', cardArray.MovieNumber);
    $('#' + newCardID + ' .movieNameLabel').attr('title', cardArray.NameENU + ' / ' + cardArray.NameRU);
    $('#' + newCardID + ' .movieNameLabel').html(cardArray.NameENU + ' / ' + cardArray.NameRU);
    if (!cardArray.Series) {
      $('#' + newCardID + ' #seriesImg').attr('style', 'display:inline-block;visibility:hidden');
    }
    if (cardArray.Part != 0) {
      $('#' + newCardID + ' #relation-number').attr('id', cardArray.RelationNumber);
      $('#' + newCardID + ' #partNumber').html(cardArray.Part);
    }
    else {
      $('#' + newCardID + ' .relationImage').attr('style', 'visibility:hidden');
    }
    $('#' + newCardID + ' #wikiLink').attr('href', cardArray.WIKI);
    $('#' + newCardID + ' #trailerLink').attr('href', cardArray.Trailer);

    if (currentState.selectedCards.indexOf('' + cardArray.MovieNumber + '') != -1) {
      $('#Card' + cardArray.MovieNumber).find('.cardWindow').css('border', "medium solid #75D975");
    }
    else {
      $('#Card' + cardArray.MovieNumber).find('.cardWindow').css('border', "medium solid transparent");
    }
    overrideRightClickMenu();
  }
  catch (err) {
    showErrorMessage('showSingleCard', err.message);
  }
}

function selectedCardAddedBycurrentUser(id) {
  try {
    if (currentState.currentBatchAndPool == null) {
      return;
    }
    if ((currentState.state == 'game') & (currentState.currentBatchAndPool[0].CurrentRound == 2)) {
      var selectedCard = currentState.currentCardSet.value.filter(item => item.MovieNumber === parseInt(id, 10));
      if (selectedCard[0].UserID == currentState.usrLogin) {
        return true;
      }
    }
  }
  catch (err) {
    showErrorMessage('selectedCardAddedBycurrentUser', err.message);
  }
}

function addselectedCardTocurrentState(sender, id) {
  try {
    if (currentState.selectedCards.indexOf('' + id + '') != -1) {
      $('#' + sender.id).find('.cardWindow').css('border', "medium solid transparent");
      currentState.selectedCards.remove(id);
    }
    else {
      $('#' + sender.id).find('.cardWindow').css('border', "medium solid #4CE878");
      currentState.selectedCards.push(id);
    }
  }
  catch (err) {
    showErrorMessage('addselectedCardTocurrentState', err.message);
  }
}

function highlightIfSelectedMoreThanAllowed() {
  try {
    if (currentState.state == 'game') {
      switch (currentState.currentBatchAndPool[0].CurrentRound) {
        case 1:
          {
            if (currentState.selectedCards.length > 5) {
              $('#selectedButton').html('Selected [<span style="color:red">' + currentState.selectedCards.length + '</span>]');
            }
            break;
          }
        case 2:
          {
            if (currentState.selectedCards.length > 2) {
              $('#selectedButton').html('Selected [<span style="color:red">' + currentState.selectedCards.length + '</span>]');
            }
            break;
          }
        case 3:
          {
            if (currentState.selectedCards.length > 1) {
              $('#selectedButton').html('Selected [<span style="color:red">' + currentState.selectedCards.length + '</span>]');
            }
            break;
          }
      }
    }
  }
  catch (err) {
    showErrorMessage('highlightIfSelectedMoreThanAllowed', err.message);
  }
}

function gridItemOnClick(sender) {
  try {
    var id = sender.id.substring(4);
    if (selectedCardAddedBycurrentUser(id)) {
      return;
    }
    addselectedCardTocurrentState(sender, id);
    $('#selectedButton').html('Selected [' + currentState.selectedCards.length + ']');
    highlightIfSelectedMoreThanAllowed();
  }
  catch (err) {
    showErrorMessage('gridItemOnClick', err.message);
  }
}

function overrideRightClickMenu() {
  try {
    if (!currentState.userIsAdmin) {
      return;
    }
    $(".movieNameDiv").bind('contextmenu', function (e) {
      var top = e.pageY + 5;
      var left = e.pageX;
      $("#context-menu").toggle(100).css({
        top: top + "px",
        left: left + "px"
      });
      return false;
    });

    $(document).bind('contextmenu click', function () {
      $("#context-menu").hide();
    });

    $('#context-menu').bind('contextmenu', function () {
      return false;
    });

    $('#context-menu li').click(function (event) {
      try {
        event.stopPropagation();
        $("#context-menu").hide();
        showCardDetailsClick(currentState.mouseOverNumber);
      }
      catch (err) {
        showErrorMessage('menuItemClick', err.message);
      }
    });
  }
  catch (err) {
    showErrorMessage('overrideRightClickMenu', err.message);
  }
}

function mouseOverName(sender) {
  currentState.mouseOverNumber = sender.id;
}