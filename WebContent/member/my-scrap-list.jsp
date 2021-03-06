<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
	$(document).ready(function() {
		
		//전체 선택 및 삭제
		$("#checkall").click(function() {
			//클릭이 되어있으면
			if($(this).prop("checked")){
				//input태그의 name이 checkedScrap인 태그들을 찾아서 
				//checked옵션을 true로 정의
				$("input[name=checkedScrap]").prop("checked", true);
			}
			
			//클릭이 안되어있으면
			else {
				//input태그의 name이 checkedScrap인 태그들을 찾아서 
				//checked옵션을 false로 정의
				$("input[name=checkedScrap]").prop("checked", false);
			}
		});//checkall
		
		
		//스크랩 포스팅 삭제
		$("#delete_btn").click(function() {
			
			//checkedPost : 체크된 포스트
			var checkedPost = $("input[name=checkedScrap]:checked");
			
	        if((checkedPost.length) == 0){
	            alert("삭제할 포스팅을 선택해 주세요!");
	            return false;
	            
	         } //if
	         
	         else {checkedPost.each(function() {
	            var deletePostNo = $(this).val();
	            //alert(deletePostNo);
	            $.ajax({
	               type : "get",
	               url : "front",
	               data : "command=deleteScrapPost&postNo="+deletePostNo,
	               success : function(result) {
	                  if (result == "ok")
	                  	location.href="${pageContext.request.contextPath}/front?command=myScrapList";
	               }
	            });
	
	         });//each
	         
	         alert(checkedPost.length +"개 포스팅 스크랩 삭제완료!")
	         
	         } //else
	        	 
		});//삭제 버튼
		
		
	});//ready
</script>

<div class="container">
	<div class="row">
		<div class="col-sm-9">
			<div class="panel panel-primary">
				<div class="panel-heading">${sessionScope.memberVO.nickName}님의 스크랩 목록</div>
					<table class="table hoh">
						<thead>
							<tr align="center">
								<th>시대이름</th>
								<th>제목</th>
								<th>작성자</th>
								<th>좋아요</th>
								<th>조회수</th>
								<th>스크랩 날짜</th>
								<th><input type="checkbox" id="checkall"></th>
							</tr>
						</thead>

						<tbody>
						<c:forEach items="${requestScope.scrapedPostVOList}" var="list" varStatus="status">
						<tr>
							<td>${list.memberVO.ageName}</td>
							<td><a href="${pageContext.request.contextPath}/front?command=detailpost&postNo=${list.postNo}">${list.title}</a></td>
							<td>${list.memberVO.nickName}</td>
							<td>${list.likeCount}</td>
							<td>${list.viewCount}</td>
							<td>${list.scrapedDate}</td>
							<td align="left">
								<%--checkBox~ --%>
								<form action="front" id="scrapForm">
									<input type="checkbox" name="checkedScrap" value="${list.postNo}">
								</form>
							</td>
						</tr>
						</c:forEach>

						<tr>
							<td colspan="7" align="right">
								<button type="button" id="delete_btn" class="btn btn-danger btn-sm">
								선택 삭제</button>
							</td>
						</tr>

						</tbody>
					</table>
			</div>
		</div>
	</div>
</div>