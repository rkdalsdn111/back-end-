<%@ page contentType="text/html; charset=UTF-8" %>

<%
    request.setCharacterEncoding("UTF-8");

    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String gender = request.getParameter("gender");
    String[] hobbies = request.getParameterValues("hobby");
    String birthdate = request.getParameter("birthdate");

    String hobbyList = "";
    if (hobbies != null) {
        for (String hobby : hobbies) {
            hobbyList += hobby + " ";
        }
    }
%>

<html>
<head>
    <title>회원 가입 정보</title>
</head>
<body>
    <h2>회원 정보</h2>
    이름: <%= name %> <br>
    이메일: <%= email %> <br>
    성별: <%= gender %> <br>
    관심사: <%= hobbyList %> <br>
    생년월일: <%= birthdate %>
</body>
</html>