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
' WorkDiary_JP.asp  KYJ

Dim junID , P_Lot_NO
junID = request("junID")
P_Lot_NO = request("P_Lot_NO")

%>

<head>
<meta charset="utf-8">
<title>작업일지등록(재단)</title>
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
    .btn{ width: 100px; height: 60px; background-color: #337ab7; color: #fff; float: left; line-height: 30px; text-align: center; vertical-align: middle; font-size: 16px; border-radius: 0px;  }

    .btn_01{ width: 118px; height: 40px; border-radius: 3px; margin: 30px 0.5% 10px 1%;  }
    .btn_01_2{ height: 40px; border-radius: 3px; margin: 30px 4% 10px 0px;  }

    .btn_02{ width: 118px; border-radius: 3px; margin: 10px 0.5% 10px 0px;line-height: 50px; text-align: center; vertical-align: middle;   }
    .btn_02_2{ border-radius: 3px; margin: 10px 3% 10px 0px;  }

    .btn_03{ border-radius: 3px; background-color: #FF0000; float: none; clear: right; margin: 10px 0% 10px 0px; line-height: 50px; text-align: center; vertical-align: middle; font-size: 18px; font-weight: bold; color: #fff;  }

    .btn_01:hover { color: white; background-color: #195E9B; cursor: pointer;  }
    .btn_02:hover { color: white; background-color: #195E9B; cursor: pointer;  }
    .btn_03:hover { color: #fff; background-color: #FF8080; cursor: pointer;  }

    .btn_01:disabled { color: white; background-color: #195E9B;  }
    .btn_02:disabled { color: white; background-color: #195E9B;  }
    .btn_03:disabled { color: #fff; background-color: #FF8080;  }
    /* 불량로트 닫기 */
    .btn_td_01{ width: 100%; height: 36px; line-height: 34px; vertical-align: middle; border: 1px solid #195E9B; border-radius: 3px; background-color: #337ab7; color: #fff; font-weight: bold; font-size: 16px; margin: 0px;  }

    /* 각 구역 나누기 / 구역별 css 작업 */
    .TopBtn{ height: 100px; margin: 0px 0px 5px 0px; padding: 10px 0px 0px 0px; background-color: #dff0ed;  }
    .bottom{ width: 100%  }
    
    .searchDate{ width: 30%; height: 30px; float: left; margin: 30px 1% 0px 0px;  }
    .searchDate label{ border: 1px solid #195E9B; background-color: #0EBDDD; color: #fff;  }
    .searchDate input{ border: 1px solid #195E9B;  }
    
    .date_insert{ width: 100%; height: 40px; max-height: 40px; margin: 0px 0px 5px 0px;  }
    .date{ border-collapse: collapse; width: 100%; background-color: #FCEED6;  }
    .date label{ display: block; border: 1px solid #f0bd5e; background-color: #FCEED6;  }
    .date input{ border: 1px solid #f0bd5e; text-align: center;  }

    .item_insert{ width: 100%; height: 40px; max-height: 50px; margin: 0px 0px 5px 0px;  }
    .item{ border-collapse: collapse; width: 100%; background-color: #F8DCB3;  }
    .item label{ display: block; border: 1px solid #eea236; background-color: #F8DCB3;  }
    .item input{ border: 1px solid #eea236;  }
    
    .machine_insert{ width: 100%; height: 80px; max-height: 90px; margin: 0px 0px 5px 0px;  }
    .machine{ border-collapse: collapse; width: 100%; background-color: #BEDFDB;  }
    .machine label{ display: block; border: 1px solid #5e93c2; background-color: #BEDFDB;  }
    .machine input{ border: 1px solid #5e93c2;  }
    
    .ingredient_insert{ width: 100%; max-height: 300px; margin: 0px 0px 5px 0px;  }
    .ingredient{ border-collapse: collapse; width: 100%; background-color: #D9E8F8;  }
    .ingredient label{ display: block; border: 1px solid #5D8F89; background-color: #D9E8F8;  }
    .ingredient input{ border: 1px solid #5D8F89;  }
    .ingredient textarea{ border: 1px solid #5D8F89; background-color: #ffffff;  }

    /* 공급의뢰서 조회 */
    .div_forList{ width: 100%; height: 500px; margin: 0px 0px 0px 0px;  }
    .table_forList{ width: 100%; border-collapse: collapse; border-top: 1px solid #195E9B;  }
    .table_forList tr{ display: table; box-sizing: border-box;  }
    .table_forList th{ word-break: break-all; border-left: 1px solid #195E9B;  }
    .table_forList th:first-child{ border-left: none;  }
    .table_forList td{ word-break: break-all; border-left: 1px solid #195E9B;  }
    .table_forList td:first-child{ border-left: none;  }
    .forList_header{ display: table; width: 100%; border-bottom: 1px solid #195E9B; line-height: 34px; vertical-align: middle; background-color: #0EBDDD; color: #fff;  }
    .forList_header tr{ width: 100%;  }
    .forList_body{ display: block; width: auto; max-height: 400px; overflow-y: auto; font-size: 13pt;  }
    .forList_body tr{ width: 100%; border-bottom: 1px solid #195E9B; height: 40px; text-align: center;  }
    .forList_body tr:nth-child(2n+1){ background-color: #fff;  }
    .forList_body tr:nth-child(2n){ background-color: #eee;  }
    
    /* 조회 정렬시 아이콘 */
    .ui-icon { zoom: 200%; margin-top: 1px; position: absolute; display: none; background-image: url("../IncJquery/images/ui-icons_ffffff_256x240.png");  }

    /* title */
    #title_bar{ float: left; width:22%; height:60px; margin: 5px 2% 0px 2%; vertical-align: auto; position: relative; background-size: 100%, 42px; background-position: center; background-repeat: no-repeat;  }
    #title_bar_img{ width: 100%; height: 100%;  }
    #t_header{ width: 100%; font-size: 18pt; font-weight: bold; font-family: Noto Sans KR; margin: 0px; color:white; text-align:center; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); letter-spacing: 2.5px;  }

    /* tr 태그 */
    .tr_hide{ display: none; border-collapse: collapse; width: 100%; background-color: #E0F0FF;  }
    .tr_hide label{ display: block; border: 1px solid #ACCEF2; background-color: #E0F0FF; width: 100%;  }

    /* th 태그 */
    .th_01{ box-sizing: border-box; width: 7.5%; height: 40px; font-size: 13pt; border-spacing: 0px; text-align: center;  }

    /* td 태그 */
    .td_01{ box-sizing: border-box; width: 17.5%; height: 40px; font-size: 13pt; border-spacing: 0px;  }
    .td_search_01{ width: 1%;  }
    .td_insertCount_01{ width: 5%;  }
    .td_insertCount_02{ width: 12.5%;  }
    .td_length_01{ width: 12.5%;  }
    .td_length_02{ width: 5%;  }

    /* label */
    label{ display: block; border-radius: 3px; color: #000; height: 34px; max-height: 34px; line-height: 34px; text-align: center; vertical-align: middle; font-weight: bold; white-space: nowrap; margin: 0px;  }

    /* input 태그 */
    input{ border-radius: 3px; background-color: #ffffff;  }
    input:focus{ border: 2px solid #f00; outline: none; }
    input:disabled{ color: #999;  }
    .input_tag{ width: 95%; height: 34px; max-height: 34px; line-height: 34px; vertical-align: middle; font-size: 13pt; border: 0; margin: 0px 1% 0px 2%;  }
    .input_tag_insertCount_01{ width: 95%; margin: 0px 0px 0px 7%;  }
    .input_tag_insertCount_02{ width: 96.5%; margin: 0px 0px 0px 3.5%;  }
    .input_tag_length_01{ width: 98%; margin: 0px 0px 0px 2.8%;  }
    .input_tag_length_02{ width: 80.2%; margin: 0px 0px 0px 9%;  }
    .input_remark_01{ width: 99.5%; margin: 0px 0px 0px 0.5%;  }
    .input_tag_date{ width: 95%; height: 34px; max-height: 34px; margin: 0px 1% 0px 2%; text-align:center;  }
    .input-number{ text-align: center;  }
    .input_tag_readonly_01{ background-color: #eee; pointer-events: none;  }  
    .input_tag_end_01{ width: 98%;  }  
    .input_tag_end_02{ width: 91%;  }

    /* autocomplete */
    .autocomplete > div.active{ background: #333; color: #eee;  }
    .ui-autocomplete{ max-height: 300px; overflow-y: auto; overflow-x: hidden;  }
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
            var PDA_rst_length = 0;
            var size_add_cnt = 1;

            if(seSawonid == ""){        //  부모 창에서 정보 유지중인지 확인
                alert("로그인 상태를 다시 확인해 주세요.");
                self.close();

            }else if(prk != ""){
                //  데이터불러오기
                init_disp(prk);     //  번호 같이 전달

                //  기초 데이터
                $("#OLD작업일자").val($("#작업일자").val());
                $("#작업취소").attr("disabled", true);
                $("#작업시작").attr("disabled", true);
                $("#작업수정").css("display","inline");     //  수정 할수있도록 작업수정 버튼 보이게
                $("#작업종료").attr("disabled", true);
                $("#아이템로트번호").val("<%=P_Lot_NO%>");
                $(".btn_01_2").css("margin", "30px 1.8% 10px 0px");
                $(".btn_02_2").css("margin", "10px 2% 10px 0px");
                
            }else{
                //  기초 데이터
                $("#작업수정").css("display", "none");      //  수정 할수있도록 작업수정 버튼 보이게
                $("#발생일자").val(dateString);
                $("#발생일자").attr("min", getDay());       //  달력에서 이전 일자 선택 불가능하도록
                $("#발생일자").attr("max", getDay());       //  달력에서 이후 일자 선택 불가능하도록
                $("#담당자").val(seSawonname);
                $("#창고명").val(defaultStocName);
                $("#재단LOT").val($("#발생일자").val().replace(/-/gi, "").substring(2));
                // var date = new Date();
                // date.setDate(date.getDate() - 7);       //  7일전 날짜 계산
                // var oneWeekAgo = date.toISOString().substring(0, 10);       //  계산 된 날짜 YYYY-MM-DD 형으로 변환 변수에 안담고 바로 val() 해도 무관
                var searchFirstDate = get_add_date_yyyymmdd('mm', -3);      // 3달 전으로 수정
                $("#조회일자부터").val(searchFirstDate);
                $("#조회일자까지").val(dateString);

                //  미완료 데이터 확인
                var work_id = work_check($("#창고명").val(), $("#발생일자").val(), $("#담당자").val());     //  창고명, 발생일자, 담당자 파라메타로 전달

                //  미완료 데이터에 따라 진행중상태 혹은 새로 진행할지 준비
                if(work_id != ""){      //  미완료 데이터가 있음으로 작업진행상태
                    remain_disp(work_id);       //  진행중인 workid 파라메타로 전달
                    var prk = 1;        //  시작 포커스 지정하지 않도록 prk 1로 설정 prk 찾아가면 이유 알수있음
                    $("#작업시작").attr("disabled", true);

                    //  PAD로 전송한 내역인 경우 수정 불가능하도록 처리
                    var PDA_rst = Get_Json("EXEC RF_PDA_CRE_WORKDIARY_CHECK 1, '재단', '" + work_id + "'");
                    PDA_rst_length = PDA_rst.length
                    if(PDA_rst[0].RF재단투입ID == "" || PDA_rst[0].RF재단투입ID == " "){
                        PDA_rst_length = 0;
                    }else{
                        $("#t_header").text($("#t_header").text() + "(PDA작업)");
                        $("#창고명, #재단처명, #재단기, #투입품명, #투입칼라, #투입사이즈, #품명, #칼라, #투입롤수량").prop("readonly", true);
                        $("#창고명, #재단처명, #재단기, #투입품명, #투입칼라, #투입사이즈, #품명, #칼라, #투입롤수량").addClass("input_tag_readonly_01");
                //	$("#투입롤길이,#투입롤수량,#아이템로트번호").attr("class","input-readonly").prop("readonly",true)   //  원본 구문
                        PDA_rst_length = 1;     //  autocomplete 작동 안되게
                    };
                }else{
                    $("#작업종료").attr("disabled", true);
                };
                $("#불량구분1").val("01:정상");
                $("#OutID").val("");
            };    //  초기 데이터 설정 end

            // ------------------------------------------------------------------------
            // 작업시작 버튼 클릭
            // ------------------------------------------------------------------------
            $("#작업시작").on("click", function(){
                if(save("G_Workdiary") == true){        //  작업 시작 후 버튼 제어
                    $("#작업시작").attr("disabled", true);
                    $("#작업종료").attr("disabled", false);
                    $("#불량구분1").val("01:정상");
                };
            });   //  작업시작 버튼 end

            // ------------------------------------------------------------------------
            // 작업종료 버튼 클릭
            // ------------------------------------------------------------------------
            $("#작업종료").on("click", function(){
                // if(stock_chk($("#투입품명").val(), $("#투입칼라").val(), $("#투입사이즈").val(), $("#투입수량").val() - $("#OLD투입수량").val()) == false){      // 작업일지 내에서 수정할경우 OLD투입수량 이 필요 그렇지 않기때문에 삭제
                if(stock_chk($("#투입품명").val(), $("#투입칼라").val(), $("#투입사이즈").val(), $("#투입수량").val()) == false){
                    alert("투입품 재고수량이 부족합니다.\n재고수량 확인 후 투입하세요.");
                    $("#투입롤수량").focus();
                    return false;
                }else{
                    if($("#sizeAdd").val() == 1){       //  사이즈 추가 상황일 때
                        if(save("G_WorkDiary_Sub") != true){
                            return false;
                        };
                    }else{
                        if(save("G_WorkDiary") != true){		//	기본 저장
                            return false;
                        };
                    };
                };
                
                // $(opener.location).attr("href", "javascript:searchOnDblclickHandler();");        //  원본 구문에 있는 기능   검색내용 더블클릭시 검색값지워지며 리바인드 라고 설명되어있음(IncJs/GlobEventHandler.js)

                alert("저장되었습니다.");
                if(confirm("다른 사이즈를 추가로 등록하시겠습니까 ?") == true){
                    $("#sizeAdd").val(1);
                    $("#작업시작").val("disabled", true);
                    $("#작업종료").val("disabled", false);
                    if(size_add_cnt == 1){      //  첫번째 사이즈 추가일시 원본 Workid 저장
                        $("#workid_ori").val($("#WorkID").val());
                    };
                    size_add_cnt = size_add_cnt + 1;
                    // 저장후 일부 내용 삭제 / 투입수량이 중복 체크 되는 사항 있다고함
                    $(".input-field, .input-number").not("#발생일자, #재단처명, #재단기, #품명, #칼라, #투입품명, #투입칼라, #투입사이즈, #필름LOT, #생산LOT, #재단LOT, #롤길이, #단위, #비고").each(function(){
                        if($(this).attr("type") == "text" || $(this).attr("type") == "date"){
                            $(this).val("");
                        }; 
                    });
                    $("#작업시작시간").val($("#작업종료시간").val());
                    $("#forList_body").empty();
                    $("#불량구분1").val("01:정상");
                }else{
                    opener.main_bind();
                    self.close();
                };
            });   //  작업종료 버튼 end

            // ------------------------------------------------------------------------
            // 작업취소 버튼 클릭
            // ------------------------------------------------------------------------
            $("#작업취소").on("click", function(){
                if(confirm("정말 취소하시겠습니까 ?") == true){
                    if($("#작업시작시간").val() == ""){     //  작업시작시간 유무로 작업 시작 유무 확인
                        alert("작업이 시작되었는지 다시 확인해주세요.");
                    }else{
                        var wareHouse = $("#창고명").val();
                        var delSawonName = $("#담당자").val();
                        var delGubun = 5;         //  1 : 압출, 2 : 합포, 3 : 코팅, 4 : 분단, 5 : 재단
                        var delWorkId = $("#WorkID").val();
                        var rst = Get_Json("EXEC RF_JAE_PDA_RF재단투입_ERP_CLEAR '" + delSawonName   + "', '" + delGubun + "', '" + delWorkId + "'");
                        alert(rst[0].MSG);
                        location.reload();
                    };
                };
            });   //  작업취소 버튼 end

            // ------------------------------------------------------------------------
            // 작업수정 버튼 클릭
            // ------------------------------------------------------------------------
            $("#작업수정").on("click", function(){
                $(".input-field, .input-number").attr("disabled", false);
                $("#작업종료").attr("disabled", false);
                $("#작업수정").attr("disabled", true);

            });   //  작업수정 버튼 클릭 end

            // ------------------------------------------------------------------------
            // class input-number 항목 숫자만 입력하도록 적용
            // ------------------------------------------------------------------------
            $(".input-number").on("blur keyup keydown", function(){
                // var regex = /[^0-9]/gi;    //  숫자빼곤 입력 안됨 .도안됨
                var regex = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣|aA-zZ]/gi;     //  한글 영어만 막기
                $(this).val($(this).val().replace(regex, ""));
            });   //  숫자만 입력 end

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
            // autocomplete 품명 검색 페이지 로드시 바로실행
            // ------------------------------------------------------------------------
            item_sql = "";      // 아이템 레코드셋 전역변수
            var item_json = Get_Json_common_direct("EXEC [AA_WORKDIARY_Search2] '', '품명', ''");       // json 형변환 하여 가져오는 품명 전용 검색 sql
            // 완료후 Get_Json_After 함수가 실행되고 그때 item_sql 에 데이터 들어감

            // ------------------------------------------------------------------------
            // input-auto 포커스시 실행 아래방향키 트리거 작동으로 검색 목록 펼치기 / autocomplete 실행
            // ------------------------------------------------------------------------
            $(".input-auto").on("focus", function(){
                //if(PDA_rst_length == 0){		//	PDA로 불러온 경우 실행되지 않도록 0인경우에 실행		//	PDA 내역으로 불러올경우 PDA_rst_length = 1 로 선언함
                    if(dontFocus == 0){
                    data_find(this.id, item_sql);       //  자동완성 실행
                    }else{
                        dontFocus = 0;
                        return;
                    };
                    var e = $.Event("keydown", {
                        keyCode : 40         //  아래방향키 키코드 40
                    });
                    var t_this = this;		//	setTimeout에서 this 를 사용하면 this값이 변하기 때문에 사전에 this를 t_this에 담기
                    setTimeout(function(){      //  바로 실행시 autoFocus 버그로 인해 포커스 사라짐 setTimeout 설정시 버그 사라짐
                        $(t_this).trigger(e);
                    }, 100);
                    if(this.id == "재단처명" || this.id == "재단기"){     // 오토포커스 지우고 이거 추가함
                        return;
                    }else{
                        $(this).trigger(e);
                    };
                // };
            });   //  아래방향키 트리거 end
            
            $("#재단처명, #재단기").on("focus", function(){      // 이걸해야 입력값과 상관없이 검색어 창을 보여주는데 그러면 autoFocus가 고장남...
                $(this).autocomplete("search", "");             // 그래서 autoFocus 지우고 트리거로 autoFocus 대신 추가 작성함
            });
            
            // ------------------------------------------------------------------------
            // 공급의뢰일 조회
            // ------------------------------------------------------------------------
            $("#조회일자부터, #조회일자까지").on("change", function(){
				if(jFuncDateValid(this) == true){
                    SUPPLY_DISP($("#품명").val(), $("#칼라").val(), $("#사이즈").val());
				}else if(this.id == "조회일자부터"){
                    $("#조회일자부터").val(get_add_date_yyyymmdd('mm', -3));
					return false;
				}else if(this.id == "조회일자까지"){
                    $("#조회일자까지").val(dateString);
					return false;
                };
            });     //  공급의뢰일 조회 end

            // ------------------------------------------------------------------------
            // 공급의뢰 선택 체크표시, 백그라운드 색지정
            // ------------------------------------------------------------------------
            $("#forList_body").on("click", "td", function(){
                var rowIndex = $(this).parent().parent().children().index($(this).parent()) + 1;        //  테이블 전체에서 0번째는 헤더이기 때문에 1번째 index를 주기위해 +1
                var cnt = parseInt($("#table_forList tr:eq(" + rowIndex + ") td:eq(7)").text());
                var chk = $("#table_forList tr:eq(" + rowIndex + ") td:eq(8)");     //  .text()로 줬을때 값 수정 하려면 chk 변수에서 .text()를 통해 수정이 불가능해서 .text()를 따로 사용
                var OutID = $("#table_forList tr:eq(" + rowIndex + ") td:eq(9)").text();
                var work_cnt = $("#작업수량").val() == "" ? 0 : parseInt($("#작업수량").val());
                if(chk.text() == "?"){     //  이미 체크표시가 있는 경우 이전으로 돌리기
                    chk.text("");
                    $("#작업수량").val(work_cnt - cnt);
                    $("#OutID").val("");
                    if(checkEven(rowIndex)){        //  홀수번째 줄인지 짝수번째 줄인지 확인하고 배경색 지정
                        $("#table_forList tr:eq(" + rowIndex + ")").css("background-color", "#eee");
                    }else{
                        $("#table_forList tr:eq(" + rowIndex + ")").css("background-color", "#fff");
                    };
                }else{      //  체크표시
                    chk.text("?");
                    $("#작업수량").val(work_cnt + cnt);
                    $("#OutID").val(OutID);
                    $("#table_forList tr:eq(" + rowIndex + ")").css("background-color", "#DBD6E8");
                };
            });     //  공급의뢰 선택 end
            
            // ------------------------------------------------------------------------
            // 공급의뢰 헤더 클릭으로 정렬
            // ------------------------------------------------------------------------
            $("#table_forList").on("click", "th", function(){
                var regex = /[^ㄱ-ㅎ|ㅏ-ㅣ|가-힣|aA-zZ]/gi;     //  한글 영어만 입력
                var sort_kind = $(this).text().replace(regex, "");      //  $(this).text() 시 공백등 다른 문자가 있어 replace로 한글만 남기기
                if(sort_kind == "선택"){
                    return;
                };
                $("#supply_header > th span").each(function(){      //  this가 아닌경우 display none로 아이콘 지우기
                    if($(this).parent().text().replace(regex, "") != sort_kind){
                        $(this).css("display", "none");
                    };
                });
                if($(this).children().css("display") == "none"){		//	정렬 선택이 되어 있지 않을때 아이콘 유무로 판별
                    $(this).children().css("display", "inline").attr("class", "ui-icon ui-icon-triangle-1-n");
                    SUPPLY_DISP($("#품명").val(), $("#칼라").val(), $("#사이즈").val(), sort_kind, "ASC");
                }else{
                    if($(this).children().hasClass("ui-icon-triangle-1-n") == true){		//	클래스 유무로 아이콘의 모양 판별후 정렬 순서 선택
                        $(this).children().attr("class", "ui-icon ui-icon-triangle-1-s");
                        SUPPLY_DISP($("#품명").val(), $("#칼라").val(), $("#사이즈").val(), sort_kind, "DESC");
                    }else{
                        $(this).children().attr("class", "ui-icon ui-icon-triangle-1-n");
                        SUPPLY_DISP($("#품명").val(), $("#칼라").val(), $("#사이즈").val(), sort_kind, "ASC");
                    };
                };
            });     //  공급의뢰 헤더 클릭으로 정렬 end

            // ------------------------------------------------------------------------
            // 정상수량, 불량수량 자동계산
            // ------------------------------------------------------------------------
            $('.auto_sum').on("change", function roll_sum(){
                if($("#롤길이").val() == "" || $("#롤길이").val() == "0"){      //  롤길이 입력 체크
                    alert("롤길이는 필수 입력 항목입니다.");
                    $("#롤길이").focus();
                    return false;
                };
                var roll_good = 0;      //  정상수량에 담을 변수
                var roll_bad = 0;       //  불량수량에 담을 변수
                for(i = 1; i < 9; i++){     //  1~ 8까지 반복
                    if($("#롤수량" + i).val() + "" != ""){      //  롤수량 입력 체크
                        if($("#불량구분" + i).val() == ""){     //  롤수량을 입력했는데 불량구분을 입력하지 않은경우
                            alert("불량구분을 먼저 입력해 주세요.");
                            $("#롤수량" + i).val("");		//	롤수량이 작성되어있으면 불량구분의 값이 계산되기 때문에 롤수량 제거
                            $("#불량구분" + i).focus();
                        }else{      //  입력값 계산
                            roll_good = roll_good + ($("#불량구분" + i).val() == "01:정상" ? parseInt($("#롤수량" + i).val()) : 0);     //  정상의 경우 롤 수량 계산
                            roll_bad = roll_bad + ($("#불량구분" + i).val() != "01:정상" ? parseInt($("#롤수량" + i).val()) : 0);       //  정상이 아닌 경우 롤 수량 계산
                        };
                    };
                };
                $("#정상수량").val(parseInt($("#롤길이").val()) * roll_good);       //  정상수량 전체 계산 값 대입
                $("#불량수량").val(parseInt($("#롤길이").val()) * roll_bad);        //  불량수량 전체 계산 값 대입
            });   //  수량 자동계산 end

            // ------------------------------------------------------------------------
            // 투입수량 자동계산
            // ------------------------------------------------------------------------
            $("#투입롤수량, #롤길이").on("change", function(){
                if($("#롤길이").val() == "" || $("#롤길이").val() == "0"){      //	롤길이 입력 체크
                    alert("롤길이는 필수 입력 항목입니다.");
                    $("#롤길이").focus();
                    $("#투입수량").val("");
                    return false;
                };
                if($("#투입롤수량").val() != "" && $("#투입롤수량").val() != "0"){		//	투입롤수량 입력 체크
                    $("#투입수량").val(parseInt($("#롤길이").val()) * parseInt($("#투입롤수량").val()));		//	투입수량 자동 계산
                }else{
                    $("#투입롤수량").val(0);
                };
            });     //  투입수량 자동계산 end

            // ------------------------------------------------------------------------
            // 투입수량 OLD 저장
            // ------------------------------------------------------------------------
            $("#투입수량").focusin(function(){
                if((prk > 1) && ($("#OLD작업일자").val() == $("#작업일자").val())){
                    if($("#투입수량").val() == "0"){
                        $("#OLD투입수량").val($("#투입수량").val());
                    };
                };
            });

            // ------------------------------------------------------------------------	
            // 시작시 포커스
            // ------------------------------------------------------------------------	
            if(prk + "" == ""){     //  불러올 작업이 없을때만 실행되는것이나 마찬가지
                $("#재단처명").focus();
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
            var rst = Get_Json("B_WORK_LST_BUN 'G_WorkDiary', " + id);
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
                        if(this.id == "발생일자"){
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
    // 당일 미완료 작업일지 번호 호출
    // ------------------------------------------------------------------------
    function work_check(war_name ,work_date, worker){
        try{
            var rst = Get_Json("B_WORK_CHECK 'G_WorkDiary', '" + war_name + "', '" + work_date + "', '" + worker + "'");

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
            var rst = Get_Json("B_WORK_LST_REMAIN 'G_WorkDiary'," + id);		//	재단작업 진행중인것 있는지 체크 사이즈 추가루틴은 확인하지 않음 시작버튼 자체가 별도로 없음
            if(rst[0].WorkID != ""){
                $("#WorkID").val(rst[0].WorkID);
                $("#창고명").val(rst[0].창고명);
                $(".input-field, .input-number, .input-readonly").each(function(){
                    if($(this).attr("type") == "text" || $(this).attr("type") == "date" || $(this).attr("type") == "textarea" || $(this).attr("type") == "hidden"){
                        var field = rst[0][this.id] + "";
                        field = ((field == 0 || field == "null") ? "" : field);
                        if(this.id == "발생일자"){
                            $("#" + this.id).val(field.substring(0, 10));       //  db에 저장된 발생일자에 시간값 제거
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
    //  재고 체크
    // ------------------------------------------------------------------------
    function stock_chk(item, color, size, cnt){
        if(item == "" || color == "" || size == "" || cnt == "" || size.includes("난단") == true){
            return true;
        };
        var enabled;
        var date = $("#발생일자").val();
        var wareID = $("#창고명").val() == "재단창고" ? 8 : $("#창고명").val() == "상품창고" ? 14 : 7;
        //  GET_ITEMZIZE 자체가 느려 ID 3개만 가져올것이기 때문에 select 구문 따로 작동
        // var rst_item = Get_Json("SELECT * FROM [dbo].[Get_ITEMSIZE](1) WHERE 아이템품명 = '" + item + "' AND 칼라 = '" + color + "' AND 사이즈 = '" + size + "'");
        // console.log("SELECT * FROM [dbo].[Get_ITEMSIZE](1) WHERE 아이템품명 = '" + item + "' AND 칼라 = '" + color + "' AND 사이즈 = '" + size + "'");
        // var itemID = rst_item[0].아이템ID;
        // var colorID = rst_item[0].칼라ID;
        // var sizeID = rst_item[0].사이즈ID;
        var rst_itemid = Get_Json("SELECT 아이템ID FROM H_아이템 WHERE 아이템품명 = '" + item + "'");
        var rst_colorid = Get_Json("SELECT detailid FROM C_칼라 WHERE detailname = '" + color + "'");
        var rst_sizeid = Get_Json("SELECT detailid FROM C_사이즈 WHERE detailname = '" + size + "'");
        var itemID = rst_itemid[0].아이템ID;
        var colorID = rst_colorid[0].detailid;
        var sizeID = rst_sizeid[0].detailid;
        var rst = Get_Json("EXEC [H_Stock_NEW_CHUL_CHECK_RST] '" + date + "', '" + wareID + "', '" + itemID + "', '" + colorID + "', '" + sizeID + "', '" + cnt + "', '재단투입전표', 0");
        console.log("EXEC [H_Stock_NEW_CHUL_CHECK_RST] '" + date + "', '" + wareID + "', '" + itemID + "', '" + colorID + "', '" + sizeID + "', '" + cnt + "', '재단투입전표', 0");
        enabled = rst[0].ENABLED;       // 재고 상태에 따라 사용가능일시 1 불가능일시 0 이 반환됨
        return enabled;
    };

    // ------------------------------------------------------------------------
    //  저장
    // ------------------------------------------------------------------------
    function save(table){
        try{
            var id = seSawonid;
            var WorkID = $("#WorkID").val();
            var t_val = "";
            var save_data = "";
            $('.input-field, .input-number, .input-readonly').each(function(){		//	저장 대상의 input 항목 체크
                if($(this).attr("type") == "text" || $(this).attr("type") == "date" || $(this).attr("type") == "hidden" || $(this).attr("type") == "textarea"){
                    t_val = $(this).val();
                }else if($(this).attr("type") == "checkbox"){
                    t_val = $(this).is(":checked") == true ? 1 : 0;
                }else if($(this).attr("type") == "select-one"){
                    t_val = $(this).val() == null ? 0 : $(this).val();
                };
                save_data += ", '" + t_val + "'";		//	체크하며 입력값 변수에 담기
            });
            var insert = Get_Json("EXEC [AA_WORKDIARY_재단] '" + id + "', '" + WorkID + "'" + save_data + ", '" + table + "'");		//	저장 sp 실행
            if(insert[0].VALID == 0){		//	sql 실행시 validation 문제있을경우 메세지와 포커스값 가져오기
                dontFocus = 1;      // 자동완성 화살표 트리거만 작동하도록 작업
                alert(insert[0].MSG);
                $("#" + insert[0].RETURN_INPUT).focus();
                return false;
            }else if(insert[0].VALID == 1){		//	저장 성공시 데이터 반환
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
            var color = "";
            var size = "";
            var t_sql = "";
            var Stoc = $("#창고명").val();
            var gubun = "";
            if(id == "재단처명" || id == "재단기" || id.includes("불량구분")){		//	재단처명, 재단기, 불량구분 의 경우 실행 sql문 지정
                gubun = id == "재단처명" ? "재단처명" : id == "재단기" ? "재단기" : "불량구분";
                t_sql = "EXEC AA_WORKDIARY_Search '', '" + gubun + "', ''";
            }else if(id == "칼라" || id == "투입칼라"){		//	칼라, 투입칼라 의 경우 실행 sql문 지정
                item = id == "칼라" ? "품명" : "투입품명";
                if($("#" + item).val() == ""){
                    dontFocus = 1;      // 자동완성 화살표 트리거만 작동하도록 작업
                    alert(item + "을 입력해 주세요.");
                    $("#" + item).focus();
                    return false;
                }else{
                    t_sql = "EXEC AA_WORKDIARY_Search '', '칼라', '" + $("#" + item).val() + "'";
                };
            }else if(id == "사이즈" || id == "투입사이즈" || id == "난단사이즈"){		//	사이즈, 투입사이즈, 난단사이즈 의 경우 실행 sql문 지정
                item = id == "사이즈" ? "품명" : "투입품명";		//	사이즈, 투입사이즈 에 따라 맞춰줄 품명 지정
                color = id == "사이즈" ? "칼라" : "투입칼라";
                if(($("#" + item).val() == "" || $("#" + color).val() == "") && id != "난단사이즈"){		//	사전 입력 요소 확인 난단사이즈의 경우 품명과 관계 없기 때문에 제외
                    dontFocus = 1;      // 자동완성 화살표 트리거만 작동하도록 작업
                    var focus = $("#" + item).val() == "" ? item : color;
                    alert(focus + "을 입력해 주세요.");
                    $("#" + focus).focus();
                    return false;
                }else{
                    if(id == "사이즈"){
                        t_sql = "EXEC AA_WORKDIARY_Search '', '재단', '" + $("#" + item).val() + "'";
                    }else if(id == "투입사이즈"){
                        t_sql = "EXEC AA_WORKDIARY_Search '', '투입', '" + $("#" + item).val() + "'";
                    }else if(id == "난단사이즈"){
                        t_sql = "EXEC AA_WORKDIARY_Search '', '난단', ''";
                    };
                };
            }else if(id == "생산LOT"){		//	생산LOT 의 경우 실행 sql문 지정
                if($("#투입품명").val() == "" || $("#투입칼라").val() == "" || $("#투입사이즈").val() == ""){		//	사전 입력 요소 확인
                    // dontFocus = 1;      // 자동완성 화살표 트리거만 작동하도록 작업
                    // alert("투입품 입력 정보를 재확인 해주세요.");
                    // var focus = $("#투입품명").val() == "" ? "투입품명" : $("#투입칼라").val() == "" ? "투입칼라" : "투입사이즈";
                    // $("#" + focus).focus();
                    return false;
                }else{
                    t_sql = "EXEC [AA_WORKDIARY_LOTNO] '', '" + $("#담당자").val() + "', '" + $("#투입품명").val() + "', '" + $("#투입칼라").val() + "', '" + $("#투입사이즈").val() + "', '" + Stoc + "'";
                };
            };
            console.log(t_sql)
            var find_rst = "";		//	실행시킬 sql문 담을 변수 지정
            var find_data_array = new Array();		//	sql의 정보 반환 받을 데이터 Array 생성
            var find_unit_array = new Array();		//	품명의 단위 반환 받을 데이터 Array 생성
            var find_roll_array = new Array();		//	품명의 길이 반환 받을 데이터 Array 생성
            if(id.includes("품명")){		//	품명의 경우 페이지 로드시 바로 sql 실행하여 담아두어 함수 실행 변수로 받아온것 사용
                find_rst = item_sql;
            }else if(id == "생산LOT"){
                //Get_Json_Before() // 프로그래스바 실행
                $("#"+ id).css("background-color", "#eee");
                Get_Json_common_direct2(t_sql);
                G_LotID = id;
                // 가져오기완료후 Get_Json_After2 실행됨
                return;
            }else{		//	그 외의 경우 sql문 Get_Json()으로 실행
                find_rst = Get_Json(t_sql);
            };
            find_data_array[id] = find_rst;
            if(id == "작업구분"){		//	작업구분의 경우 직접 데이터 작성
                find_data_array = ["공급의뢰", "샘플출고", "가공출고"];
            }else if(id == "품명" || id == "투입품명"){
                if(find_rst[0]["FND_DATA"] ==  ""){        //  데이터가 없는경우 move_next 발동시키키위한 다음으로 넘어가기 삽입
                    find_data_array.push("조회 내용이 없습니다. 다음으로 넘어가기");
                }else{
                    for(var i in find_rst){     //  품명의 경우 롤 길이와 단위까지 조회해서 가져오기 때문에 배열로 key 와 value 를 직접 지정시킴
                        find_data_array.push({label : find_rst[i]["FND_DATA"], value : find_rst[i]["FND_DATA"], unit : find_rst[i]["unitName"], roll : find_rst[i]["rollName"]});
                    };
                };
            }else if(id == "생산LOT"){
                if(find_rst[0]["FieldName"] == "" || find_rst[0]["FieldName"] == " "){
                    find_data_array.push("조회 내용이 없습니다. 다음으로 넘어가기");
                }else{
                    for(var i in find_rst){		//	생산LOT의 경우 지정한 별칭(AS(Alias))이 다르기 때문에 다르게 작성
                        find_data_array.push(find_rst[i]["FieldName"]);
                    };
                };
            }else{
                if(find_rst[0]["FND_DATA"] == "" || find_rst[0]["FND_DATA"] == " "){
                    find_data_array.push("조회 내용이 없습니다. 다음으로 넘어가기");
                }else{
                    for(var i in find_rst){		//	외에 경우에 모두 같은 별칭(AS(Alias))를 사용하였기에 알맞게 변수에 담기
                        find_data_array.push(find_rst[i]["FND_DATA"]);
                    };
                };
            };
            autocomplete_dbc(find_data_array, id);
        }catch(err){
            alert(err.message);
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
                    if(this.id == "재단처명"){
                        var date = new Date();
                        if(ui.item.value == "재단라인"){        //  재단라인일 경우 세팅
                            $("#창고명").val("재단창고");
                            $("#search_title").html("공급의뢰일");
                            // date.setDate(date.getDate() - 7);       //  7일전 날짜 계산
                            // var oneWeekAgo = date.toISOString().substring(0, 10);       //  계산 된 날짜 YYYY-MM-DD 형으로 변환 변수에 안담고 바로 val()에 담아도 무관
                            //  toISOString() 쓰면 기본값이 세계 표준시로 바뀌어서 계산값이 달라짐 > get_add_date_yyyymmdd 사용
                            var searchFirstDate = get_add_date_yyyymmdd('mm', -3);      // 3달전 으로 수정
                            $("#조회일자부터").val(searchFirstDate);
                            $("#조회일자까지").val(dateString);
                            $("#재단LOT").val($("#발생일자").val().replace(/-/gi, "").substring(2));
                            $("#생산LOT").val("");
                        }else if(ui.item.value == "지원라인"){      //  지원라인일 경우 세팅
                            $("#창고명").val("상품창고");
                            $("#재단기").val("소폭 슬리터 2번");
                            $("#search_title").html("출고의뢰일");
                            // date.setDate(date.getDate() + 2);       //  2일후 날짜 계산
                            // var twoDaysLater = date.toISOString().substring(0, 10);     // 계산 된 날짜 YYYY-MM-DD 형으로 변환 변수에 안담고 바로 val()에 담아도 무관
                            var twoDaysLater = get_add_date_yyyymmdd('dd', +2);      // 2일 후 날짜 계산
                            $("#조회일자부터").val(dateString);
                            $("#조회일자까지").val(twoDaysLater);
                            $("#생산LOT").val($("#발생일자").val().replace(/-/gi, "").substring(2));
                            $("#재단LOT").val("");
                            $("#품명").focus();     //  지원라인의 경우 재단기도 작성을 해주기 때문에 품명으로 포커스 이동하고 move_next 발동하지 않도록 return false; 으로 탈출
                            return false;       //  작성 안하면 move_next 발동으로 칼라 까지 가게 됨
                        }else{		//	합포라인일 경우 세팅
                            $("#창고명").val("합포창고");
                        };
                    };
                    if(this.id == "품명" || this.id == "투입품명"){     //  품명 입력시 롤길이, 단위, 투입품명 까지 전체 입력
                        $("#롤길이").val(ui.item.roll);
                        $("#단위").val(ui.item.unit);
                        if(id == "품명"){		//	품명 입력시 투입품명도 입력
                            $("#투입품명").val(ui.item.value);
                        };
                    };
                    if(this.id == "칼라" || this.id == "투입칼라"){		//	칼라 입력시 투입칼라도 입력
                        $("#투입칼라").val(ui.item.value);
                    };
                    if(this.id == "사이즈"){		//	사이즈 입력시 의뢰서 조회
                        SUPPLY_DISP($("#품명").val(), $("#칼라").val(), ui.item.value);
                    };
                    var t_this = this;		//	setTimeout에서 this 를 사용하면 this값이 변하기 때문에 사전에 this를 t_this에 담기
                    setTimeout(function(){		//	setTimeout을 걸지 않으면 위의 내용이 정상 실행되지 않을때가 있음
                        move_next(t_this);		//	다음 입력 항목으로 이동 실행
                    }, 100);
                },
                focus : function(event, ui){    //  focus 시 이벤트    한글과 사용시 나머지가 사라지는 버그가 있다 ? 리턴펄스시 무시한다고함
                    return false;
                },
                change : function(event, ui){    //  change 시 이벤트
                    if(id == "품명" || id == "투입품명"){       //  품명, 투입품명 입력시 입력값 확인
                        if(autocom_valid("품명", $(this).val(), "") == "0"){
                            dontFocus = 1;      // 자동완성 화살표 트리거만 작동하도록 작업
                            $(this).val("");
                            $(this).focus();
                            if(id == "품명"){
                                $("#투입품명").val("");
                            };
                            return false;
                        };
                    };
                    if(id == "칼라" || id == "투입칼라"){		//	칼라, 투입칼라 입력시 입력값 확인
                        item = id == "칼라" ? "품명" : "투입품명";
                        if(autocom_valid("칼라", $(this).val(), $("#" + item).val()) == "0"){
                            dontFocus = 1;      // 자동완성 화살표 트리거만 작동하도록 작업
                            $(this).val("");
                            $(this).focus();
                            if(id == "칼라"){
                                $("#투입칼라").val("");
                            };
                            return false;
                        };
                    };
                    if(this.id == "사이즈" || this.id == "투입사이즈"){		//	사이즈, 투입사이즈 입력시 입력값 확인
                        item = id == "사이즈" ? "품명" : "투입품명";
                        var t_this = this;
                        setTimeout(function(){
                            if(autocom_valid("사이즈", $(t_this).val(), $("#" + item).val()) == "0"){
                                if($(t_this).val() != ""){
                                    if($(t_this).val().includes("난단")){
                                        // 난단이 포함된 경우 벨리드가 일치하지 않아도 넘어가도록 오탈자 처리는 어떻게하지 ?
                                        // 저장 SP에서 오탈자 등 확인 위해 투입사이즈 재검색 하여 일치하는지 확인 구문 작성함
                                    }else{
                                        dontFocus = 1;      // 자동완성 화살표 트리거만 작동하도록 작업
                                        alert("입력값이 올바르지 않습니다.");
                                        $(t_this).val("");
                                        $(t_this).focus();
                                        return false;
                                    };
                                };
                            };
                        }, 200);
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
                // if(this.id == "재단처" || this.id == "재단기"){
                //     $(this).autocomplete("search", "");    //  focus시 바로 검색창이 ON   트리거로 아래방향키 누르는것 추가 같이 있으면 autoFocus 가 버그걸려서 포커스 사라짐
                // }else{
                //     $(this).autocomplete("search", $(this).val());    //  focus시 바로 검색창이 ON   트리거로 아래방향키 누르는것 추가 같이 있으면 autoFocus 가 버그걸려서 포커스 사라짐
                // };
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
    // 공급의뢰서 조회
    // ------------------------------------------------------------------------
    function SUPPLY_DISP(item, color, size, sortName, sortOrder){
        try{
            if(color == "" || size == ""){
                return false;
            };
            sortName = sortName == null ? "" : sortName == undefined ? "" : sortName;		//	sortName의 입력값 있는지 확인
            sortOrder = sortOrder == null ? "" : sortOrder == undefined ? "" : sortOrder;		//	sortOrder의 입력값 있는지 확인
            var rst = Get_Json("B_WORK_SUPPLY_LST 1, '" + item + "', '" + color + "', '" + size + "', '" + $("#조회일자부터").val() + "', '" + $("#조회일자까지").val() + "', '"
                                                        + ($("#재단처명").val() == "재단라인" ? 1 : 2) + "', '"
                                                        + sortName + "', '" + sortOrder + "'");
            console.log("B_WORK_SUPPLY_LST 1, '" + item + "', '" + color + "', '" + size + "', '" + $("#조회일자부터").val() + "', '" + $("#조회일자까지").val() + "', '"
                                                        + ($("#재단처명").val() == "재단라인" ? 1 : 2) + "', '"
                                                        + sortName + "', '" + sortOrder + "'");
            var appendHTML = "";
            if(rst[0].출고의뢰일 == "" || rst[0].출고의뢰일 == " " || rst[0].출고의뢰일 == null){       //  조회 내용이 없는 경우
                appendHTML += "<tr><td>조회 내용이 없습니다</td></tr>";
            }else{
                if(rst.length > 10){
                    for(i = 0; i < rst.length; i++){
                        appendHTML += '<tr><td style="width: 9%;">' + rst[i].공급의뢰일 + '</td><td style="width: 9%;">' + rst[i].출고의뢰일 + '</td><td style="width: 11%;">' + rst[i].공급의뢰번호
                            + '</td><td style="width: 19%;">' + rst[i].거래처명 + '</td><td style="width: 13%;">' + rst[i].품명 + '</td><td style="width: 15%;">' + rst[i].공급수량
                            + '</td><td style="width: 10%;">' + rst[i].재단수량 + '</td><td style="width: 8%;" class="number">' + rst[i].잔여수량
                            + '</td><td class="select" style="width: 5.1%;"></td><td style="display:none">' + rst[i].OUTID + '</td></tr>';
                    };
                }else{
                    for(i = 0; i < rst.length; i++){
                        appendHTML += '<tr><td style="width: 9%;">' + rst[i].공급의뢰일 + '</td><td style="width: 9%;">' + rst[i].출고의뢰일 + '</td><td style="width: 11%;">' + rst[i].공급의뢰번호
                            + '</td><td style="width: 19%;">' + rst[i].거래처명 + '</td><td style="width: 13%;">' + rst[i].품명 + '</td><td style="width: 15%;">' + rst[i].공급수량
                            + '</td><td style="width: 10%;">' + rst[i].재단수량 + '</td><td style="width: 8%;" class="number">' + rst[i].잔여수량
                            + '</td><td class="select" style="width: 6%;"></td><td style="display:none">' + rst[i].OUTID + '</td></tr>';
                    };
                };
            };
            $("#forList_body").empty();
            $("#forList_body").append(appendHTML);
        }catch(err){
            alert(err.message);
        };
    };      //  공급의뢰서 조회 end

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
    // 불량로트 열기        onfocus 로 작동		열고 닫기 작동 조건이 달라 하나로 합치면 고장남
    // ------------------------------------------------------------------------
    function openLine(num){
        $(".tr_hide_0" + num).css("display", "table-row");
    };      //  불량로트 열기 end

    // ------------------------------------------------------------------------
    // 불량로트 닫기        onclick 로 작동
    // ------------------------------------------------------------------------
    function closeLine(num){
        $(".tr_hide_0" + num).css("display", "none");
    };      //  불량로트 닫기 end

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
    function checkEven(num){        //  홀수가 들어오면 0(false) 짝수가 들어오면 1(true)
        return (num % 2 == 0);
    };      //  홀짝 구분하기 end

</script>


</head>

<body>
  
    <div class="TopBtn">
        <div id="title_bar">
            <img id="title_bar_img" src ="../image/title/title2.png">
            <p id="t_header">재단작업일지</p>
        </div>

        <table class="searchDate">
            <tr>
                <th class="th_01">
                    <label id="search_title" class="label_tag">공급의뢰일</label>
                </th>
                <td class="td_01">
                    <input type="text" id="조회일자부터" class="input_tag input_tag_date datepicker" max="9999-12-31" min="1970-01-01" autocomplete="off">
                </td>
                <td class="td_01 td_search_01">
                    <label class="label_tag">부터</label>
                </td>
                <td class="td_01">
                    <input type="text" id="조회일자까지" class="input_tag input_tag_date datepicker" max="9999-12-31" min="1970-01-01" autocomplete="off">
                </td>
                <td class="td_01 td_search_01">
                    <label class="label_tag">까지</label>
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
                        <input type="text" id="발생일자" class="input_tag input_tag_date input-field datepicker input_tag_readonly_01"  tabindex="-1" readonly autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">재단처명</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="재단처명" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">재단기</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="재단기" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">담당자</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="담당자" class="input_tag input_tag_readonly_01 input_tag_end_01 input-field" tabindex="-1" readonly>
                    </td>
                </tr>
            </table>
        </div>

        <div class="item_insert">
            <table class="item">
                <tr>
                    <th class="th_01">
                        <label class="label_tag">재단품명</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="품명" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">재단칼라</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="칼라" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">재단사이즈</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="사이즈" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">작업예정수량</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="작업수량" class="input_tag input_tag_end_01 input-number" autocomplete="off">
                    </td>
                </tr>
            </table>
        </div>

        <div class="machine_insert">
            <table class="machine">
                <tr>
                    <th class="th_01">
                        <label class="label_tag">투입품명</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="투입품명" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">투입칼라</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="투입칼라" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">투입사이즈</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="투입사이즈" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">투입수량</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="투입롤수량" class="input_tag input_tag_insertCount_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_insertCount_02" colspan="2;">
                        <input type="text" id="투입수량" class="input_tag input_tag_insertCount_02 input_tag_readonly_01 input-number" tabindex="-1" readonly autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">필름 LOT</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="필름LOT" class="input_tag input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">생산 LOT</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="생산LOT" class="input_tag input-field input-auto" autocomplete="off">
                    </td>


                    <th class="th_01">
                        <label class="label_tag">재단 LOT</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="재단LOT" class="input_tag input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">롤길이</label>
                    </th>
                    <td class="td_01 td_length_01" colspan="2;">
                        <input type="text" id="롤길이" class="input_tag input_tag_length_01 auto_sum input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_length_02">
                        <input type="text" id="단위" class="input_tag input_tag_length_02 input_tag_end_02 input-field" autocomplete="off">
                    </td>
                </tr>
            </table>
        </div>

        <div class="ingredient_insert">
            <table class="ingredient">
                <tr>
                    <th class="th_01">
                        <label class="label_tag">불량구분</label>
                    </th>
                    <td class="td_01 td_length_01">
                        <input type="text" id="불량구분1" class="input_tag input_tag_length_01 input-field input-auto" onfocus="openLine(1);" autocomplete="off">
                    </td>
                    <td class="td_01 td_length_02">
                        <input type="text" id="롤수량1" class="input_tag input_tag_length_02 auto_sum input-number" onfocus="openLine(1);" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">불량구분</label>
                    </th>
                    <td class="td_01 td_length_01">
                        <input type="text" id="불량구분2" class="input_tag input_tag_length_01 input-field input-auto" onfocus="openLine(1);" autocomplete="off">
                    </td>
                    <td class="td_01 td_length_02">
                        <input type="text" id="롤수량2" class="input_tag input_tag_length_02 auto_sum input-number" onfocus="openLine(1);" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">불량구분</label>
                    </th>
                    <td class="td_01 td_length_01">
                        <input type="text" id="불량구분3" class="input_tag input_tag_length_01 input-field input-auto" onfocus="openLine(1);" autocomplete="off">
                    </td>
                    <td class="td_01 td_length_02">
                        <input type="text" id="롤수량3" class="input_tag input_tag_length_02 auto_sum input-number" onfocus="openLine(1);" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">정상수량</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="정상수량" class="input_tag input_tag_end_01 input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                </tr>

                <tr class="tr_hide tr_hide_01">
                    <th class="th_01">
                        <label class="label_tag">불량 LOT</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="불량로트1" class="input_tag input-field" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">불량 LOT</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="불량로트2" class="input_tag input-field" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">불량 LOT</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="불량로트3" class="input_tag input-field" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <button class="btn_01 btn_td_01" onclick="closeLine(1);">닫기</button>
                    </th>
                    <td class="td_01">
                        <span> </span>
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">불량구분</label>
                    </th>
                    <td class="td_01 td_length_01">
                        <input type="text" id="불량구분4" class="input_tag input_tag_length_01 input-field input-auto" onfocus="openLine(2);" autocomplete="off">
                    </td>
                    <td class="td_01 td_length_02">
                        <input type="text" id="롤수량4" class="input_tag input_tag_length_02 auto_sum input-number" onfocus="openLine(2);" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">불량구분</label>
                    </th>
                    <td class="td_01 td_length_01">
                        <input type="text" id="불량구분5" class="input_tag input_tag_length_01 input-field input-auto" onfocus="openLine(2);" autocomplete="off">
                    </td>
                    <td class="td_01 td_length_02">
                        <input type="text" id="롤수량5" class="input_tag input_tag_length_02 auto_sum input-number" onfocus="openLine(2);" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">불량구분</label>
                    </th>
                    <td class="td_01 td_length_01">
                        <input type="text" id="불량구분6" class="input_tag input_tag_length_01 input-field input-auto" onfocus="openLine(2);" autocomplete="off">
                    </td>
                    <td class="td_01 td_length_02">
                        <input type="text" id="롤수량6" class="input_tag input_tag_length_02 auto_sum input-number" onfocus="openLine(2);" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">불량수량</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="불량수량" class="input_tag input_tag_end_01 input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                </tr>

                <tr class="tr_hide tr_hide_02">
                    <th class="th_01">
                        <label class="label_tag">불량 LOT</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="불량로트4" class="input_tag input-field" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">불량 LOT</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="불량로트5" class="input_tag input-field" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">불량 LOT</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="불량로트6" class="input_tag input-field" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <button class="btn_01 btn_td_01" onclick="closeLine(2);">닫기</button>
                    </th>
                    <td class="td_01">
                        <span> </span>
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">불량구분</label>
                    </th>
                    <td class="td_01 td_length_01">
                        <input type="text" id="불량구분7" class="input_tag input_tag_length_01 input-field input-auto" onfocus="openLine(3);" autocomplete="off">
                    </td>
                    <td class="td_01 td_length_02">
                        <input type="text" id="롤수량7" class="input_tag input_tag_length_02 auto_sum input-number" onfocus="openLine(3);" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">불량구분</label>
                    </th>
                    <td class="td_01 td_length_01">
                        <input type="text" id="불량구분8" class="input_tag input_tag_length_01 input-field input-auto" onfocus="openLine(3);" autocomplete="off">
                    </td>
                    <td class="td_01 td_length_02">
                        <input type="text" id="롤수량8" class="input_tag input_tag_length_02 auto_sum input-number" onfocus="openLine(3);" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">난단사이즈</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="난단사이즈" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">후도</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="후도" class="input_tag input_tag_end_01 input-number" autocomplete="off">
                    </td>
                </tr>

                <tr class="tr_hide tr_hide_03">
                    <th class="th_01">
                        <label class="label_tag">불량 LOT</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="불량로트7" class="input_tag input-field" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">불량 LOT</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="불량로트8" class="input_tag input-field" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <button class="btn_01 btn_td_01" onclick="closeLine(3);">닫기</button>
                    </th>
                    <td class="td_01" colspan="2;">
                        <span> </span>
                        
                    </td>
                    <th class="th_01">
                        <span> </span>

                    </th>
                    <td class="td_01">
                        <span> </span>
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">작업구분</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="작업구분" class="input_tag input-field input-auto" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">비고</label>
                    </th>
                    <td class="td_01" colspan="7;">
                        <input type="text" id="비고" class="input_tag input_remark_01 input-field" autocomplete="off">
                    </td>
                </tr>
            </table>
        </div>

        <div class="div_forList">
            <table id="table_forList" class="table_forList">
                <thead id="forList_header" class="forList_header">
                    <tr id="supply_header">
                        <th class="th_01" style="width: 9%">
                            공급의뢰일<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_01" style="width: 9%">
                            출고의뢰일<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_01" style="width: 11%">
                            공급의뢰번호<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_01" style="width: 19%">
                            거래처명<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_01" style="width: 13%">
                            품명<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_01" style="width: 15%">
                            공급수량<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_01" style="width: 10%">
                            재단수량<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_01" style="width: 8%">
                            잔여수량<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_01" style="width: 6%">
                            선택<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                    </tr>
                </thead>

                <tbody id="forList_body" class="forList_body">
                </tbody>
            </table>
        </div>
    </div>

          
<!-- hidden -->
<input type="hidden" id="창고명" class="input-field">
<input type="hidden" id="작업시작시간" class="input-field">
<input type="hidden" id="작업종료시간" class="input-field">
<input type="hidden" id="작업시간" class="input-field">
<input type="hidden" id="OutID" class="input-field">

<input type="hidden" id="IP_Address" class="input-field">
<input type="hidden" id="WorkID" value="">
<input type="hidden" id="Item" value="">
<input type="hidden" id="color" value="">
<input type="hidden" id="size" value="">
<input type="hidden" id="sizeOpt" value="">
<input type="hidden" id="OLD투입수량" value="0">
<input type="hidden" id="OLD작업일자" value="0">
<input type="hidden" id="sizeAdd" value="0">
<input type="hidden" id="workid_ori" value="0">

</body>
</HTML>