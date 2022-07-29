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

            calendarInitW();
        });

    </script>
</head>

<body>
    <div class="sec_cal">
        <div class="cal_nav">
            <a href="#" class="nav-btn go-prev">prev</a>
            <div class="weeks"></div>
            <a href="#" class="nav-btn go-next">next</a>
        </div>

        <div class="cal_wrap">
            <div class="days">
                <div id="week0" class="weekT">시간</div>
                <div id="week1" class="weekW"></div>
                <div id="week2" class="weekW"></div>
                <div id="week3" class="weekW"></div>
                <div id="week4" class="weekW"></div>
                <div id="week5" class="weekW"></div>
                <div id="week6" class="weekW"></div>
                <div id="week7" class="weekW"></div>
            </div>
            <div class="dates"></div>
        </div>
    </div>
</body>

</html>