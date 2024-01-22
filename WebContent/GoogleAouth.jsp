<%@page import="java.sql.*, java.io.*, org.json.simple.*, org.json.simple.parser.*, org.json.simple.JSONObject" %>
<%@page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.DriverManager, java.sql.SQLException" %>
<%@page import="greatvison.GoogleAuthHelper" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Start your development with Rubic landing page.">
    <meta name="author" content="Devcrud">
     <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
   <meta name="description" content="Start your development with Rubic landing page.">
   <meta name="author" content="Devcrud">
   <title>KUBER GROUP Login  page | LOGIN</title>
   <!-- font icons -->
   <link rel="stylesheet" href="rubic/public_html/assets/vendors/themify-icons/css/themify-icons.css">
   <!-- Bootstrap + Steller  -->
   <link rel="stylesheet" href="rubic/public_html/assets/css/rubic.css">
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
   
    <style>
      body {
         /* Add the linear gradient background */
         background: linear-gradient(135deg, #3498DB, #E74C3C);
         margin: 0; /* Remove default body margin */
         font-family: 'Your-Preferred-Font', sans-serif; /* Set your preferred font */
         color: #fff; /* Set text color to white or any other suitable color for better visibility on the gradient */
      }

      /* Add the rest of your existing styles here */
      /* ... */
   </style>
    <!-- CSS Styles -->
      <style>
    /* Add your custom CSS styles here */
    .google-login-button {
      display: flex;
      flex-direction: column;
      align-items: center;
      text-align: center;
      padding: 10px;
      border: 2px solid #007bff;
      border-radius: 5px;
      max-width: 250px;
      margin: 0 auto;
      text-decoration: none;
      color: #007bff;
      font-weight: bold;
    }
    .google-icon {
      font-size: 24px;
    }
    .button-text {
      margin-top: 10px;
    }
  </style>
</head>
<body>
    <!-- Page Header -->
    <h1></h1>

    <section class="section" id="contact">
        <div class="container text-center">
            <h6 class="display-4 has-line">LOGIN</h6>
            <p class="mb-5 pb-2">WELCOME TO KUBER GROUP</p>

            <form action="ClientLogin" method="post">
                <div class="row mb-4" style="align-content: center; justify-content: center;">
                    <div class="col-md-6">
                        <div class="form-group pb-1">
                            <input type="email" class="form-control" required placeholder="Please Enter Email Id" name="email">
                        </div>
                        <div class="form-group pb-1">
                            <input type="password" class="form-control" required placeholder="Please Enter Password" name="pwd">
                        </div>
                    </div>
                </div>
                <input type="submit" class="btn btn-primary btn-block" value="LogIn">
               
            </form>
       
    <div class="oauthDemo">
        <%
            /*
             * The GoogleAuthHelper handles all the heavy lifting and contains all "secrets"
             * required for constructing a Google login URL.
             */
            final GoogleAuthHelper helper = new GoogleAuthHelper();

            if (request.getParameter("code") == null || request.getParameter("state") == null) {
                /*
                 * Initial visit to the page
                 */
                 %>
                <br>
			<a href="<%= helper.buildLoginUrl() %>" class="google-login-button">
  <div class="google-icon">
    <i class="fas fa-user"></i> <!-- Replace "fas fa-user" with the class of your desired icon -->
  </div>
  <div class="button-text">Don't have an account? Sign up</div>
</a>



<%
                /*
                 * Set the secure state token in the session to be able to track what we sent to Google
                 */
                session.setAttribute("state", helper.getStateToken());
            } else if (request.getParameter("code") != null && request.getParameter("state") != null
                    && request.getParameter("state").equals(session.getAttribute("state"))) {
                session.removeAttribute("state");

                //out.println("<pre>");
                /*
                 * Executes after Google redirects to the callback URL.
                 * Please note that the state request parameter is for convenience to differentiate
                 * between authentication methods (e.g., Facebook OAuth, Google OAuth, Twitter, in-house).
                 * 
                 * GoogleAuthHelper()#getUserInfoJson(String) method returns a String containing
                 * the JSON representation of the authenticated user's information.
                 * At this point, you should parse and persist the info.
                 */
                String userInfoJson = helper.getUserInfoJson(request.getParameter("code"));
                //out.println(userInfoJson);

                // Parse JSON to extract user information
                JSONParser parser = new JSONParser();
                try {
                    JSONObject jsonObject = (JSONObject) parser.parse(userInfoJson);
                    String userId = (String) jsonObject.get("id");
                    String email = (String) jsonObject.get("email");
                    String name = (String) jsonObject.get("name");
                    String givenName = (String) jsonObject.get("given_name");
                    String familyName = (String) jsonObject.get("family_name");
                    String picture = (String) jsonObject.get("picture");
                    String locale = (String) jsonObject.get("locale");

                    // Database Connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/indore", "root", "12345678");

                    // Check if the user already exists in the database
                    String checkQuery = "SELECT COUNT(*) FROM usersdata WHERE user_id = ?";
                    PreparedStatement checkStatement = con.prepareStatement(checkQuery);
                    checkStatement.setString(1, userId);
                    ResultSet resultSet = checkStatement.executeQuery();
                    resultSet.next();
                    int count = resultSet.getInt(1);

                    if (count == 0) {
                        // Insert data into the database only if the user doesn't already exist
                        String insertQuery = "INSERT INTO usersdata (user_id, email, name, given_name, family_name, picture, locale) VALUES (?, ?, ?, ?, ?, ?, ?)";

                        try {
                            PreparedStatement preparedStatement = con.prepareStatement(insertQuery);
                            preparedStatement.setString(1, userId);
                            preparedStatement.setString(2, email);
                            preparedStatement.setString(3, name);
                            preparedStatement.setString(4, givenName);
                            preparedStatement.setString(5, familyName);
                            preparedStatement.setString(6, picture);
                            preparedStatement.setString(7, locale);
                            preparedStatement.executeUpdate();
                            //response.sendRedirect("clientregistration.html"); // Replace with your actual URL
                        } catch (SQLException e) {
                            e.printStackTrace();
                            out.println("Error inserting user data: " + e.getMessage());
                        }
                    } else {
                        // User data already exists in the database. No new data inserted.
                    }
                } catch (ParseException e) {
                    e.printStackTrace();
                    out.println("Error parsing user data: " + e.getMessage());
                }
              //out.println("</pre>");
            }
        %>
         </div>
    </section>

    <!-- Main content -->
    <div class="container">
        <h3 class="mt-5">Copyright 2015 <script></script> &copy; <a href="http://www.greatvison.com">KuberGroup</a></h3>
    </div>
    
    <footer class="footer py-4 bg-light">
        <div class="container text-center">
            <div class="social-links">
                <a href="javascript:void(0)" class="text-dark"><i class="ti-facebook"></i></a>
                <a href="javascript:void(0)" class="text-dark"><i class="ti-twitter-alt"></i></a>
                <a href="javascript:void(0)" class="text-dark"><i class="ti-google"></i></a>
                <a href="javascript:void(0)" class="text-dark"><i class="ti-pinterest-alt"></i></a>
                <a href="javascript:void(0)" class="text-dark"><i class="ti-instagram"></i></a>
                <a href="javascript:void(0)" class="text-dark"><i class="ti-rss"></i></a>
            </div>
        </div>
    </footer>

    <!-- Core JavaScript -->
    <script src="assets/vendors/jquery/jquery-3.4.1.js"></script>
    <script src="assets/vendors/bootstrap/bootstrap.bundle.js"></script>
    
    <!-- Your custom JavaScript -->
    <script src="assets/js/rubic.js"></script>
        
    </div>
</body>
</html>
