<!--#include virtual="N_MAIN/global.asp" -->
<!DOCTYPE html>
<html>
<%
call vFunChkSession(2)	'세션체크 및 중복사용자체크     함수위치: /INCLUDE/function.asp
  Response.CharSet="UTF-8"
  Session.Codepage="65001"
  Response.Codepage="65001"
  Response.ContentType="text/html;charset=utf-8"
' ========================================================================================================
' WorkDiary_compression.asp
' WorkDiary_BP.asp  KYJ

Dim junID , P_Lot_NO
junID = request("junID")
P_Lot_NO = request("P_Lot_NO")

%>

<head>
<meta charset="utf-8">
<title>작업일지등록(분단)</title>
<!-- 내부문서 참조 -->
<script src="../../N_Main/jQuery/jquery-1.12.4.min.js"></script>
<script src="../../N_Main/jQuery/jquery-ui.js"></script>
<script type="text/javascript" src="../erp_func/common_func.js?230103a"></script>
<script type="text/javascript" src="../../N_CSS/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="../../N_CSS/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="../../IncJquery/jquery-ui.min.css">
<!-- datepicker -->

<link rel="stylesheet" type="text/css" href="../../N_CSS/datepicker2.css" />

<style>
    /* 전체 영역 */
    html, body { width: 99.5%; margin: 5px 5px 5px 5px;  }

    /* 버튼 */
    .btn{ width: 100px; height: 60px; background-color: #337ab7; color: #fff; float: left; font-size: 16px; border-radius: 0px; text-align: center; vertical-align: auto;  }  
    .btn_01{ width: 118px; height: 40px; border-radius: 3px; margin: 30px 0.5% 10px 4%; line-height: 30px;  }
    .btn_01_2{ height: 40px; border-radius: 3px; margin: 30px 1% 10px 0px;  }
    .btn_02{ width: 118px; border-radius: 3px; margin: 10px 0.5% 10px 0px;  }
    .btn_02_2{ border-radius: 3px; margin: 10px 3% 10px 0px;  }
    .btn_03{ border-radius: 3px; background-color: #FF0000; float: none; clear: right; margin: 10px 0% 10px 0px; line-height: 50px; font-size: 18px; font-weight: bold; color: #fff;  }
    .btn_01:hover { color: white; background-color: #195E9B; cursor: pointer;  }
    .btn_02:hover { color: white; background-color: #195E9B; cursor: pointer;  }
    .btn_03:hover { color: #fff; background-color: #FF8080; cursor: pointer;  }  
    .btn_01:disabled { color: white; background-color: #195E9B; cursor: pointer;  }
    .btn_02:disabled { color: white; background-color: #195E9B; cursor: pointer;  }
    .btn_03:disabled { color: #fff; background-color: #FF8080; cursor: pointer;  }
    .btn_add { position: absolute; border: none; margin: 4px 4px 4px 4px; color: #fff; left: 80%; top: 450px; background-color: tomato;  }

    /* 각 구역 나누기 / 구역별 css 작업 */
    .TopBtn{ height: 100px; margin: 0px 0px 5px 0px; padding: 10px 0px 0px 0px; background-color: #dff0ed;  }
    .bottom{ width: 100%;  }

    .searchDate{ width: 20%; height: 30px; float: left; margin: 30px 1% 0px 0px;  }
    .searchDate label{ border: 1px solid #195E9B; background-color: #0EBDDD; color: #fff; margin: 0px 2px 0px 0px;  }
    .searchDate input{ border: 1px solid #195E9B; text-align: center;  }

    .date_insert{ width: 100%; height: 40px; max-height: 40px; margin: 0px 0px 5px 0px;  }
    .date{ border-collapse: collapse; width: 100%; background-color: #FCEED6;  }
    .date label{ display: block; border: 1px solid #f0bd5e; background-color: #FCEED6;  }
    .date input{ border: 1px solid #f0bd5e; text-align: center;  }

    .item_insert{ width: 100%; height: 120px; max-height: 130px; margin: 0px 0px 5px 0px;  }
    .item{ border-collapse: collapse; width: 100%; background-color: #F8DCB3;  }
    .item label{ display: block; border: 1px solid #eea236; background-color: #F8DCB3;  }
    .item input{ border: 1px solid #eea236;  }

    .machine_insert{ width: 100%; margin: 0px 0px 5px 0px;  }
    .machine{ border-collapse: collapse; width: 100%; background-color: #BEDFDB;  }
    .machine label{ display: block; border: 1px solid #5e93c2; background-color: #BEDFDB;  }
    .machine input{ border: 1px solid #5e93c2;  }

    /* 의뢰서 조회 */
    .div_forList{ width: 100%; height: 350px; margin: 0px 0px 0px 0px;  }
    .table_forList{ width: 100%; border-collapse: collapse; border-top: 1px solid #195E9B; width: 100%; overflow-y:auto;  }
    .table_forList tr{ display: table; box-sizing: border-box;  }
    .table_forList th{ word-break: break-all; border-left: 1px solid #195E9B;  }
    .table_forList th:first-child{ border-left: none;  }
    .table_forList td{ word-break: break-all; border-left: 1px solid #195E9B;  }
    .table_forList td:first-child{ border-left: none;  }
    .forList_header{ display: table; width: 100%; border-bottom: 1px solid #195E9B; line-height: 34px; vertical-align: middle; background-color: #0EBDDD; color: #fff;  }
    .forList_header tr{ width: 100%;  }
    .forList_body{ display: block; width: auto; max-height: 300px; overflow-y: auto; font-size: 13pt;  }
    .forList_body tr{ width: 100%; border-bottom: 1px solid #195E9B; height: 30px; text-align: center;  }
    .forList_body tr:nth-child(2n+1){ background-color: #fff;  }
    .forList_body tr:nth-child(2n){ background-color: #eee;  }

    /* 조회 정렬시 아이콘 */
    .ui-icon { zoom: 200%; margin-top: 1px; position: absolute; display: none; background-image: url("../IncJquery/images/ui-icons_ffffff_256x240.png");  }
    
    /* title */
    #title_bar{ float: left; width:22%; height:60px; margin: 5px 9% 0px 2%; vertical-align: auto; position: relative; background-size: 100%, 42px; background-position: center; background-repeat: no-repeat;  }
    #title_bar_img{ width: 100%; height: 100%;  }
    #t_header{ width: 100%; font-size: 18pt; font-weight: bold; font-family: Noto Sans KR; margin: 0px; color:white; text-align:center; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); letter-spacing: 2.5px;  }

    /* tr 태그 */
    .tr_disable_01{ display: table-row;  }
    .tr_disable_01 label{ background-color: #E6E4DA;  }

    /* th 태그 */
    .th_01{ box-sizing: border-box; width: 7.5%; height: 40px; font-size: 13pt; border-spacing: 0px; text-align: center;  }
    .th_table_01{ box-sizing: border-box; text-align: center;  }
    .th_search_01{ box-sizing: border-box; width: 22%; height: 40px; font-size: 13pt; border-spacing: 0px; text-align: center;  }

    /* td 태그 */
    .td_01{ box-sizing: border-box; width: 17.5%; height: 40px; font-size: 13pt; border-spacing: 0px;  }
    .td_search_01{ box-sizing: border-box; width: 48%; height: 40px; font-size: 13pt; border-spacing: 0px;  }
    .td_insertCount_01{ width: 8.75%;  }
    .td_insertCount_02{ width: 8.75%;  }
    .td_length_01{ width: 12.5%;  }
    .td_length_02{ width: 5%;  }

    /* label */
    label{ display: block; border-radius: 3px; color: #000000; height: 34px; max-height: 34px; line-height: 34px; text-align: center; vertical-align: middle; font-weight: bold; white-space: nowrap; margin: 0px;  }
    .label_tag_2row{ height: 74px; max-height: 74px; line-height: 74px;  }

    /* input 태그 */
    input{ border-radius: 3px; background-color: #ffffff;  }
    input:focus{ border: 2px solid #f00; outline: none; }
    input:disabled{ color: #999;  }
    .input_tag{ width: 95%; height: 34px; max-height: 34px; line-height: 34px; vertical-align: middle; font-size: 13pt; border: 0; margin: 0px 1% 0px 2%;  }
    .input_tag_insertCount_01{ width: 96%; margin: 0px 1% 0px 4.2%;  }
    .input_tag_insertCount_02{ width: 90%; margin: 0px 1% 0px 4%;  }
    .input_tag_length_01{ width: 96%;  }
    .input_tag_length_02{ width: 80%;  }
    .input_remark_01{ width: 98.7%;  }
    .input_tag_date{ width: 95%; height: 34px; max-height: 34px; margin: 0px 1% 0px 2%; text-align: center;  }
    .input-number{ text-align: center;  }
    .input_tag_readonly_01{ background-color: #eee; pointer-events: none;  }  
    .input_tag_end_01{ width: 98%;  }

    /* textarea */
    .input_tag_Lremark_01{ width: 99.3%; height: 74px; font-size: 13pt; border: 0; border-radius: 3px; margin: 4px 0.1% 0px 0px; padding: 0px;  }

    /* span */
    span{ line-height: 34px; text-align: center; vertical-align: middle;  }

    /* autocomplete */
    .autocomplete > div.active{ background: #333; color: #eee;  }
    .ui-autocomplete{ max-height: 300px; overflow-y: auto; overflow-x: hidden;  }
    html .ui-autocomplete{ font-size: 16px; font-family: Noto Sans KR;  }
    .ui-menu-item-wrapper{ height: 40px; line-height: 30px; vertical-align: middle;  }
    .ui-state-active{ margin: 0px !important;  }
    
    /* 분단 길이/수량 가리기 */
    #insertTable tr:nth-child(n+6) { display: none;  }

    /* datepicker */
    .datepicker{ text-align: center;  }

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

    $(document).ready(function(){
        try{
            // ------------------------------------------------------------------------
            // 초기 데이터 설정
            // ------------------------------------------------------------------------
            window.focus();
            $("#IP_Address").val(IP_Address);
            // 로트번호 검색시 사용할 전역 변수 선언
            G_LotID = "";

            //  작업 종료된 작업일지 호출시 사용하는 번호
            var prk = "<%=junID%>";

            if(seSawonid == ""){        //  부모 창에서 정보 유지중인지 확인
                alert("로그인 상태를 다시 확인해 주세요.");
                self.close();
            }else if(prk != ""){
                //  데이터불러오기
                init_disp(prk);     //  번호 같이 전달

                //  기초 데이터
                $("#작업취소").attr("disabled", true);
                $("#작업시작").attr("disabled", true);
                $("#작업수정").css("display","inline");     //  수정 할수있도록 작업수정 버튼 보이게
                $("#작업종료").attr("disabled", true);
                $("#아이템로트번호").val("<%=P_Lot_NO%>");
                $(".btn_02_2").css("margin", "10px 2% 10px 0px");
                setTag();
            }else if(prk == ""){
                //  기초 데이터
                $("#작업수정").css("display","none");
                $(".btn_01_2").css("margin", "30px 4% 10px 0px");
                $("#작업일자").val(getDay());
                $("#작업일자").attr("min", getDay());       //  달력에서 이전 일자 선택 불가능하도록
                $("#작업일자").attr("max", getDay());       //  달력에서 이후 일자 선택 불가능하도록
                var date = new Date();
                // date.setDate(date.getDate() - 7);       //  7일전 날짜 계산
                // var oneWeekAgo = date.toISOString().substring(0, 10);       //  계산 된 날짜 YYYY-MM-DD 형으로 변환 변수에 안담고 바로 val() 해도 무관
                var oneWeekAgo = get_add_date_yyyymmdd('dd', -7);       // 7일 전 날짜 계산
                $("#조회일자").val(oneWeekAgo);
                $("#작업자").val(seSawonname);
                $("#창고명").val(defaultStocName);

                //  미완료 데이터 확인
                var work_id = work_check($("#창고명").val(), $("#작업일자").val(), $("#작업자").val());     //  창고명, 작업일자, 작업자 파라메타로 전달

                //  미완료 데이터에 따라 진행중상태 혹은 새로 진행할지 준비
                if(work_id != ""){      //  미완료 데이터가 있음으로 작업진행상태
                    remain_disp(work_id);       //  진행중인 workid 파라메타로 전달
                    prk = 1;        //  시작 포커스 지정하지 않도록 prk 1로 설정 prk 찾아가면 이유 알수있음
                    $("#작업시작").attr("disabled", true);
                    //  진행중인작업에 추가한 tr태그 있을경우 추가하도록
                    setTag();
                    //  PAD로 전송한 내역인 경우 수정 불가능하도록 처리
                    var PDA_rst = Get_Json("EXEC RF_PDA_CRE_WORKDIARY_CHECK 1, '분단', '" + work_id + "'");
                    PDA_rst_length = PDA_rst.length
                    if(PDA_rst[0].RF분단투입ID == "" || PDA_rst[0].RF분단투입ID == " "){
                        PDA_rst_length = 0;
                    }else{
                        $("#t_header").text($("#t_header").text() + "(PDA작업)");
                        $("#투입롤길이, #투입롤수량, #아이템로트번호,#투입롤길이2, #투입롤수량2, #아이템로트번호2, #투입롤길이3, #투입롤수량3, #아이템로트번호3").prop("readonly", true);
                        $("#투입롤길이, #투입롤수량, #아이템로트번호,#투입롤길이2, #투입롤수량2, #아이템로트번호2, #투입롤길이3, #투입롤수량3, #아이템로트번호3").addClass("input_tag_readonly_01");
                        $("#창고명, #분단기, #품명, #칼라, #사이즈").prop("readonly", true);
                        $("#창고명, #분단기, #품명, #칼라, #사이즈").addClass("input_tag_readonly_01");
                        PDA_rst_length = 1;     //  autocomplete 작동 안되게
                    };
                }else{      //  미완료 데이터 없음으로 작업시작준비
                    $("#작업종료").attr("disabled", true);
                };
            };    //  초기 데이터 설정 end

            // ------------------------------------------------------------------------
            // 작업시작 버튼 클릭
            // ------------------------------------------------------------------------
            $("#작업시작").on("click", function(){
                if(save() == true){
                    $("#작업시작").attr("disabled", true);
                    $("#작업종료").attr("disabled", false);
                    $("#불량구분1").val("01:정상");
                };
            });   //  작업시작 버튼 end

            // ------------------------------------------------------------------------
            // 작업취소 버튼 클릭
            // ------------------------------------------------------------------------
            $("#작업취소").on("click", function(){
                if(confirm("정말 취소하시겠습니까 ?") == true){
                    if($("#작업시작시간").val() == ""){
                        alert("작업이 시작되었는지 다시 확인해주세요.");
                    }else{
                        var wareHouse = $("#창고명").val();
                        var delSawonName = $("#작업자").val();
                        var delGubun = 4;         //  1 : 압출, 2 : 합포, 3 : 코팅, 4 : 분단, 5 : 재단
                        var delWorkId = $("#WorkID").val();
                        var rst = Get_Json("EXEC RF_BUN_PDA_RF분단투입_ERP_CLEAR '" + delSawonName   + "', '" + delGubun + "', '" + delWorkId + "'");
                        alert(rst[0].MSG);
                        location.reload();
                    };
                };
            });   //  작업취소 버튼 end

            // ------------------------------------------------------------------------
            // 작업종료 버튼 클릭
            // ------------------------------------------------------------------------
            $("#작업종료").on("click", function(){
                if(save() == true){
                    alert("저장되었습니다.");
                    opener.main_bind();
                    self.close();
                    };
            });   //  작업종료 버튼 end

            // ------------------------------------------------------------------------
            // 작업수정 버튼 클릭
            // ------------------------------------------------------------------------
            $("#작업수정").on("click", function(){
                $(".input-field, .input-number").attr("disabled", false);
                $("#작업종료").attr("disabled", false);
                $("#작업수정").attr("disabled", true);
                //  PAD로 전송한 내역인 경우 수정 불가능하도록 처리
                var PDA_rst = Get_Json("EXEC RF_PDA_CRE_WORKDIARY_CHECK 1, '분단', '" + work_id + "'");
                PDA_rst_length = PDA_rst.length
                if(PDA_rst[0].RF분단투입ID == "" || PDA_rst[0].RF분단투입ID == " "){
                    PDA_rst_length = 0;
                }else{
                    $("#t_header").text($("#t_header").text() + "(PDA작업)");
                    $("#투입롤길이, #투입롤수량, #아이템로트번호,#투입롤길이2, #투입롤수량2, #아이템로트번호2, #투입롤길이3, #투입롤수량3, #아이템로트번호3").pro("readonly", true);
                    $("#투입롤길이, #투입롤수량, #아이템로트번호,#투입롤길이2, #투입롤수량2, #아이템로트번호2, #투입롤길이3, #투입롤수량3, #아이템로트번호3").addClass("input_tag_readonly_01");
                    $("#창고명, #분단기, #품명, #칼라, #사이즈").pro("readonly", true);
                    $("#창고명, #분단기, #품명, #칼라, #사이즈").addClass("input_tag_readonly_01");
                    PDA_rst_length = 1;     //  autocomplete 작동 안되게
                };
                //  진행중인작업에 추가한 tr태그 있을경우 추가하도록
                setTag();

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
            // class input-number 항목 숫자만 입력하도록 적용
            // ------------------------------------------------------------------------
            $(".input-number").on("blur keyup", function(){
                // var regex = /[^0-9]/gi;    //  숫자빼곤 입력 안됨 .도안됨
                var regex = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣|aA-zZ]/gi;     //  한글 영어만 막기
                $(this).val($(this).val().replace(regex, ""));
            });   //  숫자만 입력 end

            // ------------------------------------------------------------------------
            // autocomplete 품명 검색 페이지 로드시 바로실행
            // ------------------------------------------------------------------------
            item_sql = "";      // 아이템 레코드셋 전역변수
            var item_json = Get_Json_common_direct("EXEC [AA_WORKDIARY_Search2] '', '품명', ''");       // json 형변환 하여 가져오는 품명 전용 검색 sql
            // 완료후 Get_Json_After 함수가 실행되고 그때 item_sql 에 데이터 들어감

            // ------------------------------------------------------------------------
            // input-auto 포커스시 실행 아래방향키 트리거 작동으로 검색 목록 펼치기 / autocomplete 실행
            // ------------------------------------------------------------------------
            $(".input-auto").on("focus", function(){
                if(dontFocus == 0){
                    data_find(this.id, item_sql);       //  자동완성 실행
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
                if(this.id == "창고명" || this.id == "분단기"){     // 오토포커스 지우고 이거 추가함
                    return;
                }else{
                    $(this).trigger(e);
                };
            });   //  아래방향키 트리거 end
            
            $("#창고명, #분단기").on("focus", function(){      // 이걸해야 입력값과 상관없이 검색어 창을 보여주는데 그러면 autoFocus가 고장남...
                $(this).autocomplete("search", "");             // 그래서 autoFocus 지우고 트리거로 autoFocus 대신 추가 작성함
            });
            
            // ------------------------------------------------------------------------
            // 조회
            // ------------------------------------------------------------------------
            $("#조회일자").on("change", function(){
				if(jFuncDateValid(this) == true){
					SUPPLY_DISP();
				}else{
					$("#조회일자").val(oneWeekAgo);
					return false;
				};
            });     //  조회 end
            
            // ------------------------------------------------------------------------
            // 조회 내용 선택
            // ------------------------------------------------------------------------
            $("#forList_body").on("click", "tr", function(){
                //  목적은 이해하였으나 이를 제어하는 V 기능이 없음 원문에 있어서 가져옴
                $("#table_forList tbody tr").each(function(){
                    if(checkEven($(this).index() + 1) == true){     //  index에 맞춰서 홀수열 짝수열 구분
                        $("td", this).css("background", "#eee");
                        // $("td", this).css("color", "#000");
                    }else{
                        $("td", this).css("background", "#fff");
                        // $("td", this).css("color", "#000");
                    };
                });
                var chk = $("td:eq(4)", this).text();
                if(chk == "" || chk === "●"){       //  조회 내용 상단에 자동 작성
                    $("#품명").val($("td:eq(6)", this).text());
                    $("#칼라").val($("td:eq(7)", this).text());
                    $("#사이즈").val($("td:eq(8)", this).text());
                    $("#투입롤길이").val($("td:eq(9)", this).text());
                    $("#투입롤수량").val(1);
                    sum();
                    $("#아이템로트번호").val($("td:eq(10)", this).text());
                    $("#입고전표ID").val($("td:eq(12)", this).text());
                    $("td", this).css("background-color", "#DBD6E8");
                };
            });     //  조회 내용 선택 end
            
            // ------------------------------------------------------------------------
            // 조회 내용 헤더 클릭으로 정렬
            // ------------------------------------------------------------------------
            $("#table_forList").on("click", "th", function(){
                var regex = /[^ㄱ-ㅎ|ㅏ-ㅣ|가-힣|aA-zZ]/gi;     //  한글 영어만 입력
                var sort_kind = $(this).text().replace(regex, "");      //  그냥 $(this).text() 시 공백등 다른 문자가 있어 replace로 한글만 남기기
                console.log(sort_kind);
                if(sort_kind == "선택"){
                    return;
                };
                $("#supply_header > th span").each(function(){      //  this가 아닌경우 display none로 아이콘 지우기
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
            // 투입총수량 자동계산 함수실행
            // ------------------------------------------------------------------------
            $(".auto_sum_01").on("change", function(){
                sum();
            });     //  투입총수량 자동계산 함수실행 end

            // ------------------------------------------------------------------------
            // 분단총수량 자동계산
            // ------------------------------------------------------------------------
            $(".auto_sum_02").on("change", function(){
                var sum = 0;
                for(i = 1; i < 11; i++){
                    $("#분단수량" + i).val(parseInt($("#분단롤길이" + i).val() == "" ? 0 : $("#분단롤길이" + i).val()) * parseInt($("#분단롤수량" + i).val() == "" ? 0 : $("#분단롤수량" + i).val()));
                    sum += parseInt($("#분단수량" + i).val());
                };
                $("#분단총수량").val(sum);
            });     //  분단총수량 자동계산

            // ------------------------------------------------------------------------	
            // 시작시 포커스
            // ------------------------------------------------------------------------	
            if(prk + "" == ""){     //  불러올 작업이 없을때만 실행되는것이나 마찬가지
                $("#창고명").focus();
            };    //  시작시 포커스 end

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
					$(this).val(getDay());
					$(this).focus();
					return;
				};
			});		// 입력값 확인



        }catch(err){
            alert(err.message);
        };    //  catch end
    });     //  document.reaty end

    // ------------------------------------------------------------------------
    // 읽기전용 데이터 불러오기
    // ------------------------------------------------------------------------
    function init_disp(id){
        try{
            var rst = Get_Json("B_WORK_LST_BUN 'G_WorkDiary_분단', " + id);
            if(rst[0].WorkID == "" || rst[0].WorkID == " " || rst[0].WorkID == null){
                alert("작업일지가 등록되지 않았습니다.");
                self.close();
            }else{
                $("#WorkID").val(rst[0].WorkID);
                $("#창고명").val(rst[0].창고명);
                $(".input-field, .input-number").each(function(){
                    $(this).attr("disabled", true);      //  읽기 전용으로 불러오기
                    if($(this).attr("type") == "text" || $(this).attr("type") == "date" || $(this).attr("type") == "textarea" || $(this).attr("type") == "hidden"){
                        var field = rst[0][this.id] + "";
                        field = ((field == 0 || field == "null") ? "" : field);
                        if(this.id == "작업일자"){
                            $("#" + this.id).val(field.substring(0, 10));       //  db에 저장된 작업일자에 시간값 제거
                        }else{
                            $("#" + this.id).val(field);
                        };
                    }else if($(this).attr("type") == "checkbox"){
                        $("input:checkbox[id='" + this.id + "']").prop("checked", rst[0][this.id]);
                    };
                });
            };
        }catch(err){
            alert(err.message);
            self.close();
        };
    };    // 읽기전용 데이터 end

    // ------------------------------------------------------------------------
    //  당일 미완료 작업일지 번호 호출
    // ------------------------------------------------------------------------
    function work_check(war_name ,work_date, worker){
        try{
            var rst = Get_Json("B_WORK_CHECK 'G_WorkDiary_분단', '" + war_name + "', '" + work_date + "', '" + worker + "'");

            if(rst[0].WORKID != " "){       //  WORKID 가 있는지 없는지 확인
                var valid = rst[0].WORKID + "";
            }else{
                valid = "";
            };
            return valid;
        }catch(err){
            alert(err.message);
        };
    };    //  당일 미완료 작업일지 번호 end

    // ------------------------------------------------------------------------
    // 미완료 작업일지 불러오기
    // ------------------------------------------------------------------------
    function remain_disp(id){
        try{
            var rst = Get_Json("B_WORK_LST_REMAIN 'G_WorkDiary_분단'," + id);
            if(rst[0].WorkID != ""){
                $("#WorkID").val(rst[0].WorkID);
                $("#창고명").val(rst[0].창고명);
                $(".input-field, .input-number").each(function(){
                    if($(this).attr("type") == "text" || $(this).attr("type") == "date" || $(this).attr("type") == "textarea" || $(this).attr("type") == "hidden"){
                        var field = rst[0][this.id] + "";
                        field = ((field == 0 || field == "null") ? "" : field);
                        if(this.id == "작업일자"){
                            $("#" + this.id).val(field.substring(0, 10));       //  db에 저장된 작업일자에 시간값 제거
                        }else{
                            $("#" + this.id).val(field);
                        };
                    }else if($(this).attr("type") == "checkbox"){
                        $("input:checkbox[id='" + this.id + "']").prop("checked", rst[0][this.id]);
                    };
                });
            };
        }catch(err){
            alert(err.message);
        };
    };    // 미완료 작업일지 불러오기 end

    // ------------------------------------------------------------------------
    //  저장
    // ------------------------------------------------------------------------
    function save(){
        try{
            var id = seSawonid;
            var WorkID = $("#WorkID").val();
            var t_val = "";
            var save_data = "";
            var t_id = "";
            $('.input-field, .input-number, .input-readonly').each(function(){
                if($(this).attr("type") == "text" || $(this).attr("type") == "date" || $(this).attr("type") == "hidden" || $(this).attr("type") == "textarea"){
                    t_val = $(this).val();
                }else if($(this).attr("type") == "checkbox"){
                    t_val = $(this).is(":checked") == true ? 1 : 0;
                }else if($(this).attr("type") == "select-one"){
                    t_val = $(this).val() == null ? 0 : $(this).val();
                };
                save_data += ", '" + t_val + "'";
                t_id += ", '" + this.id + "'";
            });
            // console.log(t_id)
            // console.log("EXEC [AA_WORKDIARY_분단] '" + id + "', '" + WorkID + "'" + save_data)
            var insert = Get_Json("EXEC [AA_WORKDIARY_분단] '" + id + "', '" + WorkID + "'" + save_data);
            if(insert[0].VALID == 0){
                dontFocus = 1;      // 자동완성 화살표 트리거만 작동하도록 작업
                alert(insert[0].MSG);
                $("#" + insert[0].RETURN_INPUT).focus();
                return false;
            }else if(insert[0].VALID == 1){
                $("#작업시작시간").val(insert[0].작업시작시간);
                $("#작업종료시간").val(insert[0].작업종료시간);
                $("#작업시간").val(insert[0].작업시간);
                $("#WorkID").val(insert[0].WorkID);
                return true;
            };
        }catch(err){
            alert(err.message);
        };
    };    //  save end

    // ------------------------------------------------------------------------
    // 품명 autocomplete 전역변수 재 선언       // common_func.js 의 Get_Json_Done() 에서 작동됨
    // ------------------------------------------------------------------------
    function Get_Json_After(temp_rst){
        // console.log("Get_Json_After");
        item_json = temp_rst;
        // console.log(item_json);
        item_sql = item_json;
    };      // 품명 전역번수 재 선언 end
    
    // ------------------------------------------------------------------------
    // 로트번호 검색내용 가져온후 실행          // common_func.js 의 Get_Json_Done2() 에서 작동됨
    // ------------------------------------------------------------------------
    function Get_Json_After2(temp_rst){
        var t_find_data_array = new Array();
        if(temp_rst.length <= 1 && !temp_rst[0].valueOf() == "" ){        //  데이터가 없는경우 move_next 발동시키키위한 다음으로 넘어가기 삽입
            t_find_data_array.push("조회 내용이 없습니다. 다음으로 넘어가기");
        }else{
            for(var i in temp_rst){
                t_find_data_array.push(temp_rst[i]["FieldName"]);
            };
        };
        $("#"+ G_LotID).css("background-color", "#ffffff");
        autocomplete_dbc(t_find_data_array, G_LotID);
        // 로트번호의 경우 중간에 return 해서 따로 실행되기 때문에 트리거 재작성
        var e = $.Event("keydown", {        // autocomplete 완료시 검색내용 확장 되도록 아래방향키 트리거 만들기
            keyCode : 40         //  아래방향키 키코드 40   뒤에 세미콜론 붙이면 오류남
        });
        setTimeout(function(){      //  바로 실행시 autoFocus 버그로 인해 포커스 사라짐 setTimeout 설정시 버그 사라짐
            $("#" + G_LotID).trigger(e);        // 아래 방향키 트리거 작동
        }, 100);
    };

    // ------------------------------------------------------------------------
    // 검색어 입력 자동완성 sql
    // ------------------------------------------------------------------------
    function data_find(id, item_sql){
        try{
            var item = "";
            var t_sql = "";
            var gubun = "";
            if(id == "창고명" || id == "분단기" || id.includes("분단구분")){
				gubun = id == "창고명" ? "창고명" : id == "분단기" ? "분단기" : "분단구분"
                t_sql = "EXEC AA_WORKDIARY_Search '', '" + gubun + "', ''";
            }else if(id == "칼라"){
                if($("#품명").val() == ""){
                    dontFocus = 1;      // 자동완성 화살표 트리거만 작동하도록 작업
                    alert("품명을 입력해 주세요.");
                    $("#품명").focus();
                    return false;
                }else{
                    t_sql = "EXEC AA_WORKDIARY_Search '', '칼라', '" + $("#품명").val() + "'";
                };
            }else if(id == "사이즈"){
                if($("#품명").val() == ""){
                    dontFocus = 1;      // 자동완성 화살표 트리거만 작동하도록 작업
                    alert("품명을 입력해 주세요.");
                    $("#품명").focus();
                    return false;
                }else{
                    t_sql = "EXEC AA_WORKDIARY_Search '', '사이즈', '" + $("#품명").val() + "'";
                };
            }else if(id.includes("로트번호")){
                if($("#품명").val() == "" || $("#칼라").val() == "" || $("#사이즈").val() == ""){
                    dontFocus = 1;      // 자동완성 화살표 트리거만 작동하도록 작업
                    alert("투입품 입력 정보를 재확인 해주세요.");
                    var focus = $("#품명").val() == "" ? "칼라" : $("#투입칼라").val() == "" ? "사이즈" : size;
                    $("#" + focus).focus();
                    return false;
                }else{
                    t_sql = "EXEC [AA_WORKDIARY_LOTNO] '', '" + $("#작업자").val() + "', '" + $("#품명").val() + "', '" + $("#칼라").val() + "', '" + $("#사이즈").val() + "', '" + $("#창고명").val() + "'";
                };
            };
            var find_rst = "";
            var find_data_array = new Array();
            if(id == "품명"){
                find_rst = item_sql;
            }else if(id.includes("로트번호")){
                //Get_Json_Before() // 프로그래스바 실행
                $("#"+ id).css("background-color", "#eee");
                Get_Json_common_direct2(t_sql);
                G_LotID = id;
                // 가져오기완료후 Get_Json_After2 실행됨
                return;
            }else{
                find_rst = Get_Json(t_sql);
            };

            find_data_array[id] = find_rst;
            if(find_rst[0]["FND_DATA"] == "" | find_rst[0]["FND_DATA"] == " "){
                find_data_array.push("조회 내용이 없습니다. 다음으로 넘어가기");
                // return false;        // return 으로 예외처리를 해버리면 자동완성이 아예 작동하지 않음
            }else{
                for(var i in find_rst){
                    find_data_array.push(find_rst[i]["FND_DATA"]);
                };
            };
            autocomplete_dbc(find_data_array, id);
        }catch(err){
            alert(err.message);
            $("#품명").focus();
        };
    };    //  data_find end

    // ------------------------------------------------------------------------
    // 자동완성 전체 구문
    // ------------------------------------------------------------------------
    function autocomplete_dbc(find_data_array, id){
        try {
            $("#" + id).autocomplete({    // autocomplete 시작
                source : find_data_array,    //  자동완성에 넣을 자료
                select : function(event, ui){   //  자료 선택시 이벤트      $(this).val()은 이미 입력된 값을 작성하여 작동하게됨 선택하기 전의 값이 전달됨 / ui.item.value로 작성시 선택한 값으로 파라메타 전달
                    $("#" + id).val(ui.item.value);
                    if(this.id == "창고명"){
                        SUPPLY_DISP();
                    };
                    var t_this = this;
                    setTimeout(function(){
                        move_next(t_this);
                    }, 100);
                },
                focus : function(event, ui){    //  focus 시 이벤트    한글과 사용시 나머지가 사라지는 버그가 있다 ? 리턴펄스시 무시한다고함
                    return false;
                },
                change : function(event, ui){    //  change 시 이벤트
                    if(this.id == "품명"){       //  품명, 칼라, 사이즈 종류 입력시 입력내용 확인
                        if(autocom_valid("품명", $(this).val(), "") == "0"){
                            dontFocus = 1;      // 자동완성 화살표 트리거만 작동하도록 작업
                            $(this).val("");
                            $(this).focus();
                            return false;
                        };
                    };
                    if(this.id == "칼라"){
                        if(autocom_valid("칼라", $(this).val(), $("#품명").val()) == "0"){
                            dontFocus = 1;      // 자동완성 화살표 트리거만 작동하도록 작업
                            $(this).val("");
                            $(this).focus();
                            return false;
                        };
                    };
                    if(this.id == "사이즈"){
                        if(autocom_valid("사이즈", $(this).val(), $("#품명").val()) == "0"){
                            dontFocus = 1;      // 자동완성 화살표 트리거만 작동하도록 작업
                            $(this).val("");
                            $(this).focus();
                            return false;
                        };
                    };
                    if($(this).val().includes("다음으로")){       //  move_next 발동용 입력값 삭제
                        $(this).val("");
                    };
                },
                minLength : 0,    //  최소 글자 수
                // autoFocus : true,   //  true로 설정 시 첫 번째 항목에 자동 포커스
                classes : {   //  위젯 요소에 추가 할 클래스 지정
                    'ui-autocomplete' : 'highlight'
                },
                delay : 100,    //  작동 지연시간
                disable : false,    //  true 시 자동완성 기능 꺼짐
                position : {    //  위치
                    my : 'left top',
                    at : 'left bottom',
                    collision : "flip"      //  화면 어딘가와 충돌시 충돌하지 않는 방향으로 펼치기
                }
            }).focus(function(){
                // $(this).autocomplete("search", $(this).val());    //  focus시 바로 검색창이 ON   트리거로 아래방향키 누르는것 추가 같이 있으면 autoFocus 가 버그걸려서 포커스 사라짐
            });
        }catch(err){
            alert(err.message);
        };
    };    //  autocomplete_dbc end

    // ------------------------------------------------------------------------
    // 자동완성 valid check
    // ------------------------------------------------------------------------
    function autocom_valid(gubun, data, parm){
        try{
            var valid = "";
            var rst = Get_Json("EXEC B_autocom_valid '" + gubun + "', '" + data + "', '" + parm + "'");
            if(rst[0][""] == 0 || rst[0][""] == 1){
                valid = rst[0][""];
            };
            return valid;
        }catch(err){
            alert(err.message);
        };
    };    //  자동완성 valid check end

    // ------------------------------------------------------------------------
    // 의뢰서 조회
    // ------------------------------------------------------------------------
    function SUPPLY_DISP(sortName, sortOrder) {
        try{
            sortName = sortName == null ? "" : sortName == undefined ? "" : sortName;		//	sortName의 입력값 있는지 확인
            sortOrder = sortOrder == null ? "" : sortOrder == undefined ? "" : sortOrder;		//	sortOrder의 입력값 있는지 확인
            var rst = Get_Json("EXEC B_WORK_PROD_LST 1, '" + $("#창고명").val() + "', '" + $("#조회일자").val() + "', '" + sortName + "', '" + sortOrder + "'");
            var appendHTML = "";
            if(rst[0].생산일자 == "" || rst[0].생산일자 == " " || rst[0].생산일자 == null){       //  조회 내용이 없는 경우
                appendHTML += "<tr><td>조회 내용이 없습니다</td></tr>";
            }else{
                if(rst.length > 10){
                    for(i = 0; i < rst.length; i++){
                        appendHTML += '<tr><td style="width: 8%">' + rst[i].생산일자 + '</td><td style="width: 8%">' + rst[i].박리일자 + '</td><td style="width: 7%">' + rst[i].창고명 + '</td><td style="width: 7%">' + rst[i].담당자
                                + '</td><td class="select" style="width: 2%">' + rst[i].분단사용 + '</td><td style="width: 7%">' + rst[i].장비구분
                                + '</td><td style="width: 13%">'+ rst[i].품명 + '</td><td style="width: 13%">' + rst[i].칼라 + '</td><td style="width: 8%">' + rst[i].사이즈 + '</td><td class="number" style="width: 5%">' + rst[i].수량
                                + '</td><td style="width: 10%">' + rst[i].로트번호 + '</td><td style="width: 11.1%">' + rst[i].생산비고 + '</td><td style="display:none">' + rst[i].입고전표ID + '</td></tr>';
                    };
                }else{
                    for(i = 0; i < rst.length; i++){
                        appendHTML += '<tr><td style="width: 8%">' + rst[i].생산일자 + '</td><td style="width: 8%">' + rst[i].박리일자 + '</td><td style="width: 7%">' + rst[i].창고명 + '</td><td style="width: 7%">' + rst[i].담당자
                                + '</td><td class="select" style="width: 2%">' + rst[i].분단사용 + '</td><td style="width: 7%">' + rst[i].장비구분
                                + '</td><td style="width: 13%">'+ rst[i].품명 + '</td><td style="width: 13%">' + rst[i].칼라 + '</td><td style="width: 8%">' + rst[i].사이즈 + '</td><td class="number" style="width: 5%">' + rst[i].수량
                                + '</td><td style="width: 10%">' + rst[i].로트번호 + '</td><td style="width: 12%">' + rst[i].생산비고 + '</td><td style="display:none">' + rst[i].입고전표ID + '</td></tr>';
                    };
                };
            };
            $("#forList_body").empty();
            $("#forList_body").append(appendHTML);
        }catch(err){
            alert(err.message);
        };
    };      //  의뢰서 조회 end

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
    // 분단 길이 / 수량 항목 늘리기
    // ------------------------------------------------------------------------
    function showTrTag(){
        try{
            var int = parseInt($("#countAdd").val());       //  몇번째 값인지 저장하기 위한 히든값 start 6
            var top = parseInt($("#topInt").val());       //  top 위치 저장된 히든값 start 450
            var divHeight = parseInt($("#divHeight").val());        //  테이블 div height 히든값
            var tbodyHeight = parseInt($("#tbodyHeight").val());        //  테이블 tbody height 히든값
            if(int < 11){
                if (int > 5){        //  int 번째 tr 태그 display 속성 변경
                    $("#insertTable tr:nth-child(" + int + ")").css("display", "table-row");
                    $("#addInput").text("+" + (int + 1));
                    $(".btn_add").css("top", (top + 40) + "px");
                };
            }else{
                return;
            };
            if(int > 7){        //  테이블 늘어져서 전체 스크롤 생기는것 방지하기 위해 자체적인 크기 조절
                $(".div_forList").css("height", (divHeight - 40) + "px");
                $(".forList_body").css("height", (tbodyHeight - 40) + "px");
                $("#divHeight").val(parseInt($("#divHeight").val()) - 40);     //  히든값 숫자 - 40 처리
                $("#tbodyHeight").val(parseInt($("#tbodyHeight").val()) - 40);     //  히든값 숫자 - 40 처리
            };
            if(int == 10){      //  10 번째일경우 버튼 안보이게
                $("#addInput").hide();
                return;
            };
            $("#countAdd").val(parseInt($("#countAdd").val()) + 1);     //  히든값 숫자 + 1 처리
            $("#topInt").val(parseInt($("#topInt").val()) + 40);     //  히든값 숫자 + 40 처리
        }catch(err){
            alert(err.message);
        };
    };      //  분단 길이 / 수량 항목 늘리기 end

    // ------------------------------------------------------------------------
    // 분단 길이 / 수량 항목 데이트 있으면 바로 늘리기
    // ------------------------------------------------------------------------
    function setTag(){
        for(i = 6; i < 11; i++){
            if($("#분단롤길이" + i).val().length > 0){
                showTrTag();
            }else{
                return false;
            };
        };
    };
    

    // ------------------------------------------------------------------------
    // 투입총수량 함수
    // ------------------------------------------------------------------------
    function sum(){
        var roll_length = $("#투입롤길이").val() == "" ? 0 : $("#투입롤길이").val();
        var roll_cnt = $("#투입롤수량").val() == "" ? 0 : $("#투입롤수량").val();
        var roll_length2 = $("#투입롤길이2").val() == "" ? 0 : $("#투입롤길이2").val();
        var roll_cnt2 = $("#투입롤수량2").val() == "" ? 0 : $("#투입롤수량2").val();
        var roll_length3 = $("#투입롤길이3").val() == "" ? 0 : $("#투입롤길이3").val();
        var roll_cnt3 = $("#투입롤수량3").val() == "" ? 0 : $("#투입롤수량3").val();
        $("#투입총수량").val(parseInt(roll_length) * parseInt(roll_cnt) + parseInt(roll_length2) * parseInt(roll_cnt2) + parseInt(roll_length3) * parseInt(roll_cnt3));
    };      //  투입총수량 함수 end

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

    // ------------------------------------------------------------------------
    // 홀짝 구분하기
    // ------------------------------------------------------------------------
    function checkEven(num){        //  홀수가 들어오면 false 짝수가 들어오면 true
        return (num % 2 == 0);
    };      //  홀짝 구분하기 end



</script>

</head>

<body>
  
    <div class="TopBtn">
        <div id="title_bar">
            <img id="title_bar_img" src ="../image/title/title2.png">
            <p id="t_header">분단작업일지</p>
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

        <button id="새로고침" class="btn btn_01" onclick="location.reload();">
            <svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" fill="currentColor" class="bi bi-arrow-clockwise" viewBox="0 0 14 14">
                <path fill-rule="evenodd" d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2v1z"/>
                <path d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466z"/>
            </svg>
            <i class="bi bi-arrow-clockwise"></i>
            새로고침
        </button>
        <button id="작업취소" class="btn btn_01 btn_01_2">
            작업취소
        </button>
        <button id="작업수정" class="btn btn_02 btn_02_1">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-fill" viewBox="0 0 16 16">
                <path d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708l-3-3zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207l6.5-6.5zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.499.499 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11l.178-.178z"/>
            </svg>
            <i class="bi bi-pencil-fill"></i>
            작업수정
        </button>
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
                        <input type="text" id="작업일자" class="input_tag input-field datepicker" max="9999-12-31" min="1970-01-01" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">창고명</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="창고명" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">분단기</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단기" class="input_tag input-field input-auto" autocomplete="off">
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

        <div class="item_insert">
            <table class="item">
                <tr>
                    <th class="th_01">
                        <label class="label_tag">품명</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="품명" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">칼라</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="칼라" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">사이즈</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="사이즈" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">비고</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="투입비고" class="input_tag input_tag_end_01 input-field" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">투입길이/수량</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="투입롤길이" class="input_tag input_tag_insertCount_01 auto_sum_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="투입롤수량" class="input_tag input_tag_insertCount_02 auto_sum_01 input-number" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">로트번호</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="아이템로트번호" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">투입총수량</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="투입총수량" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">분단총수량</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단총수량" class="input_tag input_tag_readonly_01 input_tag_end_01 input-number" tabindex="-1" readonly>
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">투입길이/수량</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="투입롤길이2" class="input_tag input_tag_insertCount_01 auto_sum_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="투입롤수량2" class="input_tag input_tag_insertCount_02 auto_sum_01 input-number" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">로트번호</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="아이템로트번호2" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">투입길이/수량</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="투입롤길이3" class="input_tag input_tag_insertCount_01 auto_sum_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="투입롤수량3" class="input_tag input_tag_insertCount_02 auto_sum_01 input-number" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">로트번호</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="아이템로트번호3" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>
            </table>
        </div>

        <div class="machine_insert">
            <table id="insertTable" class="machine">
                <tr id="tr_div_01">
                    <th class="th_01">
                        <label class="label_tag">분단길이/수량</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="분단롤길이1" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="분단롤수량1" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">분단수량</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단수량1" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">분단구분</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단구분1" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">비고</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단비고1" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
                
                <tr id="tr_div_2">
                    <th class="th_01">
                        <label class="label_tag">분단길이/수량</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="분단롤길이2" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="분단롤수량2" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">분단수량</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단수량2" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">분단구분</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단구분2" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">비고</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단비고2" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
                
                <tr id="tr_div_3">
                    <th class="th_01">
                        <label class="label_tag">분단길이/수량</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="분단롤길이3" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="분단롤수량3" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">분단수량</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단수량3" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">분단구분</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단구분3" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">비고</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단비고3" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
                
                <tr id="tr_div_4">
                    <th class="th_01">
                        <label class="label_tag">분단길이/수량</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="분단롤길이4" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="분단롤수량4" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">분단수량</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단수량4" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">분단구분</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단구분4" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">비고</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단비고4" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
                
                <tr id="tr_div_5">
                    <th class="th_01">
                        <label class="label_tag">분단길이/수량</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="분단롤길이5" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="분단롤수량5" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">분단수량</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단수량5" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">분단구분</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단구분5" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">비고</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단비고5" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
                
                <tr id="tr_div_6">
                    <th class="th_01">
                        <label class="label_tag">분단길이/수량</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="분단롤길이6" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="분단롤수량6" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">분단수량</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단수량6" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">분단구분</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단구분6" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">비고</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단비고6" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
                
                <tr id="tr_div_7">
                    <th class="th_01">
                        <label class="label_tag">분단길이/수량</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="분단롤길이7" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="분단롤수량7" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">분단수량</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단수량7" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">분단구분</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단구분7" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">비고</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단비고7" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
                
                <tr id="tr_div_8">
                    <th class="th_01">
                        <label class="label_tag">분단길이/수량</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="분단롤길이8" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="분단롤수량8" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">분단수량</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단수량8" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">분단구분</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단구분8" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">비고</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단비고8" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
                
                <tr id="tr_div_9">
                    <th class="th_01">
                        <label class="label_tag">분단길이/수량</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="분단롤길이9" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="분단롤수량9" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">분단수량</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단수량9" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">분단구분</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단구분9" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">비고</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단비고9" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
                
                <tr id="tr_div_10">
                    <th class="th_01">
                        <label class="label_tag">분단길이/수량</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="분단롤길이10" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="분단롤수량10" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">분단수량</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단수량10" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">분단구분</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단구분10" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">비고</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="분단비고10" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
            </table>
            <button id="addInput" class="btn_add" onclick="showTrTag();">+ 6</button>
        </div>

        <div class="div_forList">
            <table id="table_forList" class="table_forList">
                <thead id="forList_header" class="forList_header">
                    <tr id="supply_header">
                        <th class="th_table_01" style="width: 8%">
                            생산일자<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 8%">
                            박리일자<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 7%">
                            창고명<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 7%">
                            담당자<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 2%">
                            &nbsp;<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 7%">
                            장비구분<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 13%">
                            품명<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 13%">
                            칼라<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 8%">
                            사이즈<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 5%">
                            수량<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 10%">
                            로트번호<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 12%">
                            생산비고<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                    </tr>
                </thead>
                
                <tbody id="forList_body" class="forList_body">
                </tbody>
            </table>
        </div>
    </div>

          
<!-- hidden -->
<input type="hidden" id="작업시작시간" class="input-field">
<input type="hidden" id="작업종료시간" class="input-field">
<input type="hidden" id="작업시간" class="input-field">

<input type="hidden" id="입고전표ID" class="input-field">
<input type="hidden" id="IP_Address" class="input-field">
<input type="hidden" id="WorkID" value="">

<input type="hidden" id="countAdd" value="6">
<input type="hidden" id="topInt" value="450">
<input type="hidden" id="divHeight" value="350">
<input type="hidden" id="tbodyHeight" value="300">

</body>
</HTML>