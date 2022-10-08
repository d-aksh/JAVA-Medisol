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
  <p class="text-center bg-light p-2">For any emergency contact <a href="tel:9811XXXXXX">9811XXXXXX</a> or email at <a href="mailto:info@plusdemic.com">info@medisol.com</a> </p>
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
  <header class="container mt-4">
  	  <div class="p-2">
        <form action="SearchItems.jsp" method="post" >
          <div class="form-row">
		    <div class="col-10">
		      <input class="form-control" type="text" name="name" maxlength="100" placeholder="Medicine name/Product name" required/>
		    </div>
		    <div class="col-2">
		      <button type="submit" class="btn btn-success">Search</button>
		    </div>
		  </div>
        </form>
  	  </div>
      <div class="row p-5">
          <div class="col-sm"  data-aos="zoom-in" data-aos-duration="2000" >
              <h1>Covid-19 Risk Assessment</h1>
              <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Culpa ipsa totam omnis nesciunt praesentium minus officia eligendi dicta nam, nobis quod, nostrum enim. Quaerat, fuga blanditiis! Repellat est impedit at eligendi tenetur. Repudiandae perferendis sit doloremque blanditiis eum? Tenetur voluptatum similique neque non iste, error expedita suscipit? Commodi, delectus. Repellat!</p>
          </div>
          <div class="col-sm"  data-aos="fade-left" data-aos-duration="2000" >
              <img src="resources/img1.jpg" alt="">
              <img src="resources/img2.jpg" alt="">
              <img src="resources/img3.jpg" alt="">
              <img src="resources/img4.jpg" alt="">
              <img src="resources/img5.jpg" alt="">
              <img src="resources/img6.jpg" alt="">
          </div>
      </div>
  </header>
  <section class="container mt-4 p-4">
    <div class="row">
      <div class="col-sm-8">
        <div class="row">
            <div class="col-sm my-2">
                <div class="mycard">
                  <div class="image-circle">
                    <img src="resources/icon1.png" alt="">
                  </div>
                  <h5>Triage</h5>
                  <p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Ipsam, laudantium.</p>
                </div>
            </div>
            <div class="col-sm my-2">
              <div class="mycard">
                <div class="image-circle">
                  <img src="resources/icon2.png" alt="">
                </div>
                <h5>Triage</h5>
                <p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Ipsam, laudantium.</p>
              </div>
          </div>
          <div class="col-sm my-2">
            <div class="mycard">
              <div class="image-circle">
                <img src="resources/icon3.png" alt="">
              </div>
              <h5>Triage</h5>
              <p>Lorem, ipsum dolor sit amet consectetur adipisicing elit. Ipsam, laudantium.</p>
            </div>
        </div>
        </div>
      </div>
      <div class="col-sm-4">
        <div>
            <h3>How it helps people</h3>
            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptatum at aspernatur, fugit asperiores voluptatem mollitia expedita repellat cumque iusto! Quaerat numquam saepe voluptas vitae, aliquam eligendi tenetur quibusdam harum quasi in culpa, ipsam consequatur modi iusto iure earum corporis excepturi inventore cum officiis. Adipisci eos necessitatibus quidem voluptatem fugiat porro.</p>
            <button class="btn btn-light" data-toggle="modal" data-target="#myModal">Get in touch</button>
        </div>
      </div>
    </div>
  </section>
  <section>
    <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
      <div class="carousel-inner">
        <div class="carousel-item active">
          <img src="resources/slide1.jpg" class="d-block w-100" alt="...">
        </div>
        <div class="carousel-item">
          <img src="resources/slide2.jpg" class="d-block w-100" alt="...">
        </div>
        <div class="carousel-item">
          <img src="resources/slide3.jpg" class="d-block w-100" alt="...">
        </div>
      </div>
     <button class="carousel-control-prev" type="button" data-target="#carouselExampleControls" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
      </button>
      <button class="carousel-control-next" type="button" data-target="#carouselExampleControls" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
      </button>
    </div>
  </section>
  <hr>
  <section class="container" id="service">
    <div class="row">
      <div class="col-sm m-2"  data-aos="fade-up" data-aos-duration="1000" data-aos-delay="100" >
          <h3>How to use it</h3>
          <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptatum at aspernatur, fugit asperiores voluptatem mollitia expedita repellat cumque iusto! Quaerat numquam saepe voluptas vitae, aliquam eligendi tenetur quibusdam harum quasi in culpa, ipsam consequatur modi iusto iure earum corporis excepturi inventore cum officiis. Adipisci eos necessitatibus quidem voluptatem fugiat porro.</p>
          <button class="btn btn-light" data-toggle="modal" data-target="#myModal">Get in touch</button>
      </div>
      <div class="col-sm m-2 text-center"  data-aos="fade-up" data-aos-duration="1000" data-aos-delay="400" >
          <img src="resources/image1.jpg" class="rounded-lg img-fluid" alt="">
          <h6 class="p-2 text-muted">Coronavirus</h6>
      </div>
      <div class="col-sm m-2 text-center" data-aos="fade-up" data-aos-duration="1000" data-aos-delay="700"  >
          <img src="resources/image2.jpg" class="rounded-lg img-fluid" height="250px" alt="">
          <h6 class="p-2 text-muted">Diagnostic</h6>
      </div>
      <div class="col-sm m-2 text-center" data-aos="fade-up" data-aos-duration="1000" data-aos-delay="1000"  >
          <img src="resources/image3.jpg" class="rounded-lg img-fluid" height="250px" alt="">
          <h6 class="p-2 text-muted">Test</h6>
      </div>
    </div>
  </section>
  <section class="container-fluid bg-info p-5 text-center">
      <div class="container gallery">
        <a href="resources/img1.jpg" data-toggle="lightbox" data-gallery="my-gallery"><img src="resources/img1.jpg" alt=""/></a>
        <a href="resources/img2.jpg" data-toggle="lightbox" data-gallery="my-gallery"><img src="resources/img2.jpg" alt=""/></a>
        <a href="resources/img3.jpg" data-toggle="lightbox" data-gallery="my-gallery"><img src="resources/img3.jpg" alt=""/></a>
        <a href="resources/img4.jpg" data-toggle="lightbox" data-gallery="my-gallery"><img src="resources/img4.jpg" alt=""/></a>
        <a href="resources/img5.jpg" data-toggle="lightbox" data-gallery="my-gallery"><img src="resources/img5.jpg" alt=""/></a>
        <a href="resources/img6.jpg" data-toggle="lightbox" data-gallery="my-gallery"><img src="resources/img6.jpg" alt=""/></a>
      </div>
  </section>
  <section class="container bg-light my-4 p-5 text-center" >
      <h3 data-aos="zoom-out" data-aos-duration="1000" data-aos-delay="100">Why you can trust this tool</h3>
      <div class="row container m-5" data-aos="zoom-out" data-aos-duration="1000" data-aos-delay="500">
        <div class="col-sm">
          <div class="row">
            <div class="col-2 text-right">
                <img src="resources/icon1.png" height="50px" alt="">
            </div>
            <div class="col-10 text-left">
              <h5>Lorem ipsum dolor sit amet, consectetur adipisicing.</h5>
              <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptatem unde et eveniet.</p>
          </div>
          </div>
        </div>
        <div class="col-sm">
          <div class="row">
            <div class="col-2 text-right">
                <img src="resources/icon2.png" height="50px" alt="">
            </div>
            <div class="col-10 text-left">
              <h5>Lorem ipsum dolor sit amet, consectetur adipisicing.</h5>
              <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptatem unde et eveniet.</p>
          </div>
          </div>
        </div>
      </div>  
  </section>
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
              <input type="text" name="id" maxlength="100" class="form-control" placeholder="Admin ID" required/>
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

</script>
</html>