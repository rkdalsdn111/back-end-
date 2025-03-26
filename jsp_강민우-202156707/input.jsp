<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>학생 점수 입력</title>
</head>
<body>
    <h2>학생 점수 입력</h2>
    <form action="result.jsp" method="post">
        이름: <input type="text" name="name"><br>
        수학 점수: <input type="text" name="math"><br>
        영어 점수: <input type="text" name="english"><br>
        과학 점수: <input type="text" name="science"><br>
        <input type="submit" value="제출">
    </form>
</body>
</html>