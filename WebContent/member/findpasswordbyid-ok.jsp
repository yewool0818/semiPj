<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
	alert("${requestScope.vo.nickName}님의 비밀번호는 ${requestScope.pw}입니다");
	location.href="${pageContext.request.contextPath}/front?command=home";
</script>
</body>
</html>