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
            var span = document.getElementsByClassName("close")[0];
            var closeBtn = document.getElementsByClassName("close-a")[0];

            $('.current').on('click', function (){
                var thisId = $(this).attr('id');

                $('#calYear').val(thisId.split('_')[0])
                $('#calMonth').val(thisId.split('_')[1])
                $('#calday').val(thisId.split('_')[2])

                modal.style.display = "block";
            })

            span.onclick = function() {
                modal.style.display = "none";
            }

            closeBtn.onclick = function() {
                modal.style.display = "none";
            }

            window.onclick = function(event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }
        })

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
                <div class="content-box" style="margin: 20% 0 0 37%; position: fixed">
                    <div class="conBox">
                        <div style="display: flex">
                            <p class="conBox-msg">Register a new Contents</p>
                            <a href="#" class="close-a">X</a>
                        </div>
                        <div class="conBox-body">
                            <br/>
                            <form id="saveContent" name="saveContent">
                                <input type="hidden" id="cpnCd" name="cpnCd" value="${cpnCd}">

                                <div class="input-group mb-3">
                                    <p class="conBox-menu1">일시</p>
                                    <input type="text" id="stDay" name="stDay" class="conCal-input" value="">
                                    <input type="text" id="stTime" name="stDay" class="conCal-input" value="">
                                    <p class="conBox-h4">~</p>
                                    <input type="text" id="edDay" name="stDay" class="conCal-input" value="">
                                    <input type="text" id="edTime" name="stDay" class="conCal-input" value="">
                                </div>

                                <div class="input-group mb-3">
                                    <p class="conBox-menu2">일정명</p>
                                    <select id="calendar" name="calendar" class="conBox-select">
                                        <option>일정</option>
                                    </select>
                                    <input type="text" id="content" name="content" class="conBox-input" placeholder="일정명"><br/>
                                </div>

                                <div class="row" style="float: right" >
                                    <button type="button" class="btn btn-primary" style="margin-right:5px;" onclick="saveContent()">일정상세 입력</button>
                                    <button type="button" class="btn btn-primary" style="margin-right:5px;" onclick="saveContent()">등록</button>
                                    <button type="button" class="btn close-btn" style="margin-right:15px;" onclick="saveContent()">취소</button>
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