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
            calendarInit();
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
                <div class="week">MON</div>
                <div class="week">TUE</div>
                <div class="week">WED</div>
                <div class="week">THU</div>
                <div class="week">FRI</div>
                <div class="week">SAT</div>
                <div class="week">SUN</div>
            </div>
            <div class="dates"></div>
        </div>
    </div>
</body>

</html>