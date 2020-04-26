function showList(cardsJson) {
    try {
        var cards = JSON.parse(cardsJson);
        currentState.currentCardSet = cards;
        cards.value = sortJSON(cards.value, "NameENU");
        cards.value.unshift('empty');
        $('body').append('<div class="listContainer" id="listContainer"></div>');
        for (i = 1; i < cards.value.length; i++) {
            $('#listContainer').append('<a class="listItem" id="List' + cards.value[i].MovieNumber +
                '" onclick="showCardDetailsClick(this.id)">' + cards.value[i].NameENU + ' / ' +
                cards.value[i].NameRU + '</a><br>');
        }
        $('#selectorControl').val('Batch');
    }
    catch (err) {
        showErrorMessage('showList', err.message);
    }
}

