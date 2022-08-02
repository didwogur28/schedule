/*
    달력 렌더링 할 때 필요한 정보 목록

    현재 월(초기값 : 현재 시간)
    금월 마지막일 날짜와 요일
    전월 마지막일 날짜와 요일
*/

function calendarInitM(datas, str) {

  // 날짜 정보 가져오기
  var date = "";

  if (typeof str == "undefined" || str == null || str == "") {
    date = new Date(); // 현재 날짜(로컬 기준) 가져오기
  } else {
    date = new Date(str);
  }

  var currentYear = date.getFullYear();
  var currentMonth = date.getMonth()+1;
  var currentDate = date.getDate();
  var currentWeek = date.getDay();

  // 캘린더 렌더링
  renderCalender(thisMonth);

  function renderCalender(thisMonth) {

    // 렌더링을 위한 데이터 정리
    currentYear = thisMonth.getFullYear();
    currentMonth = thisMonth.getMonth();
    currentDate = thisMonth.getDate();

    // 이전 달의 마지막 날 날짜와 요일 구하기
    var startDay = new Date(currentYear, currentMonth, 0);
    var prevDate = startDay.getDate();
    var prevDay = startDay.getDay();

    // 이번 달의 마지막날 날짜와 요일 구하기
    var endDay = new Date(currentYear, currentMonth + 1, 0);
    var nextDate = endDay.getDate();
    var nextDay = endDay.getDay();

    // 해당 일 아이디 값(년_월_일) 구하기
    var realMonth = currentMonth+1;
    realMonth = String(realMonth).length === 1 ? '0' + realMonth : realMonth;
    var prevMonth = realMonth-1;
    var prevYear = currentYear;
    if(realMonth == '1') {
      prevMonth = '12'
      prevYear = currentYear-1;
    }
    var nextMonth = realMonth + 1;
    var nextYear = currentYear;
    if(realMonth == '12') {
      nextMonth = '1'
      nextYear = currentYear + 1;
    }

    // 현재 월 표기
    $('.year-month').text(currentYear + '.' + (currentMonth + 1));

    // 렌더링 html 요소 생성
    $('.dates').html("");
    calendar = document.querySelector('.dates')
    calendar.innerHTML = '';

    // 지난달
    for (var i = prevDate - prevDay + 1; i <= prevDate; i++) {
      calendar.innerHTML = calendar.innerHTML + '<div id="'+prevYear+'-'+prevMonth+'-'+i+'" class="dayM prev disable">' + i + '</div>'
    }
    // 이번달
    for (var i = 1; i <= nextDate; i++) {
      calendar.innerHTML = calendar.innerHTML + '<div id="'+currentYear+'-'+realMonth+'-'+i+'" class="dayM current">' + i + '</div>'
    }
    // 다음달
    for (var i = 1; i <= (7 - nextDay == 7 ? 0 : 7 - nextDay); i++) {
      calendar.innerHTML = calendar.innerHTML + '<div id="'+nextYear+'-'+nextMonth+'-'+i+'" class="dayM next disable">' + i + '</div>'
    }

    // 오늘 날짜 표기
    if (today.getMonth() == currentMonth) {
      todayDate = today.getDate();
      var currentMonthDate = document.querySelectorAll('.dates .current');
      currentMonthDate[todayDate -1].classList.add('today');
    }
  }
}

// 다음달로 이동
$('.go-next').on('click', function() {
  var thisMonth = new Date(currentYear, currentMonth + 1, 1);
  calendarInitM(thisMonth);
});

function modalInitM() {
  var modal = document.getElementById('myModal');
  var span = document.getElementsByClassName("close")[0];
  var closeA = document.getElementsByClassName("close-a")[0];
  var closeBtn = document.getElementsByClassName("close-btn")[0];

  $('.dayM').on('click', function (){
    var thisId = $(this).attr('id');

    modal.style.display = "block";

    $('input[name=stDay]').attr('value',thisId);
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

  window.onclick = function(event) {
    if (event.target == modal) {
      modal.style.display = "none";
    }
  }
}
