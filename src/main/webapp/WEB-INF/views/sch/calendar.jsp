<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>스케줄 페이지</title>
    <%@ include file="../include/head.jsp" %>
    <%@ include file="../include/plugin_js.jsp" %>

    <script>

        var tabNum = "${tab}";
        if(tabNum == "") {
            tabNum = "2";
        }

        $(document).ready( function() {

            $("#goWeek").click(function() {

                location.href='/schedule/sch/goCalendar?cpnCd=${cpnCd}&tab=1';
            });

            $("#goMonth").click(function() {

                location.href='/schedule/sch/goCalendar?cpnCd=${cpnCd}&tab=2';
            });

            $("#goList").click(function() {

                location.href='/schedule/sch/goCalendar?cpnCd=${cpnCd}&tab=3';
            });

            clickTabCal(tabNum);
        })

        function clickTabCal(tabNum) {

            $(".cal-list-tab a").removeClass("current");

            if(tabNum == 1) {
                $(".cal-list-tab #goWeek").addClass("current");
            } else if(tabNum == 2) {
                $(".cal-list-tab #goMonth").addClass("current");
            } else {
                $(".cal-list-tab #goList").addClass("current");
            }

            $.ajax({
                url:"/schedule/sch/goDetailCalendar?cpnCd=${cpnCd}&tabNum="+tabNum,
                type: "GET",
                dataType: "html",
                success: function(html) {
                    if (html != null && !html.empty) {
                        $("#calHtml").empty();
                        $("#calHtml").html(html);
                    }
                }
            });
        }

    </script>


<body class="calBody">
    <div class="cal-detail">
        <ul class="cal-list">
            <li class="cal-list-tab"><a href="#" id="goWeek" class="tab">주간</a></li>
            <li class="cal-list-tab"><a href="#" id="goMonth" class="current tab">월간</a></li>
            <li class="cal-list-tab"><a href="#" id="goList" class="tab">목록</a></li>
        </ul>
    </div>

    <div id="calHtml" class="claHtml"></div>
</body>

</html>