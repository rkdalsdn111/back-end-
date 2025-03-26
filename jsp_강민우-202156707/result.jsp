<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.text.DecimalFormat" %>

<%
    request.setCharacterEncoding("UTF-8");

    String name = request.getParameter("name");
    int math = Integer.parseInt(request.getParameter("math"));
    int english = Integer.parseInt(request.getParameter("english"));
    int science = Integer.parseInt(request.getParameter("science"));

    int total = math + english + science;
    double average = total / 3.0;

    DecimalFormat df = new DecimalFormat("0.00");
%>

<html>
<head>
    <title>점수 결과</title>
</head>
<body>
    <h2>학생 점수 결과</h2>
    이름: <%= name %> <br>
    총점: <%= total %> <br>
    평균: <%= df.format(average) %>
</body>
</html>