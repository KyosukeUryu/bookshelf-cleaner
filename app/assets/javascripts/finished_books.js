document.addEventListener('turbolinks:load', function() {
  let date = document.getElementById('disposal_disabled');
  let status = document.getElementById('finish_status');

  status.addEventListener('change', function(){
    if (this.value === 'disposal_soon') {
      date.disabled = false;
    } else {
      date.disabled = true;
    }
  })
})
