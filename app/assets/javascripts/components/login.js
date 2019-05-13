function registerSubmitLoginForm() {
  document.querySelectorAll('[data-form=\'login\']').forEach(function(form) {
    form.addEventListener('submit', function(event) {
      event.preventDefault();
      submitLoginForm(form);
    });
  });
}

function submitLoginForm(form) {
  Rails.ajax({
    url: form.getAttribute('action'),
    type: form.getAttribute('method'),
    data: serialize(form),
    success: function(data) {
      localStorage.setItem('token', data.token);
      redirectTo = document.querySelector('meta[name=\'new-game-path\']').getAttribute('content');
      window.location.href = redirectTo;
    },
    error: function(data) {
      w3_errors(data.errors);
    }
  });
}

ready(registerSubmitLoginForm());