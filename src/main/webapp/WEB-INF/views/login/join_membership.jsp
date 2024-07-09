<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!-- 회원가입 페이지 -->
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
      let length = jfrm.length - 4; // length에 버튼 값까지 포함  인증번호전송, 중복확인, 취소, 확인 까지 포함이라서 -4를 함
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
   <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.2/kakao.min.js"
  integrity="sha384-TiCUE00h649CAMonG018J2ujOgDKW/kVWlChEuu4jK2vxfAAD0eZxzCKakxg55G4" crossorigin="anonymous"></script>
   <script>
   Kakao.init('faae190fd5bb60c910724b6781aeda60');
   Kakao.isInitialized();
   
   function sendToMe() {
      var url = new URL(window.location.href);
      // AJAX 요청 예시
      $.ajax({
          url: 'https://kauth.kakao.com/oauth/token',
          type: 'POST',
          data: {
              grant_type: 'authorization_code',
              client_id: 'faae190fd5bb60c910724b6781aeda60',
              redirect_url: 'http://localhost:7080/login/join_membership.do',
              code : url.searchParams.get('code')
          },
          success: function(response) {
              console.log(response)
                accessToken = response.access_token;
              console.log('추출된 access_token:', accessToken);
              Kakao.Auth.setAccessToken(accessToken);
            Kakao.API.request({
                 url: '/v2/api/talk/memo/default/send',
                 data: {
                   template_object: {
                     object_type: 'feed',
                     content: {
                       title: '${random}',
                       description: '회원가입을 위한 인증 코드를 확인해주세요.',
                             image_url:
                                'https://developers.kakao.com',
                             link: {
                               web_url: 'https://developers.kakao.com',
                               mobile_web_url: 'https://developers.kakao.com',
                       },
                     },
                    
                     buttons: [
                       {
                         title: '웹으로 보기',
                         link: {
                           mobile_web_url: 'https://developers.kakao.com',
                           web_url: 'https://developers.kakao.com',
                         },
                       },
                       {
                         title: '앱으로 보기',
                         link: {
                           mobile_web_url: 'https://developers.kakao.com',
                           web_url: 'https://developers.kakao.com',
                         },
                       },
                     ],
                   },
                 },
               })
                 .then(function(response) {
                   console.log(response);
                   // 인증 코드를 서버에 전송하여 검증
                         $.ajax({
                             url: 'verifyCode.do',
                             type: 'POST',
                             data: {
                                 access_token: accessToken,
                                 auth_code: response.auth_code // 인증 코드 전송
                             },
                             success: function(verificationResult) {
                                 if (verificationResult === 'success') {
                                     alert('인증이 성공적으로 완료되었습니다.');
                                 } else {
                                     alert('인증에 실패했습니다.');
                                 }
                             },
                             error: function(err) {
                                 console.error('서버 오류:', err);
                             }
                         });
                 })
                 .catch(function(error) {
                   console.log(error);
                 });
          },
          error: function(xhr, status, error) {
              console.error('에러 발생:', error);
          }
      });
   } 
</script>
<script type="text/javascript">

    function out() {
            // 사용자가 입력한 인증번호
             var code = document.getElementById("code").value;
            // 서버에서 받은 랜덤 값
            var random = <%= request.getAttribute("random") %>;
            // 유효성 검사
            if (code == random) {
                // 인증 성공 메시지 표시
                /* document.getElementById("message").innerHTML = "인증이 완료되었습니다."; */
                var messageElement = document.getElementById("message");
            messageElement.innerHTML = "인증이 완료되었습니다.";
            messageElement.style.color = "black"; // 알림에 대한 색상
                // 확인 버튼 활성화
                // 카카오톡 인증 코드가 맞으면 모든 text 값 활성화
                document.getElementById("ok").disabled = false;
                document.getElementById("name").disabled = false;
                document.getElementById("jid").disabled = false;
                document.getElementById("pw").disabled = false;
                document.getElementById("mail").disabled = false;
                document.getElementById("p1").disabled = false;
                document.getElementById("p2").disabled = false;
                document.getElementById("p3").disabled = false;
                
                
            } else {
                // 인증 실패 메시지 표시
                /* document.getElementById("message").innerHTML = "인증번호가 일치하지 않습니다. 다시 시도해 주세요."; */
                var messageElement = document.getElementById("message");
            messageElement.innerHTML = "인증번호가 일치하지 않습니다. 다시 시도해 주세요.";
            messageElement.style.color = "black"; // 알림에 대한 색상
                // 확인 버튼 비활성화
                // 카카오 인증 코드가 틀렸을시 모든 text 값 비활성화
                document.getElementById("ok").disabled = true;
                document.getElementById("name").disabled = true;
                document.getElementById("jid").disabled = true;
                document.getElementById("pw").disabled = true;
                document.getElementById("mail").disabled = true;
                document.getElementById("p1").disabled = true;
                document.getElementById("p2").disabled = true;
                document.getElementById("p3").disabled = true;
     
            }
       }
   /* 인증번호 전송 버튼을 눌렀을때 click_div에 대한 값 사라짐, 나타남 */
    function btnclick(){
       const click_div = document.getElementById('click_div');
       if(click_div.style.display === 'none'){ /* click_div에 대한 요소 사라지게함 */
          click_div.style.display = 'block';  /* 함수가 호출 되었을때 click_div에 대한 값 나타내지게하고 block */
       }
    }
   function kakao_btn(){
       const send = document.getElementById('send');
        document.getElementById("send").disabled = false;
    }
   

