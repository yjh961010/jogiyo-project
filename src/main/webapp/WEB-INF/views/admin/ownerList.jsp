<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 점주 회원가입 목록 페이지 -->

<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/ownerList.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><!-- forEach를 쓰기위함 -->

<div align="center" style="margin-top: 60px;">
<h1><span style="font-weight: bold; color:#fa0050; font-family: 'Gothic A1', sans-serif;">점주 회원가입 목록</span></h1>
<h4><span style="font-weight: bold; color:#black; font-family: 'Gothic A1', sans-serif;">
	관리자가 승인을 해야 점주님들과 맛있는 일을 합니다!</span></h4>
<h4><span style="font-weight: bold; color:#black; font-family: 'Gothic A1', sans-serif;">
	관리자는 승인을 꼭 해주세요!</span></h4>
</div>

	<div class="form-container">
	<div align="center" style="margin-top: -5px;""margin-bottom: 30px;" "border-radius: 8px;">
	<table border="1" width="70%" height="20%">
	<tr>
	<th width="30">이름</th>
	<th width="30">아이디</th>
	<th width="30">승인</th>
	</tr>
	<c:forEach var="dto" items="${ownerList}">
		<tr>
			<td>${dto.name}</td>
			<td>${dto.id}</td>
	<form method="post" name="owner" action="/admin/ownerList_ok.do" class="form-container">
	<!-- forEach로 반복적으로 돌리기에 form태그 또한 forEach안에 와야함 -->
	<input type="hidden" name="id" value="${dto.id}">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<td><input type="submit" value="승인"></td>
	</form>
		</tr>
	</c:forEach>			
	</table>
	</div>
	<div align="center" style="margin-bottom: 110px; border-radius: 8px;">
	</div>
	</div>


<jsp:include page="../footer.jsp"/>