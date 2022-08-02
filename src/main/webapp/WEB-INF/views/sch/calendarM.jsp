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
            var date = new Date('2022-8-17');

            var currentYear = date.getFullYear();                               // 기준일 년도
            var currentMonth = date.getMonth()+1;                               // 기준일 월
            var currentDate = date.getDate();                                   // 기준일 날
            var currentDay = date.getDay();                                     // 기준일 요일

            var firstDate = new Date(currentYear, currentMonth-1, 1).getDate(); // 기준일 월 첫날
            var firstDay = new Date(currentYear, currentMonth-1, 1).getDay();   // 기준일 월 첫째날의 요일
            var lastDate = new Date(currentYear, currentMonth, 0).getDate();    // 기준일 월 마지막날
            var lastDay = new Date(currentYear, currentMonth, 0).getDay();      // 기준일 월 마지막날

            var drawFstDate = "";                                               // 기준일 월 첫번째 월요일 날
            var drawEndDate = "";                                               // 기준일 월 마지막 일요일 날

            var prevYear = currentYear;                                         // 기준일 이전 년도
            var prevMonth = currentMonth-1;                                     // 기준일 이전 월

            if(currentMonth == '1') {
                prevYear = currentYear-1;
                prevMonth = '12'
            }

            var startDay = new Date(prevYear, prevMonth, 0);
            var prevDate = startDay.getDate();                                  // 기준일 이전 월 마지막 일
            var prevDay = startDay.getDay();                                    // 기준일 이전 월 마지막일의 요일

            var nextYear = currentYear;                                         // 기준일 다음 년도
            var nextMonth = currentMonth + 1;                                   // 기준일 다음 월

            if(currentMonth == '12') {
                nextYear = currentYear + 1;
                nextMonth = '1'
            }

            var endDay = new Date(currentYear, currentMonth, 1);
            var nextDate = endDay.getDate();                                    // 기준일 다음 월 첫번째 일
            var nextDay = endDay.getDay();                                      // 기준일 다음 월 첫번째일의 요일

            var weekCnt = 0;
            var weeks = [];
            var weekDays = [];
            var lastArr = "";

            if(firstDay != 0) {
                weekCnt = 1
            }

            for(var i=1; i<=lastDate; i++) {                                    // 주별 날짜 셋팅

                firstDay ++;

                if(firstDay == 7) {
                    firstDay = 0;
                    weekCnt++;
                }
            }

            firstDay = new Date(currentYear, currentMonth-1, 1).getDay();

            prevMonth = String(prevMonth).length === 1 ? '0' + prevMonth : prevMonth;
            currentMonth = String(currentMonth).length === 1 ? '0' + currentMonth : currentMonth;
            nextMonth = String(nextMonth).length === 1 ? '0' + nextMonth : nextMonth;

            for(var i=1; i<=weekCnt; i++) {

                switch(i) {

                    case 1:                     // 첫째 주

                        if(firstDay != 0) {     // 첫째 주 1일이 일요일이 아닐 때
                            for(var j=(prevDate-prevDay); j<=prevDate; j++) {
                                j = String(j).length === 1 ? '0' + j : j;
                                weekDays.push(prevYear+'-'+prevMonth+'-'+j);
                            }
                            for(var j=firstDate; j<=(7-firstDay); j++) {
                                j = String(j).length === 1 ? '0' + j : j;
                                weekDays.push(currentYear+'-'+currentMonth+'-'+j);
                            }
                        } else {
                            for(var j=firstDate; j<=7; j++) {
                                j = String(j).length === 1 ? '0' + j : j;
                                weekDays.push(currentYear+'-'+currentMonth+'-'+j);
                            }
                        }
                        weeks.push(weekDays);
                        break;

                    case weekCnt:               // 마지막 주

                        if(lastDay != 6) {      // 마지막 주 마지막날이 토요일이 아닐 때

                            for(var j=(lastArr+1); j<=lastDate; j++) {
                                j = String(j).length === 1 ? '0' + j : j;
                                weekDays.push(currentYear+'-'+currentMonth+'-'+j);
                            }

                            for(var j=nextDate; j<=(7-nextDay); j++) {
                                j = String(j).length === 1 ? '0' + j : j;
                                weekDays.push(nextYear+'-'+nextMonth+'-'+j);
                            }

                        } else {
                            for(var j=(lastArr+1); j<=(lastArr+7); j++){
                                j = String(j).length === 1 ? '0' + j : j;
                                weekDays.push(currentYear+'-'+currentMonth+'-'+j);
                            }
                        }
                        weeks.push(weekDays);
                        break;

                    default:

                        for(var j=(lastArr+1); j<=(lastArr+7); j++){
                            j = String(j).length === 1 ? '0' + j : j;
                            weekDays.push(currentYear+'-'+currentMonth+'-'+j);
                        }
                        weeks.push(weekDays);
                        break;

                }

                lastArr = Number((weeks[weeks.length-1][weekDays.length-1]).split('-')[2]);
                weekDays = [];
            }

            var str = "";

            $('.dates').html("");

            for(var i=0; i<weeks.length; i++) {
                str = str + '<div id="' + currentMonth + '_' + i + '" class="divWeek' + weekCnt + '">'
                str = str + '<table class="tbWeek' + weekCnt + '">'
                str = str + '<tbody>'
                str = str + '<tr>'
                for (var j = 0; j < weeks[i].length; j++) {
                    str = str + '<td class="dayM"></td>'
                }
                str = str + '</tr>'
                str = str + '</tbody>'
                str = str + '</table>'

                str = str + '<table class="tbWeekCnt' + weekCnt + '">'
                str = str + '<tbody>'
                str = str + '<tr>'
                for (var j = 0; j < weeks[i].length; j++) {
                    if (weeks[i][j].split('-')[1] != currentMonth) {
                        str = str + '<td class="dayM disable">' + Number(weeks[i][j].split('-')[2]) + '</td>'
                    } else {
                        str = str + '<td class="dayM current">' + Number(weeks[i][j].split('-')[2]) + '</td>'
                    }
                }
                str = str + '</tr>'
                str = str + '</tbody>'
                str = str + '</table>'
                str = str + '</div>'
            }
            $('.year-month').text(currentYear + '.' + (currentMonth));
            $('.dates').append(str);


            // calendarInitM();
            // modalInitM();
        })

        function goPrev() {
            var thisDay = $('.year-month').text();
            var date = new Date(thisDay.split('.')[0], thisDay.split('.')[1] - 1, 1);
            calendarInitM(date);
        }
    </script>
</head>

<body>
    <div class="sec_cal">
        <div class="cal_nav">
            <a href="#" class="nav-btn go-prev" onclick="goPrev()">prev</a>
            <div class="year-month"></div>
            <a href="#" class="nav-btn go-next">next</a>
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
                                    <input type="date" id="stDay" name="stDay" class="conCal-input" value="">
                                    <input type="text" id="stTime" name="stTime" class="conCal-input" value="">
                                    <p class="conBox-h4">~</p>
                                    <input type="date" id="edDay" name="edDay" class="conCal-input" value="">
                                    <input type="text" id="edTime" name="edTime" class="conCal-input" value="">
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