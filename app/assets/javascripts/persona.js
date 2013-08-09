$.getScript("https://login.persona.org/include.js");

function loginViaEmail() {
  navigator.id.get(function(assertion) {
    if (assertion) {
      $('input[name=assertion]').val(assertion);
      $('form').submit();
    } else {
      window.location = "#{failure_path}"
    }
  });  
}

$(function() {
  $('.persona-login').click(function() {
    loginViaEmail();
    return false;
  });
});