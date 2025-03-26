<%@ page contentType="text/html; charset=UTF-8" %>

<html>
<head>
    <title>회원 가입</title>
</head>
<body>
    <h2>회원 가입</h2>
    <form action="register_result.jsp" method="post">
        이름: <input type="text" name="name"><br>
        이메일: <input type="email" name="email"><br>
        비밀번호: <input type="password" name="password"><br>
        성별: 
        <input type="radio" name="gender" value="남"> 남
        <input type="radio" name="gender" value="여"> 여 <br>
        관심사:
        <input type="checkbox" name="hobby" value="운동"> 운동
        <input type="checkbox" name="hobby" value="독서"> 독서
        <input type="checkbox" name="hobby" value="음악"> 음악 <br>
        생년월일: <input type="date" name="birthdate"><br>
        <input type="submit" value="가입">
    </form>
</body>
</html>