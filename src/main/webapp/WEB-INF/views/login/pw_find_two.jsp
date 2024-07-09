<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- 비밀번호찾기 두번째 페이지 -->
<jsp:include page="../header.jsp"/>
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css"> --%>

<style>
    /* 기본 스타일 */
    .form-container {
        margin: 0 auto;
        border-collapse: collapse;
        width: 25%;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-shadow: 0 8px 16px rgba(1, 1, 1, 0.2);
        background-color: #f9f9f9;
        padding: 20px;
    }
    
   .form-row {
    display: flex;
    align-items: center; /* 세로 중앙 정렬 */
}
    
    /*테이블 세로 길이 줄임  */
    .form-container td {
        padding: 1px;
    }

    .form-container input[type="text"]
    .form-container input[type="password"] {
        width: calc(110% - 20px);
        padding: 8px;
        border-radius: 5px;
        border: 1px solid #ccc;
        display: block;
        margin: 10px auto;
        font-size: 14px;
    }

    .form-container button { /* 인증번호, 취소, 인증번호 전송 버튼  */
        background-color: #fa0050;
        color: white;
        border: none;
        padding-top: 4px; /* 위쪽 padding 설정 */
   		padding-bottom: 4px; /* 아래쪽 padding 설정 */
   		padding-left: 5px; /* 왼쪽 padding 설정 */
    	padding-right: 5px; /* 오른쪽 padding 설정 */
        cursor: pointer;
        border-radius: 5px;
        width: calc(80% - 10px); /* 버튼 넓이 */
        display: block;
        margin: 10px auto;
        font-size: 16px;
    }
    
  	.form-container input[type="submit"]{	/* 확인 submit */
  		background-color: #fa0050;
        color: white;
        border: none;
        padding-top: 4px; /* 위쪽 padding 설정 */
   		padding-bottom: 4px; /* 아래쪽 padding 설정 */
   		padding-left: 2px; /* 왼쪽 padding 설정 */
    	padding-right: 2px; /* 오른쪽 padding 설정 */
        cursor: pointer;
        border-radius: 5px;
        width: calc(130% - 10px); /* 버튼 넓이 */
        display: block;
        margin: 10px auto;
        font-size: 16px;
  	}
    

    .form-container .actions form {
        display: inline;
    }

    .form-container .actions button {
        background-color: #fa0050;
        color: white;
        border: none;
        padding: 10px 20px;
        cursor: pointer;
        border-radius: 5px;
        margin: 5px 0;
    }

    .form-container a {
        color: #fa0050;
        text-decoration: none;
        font-size: 14px;
    }

    .form-container a:hover {
        text-decoration: underline;
    }

    /* 반응형 스타일 */
    @media (max-width: 768px) {
        .form-container {
            width: 80%;
        }
        .form-container input[type="text"],
        .form-container input[type="password"],
        .form-container button {
            width: 100%;
            margin: 10px 0;
        }
    }

    @media (max-width: 480px) {
        .form-container {
            width: 100%;
        }
    } 
</style>


<div align="center" style="margin-top: 20px; margin-bottom: 20px;">
   <h1><span style="font-weight: bold; color:#fa0050; font-family: 'Gothic A1', sans-serif;">비밀번호 찾기</span></h1>
   <h4><span style="font-weight: bold; color:#black; font-family: 'Gothic A1', sans-serif;">아이디와 전화번호를 입력해주세요.</span></h4>
   </div>
   
 

		<form name="f" method="post" action="/login/pw_find_ok_two.do" class="form-container">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<div align="center" style="margin-top: -5px; margin-bottom: 30px; border-radius: 8px;">
		
		<table>
			<tr class="form-row">
			<td>이름</td><td><input type="text" name="name" id="name"></td>
			</tr>
		</table>
	
		<table>
			<tr class="form-row"> 
			<td>아이디</td><td><input type="text" value="${id.trim()}" name="id" readOnly></td>
				 <!-- 아이디 입력칸에 앞에 공백을 지우기위해 trim()을 줌 중요!!!!! -->
			</tr>
		</table>
	
		
		<table>
			<tr class="form-row">
			<td>전화번호</td>
			<td><input type="text" name="phone1" id="p1" size="3" maxlength="3"></td>
			<td>-</td>
			<td><input type="text" name="phone2" id="p2" size="3" maxlength="4"></td>
			<td>-</td>
			<td><input type="text" name="phone3" id="p3" size="3" maxlength="4"></td>
			</tr>
		</table>
		
		<table>
			<tr>
			<td><input type="submit" value="확인" id="ok"></td>
			<td><button type="button" style="width: 50px;" onclick="alert('로그인 페이지로 이동합니다.');
				window.location.href='login.do';">취소</button></td>
			</tr>
		</table>
		</div>
		</form>		
<jsp:include page="../footer.jsp"/>