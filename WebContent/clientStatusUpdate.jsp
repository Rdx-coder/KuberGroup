<!DOCTYPE html>
<html>
<head>
    <title>Client Status Update</title>
</head>
<body>
    <form action="ClientStatusUpdate" method="post">
        <input type="hidden" name="id" value="${param.id}">
        
        <label>Email:</label>
        <input type="text" name="email" value="${param.email}"><br>

        <label>Customer Pay:</label>
        <input type="text" name="customerpay" value="${param.customerpay}"><br>

        <label>Net Profit:</label>
        <input type="text" name="netprofit" value="${param.netprofit}"><br>

        <label>Net Loss:</label>
        <input type="text" name="netloss" value="${param.netloss}"><br>

        <input type="submit" value="Update">
    </form>
</body>
</html>
