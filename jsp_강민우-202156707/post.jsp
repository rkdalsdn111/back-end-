<%@ page contentType="text/html; charset=UTF-8" %>

<%
    request.setCharacterEncoding("UTF-8");

    String title = request.getParameter("title");
    String content = request.getParameter("content");
%>

<html>
<head>
    <title>게시판 글</title>
</head>
<body>
    <h2>게시글 내용</h2>
    제목: <%= title %> <br>
    내용: <pre><%= content %></pre>
</body>
</html>