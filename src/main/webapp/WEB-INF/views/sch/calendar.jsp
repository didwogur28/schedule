<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

            if("1" == tabNum){
                clickTabWeek();
            }else if("2" == tabNum){
                clickTabMonth();
            }else if("3" == tabNum){
                clickTabList();
            }
        })

        function clickTabWeek() {

            $(".cal-list-tab a").removeClass("current");
            $(".cal-list-tab #goWeek").addClass("current");

            $.ajax({
                url:"/schedule/sch/goCalendarW?cpnCd=${cpnCd}",
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

        function clickTabMonth() {

            $(".cal-list-tab a").removeClass("current");
            $(".cal-list-tab #goMonth").addClass("current");

            $.ajax({
                url:"/schedule/sch/goCalendarM?cpnCd=${cpnCd}",
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

        function clickTabList() {
            $(".cal-list-tab a").removeClass("current");
            $(".cal-list-tab #goList").addClass("current");

            $.ajax({
                url:"/schedule/sch/goCalendarL?cpnCd=${cpnCd}",
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