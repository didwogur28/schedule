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

        });

    </script>
</head>

<body>
    <div class="sec_cal">
        <div class="cal_nav">
            <h1>일정 상세</h1>
        </div>

        <div class="content-box" style="margin: 10% 0 0 20%; position: fixed">
            <div class="conBox">
                <div class="conBox-body">
                    <br/>
                    <input type="hidden" id="cpnCd" name="cpnCd" value="${cpnCd}">
                    <input type="hidden" id="stWk" name="stWk" value="">
                    <input type="hidden" id="edWk" name="edWk" value="">

                    <div class="input-group mb-3">
                        <p class="conBox-menu1">일시</p>
                        <input type="text" id="stDay" name="stDay" class="conCal-input" value="${conDetailInfo.stDay}">
                        <input type="text" id="stTm" name="stTm" class="conCal-select" value="${conDetailInfo.stTm}">
                        <p class="conBox-h4">~</p>
                        <input type="text" id="edDay" name="edDay" class="conCal-input" value="${conDetailInfo.edDay}">
                        <input type="text" id="edTm" name="edTm" class="conCal-select" value="${conDetailInfo.edTm}">
                    </div>

                    <div class="input-group mb-3">
                        <p class="conBox-menu2">일정명</p>
                        <input type="text" id="conBox" name="conBox" class="conBox-select" value="${conDetailInfo.conCd}">
                        <input type="text" id="content" name="content" class="conBox-input" value="${conDetailInfo.conDtl}"><br/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>