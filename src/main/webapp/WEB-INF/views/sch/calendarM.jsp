<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>스케쥴 페이지</title>
    <%@ include file="../include/head.jsp" %>
    <%@ include file="../include/plugin_js.jsp" %>

    <script>

        $(document).ready(function() {
            calendarInitM();

            var modal = document.getElementById('myModal');
            var btn = document.getElementById("cur12");
            var span = document.getElementsByClassName("close")[0];

            btn.onclick = function() {
                modal.style.display = "block";
            }

            span.onclick = function() {
                modal.style.display = "none";
            }

            // window.onclick = function(event) {
            //     if (event.target == modal) {
            //         modal.style.display = "none";
            //     }
            // }
        });

    </script>
</head>

<body>
    <div class="sec_cal">
        <div class="cal_nav">
            <a href="#" class="nav-btn go-prev">prev</a>
            <div class="year-month"></div>
            <a href="#" class="nav-btn go-next">next</a>
        </div>

        <div class="cal_wrap">
            <div class="days">
                <div class="weekM">MON</div>
                <div class="weekM">TUE</div>
                <div class="weekM">WED</div>
                <div class="weekM">THU</div>
                <div class="weekM">FRI</div>
                <div class="weekM">SAT</div>
                <div class="weekM">SUN</div>
            </div>
            <div class="dates"></div>

            <div id="myModal" class="modal">
                <!-- Modal content -->
                <div class="register-box" style="margin: 20% 0 0 45%; position: fixed">
                    <div class="card">
                        <div>
                            <a href="#" class="close-btn">X</a>
                        </div>
                        <div class="card-body register-card-body">
                            <p class="register-box-msg">Register a new Contents</p>
                            <form id="saveContent" name="saveContent">
                                <input type="hidden" id="cpnCd" name="cpnCd" value="">

                                <div class="input-group mb-3">
                                    <input type="text" id="content" name="content" class="form-control" placeholder="일정명"><br/>
                                </div>
                                <div class="input-group mb-3">
                                    <input type="calendar" id="calendar" name="calendar" class="form-control">
                                </div>

                                <div class="row" style="float: right" >
                                    <button type="button" class="btn btn-primary" style="margin-right:5px;" onclick="saveContent()">등록</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <span class="close">&times;</span>
            </div>
        </div>
    </div>
</body>

</html>