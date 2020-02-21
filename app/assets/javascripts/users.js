document.addEventListener('turbolinks:load', function() {
  document.getElementById('user-file').addEventListener('change', function(e) {
    var file = document.getElementById('user-file').files[0];
    var div_image = document.getElementById('image')
    var img = document.createElement('img')
    var reader = new FileReader();
    reader.addEventListener('load', function(e) {
      img.src = reader.result;
      img.width = 80;
      img.height = 80;
    });
    div_image.appendChild(img);
    reader.readAsDataURL(file);
  });
});
