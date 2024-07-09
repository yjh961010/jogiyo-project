<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 점주 회원가입 페이지 -->
<jsp:include page="../header.jsp" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/joinMemberShip.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
   let ck = false;
   function idCheck() {
      let id = $("#jid").val();
      if (id == "") {
         alert("아이디를 입력해주세요");
         $("#jid").focus();
         return;
      }
      var csrfToken = $("meta[name='_csrf']").attr("content");
       var csrfHeader = $("meta[name='_csrf_header']").attr("content");  
      $.ajax({
         url : "idCheck.do",
         type : "post",
         data : {
            "jid" : id,
            "_csrf": csrfToken
         },
         beforeSend: function(xhr) {
                // AJAX 요청 헤더에 CSRF 토큰 추가
                xhr.setRequestHeader(csrfHeader, csrfToken);
            },
         success : function(res) {
            if (res == "OK") {
               alert("사용가능한 아이디 입니다.")
               ck = true;
            } else {
               alert("이미 사용중인 아이디 입니다.")
               $("#jid").val("");
               $("#jid").focus();
               ck = false;
            }
         },
         error : function(err) {
            console.log(err);
            ck = false;
         }

      })
   }
   function check() {
      if (ck == false) {
         alert("아이디 중복확인을 먼저 해주세요.")
         return false;
      }
	 /* text 입력 안할 시 title에 대한 알림창이 나옴 */
     const jfrm = document.f1;
      let length = jfrm.length - 2;
      for (let i = 0; i < length; i++) {
         if (jfrm[i].value == "" || jfrm[i].value == null) {
            alert(jfrm[i].title + "을 입력해 주세요");
            jfrm[i].focus();
            return false;
         }
      }
      return true;
   }
   </script>

<div align="center" style="margin-top: 60px;">
<div align="center" style="margin-top: 20px;""margin-bottom: 20px;">
<h1><span style="font-weight: bold; color:#fa0050; font-family: 'Gothic A1', sans-serif;">점주 회원가입</span></h1>
</div>
<form name="f1" method="post" onsubmit="return check()"
   action="/login/owner_membership_ok.do" class="form-container">
   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <div align="center" style="margin-top: -5px;""margin-bottom: 30px;" "border-radius: 8px;">
   
      <table>
      	<tr class="form-row">
         <td>이름</td><td><input type="text" name="name" id="name"></td>
       	</tr>
      	</table>
      	
      	<table>
      	<tr class="form-row">
         <td>아이디</td><td><input type="text" name="id" id="jid" title="아이디"></td>
       	 <td><input type="button" value="중복확인" id="dupli" style="margin-left: 20px;" onclick="idCheck()"></td>
      	</tr>
      	</table>
      	
      <table>
      <tr class="form-row">
         <td>비밀번호</td>
         <td><input type="password" name="passwd" id="pw" title="비밀번호"></td>
      </tr>
      </table>
      
      <table>
      <tr class="form-row">
         <td>이메일</td>
         <td><input type="text" name="mail" id="mail" title="이메일"></td>
      </tr>
      </table>
  	 
   	  <table>
      <tr class="form-row">
         <td>전화번호</td>
         <td><input type="text" title="전화번호" name="phone1" id="p1" size="3" maxlength="3"></td>
         <td>-</td> 
         <td><input type="text" title="전화번호" name="phone2" id="p2" size="3" maxlength="4"></td>
         <td>-</td> 
         <td><input type="text" title="전화번호" name="phone3" id="p3" size="3" maxlength="4"></td>
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
      </div>
      <div align="center" style="margin-bottom: 110px; border-radius: 8px;">
      </div>
</form>
<jsp:include page="../footer.jsp" />