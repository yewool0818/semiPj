<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<body>
   <div class="container">
      <div class="row">
         <div class="col-sm-10">
            <div class="panel panel-primary">
               <div class="panel-heading">${requestScope.ageName} 게시물~!</div>
               <table class="table hoh">
                  <thead>
                     <tr>
                        <th align="center">번호</th>
                        <th colspan="2" align="center">제목</th>
                        <th align="center">작성자</th>
                        <th align="center">조회수</th>
                        <th align="center">게시일</th>
                     </tr>
                  </thead>
                  <tbody>
                     <c:set var="pb" value="${requestScope.listvo.pagingBean}" />
                     <c:forEach items="${requestScope.listvo.list }" var="list"
                        varStatus="status">
                        <tr>
                           <td align="center">${requestScope.totalPostCount-((pb.nowPage-1)*pb.postCountPerPage+status.index)}</td>
                           <td colspan="2"><a
                              href="${pageContext.request.contextPath}/front?command=noticeDetailpost&postNo=${list.postNo}">${list.title}</a></td>
                           <td align="center">${list.memberVO.nickName}</td>
                           <td align="center">${list.viewCount}</td>
                           <td align="center">${list.regDate}</td>
                        </tr>
                     </c:forEach>
                  </tbody>
               </table>
            </div>
            <c:if test="${sessionScope.memberVO.id =='adminmts'}">
               <div align="right">
                  <button type="submit" class="btn btn-warning"
                     onclick="location.href='${pageContext.request.contextPath}/front?command=writeNotice'">공지사항
                     작성</button>
               </div>
            </c:if>
            <%-- 페이징 처리 --%>
            <c:set var="pb" value="${requestScope.listvo.pagingBean}" />
            <div class="pagingArea">
               <div class="pagination">
                  <c:choose>
                     <%-- 왼쪽 페이지 이동 --%>
                     <c:when test="${pb.previousPageGroup}">
                        <a
                           href="front?command=noticeList&agename=${requestScope.ageName}&pageNo=${pb.startOfPageGroup-1}">&laquo;</a>
                     </c:when>
                  </c:choose>
                  <c:forEach var="i" begin="${pb.startOfPageGroup}"
                     end="${pb.endOfPageGroup}">
                     <c:choose>
                        <c:when test="${pb.nowPage!=i}">
                           <a
                              href="front?command=noticeList&agename=${requestScope.ageName}&pageNo=${i}">${i}</a>
                        </c:when>
                        <c:otherwise>
                           <a href="#" class="active">${i}</a>
                        </c:otherwise>
                     </c:choose>
                  </c:forEach>
                  <c:choose>
                     <%-- 오른쪽 페이지 이동 --%>
                     <c:when test="${pb.nextPageGroup}">
                        <a
                           href="front?command=noticeList&agename=${requestScope.ageName}&pageNo=${pb.endOfPageGroup+1}">&raquo;</a>
                     </c:when>
                  </c:choose>
               </div>
            </div>
            
         </div>
      </div>
   </div>
