function startSearch(){
  console.log('function works');
  $('#assocSearch').keyup(function(){
    var input = this.value.toUpperCase();
    var associationsContainer = document.getElementById("associations");
    var associations = associationsContainer.getElementsByClassName("card");
    for(var i = 0; i < associations.length; i++) {
       var cardBody = associations[i].getElementsByClassName('card-body')[0];
       var txtValue = cardBody.getElementsByClassName('card-title')[0].innerText;
       if(txtValue.toUpperCase().indexOf(input) > -1) {
         associations[i].style.display = "";
       } else {
         associations[i].style.display = "none";
       }
    }
  });
}
