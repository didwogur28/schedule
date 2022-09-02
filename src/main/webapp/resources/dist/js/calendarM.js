/*
    달력 렌더링 할 때 필요한 정보 목록

    현재 월(초기값 : 현재 시간)
    금월 마지막일 날짜와 요일
    전월 마지막일 날짜와 요일
*/
var weeks = [];
function calendarInitM(argDay, datas) {

  var date = new Date(argDay);

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

  var weekChk = 0;
  var dayChk = 0;

  firstDay = new Date(currentYear, currentMonth-1, 1).getDay();

  prevMonth = String(prevMonth).length === 1 ? '0' + prevMonth : prevMonth;
  currentMonth = String(currentMonth).length === 1 ? '0' + currentMonth : currentMonth;
  nextMonth = String(nextMonth).length === 1 ? '0' + nextMonth : nextMonth;

  weeks = [];
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


    for(var j=0; j<weeks[i].length; j++) {
      str = str + '<td id="'+weeks[i][j]+'" class="setContent"></td>'
    }

    str = str + '</tr>'
    str = str + '</tbody>'
    str = str + '</table>'

    str = str + '<table class="tbWeekCnt' + weekCnt + '">'
    str = str + '<tbody>'

    str = str + '<tr>'
    for(var j=0; j<weeks[i].length; j++) {
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

  $('.year-month').text(currentYear + '.' + currentMonth);
  $('.dates').append(str);

  modalInitM();
}

// 해당 월 일정 출력
function setCntInfo(datas) {

  var topVal = 30;
  var parentTag = $("#dates");
  var tdTag = parentTag.find('td');
  var str = "";

  for(var i=0; i<tdTag.length; i++) {

    if(tdTag[i].className == 'setContent') {

      for(var j=0; j<datas.length; j++) {

        if(tdTag[i].id == datas[j].stFullDt) {

          if (datas[j].stDt != datas[j].edDt) {
            str = str + '<div class="divCnts" style="top:'+topVal+'px">'

            if(tdTag[i].id.replace(/-/gi, '') == datas[j].stDt) {
              str = str + '<a href="#" onclick="thisModal('+ datas[j].seq + '); event.cancelBubble=true">' + datas[j].conDtl + " (" + datas[j].usrNm + ")" + '</a>'
            } else {
              str = str + '<a href="#" onclick="thisModal('+ datas[j].seq + '); event.cancelBubble=true"></a>'
            }

          } else {
            str = str + '<div class="divCnt" style="top:'+topVal+'px">'

            if(datas[j].stTm != '04') {
              str = str + '<a href="#" onclick="thisModal('+ datas[j].seq + '); event.cancelBubble=true"><label class="tmChk">●</label>' + " " + datas[j].conDtl + " (" + datas[j].usrNm + ")" + " - "  + datas[j].stTmNm + '</a>'
            } else {
              str = str + '<a href="#" onclick="thisModal('+ datas[j].seq + '); event.cancelBubble=true"><label class="tmChk">○</label>' + " " + datas[j].conDtl + " (" + datas[j].usrNm + ")" + '</a>'
            }

          }
          str = str + '</div>'
          str = str + '<br />'

          if(datas[j].stFullDt != datas[j].edFullDt) {
            datas[j].stFullDt = setNewDate(datas[j].stFullDt)
          } else {
            datas[j].stFullDt = datas[j].edFullDt
          }
          topVal += 20;

        }
      }
      $('#'+tdTag[i].id).append(str);
      
    }

    str = "";
    topVal = 30;
  }
}

// 등록 되어있는 일정 시작일자 +1일 세팅
function setNewDate(arg) {

  arg = arg.replace(/-/gi, '.');  // 날짜 재 셋팅

  var newDay = new Date(arg);
  var newYear = "";
  var newMonth = "";
  var newDate = "";

  newDay.setDate(newDay.getDate()+1);

  newYear = newDay.getFullYear();
  newMonth = String(newDay.getMonth()+1).length === 1 ? '0' + (newDay.getMonth()+1) : (newDay.getMonth()+1);
  newDate = String(newDay.getDate()).length === 1 ? '0' + newDay.getDate() : newDay.getDate();

  return newYear+'-'+newMonth+'-'+newDate;

}

// 일정 등록 모달 팝업 창
function modalInitM() {
  var modal = document.getElementById('myModal');
  var span = document.getElementsByClassName("close")[0];
  var closeA = document.getElementsByClassName("close-a")[0];
  var closeBtn = document.getElementsByClassName("close-btn")[0];

  $('.setContent').on('click', function (){

    var thisId = $(this).attr('id');

    modal.style.display = "block";

    $('input[name=stDay]').attr('value',thisId);
    $('input[name=edDay]').attr('value',thisId);

    var date = new Date();
    date = date.getHours();

    if(date>='0' && date < '8') {
      $("#stTm").val("03").prop("selected", true);
      $("#edTm").val("03").prop("selected", true);

    } else if(date>='8' && date < '16') {
      $("#stTm").val("01").prop("selected", true);
      $("#edTm").val("01").prop("selected", true);

    } else {
      $("#stTm").val("02").prop("selected", true);
      $("#edTm").val("02").prop("selected", true);
    }

    $("#allTm").change(function(){

      if($("#allTm").is(":checked")){
        $(".conCal-select").css("display", "none");

        $("#stTm").val("04")
        $("#edTm").val("04")

      }else{
        $(".conCal-select").css("display", "block");

        if(date>='0' && date < '8') {
          $("#stTm").val("03").prop("selected", true);
          $("#edTm").val("03").prop("selected", true);

        } else if(date>='8' && date < '16') {
          $("#stTm").val("01").prop("selected", true);
          $("#edTm").val("01").prop("selected", true);

        } else {
          $("#stTm").val("02").prop("selected", true);
          $("#edTm").val("02").prop("selected", true);
        }

      }
    });
  })

  span.onclick = function() {
    modal.style.display = "none";
  }

  closeA.onclick = function() {
    modal.style.display = "none";
  }

  closeBtn.onclick = function() {
    modal.style.display = "none";
  }
}


