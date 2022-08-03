<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>관리자 페이지</title>
    <%@ include file="../include/head.jsp" %>
    <%@ include file="../include/plugin_js.jsp" %>

    <script type="text/javascript">

        // URL 파라미터 숨기기
        history.replaceState({}, null, location.pathname);

        $(document).ready(function() {

            var modal = document.getElementById('myModal');
            var btn = document.getElementById("myBtn");
            var span = document.getElementsByClassName("close")[0];

            btn.onclick = function() {
                modal.style.display = "block";
            }

            span.onclick = function() {
                modal.style.display = "none";
            }

            window.onclick = function(event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }
        })

        // 가입 url 메시지 전송
        function sendSms() {

            var cpnCd = '<%=(String)session.getAttribute("CPNCD")%>';
            var smsMsg = "회원가입 하러가기\n https://www.naver.com?"

            $("input[name=smsMsg]").val(smsMsg);
            $("input[name=cpnCd]").val(cpnCd);

            var formData = $("#sendSns").serialize();

            $.ajax({
                data: formData,
                type: "POST",
                url: "/schedule/main/sendSms",
                success: function (result) {
                    if (result != null) {
                        if (result.status == "OK") {

                            alert('SMS 전송 완료');
                        } else {
                            alert("SMS 전송에 실패했습니다.")
                        }
                    }

                    location.reload();
                }
            })
        }
    </script>
</head>

<body class="hold-transition login-page">
    <div class="login-box">
        <div class="card">
            <div class="card-body login-card-body">
                <p class="login-box-msg">관리자 페이지 입니다.</p>

                <div class="input-group mb-3" style="float: left">
                    <button id="myBtn" class="btn btn-primary btn-block">사원 등록</button>

                    <div id="myModal" class="modal">
                        <!-- Modal content -->
                        <div class="register-box" style="margin: 20% auto;">
                            <div class="card">
                                <div class="card-body register-card-body">
                                    <p class="login-box-msg">Register a new membership</p>
                                    <form id="sendSns" name="sendSns">
                                        <input type="hidden" id="smsMsg" name="smsMsg" value="">
                                        <input type="hidden" id="cpnCd" name="cpnCd" value="">

                                        <div class="input-group mb-3">
                                            <input type="tel" id="phoNo" name="phoNo" class="form-control" placeholder="연락처">
                                            <div class="input-group-append">
                                                <div class="input-group-text">
                                                    <span class="fas fa-phone"></span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row" style="float: right" >
                                            <button type="button" class="btn btn-primary" style="margin-right:5px;" onclick="sendSms()">SEND</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <span class="close">&times;</span>
                    </div>

                </div>

                <div>
                    <button type="button" class="btn btn-primary btn-block" onclick="location.href='/schedule/sch/goCalendar?cpnCd=<%=(String)session.getAttribute("CPNCD")%>&tab=2'">스케줄 생성</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