</script> 

<div align="center" style="margin-top: 60px;">
<div align="center" style="margin-top: 20px; margin-bottom: 20px;">
<h1><span style="font-weight: bold; color:#fa0050; font-family: 'Gothic A1', sans-serif;">회원가입</span></h1>
</div>
   <form name="f1" method="post" onsubmit="return check()"
   action="/login/join_membership_ok.do" class="form-container">
   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
     <div align="center" style="margin-top: -5px; margin-bottom: 30px; border-radius: 8px;">
   

         <table>
         <tr class="form-row">
         <td>이름</td><td><input type="text" name="name" id="name" disabled></td>
          </tr>
         </table>
         
         <table style="position:relative; left:40px;">
         <tr class="form-row" >
         <td>아이디</td><td><input type="text" name="id" id="jid" title="아이디" disabled></td>
           <td><input type="button" value="중복확인" id="dupli" style="margin-left: 20px;" onclick="idCheck()"></td>
         </tr>
         </table>
         
      <table style="position:relative; right:11px;">
      <tr class="form-row">
         <td>비밀번호</td>
         <td><input type="password" name="passwd" id="pw" title="비밀번호" disabled></td>
      </tr>
      </table>
      
      <table style="position:relative; right:3px;">
      <tr class="form-row">
         <td>이메일</td>
         <td><input type="text" name="mail" id="mail" title="이메일" disabled></td>
      </tr>
      </table>
      
        <table style="position:relative; right:5px;">
      <tr class="form-row">
         <td>전화번호</td>
         <td><input type="text" title="전화번호" name="phone1" id="p1" size="3" maxlength="3" disabled></td>
         <td>-</td> 
         <td><input type="text" title="전화번호" name="phone2" id="p2" size="3" maxlength="4" disabled></td>
         <td>-</td> 
         <td><input type="text" title="전화번호" name="phone3" id="p3" size="3" maxlength="4" disabled></td>
      </tr>
      </table>
                        <!-- div값 나타나지 않게 하기 -->
      <div id="click_div" style="display: none;">
      <table style="position:relative; left:35px;">
      <tr class="form-row">
         <td>인증번호</td>
         <td><input type="text" name="code" id="code" placeholder="(필수)인증번호 입력"></td>
         <td style="position:relative; left:5px;"><button type="button" onclick="out()">인증번호 확인</button></td>
      </tr>
        </table>
        <div id="message"></div> <!-- 인증이 완료됨, 인증실패 문구 출력 -->
        </div>
        
      <table style="position:relative; top:10px;">
      <tr>
         <td style="position:relative; right:15px;"><input type="submit" value="확인" id="ok" disabled></td>
         <td style="position:relative; left:35px;"><button type="button" style="width: 50px;" onclick="alert('로그인 페이지로 이동합니다.');
            window.location.href='login.do';">취소</button></td>
         <td style="position:relative; left:65px;">
            <button type="button" onclick="sendToMe(); btnclick();" id="send">인증번호 전송</button></td>
      </tr>
      </table> 
      
   <table style="position:relative; top:25px;">
      <tr>
        <td><a href="https://kauth.kakao.com/oauth/authorize?client_id=faae190fd5bb60c910724b6781aeda60&redirect_uri=http://localhost:7080/login/join_membership.do&response_type=code&scope=talk_message"
          onclick="kakao_btn()">
         <img src="${pageContext.request.contextPath}/resources/img/kakao_login_medium_narrow.png"
                  alt="카카오 로그인"></a></td>
     </tr>
     </table>
     </div>
      </div>
      <div align="center" style="margin-bottom: 110px; border-radius: 8px;">
      </div>
   </form>
<jsp:include page="../footer.jsp" />