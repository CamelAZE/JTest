<!--#include virtual="N_MAIN/global.asp" -->
<%
call vFunChkSession(2)	'세션체크 및 중복사용자체크     함수위치: /INCLUDE/function.asp
  Response.CharSet="UTF-8"
  Session.Codepage="65001"
  Response.Codepage="65001"
  Response.ContentType="text/html;charset=utf-8"
' ========================================================================================================
' WorkDiary_PP.asp  KYJ

%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>작업일지등록(박리)</title>
<!-- 내부 문서 참조 -->
<script src="../../N_Main/jQuery/jquery-1.12.4.min.js"></script>
<script src="../../N_Main/jQuery/jquery-ui.js"></script>
<script type="text/javascript" src="../erp_func/common_func.js?230103a"></script>
<script type="text/javascript" src="../../N_CSS/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="../../N_CSS/bootstrap/3.3.2/css/bootstrap.min.css"/>
<link rel="stylesheet" href="../../IncJquery/jquery-ui.min.css"/>
<!-- datepicker -->

<link rel="stylesheet" type="text/css" href="../../N_CSS/datepicker2.css" />

<style>
    /* 전체 영역 */
    html, body { width: 99.5%; margin: 5px 5px 5px 5px;  }
    
    /* title */
    #title_bar{ float: left; width:22%; height:60px; margin: 5px 9% 0px 2%; vertical-align: auto; position: relative; background-size: 100%, 42px; background-position: center; background-repeat: no-repeat;  }
    #title_bar_img{ width: 100%; height: 100%;  }
    #t_header{ width: 100%; font-size: 18pt; font-weight: bold; font-family: Noto Sans KR; margin: 0px; color:white; text-align:center; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); letter-spacing: 2.5px;  }

    /* 버튼 */
    .btn{ width: 100px; height: 60px; background-color: #337ab7; color: #fff; float: left; font-size: 16px; border-radius: 0px; text-align: center; vertical-align: auto;  }
    .btn_02{ width: 118px; border-radius: 3px; margin: 10px 0.5% 10px 0px;  }
    .btn_02_2{ border-radius: 3px; margin: 10px 3% 10px 0px;  }
    .btn_03{ border-radius: 3px; background-color: #FF0000; float: none; clear: right; margin: 10px 0% 10px 0px; line-height: 50px; font-size: 18px; font-weight: bold; color: #fff;  }
    .btn_02:hover { color: white; background-color: #195E9B; cursor: pointer;  }
    .btn_03:hover { color: #fff; background-color: #FF8080; cursor: pointer;  }
    .btn_02:disabled { color: white; background-color: #195E9B; cursor: pointer;  }
    .btn_03:disabled { color: #fff; background-color: #FF8080; cursor: pointer;  }
    .btn_add { position: absolute; border: none; margin: 4px 4px 4px 4px; color: #fff; left: 80%; top: 450px; background-color: tomato;  }

    /* 각 구역 나누기 / 구역별 css 작업 */
    .TopBtn{ height: 100px; margin: 0px 0px 5px 0px; padding: 10px 0px 0px 0px; background-color: #dff0ed;  }
    .bottom{ width: 100%;  }

    .searchDate{ width: 20%; height: 30px; float: left; margin: 30px 22% 0px 0px;  }
    .searchDate label{ border: 1px solid #195E9B; background-color: #0EBDDD; color: #fff; margin: 0px 2px 0px 0px;  }
    .searchDate input{ border: 1px solid #195E9B; text-align: center;  }

    .date_insert{ width: 100%; height: 40px; max-height: 40px; margin: 0px 0px 5px 0px;  }
    .date{ border-collapse: collapse; width: 100%; background-color: #FCEED6;  }
    .date label{ display: block; border: 1px solid #f0bd5e; background-color: #FCEED6;  }
    .date input{ border: 1px solid #f0bd5e; text-align: center;  }

    /* th 태그 */
    .th_01{ box-sizing: border-box; width: 7.5%; height: 40px; font-size: 13pt; border-spacing: 0px; text-align: center;  }
	.th_search_01{ box-sizing: border-box; width: 22%; height: 40px; font-size: 13pt; border-spacing: 0px;  }
    .th_table_01{ box-sizing: border-box; text-align: center;  }

    /* td 태그 */
    .td_01{ box-sizing: border-box; width: 17.5%; height: 40px; font-size: 13pt; border-spacing: 0px;  }
	.td_search_01{ box-sizing: border-box; width: 48%; height: 40px; font-size: 13pt; border-spacing: 0px;  }

    /* label */
    label{ display: block; border-radius: 3px; color: #000000; height: 34px; max-height: 34px; line-height: 34px; text-align: center; vertical-align: middle; font-weight: bold; white-space: nowrap; margin: 0px;  }

    /* input 태그 */
    input{ border-radius: 3px; background-color: #ffffff;  }
    input:focus{ border: 2px solid #f00; outline: none; }
    input:disabled{ color: #999;  }
    .input_tag{ width: 95%; height: 34px; max-height: 34px; line-height: 34px; vertical-align: middle; font-size: 13pt; border: 0; margin: 0px 1% 0px 2%;  }
    .input_tag_readonly_01{ background-color: #eee; pointer-events: none; text-align: center;  }  
    .input_tag_end_01{ width: 98%;  }
	.input_list{ height: 100%; width: 100%; text-align: center; border: none; border-radius: 0px;  }

    /* 공급의뢰서 조회 */
    .div_forHeadList{ width: 100%; height: 350px; margin: 0px 0px 10px 0px;  }
    .table_forHeadList{ width: 100%; border-collapse: collapse; border-top: 1px solid #eea236;  }
    .table_forHeadList tr{ display: table; box-sizing: border-box;  }
    .table_forHeadList th{ word-break: break-all; border-left: 1px solid #eea236;  }
    .table_forHeadList th:first-child{ border-left: none;  }
    .table_forHeadList td{ word-break: break-all; border-left: 1px solid #eea236;  }
    .table_forHeadList td:first-child{ border-left: none;  }
    .forHeadList_header{ display: table; width: 100%; border-bottom: 1px solid #eea236; line-height: 40px; vertical-align: middle; background-color: #F8DCB3; color: #000;  }
    .forHeadList_header tr{ width: 100%;  }
    .forHeadList_body{ display: block; width: auto; max-height: 300px; overflow-y: auto; font-size: 13pt;  }
    .forHeadList_body tr{ width: 100%; border-bottom: 1px solid #eea236; height: 40px; text-align: center;  }
    .forHeadList_body tr:nth-child(2n+1){ background-color: #fff;  }
    .forHeadList_body tr:nth-child(2n){ background-color: #eee;  }

	/* 박리대상 조회 */
    .div_forBodyList{ width: 100%; height: 350px; margin: 0px 0px 0px 0px;  }
    .table_forBodyList{ width: 100%; border-collapse: collapse; border-top: 1px solid #5e93c2;  }
    .table_forBodyList tr{ display: table; box-sizing: border-box;  }
    .table_forBodyList th{ word-break: break-all; border-left: 1px solid #5e93c2;  }
    .table_forBodyList th:first-child{ border-left: none;  }
    .table_forBodyList td{ word-break: break-all; border-left: 1px solid #5e93c2;  }
    .table_forBodyList td:first-child{ border-left: none;  }
    .forBodyList_header{ display: table; width: 100%; border-bottom: 1px solid #5e93c2; line-height: 40px; vertical-align: middle; background-color: #BEDFDB; color: #000;  }
    .forBodyList_header tr{ width: 100%;  }
    .forBodyList_body{ display: block; width: auto; max-height: 300px; overflow-y: auto; font-size: 13pt;  }
    .forBodyList_body tr{ width: 100%; border-bottom: 1px solid #5e93c2; height: 40px; text-align: center;  }
    .forBodyList_body tr:nth-child(2n+1){ background-color: #fff;  }
    .forBodyList_body tr:nth-child(2n){ background-color: #eee;  }

    /* 조회 정렬시 아이콘 */
    .ui-icon { zoom: 200%; margin-top: 1px; position: absolute; display: none; background-image: url("../IncJquery/images/ui-icons_ffffff_256x240.png");  }

    /* autocomplete */
    .autocomplete > div.active{ background: #333; color: #eee;  }
    .ui-autocomplete{ width: auto; height: auto; max-height: 300px; overflow-y: auto; overflow-x: hidden;  }
    html .ui-autocomplete{ font-size: 16px; font-family: Noto Sans KR;  }
    .ui-menu-item-wrapper{ height: 40px; line-height: 30px; vertical-align: middle;  }
    .ui-state-active{ margin: 0px !important;  }

</style>

<script type="text/javascript">
    //  시간, 날자 구하는 변수 전역변수로 선언
    var timeString = getTime();
    var dateString = getDay();

    //  URL에서 사원번호, IP주소, 창고번호 받아오기
    var seSawonid = new URLSearchParams(window.location.search).get("seSawonid");
    var IP_Address = new URLSearchParams(window.location.search).get("IP_Address");
    var defaultStocID = new URLSearchParams(window.location.search).get("defaultStocID");

    //  사원 번호로 사원이름 가져오기
    var get_saWon = Get_Json("SELECT SawonName FROM G_SAWON WHERE USECHK = 0 AND SawonID = " + seSawonid);
    var seSawonname = get_saWon[0].SawonName;

    //  창고 번호로 창고이름 가져오기
    var get_defaultStocName = Get_Json("SELECT 창고명 AS defaultStocName FROM C_창고 WHERE 창고ID =" + defaultStocID);
    var defaultStocName = get_defaultStocName[0].defaultStocName;

    //  autocomplete 펼치지 않도록 하는 변수 선언       / 작업시작, 종료시 포커스로 들어갈때 자동완성과 화살표 트리거가 같이 작동되어 포커스 위치 버그 해결용
    let dontFocus = 0;

	// 공용 변수 선언
	p_item = "";			// 품명
	p_color = "";			// 칼라
	p_size = "";			// 사이즈
	p_item_lot = "";		// 로트번호
	p_cnt = 0;				// 생산수량
	p_Gcnt = 0;				// 숙성
	p_chk = "";				// 선택(공급의뢰)
	p_ID = "";				// key 값

	Pcnt = 0;				// 박리
	Wcnt = 0;				// 보류
	WGcnt = 0;				// 박리대기
	p_date = "";			// 박리일자
	p_remark = "";			// 비고

	$(document).ready(function(){
		try{
            // ------------------------------------------------------------------------
            // 초기 데이터 설정
            // ------------------------------------------------------------------------
            window.focus();
			$("#IP_Address").val(IP_Address);
			$("#작업일자").val(getDay());
			var date = new Date();
			// date.setDate(date.getDate() - 14);       //  14일전 날짜 계산
			// var twoWeekAgo = date.toISOString().substring(0, 10);       //  계산 된 날짜 YYYY-MM-DD 형으로 변환 변수에 안담고 바로 val() 해도 무관
            var twoWeekAgo = get_add_date_yyyymmdd('dd', -14);
			$("#조회일자").val(twoWeekAgo);
			$("#작업자").val(seSawonname);
			$("#창고명").val(defaultStocName);

			$("#작업종료").attr("disabled", true);
            
            // ------------------------------------------------------------------------
            // 조회
            // ------------------------------------------------------------------------
            $("#조회일자").on("change", function(){
				if(jFuncDateValid(this) == true){
					init_disp();
					SUPPLY_DISP();
				}else{
					$("#조회일자").val("");
					return false;
				};
            });     //  조회 end

            // ------------------------------------------------------------------------
            // 작업시작 버튼 클릭
            // ------------------------------------------------------------------------
            $("#작업시작").on("click", function(){
                if(save_line(5) == true){
                    $("#작업시작").attr("disabled", true);
                    $("#작업종료").attr("disabled", false);
				};
            });   //  작업시작 버튼 end

            // ------------------------------------------------------------------------
            // 작업종료 버튼 클릭
            // ------------------------------------------------------------------------
            $("#작업종료").on("click", function(){
                if(save_line(6) == true){
					alert("저장되었습니다.");
					opener.main_bind();
					self.close();
				};
            });   //  작업종료 버튼 end

            // ------------------------------------------------------------------------
            // 박리수량 클릭시 숙성 / 박리 / 불량 수량 자동 셋팅 업데이트 이벤트
            // ------------------------------------------------------------------------
			$("#table_forHeadList").on("click", "td", function(){
				if($(this).children().hasClass("edit-number") == false){		// 숙성 / 박리 / 불량 input 태그에 있는 edit-number로 구분하여 없을경우 작동시키지 않음
					return;
				};
				var rowindex = $(this).parent().parent().children().index($(this).parent()) + 1;					// 테이블 전체에서 0번째는 헤더이기 때문에 1번째 index를 주기위해 +1
				p_item = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(1)").text();							// 품명
				p_color = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(2)").text();							// 칼라
				p_size = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(3)").text();							// 사이즈
				p_item_lot = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(4)").text();						// 로트번호
				p_cnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(5)").text(), 10);				// 생산
				p_Gcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(6)").children().val(), 10);	// 숙성
				Pcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(7)").children().val(), 10);		// 박리
				Wcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(8)").children().val(), 10);		// 보류
				p_date = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(9)").children().val();					// 박리일자
				p_remark = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(10)").children().val();				// 비고
				p_ID = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(12)").text();							// 입고전표수량ID
				if((p_Gcnt + Pcnt + Wcnt) == p_cnt){
					$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(6)").children().val(0);						// 숙성 0 으로만들기
					$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(7)").children().val(0);						// 박리 0 으로만들기
					$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(8)").children().val(0);						// 보류 0 으로만들기
					$(this).children().val(p_cnt);																	// 숙성 | 박리 | 보류 중 선택한 항목에 전체값(cnt) 넣기
				}else{
					$(this).children().val(p_cnt - (p_Gcnt + Pcnt + Wcnt));
				};
				// 변경된 값 업데이트
				p_Gcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(6)").children().val(), 10);
				Pcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(7)").children().val(), 10);
				Wcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(8)").children().val(), 10);
				save_line(3);
			});		// 박리수량 클릭시 숙성 / 박리 / 불량 수량 자동 셋팅 업데이트 이벤트 end

            // ------------------------------------------------------------------------
            // 박리내용 수정시 업데이트 이벤트
            // ------------------------------------------------------------------------
			$("#table_forHeadList").on("change", "td", function(){
				if($(this).children().attr("name") == "박리일자"){		// 입력날짜 벨체크
					if(jFuncDateValid($(this).children()[0]) == false){
						return;
					};
				};
				if($(this).children().attr("name") != "작업완료"){
                	var rowindex = $(this).parent().parent().children().index($(this).parent()) + 1;        			// 테이블 전체에서 0번째는 헤더이기 때문에 1번째 index를 주기위해 +1
					// 숫자필드 입력값 없을시 0으로
					if($(this).children().hasClass("edit-number") && $(this).children().val() == ""){
						$(this).children().val(0);
					};
					p_cnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(5)").text(), 10);				// 생산
					if($(this).children().val() > p_cnt){
						alert("생산수량보다 큰 값으로 입력할 수 없습니다.");
						$(this).children().val(p_cnt);
						$(this).focus();
						return;
					};
					p_item = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(1)").text();							// 품명
					p_color = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(2)").text();							// 칼라
					p_size = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(3)").text();							// 사이즈
					p_item_lot = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(4)").text();						// 로트번호
					p_cnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(5)").text(), 10);				// 생산
					p_Gcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(6)").children().val(), 10);	// 숙성
					Pcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(7)").children().val(), 10);		// 박리
					Wcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(8)").children().val(), 10);		// 보류
					p_date = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(9)").children().val();					// 박리일자
					p_remark = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(10)").children().val();				// 비고
					p_ID = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(12)").text();							// 입고전표수량ID
					save_line(3);		// 입력  필드가 어디인지 확인하고 해당 필드 만 데이터 업데이트(ex)비고 내용수정시 비고 만 데이터 업데이트) / 이지만 그에 대해 하나하나 따로 저장할 방법대신 통짜 업데이트
				};
			});		// 박리내용 수정시 업데이트 이벤트 end
            
            // ------------------------------------------------------------------------
            // 박리내용 완료시 업데이트 이벤트
            // ------------------------------------------------------------------------
			$("#table_forHeadList").on("click", "td", function(){
				if($(this).children().attr("name") == "작업완료"){
					chk = $(this).children().val();
					var rowindex = $(this).parent().parent().children().index($(this).parent()) + 1;        			// 테이블 전체에서 0번째는 헤더이기 때문에 1번째 index를 주기위해 +1
					p_item = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(1)").text();							// 품명
					p_color = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(2)").text();							// 칼라
					p_size = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(3)").text();							// 사이즈
					p_item_lot = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(4)").text();						// 로트번호
					p_cnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(5)").text(), 10);				// 생산
					p_Gcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(6)").children().val(), 10);	// 숙성
					Pcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(7)").children().val(), 10);		// 박리
					Wcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(8)").children().val(), 10);		// 보류
					p_date = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(9)").children().val();					// 박리일자
					p_remark = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(10)").children().val();				// 비고
					p_ID = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(12)").text();							// 입고전표수량ID

					if(save_line(2) != true){
						return false;
					};
					$(this).children().val(chk == "" ? "V" : "");
					SUPPLY_DISP();
					if($(this).children().val() == ""){
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(6)").children().attr("class", "input_list edit-field edit-number").prop("readonly", false);		// 숙성
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(7)").children().attr("class", "input_list edit-field edit-number").prop("readonly", false);		// 박리
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(8)").children().attr("class", "input_list edit-field edit-number").prop("readonly", false);		// 보류
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(9)").children().attr("class", "input_list edit-field ins-date").prop("readonly", false);		// 박리일자
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(10)").children().attr("class", "input_list edit-field").prop("readonly", false);				// 비고
					}else{
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(6)").children().attr("class", "input_list edit-field edit-number").prop("readonly", true);		// 숙성
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(7)").children().attr("class", "input_list edit-field edit-number").prop("readonly", true);		// 박리
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(8)").children().attr("class", "input_list edit-field edit-number").prop("readonly", true);		// 보류
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(9)").children().attr("class", "input_list edit-field ins-date").prop("readonly", true);			// 박리일자
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(10)").children().attr("class", "input_list edit-field").prop("readonly", true);					// 비고
					};
					$("#table_forHeadList tr:eq(" + rowindex + ") td").each(function(){
						if(chk == ""){
							$(this).css("background-color", "#e3e3e3");
						}else{
							$(this).css("background-color", "#ffffff");
						};
					});
				};
			});		// 박리내용 완료시 업데이트 이벤트 end

            // ------------------------------------------------------------------------
            // 공급의뢰 조회 내용 선택
            // ------------------------------------------------------------------------
			$("#forBodyList_body").on("click", "tr", function(){
				var rowindex = $(this).index();
				p_item = $("#forBodyList_body tr:eq(" + rowindex + ") td:eq(4)").text();					// 품명
				p_color = $("#forBodyList_body tr:eq(" + rowindex + ") td:eq(5)").text();					// 칼라
				p_size = $("#forBodyList_body tr:eq(" + rowindex + ") td:eq(6)").text();					// 사이즈
				p_item_lot = $("#forBodyList_body tr:eq(" + rowindex + ") td:eq(7)").text();				// 로트번호
				p_cnt = parseInt($("#forBodyList_body tr:eq(" + rowindex + ") td:eq(8)").text());			// 생산수량
				p_Gcnt = parseInt($("#forBodyList_body tr:eq(" + rowindex + ") td:eq(9)").text());			// 숙성
				WGcnt = parseInt($("#forBodyList_body tr:eq(" + rowindex + ") td:eq(10)").text());			// 박리대기
				p_Gcnt = p_Gcnt + WGcnt;
				p_chk = $("#forBodyList_body tr:eq(" + rowindex + ") td:eq(11)").text();					// 선택
				p_ID = $("#forBodyList_body tr:eq(" + rowindex + ") td:eq(12)").text();					    // 입고전표수량ID
				if(p_chk == "V"){		// 체크 해제, 박리대상 제거
					$("#forBodyList_body tr:eq(" + rowindex + ") td:eq(11)").text();
					save_line(4);
				}else{					// 체크, 박리대상 추가
					$("#forBodyList_body tr:eq(" + rowindex + ") td:eq(11)").text("V");
					save_line(1);
				};
				init_disp();
				SUPPLY_DISP();
			});		// 공급의뢰 조회 내용 선택 end
            
            // ------------------------------------------------------------------------
            // 조회 내용 헤더 클릭으로 정렬
            // ------------------------------------------------------------------------
            $("#table_forBodyList").on("click", "th", function(){
                var regex = /[^ㄱ-ㅎ|ㅏ-ㅣ|가-힣|aA-zZ]/gi;     //  한글 영어만 입력
                var sort_kind = $(this).text().replace(regex, "");      //  그냥 $(this).text() 시 공백등 다른 문자가 있어 replace로 한글만 남기기
                if(sort_kind == "선택"){
                    return;
                };
                $("#supply_header_02 > th span").each(function(){      //  this가 아닌경우 display none로 아이콘 지우기
                    if($(this).parent().text().replace(regex, "") != sort_kind){
                        $(this).css("display", "none");
                    };
                });
                if($(this).children().css("display") == "none"){
                    $(this).children().css("display", "inline").attr("class", "ui-icon ui-icon-triangle-1-n");
                    SUPPLY_DISP(sort_kind, "ASC");
                }else{
                    if($(this).children().hasClass("ui-icon-triangle-1-n") == true){
                        $(this).children().attr("class", "ui-icon ui-icon-triangle-1-s");
                        SUPPLY_DISP(sort_kind, "DESC");
                    }else{
                        $(this).children().attr("class", "ui-icon ui-icon-triangle-1-n");
                        SUPPLY_DISP(sort_kind, "ASC");
                    };
                };
            });     //  조회 내용 헤더 클릭으로 정렬 end

            // ------------------------------------------------------------------------
            // input-auto 포커스시 실행 아래방향키 트리거 작동으로 검색 목록 펼치기 / autocomplete 실행
            // ------------------------------------------------------------------------
            $(".input-auto").on("focus", function(){
                if(dontFocus == 0){
                    data_find(this.id);       //  자동완성 실행
                }else{
                    dontFocus = 0;
                    return;
                };
                var e = $.Event("keydown", {
                    keyCode : 40         //  아래방향키 키코드 40
                });
                var t_this = this;
                setTimeout(function(){      //  바로 실행시 autoFocus 버그로 인해 포커스 사라짐 setTimeout 설정시 버그 사라짐
                    $(t_this).trigger(e);
                }, 100);
                if(this.id == "창고명"){     // 오토포커스 지우고 이거 추가함
                    return;
                }else{
                    $(this).trigger(e);
                };
            });   //  아래방향키 트리거 end

            $("#창고명").on("focus", function(){      // 이걸해야 입력값과 상관없이 검색어 창을 보여주는데 그러면 autoFocus가 고장남...
                $(this).autocomplete("search", "");             // 그래서 autoFocus 지우고 트리거로 autoFocus 대신 추가 작성함
            });

            // ------------------------------------------------------------------------
            // input에 키 입력시 이벤트 엔터(move_next)
            // ------------------------------------------------------------------------
            $("input").on("keydown", function(e){
                var key = e.charCode ? e.charCode : e.keyCode ? e.keyCode : 0;
                if(key == 13){
                    if($(this).hasClass("input-auto") == true){
                        e.preventDefault();
                    }else{
                        move_next(this);
                    };
                };
            });   //  키 입력시 이벤트 end

            // ------------------------------------------------------------------------
            // class edit-field 항목 숫자만 입력하도록 적용
            // ------------------------------------------------------------------------
            // $(".edit-number").on("blur keyup keydown", function(){			// $(".edit-number") 로 하면 조회된 리스트에서 인식을 하지못함 왜일까 ?
            $("body").on("blur keyup keydown", ".edit-number", function(){
                // var regex = /[^0-9]/gi;    //  숫자빼곤 입력 안됨 .도안됨
                var regex = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣|aA-zZ]/gi;     //  한글 영어만 막기
                $(this).val($(this).val().replace(regex, ""));
            });   //  숫자만 입력 end

            // ------------------------------------------------------------------------	
            // 시작시 포커스
            // ------------------------------------------------------------------------	
			$("#창고명").focus();

			// ------------------------------------------------------------------------
			// datepicker 설정
			// ------------------------------------------------------------------------
			$("body").on("focus", ".datepicker", function(){
				$(this).datepicker({
					dateFormat : "yy-mm-dd",
					prevText : "<",
					nextText : ">",
					monthNames : ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
					monthNamesShort : ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
					dayNames : ["일", "월", "화", "수", "목", "금", "토"],
					dayNamesShort : ["일", "월", "화", "수", "목", "금", "토"],
					dayNamesMin : ["일", "월", "화", "수", "목", "금", "토"],
					showMonthAfterYear : true,
					yearSuffix : "년",
					autoClose : true
				});
				// $(this).datepicker("option", "disbled", true);		// 옵션을 보이지 않게한다... ? 인데 여기에 묶어서 쓰면 에러나서 월 변경이 안됨 썻을때도 차이점을 모르겠음.
			});		// datepicker 설정 end

			$("body").on("change", ".datepicker", function(){
				if(jFuncDateValid(this) == false){
					$(this).val("");
					$(this).focus();
					return;
				};
			});		// 입력값 확인

		}catch(err){
			alert(err.message);
            self.close();
		};
	});



	// ------------------------------------------------------------------------
	// 박리작업 대상 조회
	// ------------------------------------------------------------------------
	function init_disp(){
		try{
			var rst = Get_Json("EXEC B_WORK_PEEL_LST 1, '" + $("#창고명").val() + "', '" + $("#작업일자").val() + "'");
			var appendHTML = "";
			if(rst[0].SNO == "" || rst[0].SNO == " " || rst[0].SNO == null){
				appendHTML = "<tr><td>조회 내용이 없습니다.</td></tr>";
			}else{
                var rstLength = rst.length > 7 ? 5.1 : 6;
                for(i = 0; i < rst.length; i++){
                    appendHTML += '<tr><td style="width: 3%;">' + rst[i].SNO +'</td><td style="width: 12%;">' + rst[i].품명 +'</td>'
                                + '<td style="width: 15%;">' + rst[i].칼라 +'</td><td style="width: 7%;">' + rst[i].사이즈 +'</td>'
                                + '<td style="width: 10%;">' + rst[i].아이템로트번호 +'</td><td style="width: 6%;">' + rst[i].생산수량 +'</td>'
                                + '<td style="width: 6%;"><input type="text" class="input_list edit-field edit-number" name="숙성" value="' + rst[i].숙성 + '" autocomplete="off"></td>'
                                + '<td style="width: 6%;"><input type="text" class="input_list edit-field edit-number" name="박리" value="' + rst[i].박리 + '" autocomplete="off"></td>'
                                + '<td style="width: 6%;"><input type="text" class="input_list edit-field edit-number" name="보류" value="' + rst[i].보류 + '" autocomplete="off"></td>'
                                + '<td style="width: 9%;"><input type="text" class="input_list edit-field ins-date datepicker" name="박리일자" value="' + rst[i].박리일자 + '" autocomplete="off"></td>'
                                + '<td style="width: 14%;"><input type="text" class="input_list edit-field" name="비고" value="' + rst[i].비고 + '" autocomplete="off"></td>'
                                + '<td style="width: ' + rstLength + '%;"><input type="text" class="input_list edit-field pack" name="작업완료" value="' + rst[i].작업완료 + '"></td>'
                                + '<td style="display:none;">' + rst[i].입고전표수량ID + '</td></tr>'
                };
			};
			$("#forHeadList_body").empty();
			$("#forHeadList_body").append(appendHTML);
			
			// 선택된 행 백드라운드 칼라 지정
			$("#forHeadList_body > tr").each(function(){
				if($("td:eq(11)", this).children().val() == "V"){
					$("td", this).css("background-color", "#e3e3e3");
					$("td:eq(6)", this).children().attr("class", "input_list edit-field edit-number edit-readonly").prop("readonly", true);
					$("td:eq(7)", this).children().attr("class", "input_list edit-field edit-number edit-readonly").prop("readonly", true);
					$("td:eq(8)", this).children().attr("class", "input_list edit-field edit-number edit-readonly").prop("readonly", true);
					$("td:eq(9)", this).children().attr("class", "input_list edit-field ins-date edit-readonly_01").prop("readonly", true);
					$("td:eq(10)", this).children().attr("class", "input_list edit-field edit-readonly").prop("readonly", true);
				};
			});

		}catch(err){
			alert(err.message);
		};
	};		// 박리작업 대상 조회 end

	// ------------------------------------------------------------------------
	// 공급의뢰 조회
	// ------------------------------------------------------------------------
	function SUPPLY_DISP(sortName, sortOrder){
		try{
            sortName = sortName == null ? "" : sortName == undefined ? "" : sortName;		//	sortName의 입력값 있는지 확인
            sortOrder = sortOrder == null ? "" : sortOrder == undefined ? "" : sortOrder;		//	sortOrder의 입력값 있는지 확인
			var rst = Get_Json("EXEC B_WORK_PEELING_LST 1, '" + $("#창고명").val() + "', '" + $("#조회일자").val() + "', '" + sortName + "', '" + sortOrder + "'");
			console.log("EXEC B_WORK_PEELING_LST 1, '" + $("#창고명").val() + "', '" + $("#조회일자").val() + "', '" + sortName + "', '" + sortOrder + "'")
			var appendHTML = "";
			if(rst[0].생산일자 == "" || rst[0].생산일자 == " " || rst[0].생산일자 == null){
				appendHTML = "<tr><td>조회 내용이 없습니다.</td></tr>";
			}else{
                var rstLength = rst.length > 7 ? 7.1 : 8;
                for(i = 0; i < rst.length; i++){
                    appendHTML += '<tr><td style="width: 8%;">' + rst[i].생산일자 +'</td><td style="width: 7%;">' + rst[i].창고명 +'</td>'
                            + '<td style="width: 7%;">' + rst[i].장비구분 +'</td><td style="width: 7%;">' + rst[i].담당자 +'</td>'
                            + '<td style="width: 12%;">' + rst[i].품명 +'</td><td style="width: 16%;">' + rst[i].칼라 +'</td>'
                            + '<td style="width: 9%;">' + rst[i].사이즈 +'</td>' + '<td style="width: 10%;">' + rst[i].로트번호 +'</td>'
                            + '<td style="width: 8%;">' + rst[i].생산수량 +'</td>' + '<td style="width: 8%;">' + rst[i].숙성 +'</td>'
                            + '<td style="width: ' + rstLength + '%;">' + rst[i].박리대기 +'</td>' + '<td style="display:none;">' + rst[i].선택 +'</td>'
                            + '<td style="display:none;">' + rst[i].입고전표수량ID + '</td></tr>'
                };
			};
			$("#forBodyList_body").empty();
			$("#forBodyList_body").append(appendHTML);

			// 선택된 행 백그라운드 칼라 지정
			$("#forBodyList_body > tr").each(function(){
				if($("td:eq(11)", this).text() == "V"){
					$("td", this).css("background-color", "#DBD6E8");
				};
			});
			
		}catch(err){
			alert(err.message);
		};
	};		// 공급의뢰 조회 end

    // ------------------------------------------------------------------------
    // 한줄씩 저장
    // ------------------------------------------------------------------------
	function save_line(order){		// order 1: 공급의뢰서 에서 1줄 선택시 박리대상 추가 / 2: 박리대상 완료 체크시 / 3: 박리대상 에서 내용 수정시 / 4: 박리대상 에서 제외(공급의뢰서 에서 다시 선택시)
		try{
			var id = seSawonid;
			var t_val = "";
			var save_data = "";
			$(".input-field, .input-number, .input-readonly").each(function(){
				if($(this).attr("type") == "text" || $(this).attr("type") == "date" || $(this).attr("type") == "hidden" || $(this).attr("type") == "textarea"){
					t_val = $(this).val();
                }else if($(this).attr("type") == "checkbox"){
                    t_val = $(this).is(":checked") == true ? 1 : 0;
                }else if($(this).attr("type") == "select-one"){
                    t_val = $(this).val() == null ? 0 : $(this).val();
                };
				save_data += ", '" + t_val + "'";
			});

			if(order == 1){
				save_data += ", '" + p_item + "', '" + p_color + "', '" + p_size + "', '" + p_item_lot + "', " + p_cnt + ", " + p_Gcnt + ", 0, 0, '', '', 0";
			}else if(order == 2 || order == 3 || order == 4 || order == 5 || order == 6){
				save_data += ", '" + p_item + "', '" + p_color + "', '" + p_size + "', '" + p_item_lot + "', " + p_cnt + ", " + p_Gcnt + ", " + Pcnt + ", " + Wcnt + ", '" + p_date + "', '" + p_remark + "', 0";
			};
			// console.log("EXEC [AA_WORKDIARY_박리] '" + id + "'" + save_data + ", '" + p_ID + "', " + order);
			var insert = Get_Json("EXEC [AA_WORKDIARY_박리] '" + id + "'" + save_data + ", '" + p_ID + "', " + order);
			if(insert[0].VALID == 0){
				if(insert[0].RETURN_INPUT != ""){
                    dontFocus = 1;      // 자동완성 화살표 트리거만 작동하도록 작업
					alert(insert[0].MSG);
					$("#" + insert[0].RETURN_INPUT).focus();
				}else{
					alert(insert[0].MSG);
				};
				return false;
			}else if(insert[0].VALID == 1){
				$("#작업시작시간").val(insert[0].작업시작시간);
				$("#작업종료시간").val(insert[0].작업종료시간);
				$("#작업시간").val(insert[0].작업시간);

				// 공용 변수 비우기
				p_item = "";			// 품명
				p_color = "";			// 칼라
				p_size = "";			// 사이즈
				p_item_lot = "";		// 로트번호
				p_cnt = 0;				// 생산수량
				p_Gcnt = 0;				// 숙성
				p_chk = "";				// 선택(공급의뢰)
				p_ID = "";				// key 값

				Pcnt = 0;				// 박리
				Wcnt = 0;				// 보류
				WGcnt = 0;				// 박리대기
				p_date = "";			// 박리일자
				p_remark = "";			// 비고
				return true;
			};
		}catch(err){
			alert(err.message);
		};
	};		// 한줄씩 저장 end

    // ------------------------------------------------------------------------
    // 검색어 입력 자동완성 sql
    // ------------------------------------------------------------------------
	function data_find(id){
		try{
			var t_sql = "EXEC AA_WORKDIARY_Search '', '박리작업창고', ''";
			var find_rst = "";
			var find_data_array = new Array();
			find_rst = Get_Json(t_sql);
			find_data_array[id] = find_rst;
			if(find_rst["FND_DATA"] == "" || find_rst[0]["FND_DATA"] == " "){
				find_data_array.push("조회 내용이 없습니다. 다음으로 넘어가기");
			}else{
                for(var i in find_rst){
                    find_data_array.push(find_rst[i]["FND_DATA"]);
                };
			};
			autocomplete_abc(find_data_array, id);
		}catch(err){
			alert(err.message);
		};
	};		// 검색어 입력 자동완성 sql end

    // ------------------------------------------------------------------------
    // 자동완성 전체 구문
    // ------------------------------------------------------------------------
	function autocomplete_abc(find_data_array, id){
		try{
			$("#" + id).autocomplete({
				source : find_data_array,
				select : function(event, ui){
					$("#" + id).val(ui.item.value);
					init_disp();
					SUPPLY_DISP();
                    var t_this = this;
                    setTimeout(function(){
                        move_next(t_this);
                    }, 100);
				},
				focus : function(event, ui){
					return false;
				},
				minLength : 0,
				// autoFocus : true,
				classes : {
					"ui-autocomplete" : "highlight"
				},
				disable : false,
				position : {
					my : "left top",
					at : "left bottom",
					collision : "flip"
				}
			}).focus(function(){
                // $(this).autocomplete("search", $(this).val());    //  focus시 바로 검색창이 ON   트리거로 아래방향키 누르는것 추가 같이 있으면 autoFocus 가 버그걸려서 포커스 사라짐
			});
		}catch(err){
			alert(err.message);
		};
	};		// 자동완성 전체 구문 end

    // ------------------------------------------------------------------------
    // 다음칸 이동
    // ------------------------------------------------------------------------
    function move_next(ctl){
        try{
            var inputs = $(ctl).closest("body").find(".input_tag:visible");
            for(i = 1; i < 50; i++){
                var next = inputs.eq(inputs.index(ctl)+ i)
                if(next.prop("readonly") == false){
                    next.focus().click();
                    return;
                };
            };
        }catch(err){
            alert(err.message);
        };
    };    //  다음칸 이동 end

    // ------------------------------------------------------------------------
    // 지금 시간 구하기
    // ------------------------------------------------------------------------
    function getTime(){
        var date = new Date();
        var hours = ('0' + date.getHours()).slice(-2);
        var minutes = ('0' + date.getMinutes()).slice(-2);
        var timeString = hours + ':' + minutes;
        return timeString;
    };    //  지금 시간 구하기 end

    // ------------------------------------------------------------------------
    // 오늘 날짜
    // ------------------------------------------------------------------------
    function getDay(){
        var offset = new Date().getTimezoneOffset() * 60000;        // getTimezoneOffset() = 현재 시간과의 차이를 분단위로 반환하기 때문에 1000(밀리초) * 60(초) 로 계산하여 밀리초 단위로 계산
        // var date = new Date()       // toISOString() 할시 국제표준시로 변환 되기 때문에 getTimezoneOffset과 계산
        var date = new Date(Date.now() - offset);       // toISOString() 하기 전 국제표준시와 한국 시차 만큼 값 추가하기
        var day = date.toISOString().substring(0, 10);      // 날자값만 남기기
        return day;
    };    //  오늘 날짜 end


</script>

<head>

<body>

	<div class="Topbtn">
		<div id="title_bar">
			<img id="title_bar_img" src="../image/title/title2.png">
			<p id="t_header">박리작업일지</p>
		</div>

		<table class="searchDate">
			<tr>
				<th class="th_search_01">
					<label class="label_tag">제품생산일</label>
				</th>
				<td class="td_search_01">
					<input type="text" id="조회일자" class="input_tag datepicker">
				</td>
				<td class="th_search_01">
					<label class="label_tag">부터</label>
				</td>
			</tr>
		</table>

		<button id="작업시작" class="btn btn_02">
			<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-play-fill" viewBox="0 0 12 12">
				<path d="m11.596 8.697-6.363 3.692c-.54.313-1.233-.066-1.233-.697V4.308c0-.63.692-1.01 1.233-.696l6.363 3.692a.802.802 0 0 1 0 1.393z"/>
			</svg>
			<i class="bi bi-play-fill"></i>
			작업시작
		</button>
		<button id="작업종료" class="btn btn_02 btn_02_2">
			<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-stop-fill" viewBox="0 0 12 12">
				<path d="M5 3.5h6A1.5 1.5 0 0 1 12.5 5v6a1.5 1.5 0 0 1-1.5 1.5H5A1.5 1.5 0 0 1 3.5 11V5A1.5 1.5 0 0 1 5 3.5z"/>
			</svg>
			<i class="bi bi-stop-fill"></i>
			작업종료
		</button>
		<button id="취소" class="btn btn_03" onclick="self.close();">
			취소
		</button>

	</div>

	<div class="bottom">
		<div class="date_insert">
            <table class="date">
                <tr>
                    <th class="th_01">
                        <label class="label_tag">작업일자</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="작업일자" class="input_tag input_tag_date datepicker input-field input_tag_date input_tag_readonly_01" autocomplete="off" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">작업시간</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="작업시간" class="input_tag input-field" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">창고명</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="창고명" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">작업자</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="작업자" class="input_tag input_tag_readonly_01 input_tag_end_01 input-field" tabindex="-1" readonly>
                    </td>
                </tr>
            </table>
		</div>

        <div class="div_forHeadList">
            <table id="table_forHeadList" class="table_forHeadList">
                <thead id="forHeadList_header" class="forHeadList_header">
                    <tr id="supply_header_01">
                        <th class="th_table_01" style="width: 3%">
                            No<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 12%">
                            품명<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 15%">
                            칼라<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 7%">
                            사이즈<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 10%">
                            로트번호<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 6%">
                            생산수량<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 6%">
                            숙성<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 6%">
                            박리<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 6%">
                            보류<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 9%">
                            박리일자<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 14%">
                            비고<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 6%">
                            완료<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                    </tr>
                </thead>
                
                <tbody id="forHeadList_body" class="forHeadList_body">
                </tbody>
            </table>
        </div>

        <div class="div_forBodyList">
            <table id="table_forBodyList" class="table_forBodyList">
                <thead id="forBodyList_header" class="forBodyList_header">
                    <tr id="supply_header_02">
                        <th class="th_table_01" style="width: 8%">
                            생산일자<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 7%">
                            창고명<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 7%">
                            장비구분<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 7%">
                            담당자<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 12%">
                            품명<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 16%">
                            칼라<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 9%">
                            사이즈<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 10%">
                            로트번호<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 8%">
                            생산수량<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 8%">
                            숙성<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 8%">
                            박리대기<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                    </tr>
                </thead>
                
                <tbody id="forBodyList_body" class="forBodyList_body">
                </tbody>
            </table>
        </div>

	</div>
 
<input type="hidden" id="작업시작시간" class="input-field">
<input type="hidden" id="작업종료시간" class="input-field">
<input type="hidden" id="IP_Address" class="input-field">

</body>

</html>