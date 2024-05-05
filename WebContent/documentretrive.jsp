<%@ page import="documentUploade.DatabaseUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.io.ByteArrayInputStream" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="org.apache.commons.codec.binary.Base64" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Document Images</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            padding: 20px;
        }
        .thumbnail-container {
            margin-bottom: 20px;
        }
        .thumbnail {
            max-width: 100%;
            height: auto;
            cursor: pointer;
        }
    </style>
</head>
<body>

<%! 
    // Function to determine image format based on document type
    String getImageFormat(String documentType) {
        switch (documentType.toLowerCase()) {
            case "jpeg":
            case "jpg":
                return "jpeg";
            case "png":
                return "png";
            // Add other cases as needed
            default:
                return null;
        }
    }
%>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1 class="text-center">Document Images</h1>
        </div>
    </div>

    <div class="row">
        <%
            try {
                Connection connection = DatabaseUtil.getConnection();
                Statement statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery("SELECT * FROM documents");

                while (resultSet.next()) {
                    String documentType = resultSet.getString("document_type");
                    byte[] imageData = resultSet.getBytes("content");
                    int imageId = resultSet.getInt("id");
                    int documentId = resultSet.getInt("id");
                    String gmailAuthToken = resultSet.getString("gmail_auth_token");
                    String createdAt = resultSet.getString("created_at");

                    // Convert byte array to BufferedImage
                    ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(imageData);
                    BufferedImage image = ImageIO.read(byteArrayInputStream);

                    // Determine image format based on document type
                    String imageFormat = getImageFormat(documentType);

        %>
                    <div class="col-md-4 thumbnail-container">
                        <div class="card">
                            <!-- Use a thumbnail class for the image -->
                            <img class="card-img-top thumbnail" data-toggle="modal" data-target="#myModal<%= imageId %>"
                                src="data:image/<%= imageFormat %>;base64,<%= new String(Base64.encodeBase64(imageData), "UTF-8") %>"
                                alt="<%= documentType %>"
                            />
                            <div class="card-body">
                                <h5 class="card-title"><%= documentType %></h5>
                                <p class="card-text">Document ID: <%= documentId %></p>
                                <p class="card-text">Gmail Auth Token: <%= gmailAuthToken %></p>
                                <p class="card-text">Created At: <%= createdAt %></p>
                            </div>
                        </div>
                        <!-- Modal for larger image -->
                        <div class="modal fade" id="myModal<%= imageId %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg" role="document">
                                <div class="modal-content">
                                    <div class="modal-body">
                                        <img class="img-fluid" src="data:image/<%= imageFormat %>;base64,<%= new String(Base64.encodeBase64(imageData), "UTF-8") %>" alt="<%= documentType %>"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
        <%
                }

                resultSet.close();
                statement.close();
                DatabaseUtil.closeConnection(connection);
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </div>
</div>

<!-- Include Bootstrap JS and jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
