<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Document Approval</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

<div class="container mt-5">
    <div class="jumbotron text-center">
        <h2 class="display-4">Documents Uploaded Successfully</h2>
        <p class="lead">Your documents are under review. Please wait for approval.</p>

        <div id="countdown" class="mt-3"></div>
    </div>
</div>

<script>
    // Set the countdown date and time (2 minutes from now)
    var countdownDate = new Date();
    countdownDate.setMinutes(countdownDate.getMinutes() + 2);

    // Update the countdown every 1 second
    var countdownInterval = setInterval(function () {
        var now = new Date().getTime();
        var distance = countdownDate - now;

        var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        var seconds = Math.floor((distance % (1000 * 60)) / 1000);

        document.getElementById("countdown").innerHTML = "Time remaining: " + minutes + "m " + seconds + "s ";

        if (distance < 0) {
            clearInterval(countdownInterval);
            document.getElementById("countdown").innerHTML = "Redirecting to LogIn Page.....";
            
            // Redirect to GoogleAouth.jsp after 2 minutes
            setTimeout(function () {
                window.location.href = 'GoogleAouth.jsp';
            }, 4000);
        }
    }, 1000);
</script>

</body>
</html>
	