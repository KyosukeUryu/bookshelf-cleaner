document.addEventListener('turbolinks:load', function() {
  var date = document.getElementById('disposal_disabled');
  var status = document.getElementById('finish_status');

  status.addEventListener('change', function(){
    if (this.value === 'disposal_soon') {
      date.disabled = false;
    } else {
      date.disabled = true;
    }
  })
})
