<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>게시판 글쓰기</title>
</head>
<body>
    <h2>게시판 글쓰기</h2>
    <form action="post.jsp" method="post">
        제목: <input type="text" name="title"><br>
        내용: <textarea name="content"></textarea><br>
        <input type="submit" value="등록">
    </form>
</body>
</html>