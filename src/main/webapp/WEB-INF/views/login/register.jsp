<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>회원가입 페이지</title>
<%@ include file="../include/head.jsp" %>
<%@ include file="../include/plugin_js.jsp" %>

<head>
    <script>

        function idDupChk () {

        }

        // 회원가입 빈 값 체크
        function rgstrNullChk() {

            if("" == $.trim($("#usrId").val())){
                alert("아아디를 입력해주세요.");
                $("#usrId").focus();
                return;
            }

            if("" == $.trim($("#pwdNo").val())){
                alert("패스워드를 입력해주세요.");
                $("#pwdNo").focus();
                return;
            }

            if("" == $.trim($("#usrNm").val())){
                alert("이름을 입력해주세요.");
                $("#usrNm").focus();
                return;
            }

            if("" == $.trim($("#phoNo").val())){
                alert("연락처를 입력해주세요.");
                $("#phoNo").focus();
                return;
            }
        }

        // 회원가입 처리
        function doRgstr() {

            rgstrNullChk()

            var formData = $("#doRegister").serialize();

            $.ajax({
                data: formData,
                type: "POST",
                url: "/schedule/doRegister",
                success: function (result) {
                    if(result != null) {
                        if(result.status == "OK") {
                            location.href = "/schedule/goLogin";
                        } else {
                            alert("회원가입 실패 : " + result.msg);
                            return false;
                        }
                    } else {
                        alert("회원가입 실패");
                    }
                }
            })
        }
    </script>
</head>

<body class="hold-transition register-page">
    <div class="register-box">
        <div class="card">
            <div class="card-body register-card-body">
                <p class="login-box-msg">Register a new membership</p>

                <form id="doRegister" name="doRegister" method="POST">
                    <div class="input-group mb-3">
                        <input type="text" id="usrId" name="usrId" class="form-control" placeholder="아이디">
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-exclamation"></span>
                            </div>
                        </div>
                    </div>

                    <div class="input-group mb-3">
                        <input type="password" id="pwdNo" name="pwdNo" class="form-control" placeholder="비밀번호">
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-lock"></span>
                            </div>
                        </div>
                    </div>

                    <div class="input-group mb-3">
                        <input type="password" id="pwdNoChk" name="pwdNoChk" class="form-control" placeholder="비밀번호 확인">
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-lock"></span>
                            </div>
                        </div>
                    </div>

                    <div class="input-group mb-3">
                        <input type="text" id="usrNm" name="usrNm" class="form-control" placeholder="이름">
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-user"></span>
                            </div>
                        </div>
                    </div>

                    <div class="input-group mb-3">
                        <input type="tel" id="phoNo" name="phoNo" class="form-control" placeholder="연락처">
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-phone"></span>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-8">
                            <div class="icheck-primary">
                                <input type="checkbox" id="agreeTerms" name="terms" value="agree">
                                <label for="agreeTerms">
                                    나는 관리자 입니다
                                </label>
                            </div>
                        </div>

                        <div class="col-4">
                            <button type="button" class="btn btn-primary btn-block" onclick="doRgstr()">Register</button>
                        </div>
                    </div>
                </form>

                <a href="/schedule/login" class="text-center">I already have a membership</a>
            </div>
        </div>
    </div>
</body>
</html>
