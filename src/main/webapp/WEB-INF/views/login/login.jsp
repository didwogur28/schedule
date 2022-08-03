<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>로그인 페이지</title>
    <%@ include file="../include/head.jsp" %>
    <%@ include file="../include/plugin_js.jsp" %>

    <script type="text/javascript">

        $(document).ready(function() {

            if('${LoginFailMessage}' != '') {
                alert('${LoginFailMessage}');
                window.self.location = "goLogin";
            }

            // 저장된 쿠키값을 가져와서 ID 칸에 입력, 없으면 공백
            var key = getCookie("key");
            $("#usrId").val(key);

            // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
            if($("#usrId").val() != ""){
                $("#remember").attr("checked", true); // ID 저장하기 체크 상태
            }

            $("#remember").change(function(){ // 체크박스에 변화가 있다면,
                if($("#remember").is(":checked")){ // ID 저장하기 체크했을 때,
                    setCookie("key", $("#usrId").val(), 7); // 7일 동안 쿠키 보관
                }else{ // ID 저장하기 체크 해제 시,
                    deleteCookie("key");
                }
            });

            // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
            $("#usrId").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
                if($("#remember").is(":checked")){ // ID 저장하기를 체크한 상태라면,
                    setCookie("key", $("#usrId").val(), 7); // 7일 동안 쿠키 보관
                }
            });
        })

        // 쿠키 저장하기
        // setCookie => saveid함수에서 넘겨준 시간이 현재시간과 비교해서 쿠키를 생성하고 지워주는 역할
        function setCookie(cookieName, value, exdays) {
            var exdate = new Date();

            exdate.setDate(exdate.getDate() + exdays);

            var cookieValue = escape(value) + ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
            document.cookie = cookieName + "=" + cookieValue;
        }

        // 쿠키 삭제
        function deleteCookie(cookieName) {
            var expireDate = new Date();

            expireDate.setDate(expireDate.getDate() - 1);
            document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
        }

        // 쿠키 가져오기
        function getCookie(cookieName) {
            cookieName = cookieName + '=';
            var cookieData = document.cookie;
            var start = cookieData.indexOf(cookieName);
            var cookieValue = '';

            if (start != -1) { // 쿠키가 존재하면
                start += cookieName.length;

                var end = cookieData.indexOf(';', start);

                if (end == -1) { // 쿠키 값의 마지막 위치 인덱스 번호 설정
                    end = cookieData.length;
                }

                cookieValue = cookieData.substring(start, end);
            }

            return unescape(cookieValue);
        }
    </script>
</head>

<body class="hold-transition login-page">

    <div class="login-box">
        <div class="card">
            <div class="card-body login-card-body">
                <p class="login-box-msg">Sign in to start your session</p>

                <form id="loginForm" role="form" method="post" action="/schedule/login">
                    <div class="input-group mb-3">
                        <input type="text" id="usrId" name="usrId" class="form-control" placeholder="아이디">
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-exclamation"></span>
                            </div>
                        </div>
                    </div>

                    <div class="input-group mb-3">
                        <input type="password" name="pwdNo" class="form-control" placeholder="비밀번호">
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-lock"></span>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-8">
                            <div class="icheck-primary">
                                <input type="checkbox" id="remember">
                                <label for="remember">Remember Me</label>
                            </div>
                        </div>

                        <div class="col-4">
                            <button type="submit" class="btn btn-primary btn-block">Sign In</button>
                        </div>
                    </div>
                </form>

                <p class="mb-0">
                    <a href="/schedule/goRegister" class="text-center">Register a new membership</a>
                </p>
            </div>
        </div>
    </div>
</body>
</html>
