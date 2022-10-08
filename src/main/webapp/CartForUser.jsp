<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.incapp.dao.DAO"%>
<%@page import="java.util.ArrayList"%>
<%
	String adminname=(String)session.getAttribute("adminname");
	if(adminname==null) {
		session.setAttribute("msg", "Please Login first!");
		response.sendRedirect("index.jsp");
	}else {
		DAO db=new DAO();
		ArrayList<HashMap> prescriptions=db.getPrescriptions();
		db.closeDBConnection();
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
            <li>
              <a class="nav-link" href="AdminOrders.jsp">Orders</a>
            </li>
            <li>
              <a class="nav-link" href="Users.jsp">Users</a>
            </li>
            <li>
              <a class="nav-link" href="Prescriptions.jsp">Prescriptions</a>
            </li>
          </ul>
          <p >Welcome: <b><%=adminname %></b> <a class="btn btn-sm btn-danger" href="Logout">Logout</a> </p>
      </div>
  </nav>
  <%
	String uemail=request.getParameter("uemail");
	if(uemail!=null){
		session.setAttribute("uemail", uemail);
	}else{
		uemail=(String)session.getAttribute("uemail");
	}
  %>
  <header class="container mt-4 p-5">
      <div class="row">
    	<div class="col-sm m-2">
	    	<form action="CartForUser.jsp" method="post" >
	          <div class="form-row">
			    <div class="col-10">
			      <input class="form-control" type="text" name="name" maxlength="100" placeholder="Medicine name/Product name" required/>
			    </div>
			    <div class="col-2">
			      <button type="submit" class="btn btn-success">Search</button>
			    </div>
			  </div>
	        </form>
    		<%
      		String name=request.getParameter("name");
      		db=new DAO();
			ArrayList<HashMap> items=db.getItemsLike(name);
			db.closeDBConnection();
			for(HashMap item:items) {
			%>
			<div class="row bg-light p-4 my-2">
				<div class="col-3">
					<img height="100px" src="GetImage?name=<%=item.get("name")%>">
				</div>
				<div class="col-9">
					<p>Name: <b> <%= item.get("name") %> </b>
					Company Name: <b> <%= item.get("cname") %> </b>
					Salt: <b> <%= item.get("salt") %> </b></p>
					<p>Price: <b> <%= item.get("price") %> </b>
					<%
					int q=(int)item.get("qty");
					if(q>0){
					%>
					<form action="AddToCartByAdmin" method="post">
						<input type="hidden" name="name" value="<%=item.get("name")%>" />
						<input type="hidden" name="itemSearchName" value="<%=name%>" />
						<button class="btn btn-sm btn-warning">Add to Cart</button>
					</form>
					<%	
					}else{
					%>
					<br/><br/>
					<label class='bg-danger text-white p-2'>Currently Not Available</label>
					<%	
					}
					%>
				</div>
			</div>
			<%
				}
      		%>
    	</div>
    	<div class="col-sm bg-warning m-2">
    		<h6 class="text-center p-2">Cart for <big><%=uemail %></big></h6>
    		<hr/>
    		<%
	  		db=new DAO();
	  		HashMap<Integer,String> i=db.getCartItemsByEmail(uemail);
			double total=0;
			if(i.isEmpty()){
				%>
				<p class="p-2">Cart is Empty</p>
				<%
			}
			Set set=i.keySet();
			Iterator iterator=set.iterator();
			while(iterator.hasNext()){
				int id=(int)iterator.next();
				String item_name=(String)i.get(id);
			%>
				<p class="p-2">
					<img height="50px" src="GetImage?name=<%=item_name%>">
					<b><%=item_name%></b>
					<%
						HashMap item=db.getItemByName(item_name);
						int qty=(int)item.get("qty");
						if(qty<=0) {
							%>
						<label class="bg-warning p-2">Item Out of Stock</label>		
							<%
						}
						double price=(double)item.get("price");
						total += price;
					%>
					Price: <b><%=price%></b>
					<a class="btn btn-danger btn-sm" href='RemoveFromCartByAdmin?id=<%=id%>'>Remove</a>
				</p>
				<hr>
			<%
			}
			db.closeDBConnection();
	  		%>
    	</div>
      </div>
      
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