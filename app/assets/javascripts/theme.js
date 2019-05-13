// Toggle between showing and hiding the sidebar when clicking the menu icon
var mySidebar = document.getElementById('mySidebar');

function w3_open() {
  if (mySidebar.style.display === 'block') {
    mySidebar.style.display = 'none';
  } else {
    mySidebar.style.display = 'block';
  }
}

// Close the sidebar with the close button
function w3_close() {
  mySidebar.style.display = 'none';
}

// Adds errors to the errors container
function w3_errors(errors) {
  var errorsContainer = document.querySelector('[data-container=\'errors\']');
  errorsContainer.classList.remove('w3-hide');

  Array.prototype.forEach.call(errors, function(error, i) {
    var p = document.createElement('p');
    p.innerHTML = error;
    errorsContainer.appendChild(p);
  });
};