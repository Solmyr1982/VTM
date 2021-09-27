function sendAPIRequest(requestName, action, body, cardNumber) {
  try {
    var xhttp = new XMLHttpRequest();
    if (action != 'getRatingIMDB') {
      xhttp.withCredentials = true;
    }
    var currentUser = currentState.usrLogin;
    var currentPassword = currentState.usrPassword;

    if (!currentUser) {
      currentUser = appConfig.anonUserName;
      currentPassword = appConfig.anonUserPass;
    }

    if (!body) {
      if (action == 'getRatingIMDB') {
        //xhttp.open("GET", 'http://www.omdbapi.com/?apikey=da791ea3&t=' + requestName, true);
        xhttp.open("GET", 'http://www.omdbapi.com/?apikey=da791ea3&i=' + requestName, true);
        
      }
      else {
        xhttp.open("GET", appConfig.APIURL + requestName, true);
        xhttp.setRequestHeader("Authorization", "Basic " + btoa(currentUser + ":" + currentPassword));
      }
      xhttp.send();
    }
    else {
      xhttp.open("POST", appConfig.APIURL + requestName, true);
      xhttp.setRequestHeader("Content-Type", "application/json");
      xhttp.setRequestHeader("Authorization", "Basic " + btoa(currentUser + ":" + currentPassword));
      xhttp.send(JSON.stringify(body));
    }

    xhttp.onreadystatechange = function () {
      if (xhttp.readyState === XMLHttpRequest.DONE) {
        if ((xhttp.status === 200) | (xhttp.status === 204)) {
          switch (action) {
            case 'showAllCards': case 'showHistory':
              {
                showAllCards(xhttp.responseText);
                break;
              }
            case 'showList':
              {
                showList(xhttp.responseText);
                break;
              }
            case 'showAllBatches':
              {
                showAllBatches(xhttp.responseText);
                break;
              }
            case 'login':
              {
                finalyzeLogin(xhttp.responseText);
                break;
              }
            case 'vote':
              {
                currentState.changeState('game');
                preparePool(xhttp.responseText);
                break;
              }
            case 'revalidateBatch':
              {
                currentState.batchesAndPools = JSON.parse(xhttp.responseText);
                validateSelectedBatch();
                break;
              }
            case 'startNewPool':
              {
                currentState.changeState('game');
                preparePool('newBatch');
                break;
              }
            case 'getRatingIMDB':
              {
                var reply = JSON.parse(xhttp.responseText);
                $('#' + cardNumber + 'trailerLink').html(reply.imdbRating);
                $('#' + cardNumber + 'trailerLink').attr('href', 'https://www.imdb.com/title/' + reply.imdbID + '/');
                break;
              }
            default:
              {
                showErrorMessage('Error', 'Uknown case (sendAPIRequest):' + action)
              }
          }
        }
        else {
          if (action == 'login') {
            showErrorMessage('Error', xhttp.status + ': Login failed: ' + xhttp.statusText);
            currentState.usrLogin = '';
            currentState.usrPassword = '';
          }
          else {
            if (action != 'getRatingIMDB') {
              showErrorMessage('Error', xhttp.status + ': ' + xhttp.statusText + '; Request: ' + requestName);
            }
          }
        }
        hideProgressBar();
      }
    };
    showProgressBar();
  }
  catch (err) {
    showErrorMessage('sendAPIRequest', err.message);
  }
}