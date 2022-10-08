<!DOCTYPE html>
<%@page import="java.util.HashMap"%>
<%@page import="com.incapp.dao.DAO"%>
<html>
<head>
  <title>MediSol</title>
  <link rel="icon" href="resources/medisol.png" />

  <meta name="viewport" content="width=device-width, initial-scale=1">

  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js" integrity="sha512-aVKKRRi/Q/YV+4mjoKBsE4x3H+BkegoM/em46NNlCqNTmUYADjBbeNefNxYV7giUp0VxICtqdrbqU7iVaeZNXA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.2/js/bootstrap.min.js" integrity="sha512-7rusk8kGPFynZWu26OKbTeI+QPoYchtxsmPeBqkHIEXJxeun4yJ4ISYe7C6sz9wdxeE1Gk3VxsIWgCZTc+vX3g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.2/css/bootstrap.min.css" integrity="sha512-rt/SrQ4UNIaGfDyEXZtNcyWvQeOq0QLygHluFQcSjaGB04IxWhal71tKuzP6K8eYXYB6vJV4pHkXcmFGGQ1/0w==" crossorigin="anonymous" referrerpolicy="no-referrer" />

  <!-- font awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/js/all.min.js" integrity="sha512-naukR7I+Nk6gp7p5TMA4ycgfxaZBJ7MO5iC3Fp6ySQyKFHOGfpkSZkYVWV5R7u7cfAicxanwYQ5D1e17EfJcMA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  
  <!-- Lightbox CSS & Script -->
  <script src="resources/lightbox/ekko-lightbox.js"></script>
  <link rel="stylesheet" href="resources/lightbox/ekko-lightbox.css"/>
  <!-- Lightbox END -->

  <!-- AOS CSS & Script -->
  <script src="resources/aos/aos.js"></script>
  <link rel="stylesheet" href="resources/aos/aos.css"/>
  <!-- AOS END -->

  <!-- custom css -->
  <link rel="stylesheet" href="resources/custom.css">

</head>
<body>
  <p class="text-center bg-light p-2">For any emergency contact <a href="tel:9811XXXXXX">9811XXXXXX</a> or email at <a href="mailto:info@plusdemic.com">info@medisol.com</a> </p>
  <%
		String uemail=(String)session.getAttribute("uemail");
		if(uemail==null){
	%>
			<nav class="navbar navbar-expand-sm container">
		      <a class="navbar-brand" href="index.jsp">
		        <img src="resources/medisol.png" alt=""/> <span>Medi</span>Sol
		      </a>
		      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#my-navbar"><i class="fa-solid fa-bars"></i></button>
		      <div class="collapse navbar-collapse" id="my-navbar">
		          <ul class="navbar-nav  mx-auto">
		            <li>
		              <a class="nav-link" href="index.jsp">Home</a>
		            </li>
		            <li>
		              <a class="nav-link" href="UserLogin.jsp">User Sign-In/Sign-Up</a>
		            </li>
		          </ul>
		          <button class="btn btn-light" data-toggle="modal" data-target="#myModal">Admin Login</button>
		      </div>
		  	</nav>
	<%		
		}else{
			DAO db=new DAO();
			HashMap user=db.getUserByEmail(uemail);
			int cartQty=db.getCartQty(uemail);
			db.closeDBConnection();
	%>
		<nav class="navbar navbar-expand-sm container">
		      <a class="navbar-brand" href="UserHome.jsp">
		        <img src="resources/medisol.png" alt=""/> <span>Medi</span>Sol
		      </a>
		      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#my-navbar"><i class="fa-solid fa-bars"></i></button>
		      <div class="collapse navbar-collapse" id="my-navbar">
		          <ul class="navbar-nav  mx-auto">
		            <li>
		              <a class="nav-link" href="UserHome.jsp">Home</a>
		            </li>
		            <li>
		              <a class="nav-link" href="UserOrders.jsp">Orders</a>
		            </li>
		          </ul>
		          <p>
		          Welcome: <b><%=user.get("name")%></b>  
          		  <a class="btn btn-sm btn-warning m-2" href="Cart.jsp">Cart[<%=cartQty %>]</a>
		          <a class="btn btn-sm btn-danger m-2" href="Logout">Logout</a>
		          </p>
		          
		      </div>
		  </nav>
	<%		
		}
	%>
  <header class="container mt-4">
      <h3 class="jumbotron bg-warning text-dark text-center">Something went wrong. Please try after some time.</h3>
  </header>
  
  <footer class="container m-5">
    <div class="row">
      <div class="col-sm m-2 text-left">
        <img src="resources/medisol.png" height="20px" alt=""/> <span class="text-danger"><b>Medi</b></span>Sol
        <p>
          Lorem ipsum dolor sit amet consectetur.
          <br>
          Lorem ipsum dolor sit amet consectetur adipisicing elit.
        </p>
      </div>
      <div class="col-sm m-2 text-right">
        <p>
          <a class="m-2" href="http://www.facebook.com/incapp" target="_blank"><i class="fa-brands fa-facebook-f fa-2x"></i></a>
          <a class="m-2" href="http://www.instagram.com/incapp.in" target="_blank"><i class="fa-brands fa-instagram fa-2x"></i></a>
          <a class="m-2" href="http://www.youtube.com/incapp" target="_blank"><i class="fa-brands fa-youtube fa-2x"></i></a>
        </p>
      </div>
    </div>
  </footer>
  <a id="btnTop"><i class="fa-solid fa-circle-up fa-2x"></i></a>
  <!-- Modal -->
  <div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header bg-info">
          <h5 class="modal-title text-white" id="exampleModalLabel">Admin Login Form</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <form action="AdminLogin" method="post" >
            <div class="form-group">
              <input type="email" name="email" maxlength="100" class="form-control" placeholder="Admin Email" required/>
            </div>
            <div class="form-group">
              <input type="password"name="password" maxlength="20" class="form-control" placeholder="Admin Password" required/>
            </div>
            <button type="submit" class="btn btn-primary">Login</button>
          </form>
        </div>
      </div>
    </div>
  </div>
</body>
<script>
  //AOS
  AOS.init();

  //script for scroll to top
  $("#btnTop").click(function () {
        $("html, body").animate({scrollTop: 0}, 1000);
    });
  //script for scroll to Service Section
  $("#service-menu").click(function () {
      document.getElementById("service").scrollIntoView({behavior: 'smooth'});
    });
  //script for light box
  $(document).on('click', '[data-toggle="lightbox"]', function(event) {
      event.preventDefault();
      $(this).ekkoLightbox();
  });

  //script for Google Sheet
  var scriptURL = "https://script.google.com/macros/s/AKfycbxkFW2OP4toUmh90g9UI9kMLslLdl6K8m10npIUtDEK8LMex3HaNfRrO4GRY3ROxV8J/exec";
    var form = document.forms['google-sheet'];
    form.addEventListener('submit', e => {
    e.preventDefault()
    fetch(scriptURL, { method: 'POST', body: new FormData(form)})
      .then(response => alert("Thanks for Contacting us..! We Will Contact You Soon..."))
      .catch(error => console.error('Error!', error.message))
    });
</script>
</html>