<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>관리자 페이지</title>
    <%@ include file="../include/head.jsp" %>
    <%@ include file="../include/plugin_js.jsp" %>

    <script>
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
        function sendSns() {

        }
    </script>
</head>

<body class="hold-transition login-page">

<div class="login-box">
    <div class="card">
        <div class="card-body login-card-body">
            <p class="login-box-msg">관리자 페이지 입니다.</p>

            <div class="input-group mb-3" style="float: left">
                <button id="myBtn" class="btn btn-primary btn-block" onclick="openModal()">사원 등록</button>

                <div id="myModal" class="modal">
                    <!-- Modal content -->
                    <div class="register-box" style="margin: 30% auto;">
                        <div class="card">
                            <div class="card-body register-card-body">
                                <p class="login-box-msg">Register a new membership</p>
                                <form id="doRegister" name="doRegister" method="POST">
                                    <div class="input-group mb-3">
                                        <input type="tel" id="phoNo" name="phoNo" class="form-control" placeholder="연락처">
                                        <div class="input-group-append">
                                            <div class="input-group-text">
                                                <span class="fas fa-phone"></span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row" style="float: right" >
                                        <button type="button" class="btn btn-primary" style="margin-right:5px;" onclick="sendSns()">SEND</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <span class="close">&times;</span>
                </div>

            </div>

            <div>
                <button type="submit" class="btn btn-primary btn-block">스케줄 생성</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
