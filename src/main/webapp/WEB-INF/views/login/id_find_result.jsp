<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 비밀번호 찾기 결과 페이지 -->
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/idFindResult.css">

      <div align="center" style="margin-top: 60px;">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
      <div align="center" style="margin-top: 20px; margin-bottom: 20px;">
      <h1><span style="font-weight: bold; color:#fa0050; font-family: 'Gothic A1', sans-serif;">아이디 찾기</span></h1>
      <h4><span style="font-weight: bold; color:#black; font-family: 'Gothic A1', sans-serif;">고객님의 정보와 일치하는 아이디 입니다.</span></h4>
      </div>   

      <form name="f" method="post" action="/login/id_find_ff.do" class="form-container">   
      <div align="center" style="margin-top: -5px; margin-bottom: 30px; border-radius: 8px;">
         <h4><label>고객님의 아이디 : ${id}</label></h4>
   
         
         <table>
         <tr>
         <td><button type="button" style="width: 80px;" onclick="alert('로그인 페이지로 이동합니다.');
         window.location.href='login.do';">로그인</button></td>
         <td style="width: 50px;"></td>
         <td><button type="button" style="width: 120px;" onclick="alert('비밀번호 찾기 페이지로 이동합니다.');
         window.location.href='pw_find_result.do?id=${id}'">비밀번호 변경하기</button></td>
         <!-- 'pw_find_two.do?id=+${id}'" 찾은 아이디를 비밀번호 찾기 페이지 아이디 입력란이 저장 -->
         </tr>
         </table>
         </div>
         </form>
         </div>
         <div align="center" style="margin-bottom: 110px; border-radius: 8px;">
         </div>
<jsp:include page="../footer.jsp"/>