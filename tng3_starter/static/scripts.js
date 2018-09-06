$(document).ready(function(){
    $("#add_button").click(function(){
  
      $.post("/users",
        {
          'name': $('#name').val(),
          'age' : $('#age').val(),
          'mail_id' : $('#mail_id').val()
        },
        function(data,status){
            $("#div1").text("User added");
        });
    });
    
    $("#list_button").click(function(){
      $.get("/users",
        {},
        function(data,status){
            var result = "";
            var users = data['users'];
            for ( i in users) {
                result = result + users[i] + "<br>";
            }
            $("#div1").html(result);
        });
    });
});

