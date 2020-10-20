<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>reply</title>
<%-- bootstrap 에서 가져온 링크들  --%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">

	 function updateRep(rid, content){
		 var htmls = "";
			htmls += '<textarea name="editContent" id="editContent" class="form-control" rows="3">';
			htmls += content;
			htmls += '</textarea>';
			htmls += '<span class="d-block">';
			htmls += '<strong class="text-gray-dark"></strong>';
			htmls += '<span style="padding-left: 7px; font-size: 9pt">';
			htmls +='<div class="col-sm-2" align="left">'
			htmls +='<input type="password" id="password" placeholder="비밀번호를 입력하세요">';
			htmls +='</div>';
			htmls +='<div class="col-sm-8" align="right">';
			htmls += '<input type="button" class="btn btn-info" value="확인" onclick="updateReply(' + rid + ')" style="padding-right:5px">';
			htmls += '<input type="button" class="btn btn-info" value="취소" onClick="showReplyList()">';
			htmls +='</div>';
			htmls += '</span>';
			htmls += '</span>';		
			$('#repContent' + rid).html(htmls);
		} 
	 
	function updateReply(rid){
		$(document).ready(function() {
			if($("#password").val()==$("#repPassword").val()){
			$.ajax({
				type:"get",
				url:"${pageContext.request.contextPath}/front",
				data:"command=replyupdate&content="+ $("#editContent").val() +"&repNo="+ rid + "&password=" + $("#password").val(),
				success:function(result){
					if(result=="ok"){
						location.href="${pageContext.request.contextPath}/front?command=detailpost&postNo="+$("#postNo").val();
					}
				}
			});
			}else{
				alert("비밀번호를 확인하세요!");
			}
		});
	}
	
	function showReplyList(){
		$(document).ready(function() {
			location.href="${pageContext.request.contextPath}/front?command=detailpost&postNo="+$("#postNo").val();
		});
	}
	
	$(document).ready(function() {
		var options='width=450, height=200, top=185, left=250';
		$("#replyList").on("click", "#btn_del", function(){
			alert($(this).val());
			window.open("${pageContext.request.contextPath}/board/repDeleteConfirm.jsp", "delconfirmpopup", options);
		});
	});
</script>
</head>
<body>
	<div class="container-fluid">
		<div class="row content">

			<div class="col-sm-9">
			<c:if test="${sessionScope.memberVO!=null}">
				<h3>
					<small>댓글</small>
				</h3>
				<form name="replyForm" action="${pageContext.request.contextPath}/front" method="post">
					<div class="form-group">
						<input type="text" name="nick" placeholder="작성자명" required="required">
						<input type="password" name="password" placeholder="비밀번호(4자리)" required="required">
						<textarea name="replyContent" id="replyContent" class="form-control" rows="3" required></textarea>
					</div>
					<input type="hidden" name="command" value="replywrite"> 
					<input type="hidden" name="postNo" id="postNo" value="${requestScope.postVO.postNo}">
					<button type="submit" class="btn btn-success">작성</button>
				</form>
				<br>
				<br>
		</c:if>
				<p>
					<span class="badge">${requestScope.replyCount}</span> 개의 댓글:
				</p>
				<br>
				<div id="replyList">
				
					<c:forEach items="${requestScope.replyList}" var="repList">
						<div class="row">
							<div class="col-sm-2 text-center">
								<img src="${pageContext.request.contextPath}/image/dankun.jpg" class="img-rounded" height="65" width="65" alt="profileImage">					
							</div>
							
							<div class="col-sm-10">
								<h4>
									${repList.nick} 		repNo(프라이머리키):${repList.comNo}
								</h4>
								
								<input type="hidden" id="repNo" name="repNo" value="${repList.comNo}">
								<input type="hidden" id="repPassword" name="repPassword" value="${repList.password}">
								<input type="hidden" id="btn-del" name="btn-del" value="$('#btn_del').val()">
								<p id="repContent${repList.comNo}">${repList.content}</p>
								<br>
								
								<c:if test="${sessionScope.memberVO!=null}">
								<button class="btn btn-info" id="updateBtn" onclick="updateRep('${repList.comNo}','${repList.content}')">수정</button>
								<button class="btn btn-danger btn-delete"  id="btn_del" value="${repList.comNo}">삭제</button>
								</c:if>
								
							</div>
						</div>
					</c:forEach>
					
					</div>
			</div>
		</div>
	</div>
</body>
</html>




