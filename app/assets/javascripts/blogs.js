window.onload = function(){
  var editButton = document.getElementById('edit');
  var deleteBShow = document.getElementById('delete_button');
  var editBShow = document.getElementById('edit_button');

  editButton.addEventListener('click', function() {
    editButton.style.display = 'none';
    deleteBShow.style.display = 'block';
    editBShow.style.display = 'block';

  });
};
