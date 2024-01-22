<%@page import="java.sql.*, java.io.*, org.json.simple.*, org.json.simple.parser.*, org.json.simple.JSONObject" %>
<%@page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.DriverManager, java.sql.SQLException" %>
<%@page import="greatvison.GoogleAuthHelper" %>

<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="utf-8">
   <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
   <meta name="description" content="Start your development with Rubic landing page.">
   <meta name="author" content="Devcrud">
   <title>Client Registration | Registration</title>
   <!-- font icons -->
   <link rel="stylesheet" href="rubic/public_html/assets/vendors/themify-icons/css/themify-icons.css">
   <!-- Bootstrap + Steller  -->
   <link rel="stylesheet" href="rubic/public_html/assets/css/rubic.css">
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
</head>
<body>

<!-- Page Header -->
<!-- End Of Page Header -->
<h1></h1>

<section class="section" id="contact">
    <div class="container text-center">
        <h6 class="display-4 has-line">SIGNUP</h6>
        <p class="mb-5 pb-2">WELCOME TO KUBER GROUP</p>

        <form action="ClientRegistration" method="post" onsubmit="return validateForm()">
<div class="row mb-4" style="align-content: center; justify-content: center;">
                <div class="col-md-6">
                    <div class="form-group pb-1">
                        <input type="text" class="form-control" required placeholder="Please Enter Your Name" name="name">
                    </div>
                    <div class="form-group pb-1">
                        <input type="email" class="form-control" required placeholder="Please Enter Email Id" name="email">
                    </div>
                    <div class="form-group pb-1">
                        <input type="text" class="form-control" required placeholder="Please Enter Your Number" name="mobile">
                    </div>

                    <div class="form-group pb-1">
                        <input type="date" class="form-control" required placeholder="Please Enter Date Of Birth" name="dob">
                    </div>
                    <div class="form-group pb-1">
                        <input type="text" class="form-control" required placeholder="Please Enter Your PAN Card Number" name="pan">
                    </div>
                    <div class="form-group pb-1">
                        <input type="text" class="form-control" required placeholder="Please Enter Your Account Number" name="account">
                    </div>
                    <div class="form-group pb-1">
                        <input type="password" class="form-control" required placeholder="Please Enter Password" name="pwd">
                    </div>
                </div>
            </div>
            <input type="submit" class="btn btn-primary btn-block" value="SignUP">
        </form>
        <!-- Add the "If already have an account, login" button here -->
<div class="container text-center">
<br>
        <p class="text-center">Already have an account? <a href="GoogleAouth.jsp">Login</a></p>
</div>
    </div>
</section>

<!-- main content -->
<div class="container">

    <!-- Buttons -->
    <h3 class="mt-5">Copyright 2023
        <script></script>
        &copy; <a href="">KuberGroup</a></h3></div>
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
</a>



<%
                /*
                 * Set the secure state token in the session to be able to track what we sent to Google
                 */
                session.setAttribute("state", helper.getStateToken());
            } else if (request.getParameter("code") != null && request.getParameter("state") != null
                    && request.getParameter("state").equals(session.getAttribute("state"))) {
                session.removeAttribute("state");

               // out.println("<pre>");
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
    
</footer>
<!-- End of page footer -->

<!-- core  -->
<script src="assets/vendors/jquery/jquery-3.4.1.js"></script>
<script src="assets/vendors/bootstrap/bootstrap.bundle.js"></script>

<!-- steller js -->
<script src="assets/js/rubic.js"></script>

<script>
    function validateForm() {
        var name = document.forms[0].name.value;
        var email = document.forms[0].email.value;
        var mobile = document.forms[0].mobile.value;
        var dob = document.forms[0].dob.value;
        var pan = document.forms[0].pan.value;
        var account = document.forms[0].account.value;
        var password = document.forms[0].pwd.value;

        // Name should not be empty
        if (name === "") {
            alert("Name must be filled out");
            return false;
        }

        // Email validation using regular expression
        var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
        if (!email.match(emailRegex)) {
            alert("Invalid email address");
            return false;
        }

        // Mobile number validation using regular expression
        var mobileRegex = /^[0-9]{10}$/; // Assuming 10-digit mobile numbers
        if (!mobile.match(mobileRegex)) {
            alert("Invalid mobile number");
            return false;
        }

        // Date of birth validation (you can add your own rules)
        // For example, you can check if the user is at least 18 years old.

        // PAN card validation using regular expression
        var panRegex = /^([A-Z]){5}([0-9]){4}([A-Z]){1}?$/;
        if (!pan.match(panRegex)) {
            alert("Invalid PAN Card number");
            return false;
        }

        // Account number validation (you can add your own rules)

        // Password should not be empty
        if (password === "") {
            alert("Password must be filled out");
            return false;
        }

        // Add more password validation rules (e.g., length, complexity, etc.)
        if (password.length < 8) {
            alert("Password should be at least 8 characters long");
            return false;
        }

        // If all validations pass, the form will be submitted
        return true;
    }
</script>

</body>
</html>
