<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>회원가입 페이지</title>
<%@ include file="../include/head.jsp" %>
<%@ include file="../include/plugin_js.jsp" %>

<head>
    <script type="text/javascript">

        // URL 파라미터 숨기기
        history.replaceState({}, null, location.pathname);

        $(document).ready(function() {

            $('#usrId').focusout(function() {
                idChk($(this).val());
            });

            $('#pwdNo').focusout(function() {
                pwdNoChk($(this).val(), $("#pwdNoChk").val());
            });

            $('#pwdNoChk').focusout(function() {
                pwdNoChk($(this).val(), $("#pwdNo").val());
            });

        });

        // 회원가입 처리
        function doRgstr() {

            if (rgstrChk() == false) {
                return false;
            }

            var formData = $("#doRegister").serialize();

            $.ajax({
                data: formData,
                type: "POST",
                url: "/schedule/doRegister",
                success: function (result) {
                    if(result != null) {
                        if(result.status == "OK") {
                            alert("정상 가입되었습니다.")
                            location.reload();
                            location.href = "/schedule/goLogin";
                        } else {
                            alert("가입을 다시 진행해주세요");
                            return false;
                        }
                    } else {
                        alert("회원가입 실패");
                    }
                }
            })
        }

        // 아이디 체크
        function idChk(arg) {

            var deny_char = /^[a-z0-9]+$/;
            var argLen = arg.length;

            if (arg != null && arg != "") {

                // 영어, 숫자만 입력검사
                if(!deny_char.test(arg) || argLen < 5 || argLen > 20) {
                    $("#idDupMsg").show()

                    $("#idDupMsg").html("5~20자의 영문 소문자와 숫자만 사용 가능합니다.");
                    $("#idDupMsg").css("color", "red");
                    $("#idDupChk").val("N");
                    return;
                }

                var formData = $("#doRegister").serialize();

                $.ajax({
                    data: formData,
                    type: "POST",
                    url: "/schedule/idDupChk",
                    success: function (result) {
                        if (result != null) {
                            if (result.status == "OK") {

                                $("#idDupMsg").show()

                                if (result.dupYn == "N") {
                                    $("#idDupMsg").html("사용가능한 아이디입니다.");
                                    $("#idDupMsg").css("color", "green");
                                    $("#idDupChk").val("Y");

                                } else {
                                    $("#idDupMsg").html("중복 된 아이디입니다.");
                                    $("#idDupMsg").css("color", "red");
                                    $("#idDupChk").val("N");
                                }
                            }
                        }
                    }
                })

            } else {

                $("#idDupMsg").hide();
                $("#idDupChk").val("N");
                return;
            }
        }

        // 비밀번호 일치체크
        function pwdNoChk(arg1, arg2) {

            if (arg1 != null && arg1 != "" && arg2 != null && arg2 != "") {

                if (arg1 == arg2) {
                    $("#pwChkMsg").hide();
                    $("#pwChk").val("Y");
                } else {
                    $("#pwChkMsg").show();
                    $("#pwChk").val("N");
                }

            } else {
                $("#pwChkMsg").hide();
                $("#pwChk").val("N");
                return;
            }
        }

        // 회원가입 필수값 체크
        function rgstrChk() { 

            if("" == $.trim($("#usrId").val())){
                alert("아이디를 입력해주세요.");
                $("#usrId").focus();
                return false;
            }

            if($("#idDupChk").val() != "Y"){
                alert("사용 가능한 아이디를 입력해주세요.");
                return false;
            }

            if("" == $.trim($("#pwdNo").val())){
                alert("패스워드를 입력해주세요.");
                $("#pwdNo").focus();
                return false;
            }

            if($("#pwChk").val() != "Y"){
                alert("비밀번호가 일치하지 않습니다.");
                return false;
            }

            if("" == $.trim($("#usrNm").val())){
                alert("이름을 입력해주세요.");
                $("#usrNm").focus();
                return false;
            }

            if("" == $.trim($("#phoNo").val())){
                alert("연락처를 입력해주세요.");
                $("#phoNo").focus();
                return false;
            }

            if(!$('#agreeTerms').is(':checked')) {
                alert("관리자여부를 체크해주세요.");
                return false;
            }
            return true;
        }
    </script>
</head>

<body class="hold-transition register-page">
    <div class="register-box">
        <div class="card">
            <div class="card-body register-card-body">
                <p class="login-box-msg">Register a new membership</p>

                <form id="doRegister" name="doRegister" method="POST">
                    <input type="hidden" id="cpnCd" name="cpnCd" value="${cpnCd}">
                    <input type="hidden" id="seq" name="seq" value="${seq}">

                    <div class="input-group mb-3">
                        <input type="text" id="usrId" name="usrId" class="form-control" placeholder="아이디">
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-exclamation"></span>
                            </div>
                        </div>
                    </div>
                    <div id="idDupMsg" class="idDupMsg" value=""></div>
                    <input type="hidden" id="idDupChk" value="" />

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
                    <div id="pwChkMsg" class="pwChkMsg">비밀번호가 일치하지 않습니다.</div>
                    <input type="hidden" id="pwChk" value="" />

                    <div class="input-group mb-3">
                        <input type="text" id="usrNm" name="usrNm" class="form-control" placeholder="이름">
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-user"></span>
                            </div>
                        </div>
                    </div>

                    <div class="input-group mb-3">
                        <input type="tel" id="phoNo" name="phoNo" class="form-control" placeholder="연락처" value="${phoNo}" <c:if test="${phoNo ne null}">disabled</c:if>>
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-phone"></span>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-8">
                            <div class="icheck-primary">
                                <c:choose>
                                    <c:when test="${cpnCd ne null}">
                                        <input type="checkbox" id="agreeTerms" name="roles" value="ROLE_USER">
                                        <label for="agreeTerms">
                                            유저 입니다.
                                        </label>
                                    </c:when>
                                    <c:otherwise>
                                        <input type="checkbox" id="agreeTerms" name="roles" value="ROLE_ADMIN">
                                        <label for="agreeTerms">
                                            관리자 입니다.
                                        </label>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="col-4">
                            <button type="button" class="btn btn-primary btn-block" onclick="doRgstr()">Register</button>
                        </div>
                    </div>
                </form>

                <a href="/schedule/goLogin" class="text-center">I already have a membership</a>
            </div>
        </div>
    </div>
</body>
</html>
