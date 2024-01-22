
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Document Upload</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Themify Icons CSS -->
    <link rel="stylesheet" href="rubic/public_html/assets/vendors/themify-icons/css/themify-icons.css">

    <!-- Bootstrap + Steller JS -->
    <script src="assets/vendors/jquery/jquery-3.4.1.js"></script>
    <script src="assets/vendors/bootstrap/bootstrap.bundle.js"></script>

    <!-- Your custom CSS -->
    <link rel="stylesheet" href="rubic/public_html/assets/css/rubic.css">

    <style>
        body {
            background: linear-gradient(135deg, #3498DB, #E74C3C);
            margin: 0;
            font-family: 'Your-Preferred-Font', sans-serif;
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        #upload-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        #upload-form {
            background-color: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 10px;
            width: 100%;
            max-width: 600px;
            box-sizing: border-box;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            font-size: 2.5em;
            margin-bottom: 30px;
            text-align: center;
            color: #333; /* Text color */
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-size: 1.2em;
            color: #555; /* Text color */
        }

        input[type="file"] {
            margin-bottom: 15px;
            padding: 10px;
        }

        button[type="submit"] {
            background-color: #2ECC71;
            color: #fff;
            padding: 15px;
            border: none;
            cursor: pointer;
            font-size: 1.2em;
            width: 100%;
            box-sizing: border-box;
            transition: background-color 0.3s ease-in-out;
        }

        button[type="submit"]:hover {
            background-color: #28a745; /* Darker green on hover */
        }

        p {
            text-align: center;
            margin-top: 15px;
            font-size: 1em;
            color: #555; /* Text color */
        }

        #countdown {
            color: #FFD700; /* Set the countdown text color to gold/yellow */
            margin-top: 15px;
            font-size: 1.5em;
            font-weight: bold;
            text-align: center; /* Center the countdown text */
        }

        @media (max-width: 600px) {
            #upload-form {
                border-radius: 0;
            }

            button[type="submit"] {
                border-radius: 0;
            }
        }
    </style>
</head>
<body>

   <div id="upload-container">
    <div id="upload-form" class="my-5">
        <h2>Upload Documents</h2>

        <form id="upload-doc-form" action="UploadServlet" method="post" enctype="multipart/form-data">
            <div class="form-group">
            
                <label for="adharCard">Adhar Card Image:</label>
                <input type="file" class="form-control" name="adharCard" accept="image/*" required onchange="enableUploadButton()">
            </div>

            <div class="form-group">
                <label for="panCard">Pan Card Image:</label>
                <input type="file" class="form-control" name="panCard" accept="image/*" required onchange="enableUploadButton()">
            </div>

            <div class="form-group">
                <label for="bankPassbook">Bank Passbook Image:</label>
                <input type="file" class="form-control" name="bankPassbook" accept="image/*" required onchange="enableUploadButton()">
            </div>

    <input type="submit" id="uploadBtn" class="btn btn-primary btn-block" value="Upload" disabled>
            
        </form>
         <p>
        <font color="green"><%= request.getAttribute("successMessage") %></font>
        <font color="red"><%= request.getAttribute("errorMessage") %></font>
    </p>
        

        <div id="success-message" class="mt-3" style="display: none; color: green; text-align: center;"></div>
        <div id="error-message" class="mt-3" style="display: none; color: red; text-align: center;"></div>
        <div id="countdown" class="mt-3" style="display: none;"></div>
    </div>
</div>

<script>
    function enableUploadButton() {
        var fileInputs = document.querySelectorAll('input[type="file"]');
        var uploadBtn = document.getElementById('uploadBtn');

        var allFilesSelected = Array.from(fileInputs).every(function (input) {
            return input.files.length > 0;
        });

        uploadBtn.disabled = !allFilesSelected;
    }

</script>
</body>
</html>
