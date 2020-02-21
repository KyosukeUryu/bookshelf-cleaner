document.addEventListener('turbolinks:load', function() {
  var box = document.getElementById('chat-box')
  box.scrollTop =  box.scrollHeight;
  var messages = document.getElementById('message-box')
  messages.scrollTop =  messages.scrollHeight;
});
