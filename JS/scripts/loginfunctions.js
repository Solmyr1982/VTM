function loginCloseClick(){
  hideModalCover();
  $('#loginForm').hide();
}

function showloginForm() {
  if (currentState.usrLogin) {
    loginLogoff();
    return;
  }
  showModalCover();
  $('#loginInput').val('');
  $('#passwordInptControl').val('');
  $('#loginForm').show();
  $("#loginInput").focus();
}

function loginClick(){
  loginLogoff();
}

function loginLogoff() {
  try {
    if (currentState.usrLogin) {
      $('#loginLogoff').html('login');
      currentState.usrLogin = '';
      currentState.usrPassword = '';
      $('.welcomePart').hide();
      setCookie("usrLogin", '', 30);
      setCookie("usrPassword", '', 30);
      clearAllValues();
      currentState.userIsAdmin = false;
      $('#voteButton').hide();
      $('#userNamePart').hide();
      return;
    }

    if (($('#loginInput').val() != '') & ($('#passwordInptControl').val() != '')) {
      $('#loginInput').val($('#loginInput').val().toUpperCase());
      login($('#loginInput').val(), $('#passwordInptControl').val());
    }
  }
  catch (err) {
    showErrorMessage('loginLogoff', err.message);
  }
}

function clearAllValues() {
  currentState.disableAllModes();
  currentState.resetValues();
  currentState.prepareDisplay(null);
  currentState.hideNextPrevBar();
  getAvailableBatches();
  showHideAdminButtons();
  currentState.state = 'none';
}

function showHideAdminButtons() {
  if (currentState.userIsAdmin) {
    $('#startPoolButton').show();
    $('#addMovieButton').show();
    $('#listButton').show();
    $('#currentStateButton').show();
  }
  else {
    $('#startPoolButton').hide();
    $('#addMovieButton').hide();
    $('#listButton').hide();
    $('#currentStateButton').hide();
  }
}

function login(_usrLogin, _usrPassword) {
  try {
    currentState.usrLogin = _usrLogin;
    currentState.usrPassword = _usrPassword;
    sendAPIRequest('userEntity?$filter=UserID eq \'' + currentState.usrLogin + '\'', 'login');
  }
  catch (err) {
    showErrorMessage('login', err.message);
  }
}

function finalyzeLogin(userDetailsJSON) {
  try {
    setCookie("usrLogin", currentState.usrLogin, 30);
    setCookie("usrPassword", currentState.usrPassword, 30);
    $('#voteButton').show();
    clearAllValues();

    var userDetails = JSON.parse(userDetailsJSON);
    currentState.userIsAdmin = userDetails.value[0].Administrator;
    currentState.adminURL = userDetails.value[0].adminURL;
    $('#loginLogoff').html('Logoff');
    $('#loginInput').val('');
    $('#passwordInptControl').val('');
    $('.welcomePart').show();
    $('#usernameText').html(currentState.usrLogin);
    showHideAdminButtons();
    $('#voteButton').show();
    loginCloseClick();
    $('#userNamePart').show();
  }
  catch (err) {
    showErrorMessage('finalyzeLogin', err.message);
  }
}

function getUserPassFromCookies() {
  try {
    var user = getCookie("usrLogin");
    var password = getCookie("usrPassword");
    if ((user) && (password)) {
      login(user, password);
    }
  }
  catch (err) {
    showErrorMessage('getUserPassFromCookies', err.message);
  }
}

function setCookie(cname, cvalue, exdays) {
  try {
    var d = new Date();
    d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
    var expires = "expires=" + d.toGMTString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
  }
  catch (err) {
    showErrorMessage('setCookie', err.message);
  }
}

function getCookie(cname) {
  try {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for (var i = 0; i < ca.length; i++) {
      var c = ca[i];
      while (c.charAt(0) == ' ') {
        c = c.substring(1);
      }
      if (c.indexOf(name) == 0) {
        return c.substring(name.length, c.length);
      }
    }
    return "";
  }
  catch (err) {
    showErrorMessage('getCookie', err.message);
  }
}