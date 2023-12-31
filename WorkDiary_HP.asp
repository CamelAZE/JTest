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
' WorkDiary_HP.asp  KYJ

Dim junID , P_Lot_NO
junID = request("junID")
P_Lot_NO = request("P_Lot_NO")

%>

<head>
<meta charset="utf-8">
<title>작업일지등록(합포AND코팅)</title>
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
    .btn_01_2{ height: 40px; border-radius: 3px; margin: 30px 1% 10px 0px;  }

    .btn_02{ width: 118px; border-radius: 3px; margin: 10px 0.5% 10px 0px; line-height: 50px; text-align: center; vertical-align: middle;  }
    .btn_02_2{ border-radius: 3px; margin: 10px 3% 10px 0px;  }

    .btn_03{ border-radius: 3px; background-color: #FF0000; float: none; clear: right; margin: 10px 0% 10px 0px; line-height: 50px; text-align: center; vertical-align: middle; font-size: 18px; font-weight: bold; color: #fff;  }

    .btn_01:hover { color: white; background-color: #195E9B; cursor: pointer;  }
    .btn_02:hover { color: white; background-color: #195E9B; cursor: pointer;  }
    .btn_03:hover { color: #fff; background-color: #FF8080; cursor: pointer;  }

    .btn_01:disabled { color: white; background-color: #195E9B;  }
    .btn_02:disabled { color: white; background-color: #195E9B;  }
    .btn_03:disabled { color: #fff; background-color: #FF8080;  }

    .btn_td_01{ width: 98%; height: 36px; border: 1px solid #195E9B; border-radius: 3px; background-color: #337ab7; color: #fff; font-weight: bold; font-size: 16px; line-height: 32px; vertical-align: middle; text-align: center; margin: 2px 0px 40px 2%;  }

    /* 각 구역 나누기 / 구역별 css 작업 */
    .TopBtn{ height: 100px; margin: 0px 0px 5px 0px; padding: 10px 0px 0px 0px; background-color: #dff0ed;  }
    .bottom{ width: 100%;  }

    .date_insert{ width: 100%; height: 80px; max-height: 95px; margin: 0px 0px 5px 0px;  }
    .date{ border-collapse: collapse; width: 100%; background-color: #FCEED6;  }
    .date label{ display: block; border: 1px solid #f0bd5e; background-color: #FCEED6;  }
    .date input{ border: 1px solid #f0bd5e; text-align: center;  }

    .item_insert{ width: 100%; max-height: 205px; margin: 0px 0px 5px 0px;  }
    .item{ border-collapse: collapse; width: 100%; background-color: #F8DCB3;  }
    .item label{ display: block; border: 1px solid #eea236; background-color: #F8DCB3;  }
    .item input{ border: 1px solid #eea236;  }

    .ingredient_insert{ width: 100%; height: 300px; max-height: 300px; margin: 0px 0px 0px 0px;  }
    .ingredient{ border-collapse: collapse; width: 100%; background-color: #D9E8F8;  }
    .ingredient label{ display: block; border: 1px solid #5D8F89; background-color: #D9E8F8;  }
    .ingredient input{ border: 1px solid #5D8F89;  }

    .ingredient_01{ border-collapse: collapse; width: 100%; background-color: #D9E8F8;  }
    .ingredient_01 label{ display: block; border: 1px solid #5D8F89; background-color: #D9E8F8;  }
    .ingredient_01 input{ border: 1px solid #5D8F89;  }

    .ingredient_02{ display: none; border-collapse: collapse; width: 100%; background-color: #D9E8F8;  }
    .ingredient_02 label{ display: block; border: 1px solid #5D8F89; background-color: #D9E8F8;  }
    .ingredient_02 input{ border: 1px solid #5D8F89;  }
    .ingredient textarea{ border: 1px solid #5D8F89; background-color: #ffffff;  }

    /* title */
    #title_bar{ float: left; width:22%; height:60px; margin: 5px 31.5% 0px 2%; vertical-align: auto; position: relative; background-size: 100%, 42px; background-position: center; background-repeat: no-repeat;  }
    #title_bar_img{ width: 100%; height: 100%;  }
    #t_header{ width: 100%; font-size: 18pt; font-weight: bold; font-family: Noto Sans KR; margin: 0px; color:white; text-align:center; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); letter-spacing: 2.5px;  }

    /* tr 태그 */
    .tr_hide{ display: none;  }

    /* th 태그 */
    .th_01{ box-sizing: border-box; width: 5%; height: 40px; font-size: 13pt; border-spacing: 0px;  }
    .th_remark_01{ width: 10%;  }

    /* td 태그 */
    .td_01{ box-sizing: border-box; width: 15%; height: 40px; font-size: 13pt; border-spacing: 0px;  }
    .td_temp_01{ width: 7.5%;  }
    .td_prod_01{ width: 10%;  }
    .td_prod_02{ width: 5%;  }
    .td_info_ma_01{ width: 7.5%;  }
    .td_info_pro_01{ width: 5%;  }
    .td_pro_remark_01{ width: 5%;  }
    .td_pro_remark_02{ width: 10%;  }
    .td_count_01{ width: 7.5%;  }
    .td_remark_01{ width: 71.2%;  }
    .td_btn_01{ width: 19.8%;  }

    /* label */
    label{ border-radius: 3px; color: #000000; height: 34px; max-height: 34px; line-height: 34px; text-align: center; vertical-align: middle; font-weight: bold; white-space: nowrap; margin: 0px;  }
    .label_tag_2row{ height: 74px; max-height: 74px; line-height: 74px;  }
    .label_cursor{ cursor: pointer;  }

    /* input 태그 */
    input{ border-radius: 3px; background-color: #ffffff;  }
    input:focus{ border: 2px solid #f00; outline: none; }
    input:disabled{ color: #999;  }
    .input_tag{ width: 95%; height: 34px; max-height: 34px; line-height: 34px; vertical-align: middle; font-size: 13pt; border: 0; margin: 0px 1% 0px 2%;  }
    .input_tag_date{ text-align: center;  }
    .input-number{ text-align: center;  }
    .input_tag_temp_01{ width: 74%; margin: 0px 5% 0px 4%;  }
    .input_tag_prod_01{ width: 95%; margin: 0px 0px 0px 3%;  }
    .input_tag_prod_02{ width: 87%; margin: 0px 0px 0px 3%;  }
    .input_tag_prod_02_01{ width: 88%; margin: 0px 0px 0px 3%;  }
    .input_tag_info_ma_01{ width: 71%; margin: 0px 0px 0px 2.5%;  }
    .input_tag_info_ma_02{ width: 61%; margin: 0px 0px 0px 2%;  }
    .input_tag_info_ma_03{ width: 62.5%; margin: 0px 0px 0px 2.5%;  }
    .input_tag_info_pro_01{ width: 65%; margin: 0px 0px 0px 2%;  }
    .input_tag_pro_remark_01{ width: 95%; margin: 0px 0px 0px 6%;  }
    .input_tag_pro_remark_02{ width: 92.5%; margin: 0px 0px 0px 3%;  }
    .input_tag_count_01{ width: 69%; margin: 0px 0px 0px 5%;  }
    .input_tag_readonly_01{ background-color: #eee; pointer-events: none; text-align: center;  }
    .input_tag_end_01{ width: 98%;  }
    .input_tag_end_02{ width: 78.7%;  }
    .input_tag_end_03{ width: 74.8%;  }
    .input_tag_end_04{ width: 97.5%;  }
    .input-readonly{ display: none;  }

    /* textarea */
    .textarea_tag{ width: 99.8%; height: 74px; max-height: 74px; font-size: 13pt; border-radius: 3px; margin: 0px 0.1% 0px 0.3%; padding: 0px; resize: none;  }
    textarea:focus{ border: 3px solid #f00; outline: none;  }
    textarea:disabled{ color: #ccc; background-color: #fff;  }

    /* span */
    span{ line-height: 34px; text-align: center; vertical-align: middle;  }
    .span_01{  }
    .span_02{ margin-left: 3%;  }
    .span_03{ margin-left: 1%;  }

    /* autocomplete */
    .autocomplete > div.active{ background: #333; color: #eee;  }
    .ui-autocomplete{ max-height: 300px; overflow-y: auto; overflow-x: hidden;  }
    html .ui-autocomplete{ font-size: 16px; font-family: Noto Sans KR;  }
    .ui-menu-item-wrapper{ height: 40px; line-height: 30px; vertical-align: middle;  }
    .ui-state-active{ margin: 0px !important;  }

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

            //    prk는 작업 H_생산투입전표 테이블의 생산투입전표ID   grid 에서 생성해서 가져오는것
            var prk = "<%=junID%>";

            if(seSawonid == ""){        //  부모 창에서 정보 유지중인지 확인
                alert("로그인 상태를 다시 확인해 주세요.");
                self.close();
            }else if(prk != ""){        //  prk = grid 에서 생성된 번호 완료된 작업 불러오기인지 확인
                //  데이터불러오기
                init_disp(prk);     //  번호 같이 전달

                //  기초 데이터
                $("#OLD작업일자").val($("#작업일자").val());
                $("#작업취소").attr("disabled", true);
                $("#작업시작").attr("disabled", true);
                $("#작업수정").css("display","inline");     //  수정 할수있도록 작업수정 버튼 보이게
                $("#작업종료").attr("disabled", true);
                $("#생산로트번호").val("<%=P_Lot_NO%>");

            }else if(prk == ""){        //  완료되지 않은 작업일때
                //  기초 데이터
                $("#작업수정").css("display","none");
                $(".btn_01_2").css("margin", "30px 5.8% 10px 0px");     //  작업 수정 버튼이 안보이기때문에 그에 맞춰서 위치 조정
                $("#작업일자").val(getDay());       //  오늘로 작성
                $("#작업일자").attr("min", getDay());       //  달력에서 이전 일자 선택 불가능하도록
                $("#작업일자").attr("max", getDay());       //  달력에서 이후 일자 선택 불가능하도록
                $("#작업자").val(seSawonname);

                //  창고 선언
                if(defaultStocID == 7){     //  기본창고 번호에 따라 창고명과 작업일지 이름 수정
                    $("#창고명").val("합포창고");
                    $("#t_header").text("합포작업일지");
                }else if(defaultStocID == 6){
                    $("#창고명").val("코팅창고");
                    $("#t_header").text("코팅작업일지");
                };

                //  미완료 데이터 확인
                var work_id = work_check($("#창고명").val(), $("#작업일자").val(), $("#작업자").val());     //  창고명, 작업일자, 작업자 파라메타로 전달

                //  미완료 데이터에 따라 진행중상태 혹은 새로 진행할지 준비
                if(work_id != ""){      //  미완료 데이터가 있음으로 작업진행상태
                    remain_disp(work_id);       //  진행중인 workid 파라메타로 전달
                    prk = 1;        //  시작 포커스 지정하지 않도록 prk 1로 설정 prk 찾아가면 이유 알수있음
                    $("#작업시작").attr("disabled", true);
                }else{      //  미완료 데이터 없음으로 작업시작준비
                    $("#작업종료").attr("disabled", true);
                    auto_set_date($("#작업일자").val());        //  같은날에 온도, 습도 등 데이터 있을경우 불러오기
                };
            };    //  초기 데이터 설정 end

            // ------------------------------------------------------------------------
            // 작업시작 버튼 클릭
            // ------------------------------------------------------------------------
            $("#작업시작").on("click", function(){
                if(save() == true){		//  작업 시작 후 버튼 제어
                    $("#작업시작").attr("disabled", true);
                    $("#작업종료").attr("disabled", false);
                };
            });   //  작업시작 버튼 end

            // ------------------------------------------------------------------------
            // 작업종료 버튼 클릭
            // ------------------------------------------------------------------------
            $("#작업종료").on("click", function(){
                if(inven_check() == true){		//	수정시 입력값 확인
                    if(save() == true){
                        alert("저장되었습니다.");
                        opener.main_bind();
                        self.close();
                    };
                };
            });   //  작업종료 버튼 end

            // ------------------------------------------------------------------------
            // 작업취소 버튼 클릭
            // ------------------------------------------------------------------------
            $("#작업취소").on("click", function(){
                if(confirm("정말 취소하시겠습니까 ?") == true){
                    if($("#작업시작시간").val() == ""){     //  작업시작시간 유무로 작업 시작 확인
                        alert("작업이 시작되었는지 다시 확인해주세요.");
                    }else{
                        var wareHouse = $("#창고명").val();
                        var delSawonName = $("#작업자").val();
                        var delGubun = wareHouse == "합포창고" ? "2" : wareHouse == "코팅창고" ? "3" : "false";         //  1 : 압출, 2 : 합포, 3 : 코팅, 4 : 분단, 5 : 재단
                        var delWorkId = $("#WorkID").val();
                        if(delGubun == "false"){
                            alert("지정 창고를 재확인 해주세요.");
                            return false;
                        };
                        var rst = Get_Json("EXEC RF_PROD_PDA_RF투입_ERP_CLEAR '" + delSawonName + "', '" + delGubun + "', '" + delWorkId + "'");
                        alert(rst[0].MSG);
                        location.reload();
                    };
                };
            });   //  작업취소 버튼 end

            // ------------------------------------------------------------------------
            // 작업수정 버튼 클릭
            // ------------------------------------------------------------------------
            $("#작업수정").on("click", function(){		//	입력 항목 수정할수 있도록 변경
                $(".input-field, .input-number").attr("disabled", false);
                $("#작업종료").attr("disabled", false);
                $("#작업수정").attr("disabled", true);

            });   //  작업수정 버튼 end

            // ------------------------------------------------------------------------
            // 생산수량 자동계산
            // ------------------------------------------------------------------------
            $('.auto_sum').on("keyup", function(){
                var pro_count = 0;		//	자동 계산할 값 담을 변수 선언
                for(i = 1; i < 5; i++){     //  1~ 4까지 반복
                    if($("#생산롤길이" + i).val() + "" != "" && $("#생산롤수량" + i).val() + "" != ""){		//	입력값 유무 확인 입력값이 있을때 계산 실행
                        pro_count = pro_count + parseInt($("#생산롤길이" + i).val()) * parseInt($("#생산롤수량" + i).val());
                    };
                };
                $("#생산수량").val(pro_count);		//	계산된 값 생산수량에 대입
            });   //  생산수량 자동계산 end

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
                var e = $.Event("keydown", {        // autocomplete 완료시 검색내용 확장 되도록 아래방향키 트리거 만들기
                    keyCode : 40         //  아래방향키 키코드 40   뒤에 세미콜론 붙이면 오류남
                });
                var t_this = this;		//	setTimeout에서 this 를 사용하면 this값이 변하기 때문에 사전에 this를 t_this에 담기
                setTimeout(function(){      //  바로 실행시 autoFocus 버그로 인해 포커스 사라짐 setTimeout 설정시 버그 사라짐
                    $(t_this).trigger(e);        // 아래 방향키 트리거 작동
                }, 100);
                if(this.id == "날씨" || this.id == "장비구분"){     // 오토포커스 지우고 이거 추가함
                    return;
                }else{
                    $(this).trigger(e);
                };
            });   //  아래방향키 트리거 end

            $("#날씨, #장비구분").on("focus", function(){      // 이걸해야 입력값과 상관없이 검색어 창을 보여주는데 그러면 autoFocus가 고장남...
                $(this).autocomplete("search", "");             // 그래서 autoFocus 지우고 트리거로 autoFocus 대신 추가 작성함
            });

            // ------------------------------------------------------------------------	
            // 투입수량 old 저장                                                                                    수정 에서만 사용 ?
            // ------------------------------------------------------------------------	
            $(".must_03_04").focusin(function(){
                var className = $(".must_03_04");
                var className_old = $(".oldGlu");
                if((prk > 1) && $("#OLD작업일자").val() == $("#작업일자").val()){
                    for(i = 1; i < className.length; i++){
                        if($("#" + className_old[i].id + "").val() == "0"){
                            $("#" + className_old[i].id + "").val($("#" + className[i].id + "").val());
                        };
                    };
                };
            });   //  투입수량 old 저장 end

            // ------------------------------------------------------------------------
            // #Heating 2 라인 보이기 라벨 클릭시
            // ------------------------------------------------------------------------
            $("#Heating").on("click", function(){
                $(".tr_hide").toggle();     //  보이게 안보이게 하는 Method
                // if($(".tr_hide").css("display") == "none"){      //  display 상태를 확인하고 display 상태를 변경
                //     $(".tr_hide").slideDown("slow");       //  slideDown / slideUp 쓰려면 jquery 버전 바꿔야 함 /jquery/3.6.4/jquery.min.js
                //     $(".tr_hide").css("display", "table");
                // }else{
                //     $(".tr_hide").css("display", "none");
                //     $(".tr_hide").slideUp("slow");
                // };
            });   //  라인 보이기 end

            // ------------------------------------------------------------------------
            // #Heating 2 라인 보이기2 input 포커스시
            // ------------------------------------------------------------------------
            $("#Heating_SV, #Heating_PV").on("focus", function(){       //  toggle 사용시 화면이 열려있을때는 사라지기 때문에 css Method로 보이게만 처리
                if($(".tr_hide").css("display") == "none"){     //  display 상태를 확인하고 display 상태를 변경
                    $(".tr_hide").css("display", "table");
                };
            });   //  라인 보이기 end

            // ------------------------------------------------------------------------	
            // 시작시 포커스
            // ------------------------------------------------------------------------	
            if(prk + "" == ""){     //  불러올 작업이 없을때만 실행되는것이나 마찬가지
                $("#장비구분").focus();
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
            var rst = Get_Json("B_WORK_LST 'G_WorkDiary_합포', " + id);		//	데이터 가져오도록 sql 실행
            if(rst[0].WorkID == "" || rst[0].WorkID == " " || rst[0].WorkID == null){
                alert("작업일지가 등록되지 않았습니다.");
                self.close();
            }else{
                $("#WorkID").val(rst[0].WorkID);
                $("#창고명").val(rst[0].창고명);
                if($("#창고명").val() == "합포창고"){
                    $("#t_header").text("합포작업일지");
                }else if($("#코팅창고")){
                    $("#t_header").text("코팅작업일지");
                };
                $(".input-field, .input-number, .input-readonly").each(function(){
                    $(this).attr("disabled", true);      //  읽기 전용으로 불러오기
                    if($(this).attr("type") == "text" || $(this).attr("type") == "date" || $(this).attr("type") == "textarea" || $(this).attr("type") == "hidden"){		// 가져온 데이터 input항목에 입력
                        var field = rst[0][this.id] + "";
                        field = (field == 0 || field == "null") ? "" : field;
                        if(this.id == "작업일자"){		//	작업일자의 경우 데이터 일부 수정
                            $("#" + this.id).val(field.substring(0, 10));       //  db에 저장된 작업일자에 시간값 제거
                        // }else if(this.id == "작업시작시간"){
                        //     $("#" + this.id).val(field.substring(11, 16));      //  db에 저장된 작업시작시간에 날자값 제거
                        // }else if(this.id == "작업종료시간"){     //  날자값 제거할 이유가 없음으로 그대로 가져오기
                        //     $("#" + this.id).val(field.substring(11, 16));      //  db에 저장된 작업종료시간에 날자값 제거
                        }else{
                            $("#" + this.id).val(field);
                        };
                    }else if($(this).attr("type") == "checkbox"){		//	체크박스의 경우 체크 형태로 입력
                        $("input:checkbox[id='" + this.id + "']").prop("checked", rst[0][this.id]);        //  글루 여부 확인
                    };
                });
                if($("#글루").is(":checked")){      //  글루 여부 확인후 내용 수정
                    $("#글루여부").text("글루");
                    $("#글루비고").css("background-color", "#FFEAD5");    
                };
                for(i = 1; i < 11; i++){        //  추가 글루 여부 확인후 내용 수정
                    if($("#글루" + i).is(":checked")){
                        $("#글루여부" + i).text("글루" + i);
                        $("#원단비고" + i).css("background-color", "#FFEAD5");    
                    };
                };
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
            var rst = Get_Json("B_WORK_CHECK 'G_WorkDiary_합포', '" + war_name + "', '" + work_date + "', '" + worker + "'");

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
            var rst = Get_Json("B_WORK_LST_REMAIN 'G_WorkDiary_합포'," + id);		//	압출테이블에 저장된 데이터중 진행중인 데이터 반환
            if(rst[0].WorkID != ""){		//	진행중인 데이터가 있을경우 실행
                $("#WorkID").val(rst[0].WorkID);
                $("#창고명").val(rst[0].창고명);
                $(".input-field, .input-number, .input-readonly").each(function(){
                    if($(this).attr("type") == "text" || $(this).attr("type") == "date" || $(this).attr("type") == "textarea" || $(this).attr("type") == "hidden"){
                        var field = rst[0][this.id] + "";
                        field = ((field == 0 || field == "null") ? "" : field);
                        if(this.id == "작업일자"){
                            $("#" + this.id).val(field.substring(0, 10));       //  db에 저장된 작업일자에 시간값 제거
                        // }else if(this.id == "작업시작시간"){
                        //     $("#" + this.id).val(field.substring(11, 16));       //  db에 저장된 작업시작시간에 날자값 제거
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
            $('.input-field, .input-number, .input-readonly').each(function(){
                if($(this).attr("type") == "text" || $(this).attr("type") == "date" || $(this).attr("type") == "hidden" || $(this).attr("type") == "textarea"){
                    t_val = $(this).val();
                }else if($(this).attr("type") == "checkbox"){
                    t_val = ($(this).is(":checked") == true ? 1 : 0);
                }else if($(this).attr("type") == "select-one"){
                    t_val = ($(this).val() == null ? 0 : $(this).val());
                };
                if(this.id.includes("온도") || this.id.includes("장력") || this.id == "와인딩속도" || this.id == "RPM"){
                    if(t_val == "" || t_val == " "){
                        save_data += ", " + 0;
                    }else{
                        var chk_num = Get_Json("SELECT ISNUMERIC(" + t_val + ") AS TF");
                        if(chk_num[0].TF == 1){
                            save_data += ", " + t_val;
                        }else{
                            save_data += ", " + 0;
                        };
                    };
                    // if(t_val > 0){
                    //     save_data += ", " + t_val;
                    // }else{
                    //     save_data += ", " + 0;
                    // };
                }else{
                    save_data += ", '" + t_val + "'";
                };
            });
            var insert = Get_Json("EXEC [AA_WORKDIARY_합포AND코팅] '" + id + "', '" + WorkID + "'" + save_data + "");		//	save_data 선언시 마지막에 ' 포함되어있어 ' 있으면 오류발생
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
    // 재고확인 작업 종료전 작동        작업 수정시에 작동하는것으로 인지
    // ------------------------------------------------------------------------
    function inven_check(){
        try{
            var gluName = $(".must_03_01");		//	글루품명 배열
            var gluColor = $(".must_03_02");		//	글루컬러 배열
            var gluSize = $(".must_03_03");		//	글루사이즈 배열
            var gluCount = $(".must_03_04");		//	글루수량 배열
            var oldGlu = $(".oldGlu");		//	기존글루수량 배열
            for(i = 0; i < gluName.length; i++){
                if(isNaN(oldGlu[i].value) == false){
                    if(gluCount[i].value != "" || gluCount[i].value != 0){
                        var count = gluCount[i].value - oldGlu[i].value;
                        if(stock_chk(gluName[i].value, gluColor[i].value, gluSize[i].value, count) == false){
                            if(gluName[i].id == "글루품명"){
                                alert("이형지 재고 수량이 부족합니다.\n재고수량 확인 후 투입하세요.");
                                $("#" + gluCount[i].id + "").focus();
                                return false;
                            }else if(gluName[i].id == ("원단품명" + i)){
                                alert("투입품 재고수량이 부족합니다.\n재고수량 확인 후 투입하세요.");
                                $("#" + gluCount[i].id + "").focus();
                                return false;
                            };    //  이형지인지 투입품인지
                        };
                    };
                };
            };
            return true;
        }catch(err){
            alert(err.message);
        };
    };    //  재고검사 end

    // ------------------------------------------------------------------------
    //  재고검사 안의 함수
    // ------------------------------------------------------------------------
    function stock_chk(item, color, size, cnt){
        try{
            var enabled = 0;
            var date = $("#작업일자").val();
            var wareID = defaultStocID;   //    5 : 압출창고, 7 : 합포창고, 6 : 코팅창고
            var rst_item = Get_Json("SELECT * FROM [dbo].[Get_ITEMSIZE](1) WHERE 아이템품명 = '" + item + "' AND 칼라 = '" + color + "' AND 사이즈 = '" + size + "'");
            var itemID = rst_item[0].아이템ID;
            var colorID = rst_item[0].칼라ID;
            var sizeID = rst_item[0].사이즈ID;
            var rst_check = Get_Json("EXEC [H_Stock_NEW_CHUL_CHECK_RST] '" + date + "', '" + wareID + "', '" + itemID + "', '" + colorID + "', '" + sizeID + "', '" + cnt + "', '생산투입전표', 0");
            enabled = rst_check[0].ENABLED;
            return enabled;
        }catch(err){
            alert(err.message);
        };
    };    //  재고검사 end

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
            var item = "";
            var color = "";
            var size = "";
            var Stoc = $("#창고명").val();
            if(id == "장비구분"){		//	기본 창고에 따라 검색어 달라지도록
                var gubun_text = Stoc == "합포창고" ? "L%" : Stoc == "코팅창고" ? "C%" : false;
                if(gubun_text == false){
                    dontFocus = 1;      // 자동완성 화살표 트리거만 작동하도록 작업
                    alert("기본창고를 재확인 해주세요.");
                    return false;
                }else{
                    t_sql = "EXEC AA_WORKDIARY_Search '" + gubun_text + "', '장비구분', ''";
                };
            }else if(id == "날씨"){		//	날씨의 경우 실행 sql문 지정
                t_sql = "EXEC AA_WORKDIARY_Search '', '날씨', ''";
            }else if(id.includes("칼라")){		//	칼라id에 맞춰 품명 id 변경
                item = id == "칼라" ? "품명" : id == "글루칼라" ? "글루품명" : id == "원단칼라1" ? "원단품명1" : id == "원단칼라2" ? "원단품명2" : id == "원단칼라3" ? "원단품명3" 
                        : id == "원단칼라4" ? "원단품명4" : id == "원단칼라5" ? "원단품명5" : id == "원단칼라6" ? "원단품명6" : id == "원단칼라7" ? "원단품명7" : id == "원단칼라8" ? "원단품명8" 
                        : id == "원단칼라9" ? "원단품명9" : "원단품명10";
                if($("#" + item).val() == ""){
                    dontFocus = 1;      // 자동완성 화살표 트리거만 작동하도록 작업
                    alert("품명을 입력해 주세요.");
                    $("#" + item).focus();
                    return false;
                }else{
                    t_sql = "EXEC AA_WORKDIARY_Search '', '칼라', '" + $("#" + item).val() + "'";
                };
            }else if(id.includes("사이즈")){		//	사이즈id에 맞춰 품명 id 변경
                item = id == "사이즈" ? "품명" : id == "글루사이즈" ? "글루품명" : id == "원단사이즈1" ? "원단품명1" : id == "원단사이즈2" ? "원단품명2" : id == "원단사이즈3" ? "원단품명3" 
                        : id == "원단사이즈4" ? "원단품명4" : id == "원단사이즈5" ? "원단품명5" : id == "원단사이즈6" ? "원단품명6" : id == "원단사이즈7" ? "원단품명7" : id == "원단사이즈8" ? "원단품명8" 
                        : id == "원단사이즈9" ? "원단품명9" : "원단품명10";
                color = id == "사이즈" ? "칼라" : id == "글루사이즈" ? "글루칼라" : id == "원단사이즈1" ? "원단칼라1" : id == "원단사이즈2" ? "원단칼라2" : id == "원단사이즈3" ? "원단칼라3"
                        : id == "원단사이즈4" ? "원단칼라4" : id == "원단사이즈5" ? "원단칼라5" : id == "원단사이즈6" ? "원단칼라6" : id == "원단사이즈7" ? "원단칼라7" : id == "원단사이즈8" ? "원단칼라8" 
                        : id == "원단사이즈9" ? "원단칼라9" : "원단칼라10";
                if($("#" + item).val() == ""){
                    dontFocus = 1;      // 자동완성 화살표 트리거만 작동하도록 작업
                    alert("품명을 입력해 주세요.");
                    $("#" + item).focus();
                    return false;
                }else if($("#" + color).val() == ""){
                    dontFocus = 1;      // 자동완성 화살표 트리거만 작동하도록 작업
                    alert("사이즈를 입력해 주세요.");
                    $("#" + color).focus();
                    return false;
                }else{
                    t_sql = "EXEC AA_WORKDIARY_Search '', '사이즈', '" + $("#" + item).val() + "'";
                };
            }else if(id.includes("로트번호")){		//	로트번호 순번에 따라 연결하는 품명, 칼라, 사이즈 변경
                item = id == "글루로트번호" ? "글루품명" : id == "원단로트번호1" ? "원단품명1" : id == "원단로트번호2" ? "원단품명2" : id == "원단로트번호3" ? "원단품명3" 
                        : id == "원단로트번호4" ? "원단품명4" : id == "원단로트번호5" ? "원단품명5" : id == "원단로트번호6" ? "원단품명6" : id == "원단로트번호7" ? "원단품명7" 
                        : id == "원단로트번호8" ? "원단품명8" : id == "원단로트번호9" ? "원단품명9" : "원단품명10";
                color = id == "글루로트번호" ? "글루칼라" : id == "원단로트번호1" ? "원단칼라1" : id == "원단로트번호2" ? "원단칼라2" : id == "원단로트번호3" ? "원단칼라3" 
                        : id == "원단로트번호4" ? "원단칼라4" : id == "원단로트번호5" ? "원단칼라5" : id == "원단로트번호6" ? "원단칼라6" : id == "원단로트번호7" ? "원단칼라7" 
                        : id == "원단로트번호8" ? "원단칼라8" : id == "원단로트번호9" ? "원단칼라9" : "원단칼라10";
                size = id == "글루로트번호" ? "글루사이즈" : id == "원단로트번호1" ? "원단사이즈1" : id == "원단로트번호2" ? "원단사이즈2" : id == "원단로트번호3" ? "원단사이즈3" 
                        : id == "원단로트번호4" ? "원단사이즈4" : id == "원단로트번호5" ? "원단사이즈5" : id == "원단로트번호6" ? "원단사이즈6" : id == "원단로트번호7" ? "원단사이즈7" 
                        : id == "원단로트번호8" ? "원단사이즈8" : id == "원단로트번호9" ? "원단사이즈9" : "원단사이즈10";
                if($("#" + item).val() == "" || $("#" + color).val() == "" || $("#" + size).val() == ""){
                    dontFocus = 1;      // 자동완성 화살표 트리거만 작동하도록 작업
                    alert("로트번호를 확인하기 위해\n투입품 입력 정보를 재확인 해주세요.");
                    var focus = $("#" + item).val() == "" ? item : $("#" + color).val() == "" ? color : size;
                    $("#" + focus).focus();
                    return false;
                }else{
                    t_sql = "EXEC [AA_WORKDIARY_LOTNO] '', '" + $("#작업자").val() + "', '" + $("#" + item).val() + "', '" + $("#" + color).val() + "', '" + $("#" + size).val() + "', '" + Stoc + "'";
                };
            };
            var find_rst = "";		//	실행시킬 sql문 담을 변수 생성
            var find_data_array = new Array();		//	sql의 정보 반환 받을 데이터 Array 생성
            if(id.includes("품명")){		//	품명의 경우 페이지 로드시 바로 sql 실행하여 담아두어 함수 실행 변수로 받아온것 사용
                find_rst = item_sql;
            }else if(id.includes("로트번호")){
                //Get_Json_Before() // 프로그래스바 실행
                $("#"+ id).css("background-color", "#eee");
                Get_Json_common_direct2(t_sql);     // 전달시 id값 전달하지 않음
                G_LotID = id;       // 전달하지 않은 id값을 위해 변수 지정
                // 가져오기완료후 Get_Json_After2 실행됨
                return;
            }else{		//	그 외의 경우 sql문 Get_Json()으로 실행
                find_rst = Get_Json(t_sql);
            };
            find_data_array[id] = find_rst;
            if(id.includes("로트번호")){
                if(find_rst[0]["FieldName"] == "" | find_rst[0]["FieldName"] == " "){        //  데이터가 없는경우 move_next 발동시키키위한 다음으로 넘어가기 삽입
                    find_data_array.push("조회 내용이 없습니다. 다음으로 넘어가기");
                }else{		//	로트번호의 경우 지정한 별칭(AS(Alias))이 다르기 때문에 다르게 작성
                    for(var i in find_rst){
                        find_data_array.push(find_rst[i]["FieldName"]);
                    };
                };
            }else{
                if(find_rst[0]["FND_DATA"] == "" | find_rst[0]["FND_DATA"] == " "){
                    find_data_array.push("조회 내용이 없습니다. 다음으로 넘어가기");
                }else{
                    for(var i in find_rst){
                        find_data_array.push(find_rst[i]["FND_DATA"]);
                    };
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
                    var t_this = this;
                    if(this.id == "사이즈"){       //  사이즈 입력시 이전 입력 내용 불러오기
                        auto_set($("#품명").val(), $("#칼라").val(), $(this).val(), 2);
                        return;
                    };
                    setTimeout(function(){
                        move_next(t_this);
                    }, 100);
                },
                focus : function(event, ui){    //  focus 시 이벤트    한글과 사용시 나머지가 사라지는 버그가 있다 ? 리턴펄스시 무시한다고함
                    return false;
                },
                change : function(event, ui){    //  change 시 이벤트
                    if(this.id.includes("품명") == true){       //  품명, 칼라, 사이즈 종류 입력시 입력내용 확인        select 에서 작동시 선택한 값에서만 작동하기 때문에 작성내용 확인 위해 change 작동
                        if(autocom_valid("품명", $(this).val(), "") == "0"){
                            dontFocus = 1;      // 자동완성 화살표 트리거만 작동하도록 작업
                            $(this).val("");
                            $(this).focus();
                            return false;
                        };
                    };
                    if(this.id.includes("칼라") == true){
                        item = id == "칼라" ? "품명" : id == "글루칼라" ? "글루품명" : id == "원단칼라1" ? "원단품명1" : id == "원단칼라2" ? "원단품명2" : id == "원단칼라3" ? "원단품명3" 
                                : id == "원단칼라4" ? "원단품명4" : id == "원단칼라5" ? "원단품명5" : id == "원단칼라6" ? "원단품명6" : id == "원단칼라7" ? "원단품명7" : id == "원단칼라8" ? "원단품명8" 
                                : id == "원단칼라9" ? "원단품명9" : "원단품명10";
                        if(autocom_valid("칼라", $(this).val(), $("#" + item).val()) == "0"){
                            dontFocus = 1;      // 자동완성 화살표 트리거만 작동하도록 작업
                            $(this).val("");
                            $(this).focus();
                            return false;
                        };
                    };
                    if(this.id.includes("사이즈") == true){
                        item = id == "사이즈" ? "품명" : id == "글루사이즈" ? "글루품명" : id == "원단사이즈1" ? "원단품명1" : id == "원단사이즈2" ? "원단품명2" : id == "원단사이즈3" ? "원단품명3" 
                                : id == "원단사이즈4" ? "원단품명4" : id == "원단사이즈5" ? "원단품명5" : id == "원단사이즈6" ? "원단품명6" : id == "원단사이즈7" ? "원단품명7" : id == "원단사이즈8" ? "원단품명8" 
                                : id == "원단사이즈9" ? "원단품명9" : "원단품명10";
                        if(autocom_valid("사이즈", $(this).val(), $("#" + item).val()) == "0"){
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
    //  최근입력한 투입자재, 기계정보 자동입력
    // ------------------------------------------------------------------------
    function auto_set(item, color, size, count){
        try{
            var rst = Get_Json("[B_WORK_Auto_MAT] 'G_WorkDiary_합포','"
                                    + item    + "','"
                                    + color    + "','"
                                    + size   + "'");
            if (rst[0].품명 == item && rst[0].칼라 == color && rst[0].사이즈 == size){
                if(confirm("이전 생산한 투입품을 자동으로 추가하시겠습니까 ?") == true){
                    for(i = 0; i < count; i++){		//	.auto-mat과 .machine-set 을 가진 곳에 입력 시키기 위해 2회 실행
                        var cl = (i == 0 ? '.auto-mat' : '.machine-set');
                        var classArray = $("" + cl + "");
                        for(n = 0; n < $("" + cl + "").length; n++){
                            var classId = classArray[n].id;
                            if(classArray[n].type == "text"){		//	타입이 일치하는경우 입력값 작성하도록 추가적인 타입이 있을경우 || 으로 추가
                                var field = rst[0][classId] + "";
                                field = ((field == 0 || field == "null") ? "" : field);
                                $("#" + classId + "").val(field);
                            };
                        };
                    };
                    $("#생산롤길이1").focus();
                    return;
                }else {
                    $("#생산롤길이1").focus();
                    return;
                };
            };
            $("#생산롤길이1").focus();
        }catch(err){
            alert(err.message);
        };
    };    //  최근입력한 투입자재, 기계정보 자동입력 end

    // ------------------------------------------------------------------------
    // 투입품 글루 바꾸기, 여부 체크
    // ------------------------------------------------------------------------
    function check_glu(count, id){
        if($("#" + id).is(":checked")){		// 체크 된 상태인지
            $("#글루여부" + count).text("투입품명" + count);		//	체크 안된 상태 만들기
            $("#" + id).prop("checked", false);
            if(count == ""){
                $("#글루비고").css("background-color", "#fff");
            }else{
                $("#원단비고" + count).css("background-color", "#fff");
            };
        }else{		//	체크 된 상태 만들기
            $("#글루여부" + count).text("글루" + count);
            $("#" + id).prop("checked", true);
            if(count == ""){
                $("#글루비고").css("background-color", "#FFEAD5");
            }else{
                $("#원단비고" + count).css("background-color", "#FFEAD5");
            };
        };
    };      //  투입품 글루 바꾸기, 여부 체크 end

    // ------------------------------------------------------------------------
    // 투입품 번호 바꾸기
    // ------------------------------------------------------------------------
    function changeDeisplay() {
        $("#ingredient_01").toggle();		//	보이기 안보이기 처리
        $("#ingredient_02").toggle();
        if($("#changeInput").text() == "다음투입"){		//	누름에 따라 text 변경
            $("#changeInput").text("이전투입");
        }else if($("#changeInput").text() == "이전투입"){
            $("#changeInput").text("다음투입");
        };
    };    //  투입품 번호 바꾸기 end

    // ------------------------------------------------------------------------
    // 다음칸 이동
    // ------------------------------------------------------------------------
    function move_next(ctl){
        try{
            var inputs = $(ctl).closest(".bottom").find(".input_tag:visible");
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
    //  auto_set_date 같은 날짜 날씨 온도 셋팅
    // ------------------------------------------------------------------------
    function auto_set_date(date){
        try{
            var rst = Get_Json("[B_WORK_Auto_date] 1,'" + date + "'");		//	날짜를 파라미터로 전달
            if (rst[0].날씨 != ""){		//	날씨 의 데이터가 있을경우 관련 데이터 가져오기
                $(".set-date").each(function(){
                    if($(this).attr("type") == "text"){
                        var field = rst[0][this.id] + "";
                        field = ((field == 0 || field == "null") ? "" : field);
                        $("#" + this.id).val(field);
                    };
                });
            };
        }catch(err){
            alert(err.message);
        };
    };    //    같은 날짜 날씨온도 셋팅 end

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
        var day2 = date.toISOString();      // 날자값만 남기기
        console.log(date)
        console.log(day)
        console.log(day2)
        return day;
    };    //  오늘 날짜 end


</script>


<body>
  
    <div class="TopBtn">
        <div id="title_bar">
            <img id="title_bar_img" src ="../image/title/title2.png">
            <p id="t_header">작업일지</p>
        </div>

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
                    <td class="td_01" colspan="2;">
                        <input type="text" id="작업일자" class="input_tag input-field datepicker" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">작업시간</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="작업시간" class="input_tag input-field" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">장비</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="장비구분" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">작업자</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="작업자" class="input_tag input_tag_readonly_01 input_tag_end_01 input-field " tabindex="-1" readonly>
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">날씨</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="날씨" class="input_tag input-field set-date input-auto" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">온도</label>
                    </th>
                    <td class="td_01 td_temp_01">
                        <input type="text" id="오전온도" class="input_tag input_tag_temp_01 input-number set-date" autocomplete="off"><span>&#176;C</span>
                    </td>
                    <td class="td_01 td_temp_01">
                        <input type="text" id="오후온도" class="input_tag input_tag_temp_01 input-number set-date" autocomplete="off"><span>&#176;C</span>
                    </td>

                    <th class="th_01">
                        <label class="label_tag">습도</label>
                    </th>
                    <td class="td_01 td_temp_01">
                        <input type="text" id="오전습도" class="input_tag input_tag_temp_01 input-number set-date" autocomplete="off"><span>%</span>
                    </td>
                    <td class="td_01 td_temp_01">
                        <input type="text" id="오후습도" class="input_tag input_tag_temp_01 input-number set-date" autocomplete="off"><span>%</span>
                    </td>

                    <th class="th_01">
                        <label class="label_tag">비고</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="비고" class="input_tag input_tag_end_01 input-field" autocomplete="off" spellcheck="false">
                    </td>
                </tr>
            </table>
        </div>

        <div class="item_insert">
            <table class="item">
                <tr>
                    <th class="th_01">
                        <label class="label_tag">생산품명</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="품명" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">칼라</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="칼라" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">사이즈</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="사이즈" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="생산로트번호" class="input_tag input_tag_readonly_01 input_tag_end_01 input-field " tabindex="-1" readonly>
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">생산길이 1</label>
                    </th>
                    <td class="td_01 td_prod_01">
                        <input type="text" id="생산롤길이1" class="input_tag input_tag_prod_01 input-number auto_sum" autocomplete="off">
                    </td>
                    <td class="td_01 td_prod_02">
                        <input type="text" id="생산롤수량1" class="input_tag input_tag_prod_02 input-number auto_sum" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">생산길이 2</label>
                    </th>
                    <td class="td_01 td_prod_01">
                        <input type="text" id="생산롤길이2" class="input_tag input_tag_prod_01 input-number auto_sum" autocomplete="off">
                    </td>
                    <td class="td_01 td_prod_02">
                        <input type="text" id="생산롤수량2" class="input_tag input_tag_prod_02_01 input-number auto_sum" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">생산길이 3</label>
                    </th>
                    <td class="td_01 td_prod_01">
                        <input type="text" id="생산롤길이3" class="input_tag input_tag_prod_01 input-number auto_sum" autocomplete="off">
                    </td>
                    <td class="td_01 td_prod_02">
                        <input type="text" id="생산롤수량3" class="input_tag input_tag_prod_02_01 input-number auto_sum" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">생산길이 4</label>
                    </th>
                    <td class="td_01 td_prod_01">
                        <input type="text" id="생산롤길이4" class="input_tag input_tag_prod_01 input-number auto_sum" autocomplete="off">
                    </td>
                    <td class="td_01 td_prod_02">
                        <input type="text" id="생산롤수량4" class="input_tag input_tag_prod_02_01 input_tag_end_04 input-number auto_sum" autocomplete="off">
                    </td>
                </tr>
            </table>

            <table class="item">
                <tr>
                    <th class="th_01">
                        <label id="Heating" class="label_tag label_cursor">Heating('C)</label>
                    </th>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;&nbsp;SV&nbsp;</span><input type="text" id="Heating_SV" class="input_tag input_tag_info_ma_01 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">PV&nbsp;&nbsp;</span><input type="text" id="Heating_PV" class="input_tag input_tag_info_ma_01 input-number machine-set" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">작업속도</label>
                    </th>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;WIND&nbsp;</span><input type="text" id="와인딩속도" class="input_tag input_tag_info_ma_02 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;RPM&nbsp;&nbsp;</span><input type="text" id="RPM" class="input_tag input_tag_info_ma_02 input-number machine-set" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">완제품두께</label>
                    </th>
                    <td class="td_01 td_info_pro_01">
                        <span class="span_02">&nbsp;&nbsp;좌&nbsp;</span><input type="text" id="완제품후도_좌" class="input_tag input_tag_info_pro_01 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_pro_01">
                        <span class="span_02">&nbsp;중&nbsp;</span><input type="text" id="완제품후도_중" class="input_tag input_tag_info_pro_01 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_pro_01">
                        <span class="span_02">우&nbsp;&nbsp;</span><input type="text" id="완제품후도_우" class="input_tag input_tag_info_pro_01 input-number machine-set" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">생산수량</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="생산수량" class="input_tag input_tag_readonly_01 input_tag_end_01 input-number " tabindex="-1" readonly>
                    </td>
                </tr>

            </table>

            <table class="item">
                <tr class="tr_hide">
                    <th class="th_01">
                        <label class="label_tag">Heating_2</label>
                    </th>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;&nbsp;SV&nbsp;</span><input type="text" id="Heating_SV2" class="input_tag input_tag_info_ma_01 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">PV&nbsp;&nbsp;</span><input type="text" id="Heating_PV2" class="input_tag input_tag_info_ma_01 input-number machine-set" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">챔버온도 1</label>
                    </th>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;&nbsp;실제&nbsp;&nbsp;</span><input type="text" id="챔버온도_실제1" class="input_tag input_tag_info_ma_02 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;셋팅&nbsp;&nbsp;</span><input type="text" id="챔버온도_셋팅1" class="input_tag input_tag_info_ma_03 input-number machine-set" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">챔버온도 2</label>
                    </th>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;&nbsp;실제&nbsp;&nbsp;</span><input type="text" id="챔버온도_실제2" class="input_tag input_tag_info_ma_02 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;셋팅&nbsp;&nbsp;</span><input type="text" id="챔버온도_셋팅2" class="input_tag input_tag_info_ma_03 input-number machine-set" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">챔버온도 3</label>
                    </th>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;&nbsp;실제&nbsp;&nbsp;</span><input type="text" id="챔버온도_실제3" class="input_tag input_tag_info_ma_02 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">셋팅</span><input type="text" id="챔버온도_셋팅3" class="input_tag input_tag_info_ma_03 input_tag_end_03 input-number machine-set" autocomplete="off">
                    </td>
                </tr>

                <tr class="tr_hide">
                    <th class="th_01">
                        <label class="label_tag">챔버온도 4</label>
                    </th>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;&nbsp;실제&nbsp;&nbsp;</span><input type="text" id="챔버온도_실제4" class="input_tag input_tag_info_ma_02 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;셋팅&nbsp;&nbsp;</span><input type="text" id="챔버온도_셋팅4" class="input_tag input_tag_info_ma_03 input-number machine-set" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">챔버온도 5</label>
                    </th>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;&nbsp;실제&nbsp;&nbsp;</span><input type="text" id="챔버온도_실제5" class="input_tag input_tag_info_ma_02 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;셋팅&nbsp;&nbsp;</span><input type="text" id="챔버온도_셋팅5" class="input_tag input_tag_info_ma_03 input-number machine-set" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">챔버온도 6</label>
                    </th>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;&nbsp;실제&nbsp;&nbsp;</span><input type="text" id="챔버온도_실제6" class="input_tag input_tag_info_ma_02 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;셋팅&nbsp;&nbsp;</span><input type="text" id="챔버온도_셋팅6" class="input_tag input_tag_info_ma_03 input-number machine-set" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">챔버온도 7</label>
                    </th>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;&nbsp;실제&nbsp;&nbsp;</span><input type="text" id="챔버온도_실제7" class="input_tag input_tag_info_ma_02 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">셋팅</span><input type="text" id="챔버온도_셋팅7" class="input_tag input_tag_info_ma_03 input_tag_end_03 input-number machine-set" autocomplete="off">
                    </td>
                </tr>
            </table>
        </div>

        <div class="ingredient_insert">
            <table class="ingredient">
                <tr>
                    <th class="th_01">
                        <label id="글루여부" class="label_tag label_cursor" onclick="check_glu('', '글루')">
                            투입품명
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="글루품명" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">투입칼라</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="글루칼라" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">투입사이즈</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="글루사이즈" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">투입수량</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="글루투입수량" class="input_tag input_tag_end_01 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">기준두께</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="글루기준두께" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">측정두께</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="글루측정두께" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">장력/비고</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="글루장력" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="글루비고" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="글루로트번호" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>
            </table>

            <table id="ingredient_01" class="ingredient_01">
                <tr>
                    <th class="th_01">
                        <label id="글루여부1" class="label_tag label_cursor" onclick="check_glu('1', '글루1')">
                            투입품명 1
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단품명1" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">투입칼라</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단칼라1" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">투입사이즈</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단사이즈1" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">투입수량</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;표지</span><input type="text" id="표지수량1" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;실&nbsp;</span><input type="text" id="실수량1" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">기준두께</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단기준두께1" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">측정두께</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단측정두께1" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">장력/비고</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="원단장력1" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="원단비고1" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단로트번호1" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label id="글루여부2" class="label_tag label_cursor" onclick="check_glu('2', '글루2')">
                            투입품명 2
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단품명2" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">투입칼라</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단칼라2" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">투입사이즈</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단사이즈2" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">투입수량</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;표지</span><input type="text" id="표지수량2" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;실&nbsp;</span><input type="text" id="실수량2" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                
                    <th class="th_01">
                        <label class="label_tag">기준두께</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단기준두께2" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">측정두께</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단측정두께2" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">장력/비고</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="원단장력2" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="원단비고2" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단로트번호2" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label id="글루여부3" class="label_tag label_cursor" onclick="check_glu('3', '글루3')">
                            투입품명 3
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단품명3" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">투입칼라</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단칼라3" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">투입사이즈</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단사이즈3" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">투입수량</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;표지</span><input type="text" id="표지수량3" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;실&nbsp;</span><input type="text" id="실수량3" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">기준두께</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단기준두께3" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">측정두께</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단측정두께3" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">장력/비고</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="원단장력3" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="원단비고3" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단로트번호3" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label id="글루여부4" class="label_tag label_cursor" onclick="check_glu('4', '글루4')">
                            투입품명 4
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단품명4" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">투입칼라</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단칼라4" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">투입사이즈</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단사이즈4" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">투입수량</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;표지</span><input type="text" id="표지수량4" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;실&nbsp;</span><input type="text" id="실수량4" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">기준두께</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단기준두께4" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">측정두께</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단측정두께4" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">장력/비고</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="원단장력4" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="원단비고4" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단로트번호4" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>

                </tr>

                <tr>
                    <th class="th_01">
                        <label id="글루여부5" class="label_tag label_cursor" onclick="check_glu('5', '글루5')">
                            투입품명 5
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단품명5" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">투입칼라</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단칼라5" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">투입사이즈</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단사이즈5" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">투입수량</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;표지</span><input type="text" id="표지수량5" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;실&nbsp;</span><input type="text" id="실수량5" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">기준두께</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단기준두께5" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">측정두께</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단측정두께5" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">장력/비고</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="원단장력5" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="원단비고5" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단로트번호5" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>
            </table>

            <table id="ingredient_02" class="ingredient_02">
                <tr>
                    <th class="th_01">
                        <label id="글루여부6" class="label_tag label_cursor" onclick="check_glu('6', '글루6')">
                            투입품명 6
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단품명6" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">투입칼라</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단칼라6" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">투입사이즈</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단사이즈6" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">투입수량</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;표지</span><input type="text" id="표지수량6" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;실&nbsp;</span><input type="text" id="실수량6" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">기준두께</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단기준두께6" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">측정두께</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단측정두께6" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">장력/비고</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="원단장력6" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="원단비고6" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단로트번호6" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>

                </tr>

                <tr>
                    <th class="th_01">
                        <label id="글루여부7" class="label_tag label_cursor" onclick="check_glu('7', '글루7')">
                            투입품명 7
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단품명7" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">투입칼라</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단칼라7" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">투입사이즈</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단사이즈7" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">투입수량</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;표지</span><input type="text" id="표지수량7" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;실&nbsp;</span><input type="text" id="실수량7" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">기준두께</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단기준두께7" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">측정두께</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단측정두께7" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">장력/비고</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="원단장력7" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="원단비고7" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단로트번호7" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label id="글루여부8" class="label_tag label_cursor" onclick="check_glu('8', '글루8')">
                            투입품명 8
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단품명8" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">투입칼라</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단칼라8" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">투입사이즈</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단사이즈8" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">투입수량</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;표지</span><input type="text" id="표지수량8" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;실&nbsp;</span><input type="text" id="실수량8" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">기준두께</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단기준두께8" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">측정두께</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단측정두께8" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">장력/비고</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="원단장력8" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="원단비고8" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단로트번호8" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label id="글루여부9" class="label_tag label_cursor" onclick="check_glu('9', '글루9')">
                            투입품명 9
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단품명9" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">투입칼라</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단칼라9" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">투입사이즈</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단사이즈9" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">투입수량</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;표지</span><input type="text" id="표지수량9" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;실&nbsp;</span><input type="text" id="실수량9" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">기준두께</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단기준두께9" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">측정두께</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단측정두께9" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">장력/비고</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="원단장력9" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="원단비고9" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단로트번호9" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label id="글루여부10" class="label_tag label_cursor" onclick="check_glu('10', '글루10')">
                            투입품명10
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단품명10" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">투입칼라</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단칼라10" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">투입사이즈</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단사이즈10" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">투입수량</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;표지</span><input type="text" id="표지수량10" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;실&nbsp;</span><input type="text" id="실수량10" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">기준두께</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단기준두께10" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">측정두께</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단측정두께10" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">장력/비고</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="원단장력10" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="원단비고10" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="원단로트번호10" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>
            </table>

            <table class="ingredient">
                <tr>
                    <th class="th_01 th_remark_01">
                        <label class="label_tag label_tag_2row">특이사항</label>
                    </th>
                    <td class="td_01 td_remark_01">
                        <textarea type="text" id="특이사항" class="input_tag textarea_tag input-field" autocomplete="off" spellcheck="false"></textarea>
                    </td>
                    
                    <td class="td_01 td_btn_01">
                        <button id="changeInput" class="btn_02 btn_td_01" onclick="changeDeisplay();">다음투입</button>
                    </td>
                </tr>
            </table>
        </div>
    </div>

<!-- hidden -->
<input type='hidden' id='창고명' class='input-field'>
<input type='hidden' id='작업시작시간' class='input-field'>
<input type='hidden' id='작업종료시간' class='input-field'>
<input type='hidden' id='IP_Address' class='input-field'>
<input type='hidden' id='Item' value="">   
<input type='hidden' id='color' value="">   
<input type='hidden' id='size' value="">   
<input type='hidden' id='WorkID' value="">   
<input type='hidden' id='OLD글루투입수량' value="0" class="oldGlu">
<input type='hidden' id='OLD실수량1' value="0" class="oldGlu">
<input type='hidden' id='OLD실수량2' value="0" class="oldGlu">
<input type='hidden' id='OLD실수량3' value="0" class="oldGlu">
<input type='hidden' id='OLD실수량4' value="0" class="oldGlu">
<input type='hidden' id='OLD실수량5' value="0" class="oldGlu">
<input type='hidden' id='OLD실수량6' value="0" class="oldGlu">
<input type='hidden' id='OLD실수량7' value="0" class="oldGlu">
<input type='hidden' id='OLD실수량8' value="0" class="oldGlu">
<input type='hidden' id='OLD실수량9' value="0" class="oldGlu">
<input type='hidden' id='OLD실수량10' value="0" class="oldGlu">
<input type='hidden' id='OLD작업일자' value="0" class="oldGlu">

<input type="checkbox" id="글루" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="글루1" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="글루2" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="글루3" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="글루4" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="글루5" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="글루6" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="글루7" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="글루8" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="글루9" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="글루10" class="input-readonly" value="0" style="display:none;">


</body>
</HTML>