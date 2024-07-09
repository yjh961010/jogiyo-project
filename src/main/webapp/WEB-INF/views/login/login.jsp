<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<jsp:include page="../header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css">
<style>
    /* 기본 스타일 */
    .form-container {
        margin: 0 auto;
        border-collapse: collapse;
        width: 30%;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-shadow: 0 8px 16px rgba(1, 1, 1, 0.2);
        background-color: #f9f9f9;
        padding: 20px;
    }
    /*테이블 세로 길이 줄이는 겁니당  */
    .form-container td {
        padding: 1px;
    }

    .form-container input[type="text"],
    .form-container input[type="password"] {
        width: calc(100% - 20px);
        padding: 10px;
        border-radius: 5px;
        border: 1px solid #ccc;
        display: block;
        margin: 10px auto;
        font-size: 14px;
    }

    .form-container button {
        background-color: #fa0050;
        color: white;
        border: none;
        padding: 12px;
        cursor: pointer;
        border-radius: 5px;
        width: calc(100% - 20px);
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

<div align="center" style="margin-top: 80px;">
    <h1><span style="font-weight: bold; color:#fa0050; font-family: 'Gothic A1', sans-serif;">죠기요</span></h1>
    <div align="center" style="margin-top: 40px;">
        <form action="/login/loginOk.do" method="post" class="form-container">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <table>
                <tr>
                    <td style="text-align: center;"margin-top: 40px;">
                        <label for="id" style="display:none;">아이디</label>
                        <input type="text" name="id" placeholder="아이디 입력(필수)" required style="margin-top: 30px; margin-bottom: 3px;">
                    </td>
                </tr>
                <tr>
                    <td style="text-align: center;">
                        <label for="passwd" style="display:none;">비밀번호</label>
                        <input type="password" name="passwd" placeholder="비밀번호 입력(필수)" required style="margin-bottom: 3px;">
                    </td>
                </tr>
                <tr>
                    <td style="text-align: center;">
                        <button type="submit" >로그인</button>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: center;">
                        <a href="/login/join_membership.do"
                        onclick="alert('카카오 로그인을 먼저 해주세요')">회원가입</a> |
                        
                        <a href="/login/id_find.do"
                        onclick="alert('카카오 로그인을 먼저 해주세요')">아이디 찾기</a> |
                        
                        <a href="/login/pw_find.do"
                        onclick="alert('카카오 로그인을 먼저 해주세요')">비밀번호 변경하기</a> |
                        
                        <a href="/login/owner_membership.do"
                        onclick="alert('카카오 로그인을 먼저 해주세요')">점주 회원가입</a>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div align="center" style="margin-bottom: 200px; border-radius: 8px;">
    </div>
    </div>
    <jsp:include page="../footer.jsp"/>


