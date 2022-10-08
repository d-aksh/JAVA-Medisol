<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.incapp.dao.DAO"%>
<%
	String adminname=(String)session.getAttribute("adminname");
	if(adminname==null) {
		session.setAttribute("msg", "Please Login first!");
		response.sendRedirect("index.jsp");
	}else {
%>
<!DOCTYPE html>
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
	<%
		String m=(String)session.getAttribute("msg");
		if(m!=null){
			if(m.contains("success")){
			%>
				<h6 class="bg-success text-white text-center p-3"><%=m %></h6>
			<% 
				session.setAttribute("msg", null);
			}else if(m.contains("failed") || m.contains("Already")){
			%>
				<h6 class="bg-danger text-white text-center p-3"><%=m %></h6>
			<% 
				session.setAttribute("msg", null);
			}else {
			%>
				<h6 class="bg-warning text-center p-3"><%=m %></h6>
			<% 
				session.setAttribute("msg", null);
			}
		}
	%>
  <nav class="navbar navbar-expand-sm container">
      <a class="navbar-brand" href="AdminHome.jsp">
        <img src="resources/medisol.png" alt=""/> <span>Medi</span>Sol
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#my-navbar"><i class="fa-solid fa-bars"></i></button>
      <div class="collapse navbar-collapse" id="my-navbar">
          <ul class="navbar-nav  mx-auto">
            <li>
              <a class="nav-link" href="AdminHome.jsp">Home</a>
            </li>
            <li>
              <a class="nav-link" href="AllItems.jsp">Items</a>
            </li>
          </ul>
          <p >Welcome: <b><%=adminname %></b> <a class="btn btn-sm btn-danger" href="Logout">Logout</a> </p>
      </div>
  </nav>
  <header class="container mt-4 p-5">
      <h4>Items Details:</h4>
      <%
      	String name=request.getParameter("name"); 
      	DAO db=new DAO();
		HashMap item=db.getItemByName(name);
		db.closeDBConnection();
		if(item!=null) {
			%>
			<div class="row bg-light p-4 my-2">
				<div class="col-4">
					<img height="100px" src="GetImage?name=<%=name%>">
					<form action="ChangeItemImage" method="post" enctype="multipart/form-data">
						<input type="hidden" name="name" value="<%=name%>" />
						<input class="p-2" type="file" name="image" accept="image/*" required/>
						<button class="btn btn-sm btn-primary p-2">Change Image</button>
					</form>
				</div>
				<div class="col-8 border">
					<p>Name: <b> <%= item.get("name") %> </b>
					Company Name: <b> <%= item.get("cname") %> </b>
					Salt: <b> <%= item.get("salt") %> </b></p>
					<p>Price: <b> <%= item.get("price") %> </b>
					Quantity: <b> <%= item.get("qty") %> </b></p>
					<div class="p-2 bg-info">
						<h6 class="text-white">Update Quantity:</h6>
						<form action="UpdateItemQty" method="post">
							<input type="hidden" name="name" value="<%=name%>" />
							<input class="p-2" type="number" name="qty" min="1" value="<%= item.get("qty") %>" required/>
							<button class="btn btn-sm btn-dark p-2">Update Quantity</button>
						</form>
					</div>
					<div class="my-2 p-2 bg-secondary">
						<h6 class="text-white">Update Details:</h6>
						<form class="text-white" action="UpdateItemDetails" method="post">
							<input type="hidden" name="name" value="<%=name%>" />
							Name: <input class="my-2" type="text" name="newname" maxlength="100" value="<%= item.get("name") %>" required/><br/>
							Company Name: <input class="my-2" type="text" name="cname" maxlength="100"  value="<%= item.get("cname") %>" required/><br/>
							Price: <input class="my-2" type="text" name="price" pattern="[0-9.]+" maxlength="10"  value="<%= item.get("price") %>" required/><br/>
							Salt(If Applicable): <input class="my-2" type="text" name="salt" maxlength="100"  value="<%= item.get("salt") %>" /><br/>
							<button class="btn btn-sm btn-dark p-2">Update Details</button>
						</form>
					</div>
				</div>
			</div>
			<%
		}
      %>
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

</script>
</html>
<%
}
%>