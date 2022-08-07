<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>스케쥴 페이지</title>
    <%@ include file="../include/head.jsp" %>
    <%@ include file="../include/plugin_js.jsp" %>

    <script>

        $(document).ready(function() {

            setCalData();
        })

        // 이번달 일정 조회
        function setCalData() {

            var date = "";
            var year = new Date().getFullYear();
            var month = new Date().getMonth()+1;
            var day = new Date().getDate();

            month = String(month).length === 1 ? '0' + month : month;
            day = String(day).length === 1 ? '0' + day : day;

            date = year+'-'+month+'-'+day;

            $.ajax({
                url:"/schedule/sch/getCntInfo?cpnCd=${cpnCd}&date="+year+month,
                type: "GET",
                success: function(result) {
                    if(result != null && !result.empty) {

                        if(result.status == "OK") {
                            var datas = result.datas;
                            calendarInitM(date, datas);
                        } else {
                            alert("월 달력 정보 조회에 실패했습니다.")
                            location.href = "/schedule/goMain";
                        }
                    }
                }
            })

        }

        // 이전, 다음 달 이동
        function chgMonth(arg) {
            var thisDay = $('.year-month').text();
            var date = "";

            if(arg == 'prev') {
                date = thisDay.split('.')[0] + '-' + String(Number(thisDay.split('.')[1])-1);
            } else {
                date = thisDay.split('.')[0] + '-' + String(Number(thisDay.split('.')[1])+1);
            }

            calendarInitM(date);
        }

        // 이번달 일정 등록
        function saveMonthCnt() {

            var formData = $("#saveContent").serialize();

            $.ajax({
                data: formData,
                type: "POST",
                url: "/schedule/sch/saveMonthCnt",
                success: function (result) {
                    if (result != null) {
                        if (result.status == "OK") {
                            alert("일정이 등록 되었습니다.");
                            location.reload();

                        } else {
                            alert("일정이 등록되지 않았습니다.");
                            return false;
                        }
                    }
                }
            })
        }

    </script>
</head>

<body>
    <div class="sec_cal">
        <div class="cal_nav">
            <a href="#" class="nav-btn go-prev" onclick="chgMonth('prev')">prev</a>
            <div class="year-month"></div>
            <a href="#" class="nav-btn go-next" onclick="chgMonth('next')">next</a>
        </div>

        <div class="cal_wrap">
            <div class="days">
                <div class="weekHoliday">SUN</div>
                <div class="weekM">MON</div>
                <div class="weekM">TUE</div>
                <div class="weekM">WED</div>
                <div class="weekM">THU</div>
                <div class="weekM">FRI</div>
                <div class="weekM">SAT</div>
            </div>
            <div class="dates"></div>

            <div id="myModal" class="modal">
                <!-- Modal content -->
                <div class="content-box" style="margin: 15% 0 0 37%; position: fixed">
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
                                    <input type="date" id="stDay" name="stDay" class="conCal-input" value="">
                                    <select id="stTm" name="stTm" class="conCal-select">
                                        <c:forEach items="${cntTmCodeList}" var="cntTmCodeList">
                                            <c:if test="${cntTmCodeList.value ne '04'}">
                                                <option value="${cntTmCodeList.value}">${cntTmCodeList.text}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                    <p class="conBox-h4">~</p>
                                    <input type="date" id="edDay" name="edDay" class="conCal-input" value="">
                                    <select id="edTm" name="edTm" class="conCal-select">
                                        <c:forEach items="${cntTmCodeList}" var="cntTmCodeList">
                                            <c:if test="${cntTmCodeList.value ne '04'}">
                                                <option value="${cntTmCodeList.value}">${cntTmCodeList.text}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                    <input type="checkbox" id="allTm" name="allTm" class="allChk" value="04">
                                    <p class="allTxt">종일</p>
                                </div>

                                <div class="input-group mb-3">
                                    <p class="conBox-menu2">일정명</p>
                                    <select id="conBox" name="conBox" class="conBox-select">
                                        <option>일정</option>
                                        <c:forEach items="${cntCodeList}" var="cntCodeList">
                                            <option value="${cntCodeList.value}">${cntCodeList.text}</option>
                                        </c:forEach>
                                    </select>
                                    <input type="text" id="content" name="content" class="conBox-input" placeholder="일정명"><br/>
                                </div>

                                <div class="row" style="float: right" >
                                    <button type="button" class="btn btn-primary" style="margin-right:5px;" onclick="saveMonthCnt()">등록</button>
                                    <button type="button" class="btn close-btn" style="margin-right:15px;">취소</button>
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