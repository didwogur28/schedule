/*
    달력 렌더링 할 때 필요한 정보 목록

    현재 월(초기값 : 현재 시간)
    금월 마지막일 날짜와 요일
    전월 마지막일 날짜와 요일
*/

function calendarInitW() {

  // 날짜 정보 가져오기
  var date = new Date(); // 현재 날짜(로컬 기준) 가져오기
  var utc = date.getTime() + (date.getTimezoneOffset() * 60 * 1000); // uct 표준시 도출
  var kstGap = 9 * 60 * 60 * 1000; // 한국 kst 기준시간 더하기
  var today = new Date(utc + kstGap); // 한국 시간으로 date 객체 만들기(오늘)

  var thisMonth = new Date(today.getFullYear(), today.getMonth(), today.getDate());

  var currentYear = thisMonth.getFullYear(); // 달력에서 표기하는 연
  var currentMonth = thisMonth.getMonth(); // 달력에서 표기하는 월
  var currentDate = thisMonth.getDate(); // 달력에서 표기하는 일
  var theDayOfWeek = thisMonth.getDay();  // 달력에서 표기하는 요일

  var weekDay = "";
  var weekFstDay = "";
  var weekEndDay = "";

  // 캘린더 렌더링
  renderCalender(thisMonth);

  function renderCalender(thisMonth) {

    // 렌더링을 위한 데이터 정리
    currentYear = thisMonth.getFullYear();
    currentMonth = thisMonth.getMonth();
    currentDate = thisMonth.getDate();
    theDayOfWeek = today.getDay();

    var thisWeek = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

    // 렌더링 html 요소 생성
    calendar = document.querySelector('.dates')
    calendar.innerHTML = '';

    for(var i=0; i<8; i++) {

      var timeList = "";

      if (i!=0){
        var resultDay = new Date(currentYear, currentMonth, currentDate + (i - theDayOfWeek));
        var yyyy = resultDay.getFullYear();
        var mm = Number(resultDay.getMonth()) + 1;
        var dd = resultDay.getDate();

        mm = String(mm).length === 1 ? '0' + mm : mm;
        dd = String(dd).length === 1 ? '0' + dd : dd;

        weekDay = yyyy + '.' + mm + '.' + dd;

        $("#week"+i).html(weekDay + '(' + thisWeek[i-1] + ')')

        calendar.innerHTML = calendar.innerHTML + '<div id="day'+i+'" class="dayW"></div>';

        if (i==1){
          weekFstDay = weekDay;
        } else if (i==7){
          weekEndDay = weekDay;
        }

        for(var j=1; j<25; j++) {
          j = String(j).length === 1 ? '0' + j : j;
          timeList += '<div id="'+thisWeek[i-1]+'_con'+j+'" class="conW"></div>'
        }

      } else {
        calendar.innerHTML = calendar.innerHTML + '<div id="day'+i+'" class="dayT"></div>'

        for(var j=1; j<25; j++) {
          j = String(j).length === 1 ? '0' + j : j;
          timeList += '<div id="time'+j+'" class="conT">' + j+ '</div>'
        }
      }

      $("#day"+i).append(timeList);
    }


    // 현재 주 표기
    $('.weeks').text(weekFstDay + ' ~ ' + weekEndDay);

  }

  // 이전달로 이동
  $('.go-prev').on('click', function() {
    thisMonth = new Date(currentYear, currentMonth, currentDate - 7);
    renderCalender(thisMonth);
  });

  // 다음달로 이동
  $('.go-next').on('click', function() {
    thisMonth = new Date(currentYear, currentMonth, currentDate + 7);
    renderCalender(thisMonth);
  });

}