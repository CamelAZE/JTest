var rst_type, rst_type2
var header_merge, header_merge2
//--------------------------------------------------------------------------------
// -- 서버에서 레코드셋 받아서 json 형태로 받아오기 /(데이터타입 포함)
//--------------------------------------------------------------------------------
function Get_Json_type(t_sql, param)
{
	if (param == undefined || param == null) {
		param = "";
	}
    var temp_rst
    $.ajax({
        url:  "../../N_MAIN/global_ado_type.asp",
        type: "post",
        data: 'SP=' + t_sql + '&parm=' + param ,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        async : false, 
        cache : false,
        success: function (data) {
            //console.log(data);
            if (!data.data) {
                //alert("조회된 자료가 없습니다.");
                return "조회된 자료가 없습니다."//false;
            }
            temp_rst = data.data;
            console.log(data)
            if (data.type){
                rst_type = data.type;
            } 
            if (data.header){
                header_merge = data.header
            } 
        },
        error: function (request, status, error) {
            console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
        }
    });
    return temp_rst
}
//--------------------------------------------------------------------------------
// -- 서버에서 레코드셋 받아서 json 형태로 받아오기 /(데이터타입 미포함)
//--------------------------------------------------------------------------------
function Get_Json(t_sql, param)
{
	if (param == undefined || param == null) {
		param = "";
	}
	//console.log(t_sql+ " " + param)
    var temp_rst
    $.ajax({
        url:  "../../N_MAIN/global_ado.asp",
        type: "post",
        data: 'SP=' + encodeURIComponent(t_sql) + '&parm=' + encodeURIComponent(param) ,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        async : false, 
        cache : false,
        success: function (data) {
            //console.log(data);
            if (data==undefined){
                //alert("오류입니다.")
                return
            }

            temp_rst = data.data;
        },
        error: function (request, status, error) {
            console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			return
        }
    });
    return temp_rst
}
//--------------------------------------------------------------------------------
// -- 서버에서 레코드셋 받아서 json 형태로 받아오기
//--------------------------------------------------------------------------------
function Get_Json_async(t_sql, param)
{
	if (param == undefined || param == null) {
		param = "";
	}
    var temp_rst
    $.ajax({
        url:  "../../N_MAIN/global_ado.asp",
        type: "post",
        data: 'SP=' + encodeUTF8(t_sql) + '&parm=' + encodeUTF8(param) ,
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        dataType: "json",
        async : true, 
        cache : false,
        success: function (data) {
            //console.log(data);
            if (!data) {
                alert("조회된 자료가 없습니다.");
                return false;
            }
            temp_rst = data;
        },
        error: function (request, status, error) {
            console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
        }
    });
    return temp_rst

}
//--------------------------------------------------------------------------------
// -- 서버에서 레코드셋 받아서 json 형태로 받아오기 /(데이터타입 포함// header_merge부분은 제외)
//--------------------------------------------------------------------------------
function Get_Json_type_reg(t_sql, param)
{
	if (param == undefined || param == null) {
		param = "";
	}
    var temp_rst
    $.ajax({
        url:  "../../N_MAIN/global_ado_type_reg.asp",
        type: "post",
        data: 'SP=' + t_sql + '&parm=' + param ,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        async : false, 
        cache : false,
        success: function (data) {
            //console.log(data);
            if (!data.data) {
                //alert("조회된 자료가 없습니다.");
                return "조회된 자료가 없습니다."//false;
            }
            temp_rst = data.data;
            rst_type = data.type;
        },
        error: function (request, status, error) {
            console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
        }
    });
    return temp_rst
}
//------------------------------------------------------------------------
//   UTF8로 인코더 디코더
//------------------------------------------------------------------------
function decodeUTF8(str){
    return decodeURI(str); // 또는 return decodeURIComponent(str);
}
function encodeUTF8(str){
// 특수문자도 인코딩 하기 위해서는 encodeURIComponent 를 사용한다.
    return encodeURI(str);
}
//--------------------------------------------------------------------------------
// -- Get_Json_type_direct
// -- 기존 현황등 조회시 사용 (data, header, type 3개의 json필요 / 비동기타입) 
// -- 완료후 RM_Verify_Click_Done 실행
//--------------------------------------------------------------------------------
function Get_Json_type_direct(t_sql, param, divname)
{
	if (param == undefined || param == null) {
		param = "";
	}
	var temp_rst
	$.ajax({
		url:  "../../N_MAIN/global_ado_type_dir.asp",
		type: "post",
		data: 'SP=' + encodeUTF8(t_sql) + '&parm=' + encodeUTF8(param),
		//traditional: true,	// ajax 배열 넘기기 옵션!
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		dataType: "json",
		async : true, 
        cache : false,
		success: function (data) {	
			temp_rst = (data.data)
			rst_type = (data.type[0])
			header_merge = (data.header)
			//----------------------------------------------------------------------
            if ($("#progress_div").length > 0){
                progress_exe(80)
            }
			var t_grid_name = get_cur_tab_name(divname)	//현재선택된 탭의 탭이름 가져오기
			RM_Verify_Click_Done(temp_rst, t_grid_name, t_sql, divname)  
			//----------------------------------------------------------------------
		},
		error: function (request, status, error, data) {
			if ($("#progress_div").length > 0){
                progress_modal_init_error();
            }
			console.log(">>code:" + request.status + "\n" + ">>message:" + request.responseText + "\n" + ">>error:" + error);
			return
		},
        complete : function (){
            if ($("#progress_div").length > 0){
                clearInterval(progress_plus);
            }
        }
	})
	return temp_rst
}
//--------------------------------------------------------------------------------
// -- Get_Json_type_direct2 (그리드 여러개일때)
// -- 기존 현황등 조회시 사용 (data, header, type 3개의 json필요 / 비동기타입) 
// -- 완료후 RM_Verify_Click_Done 실행
//--------------------------------------------------------------------------------
function Get_Json_type_direct2(t_sql, param)
{

	if (param == undefined || param == null) {
		param = "";
	}
	var temp_rst
	$.ajax({
		url:  "../../N_MAIN/global_ado_type_dir.asp",
		type: "post",
		data: 'SP=' + encodeUTF8(t_sql) + '&parm=' + encodeUTF8(param),
		//traditional: true,	// ajax 배열 넘기기 옵션!
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		dataType: "json",
		async : true, 
        cache : false,
		success: function (data) {	
			temp_rst = (data.data)
			rst_type = (data.type[0])
			header_merge = (data.header)
			var t_grid_name = get_cur_tab_name()	//현재선택된 탭의 탭이름 가져오기
			RM_Verify_Click_Done(temp_rst, t_grid_name, t_sql)  
			//----------------------------------------------------------------------
		},
		error: function (request, status, error, data) {
			console.log(">>code:" + request.status + "\n" + ">>message:" + request.responseText + "\n" + ">>error:" + error);
			return
		}
	})
	return temp_rst
}
//--------------------------------------------------------------------------------
// -- 서버에서 레코드셋 텍스트타입형태로 받아서 json 형태로 받아오기
//--------------------------------------------------------------------------------
function Get_Json_direct(t_sql, param)
{
	if (param == undefined || param == null) {
		param = "";
	}
    var temp_rst
    $.ajax({
        url:  "../../N_MAIN/global_ado_dir.asp",
        type: "post",
        data:'SP=' + encodeUTF8(t_sql) + '&parm=' + encodeUTF8(param),
		traditional: true,	// ajax 배열 넘기기 옵션!
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        async : false, 
        cache : false,
        success: function (data) {
	
			temp_rst = (data.data)

        },
        error: function (request, status, error) {
            console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
        }
    });

    return temp_rst
}
//--------------------------------------------------------------------------------
// -- 동기 방식으로 사용하는 함수(실행이전, 이후에 함수를 실행한다)
//--------------------------------------------------------------------------------
function Get_Json_common_direct(t_sql, param)
{
	if (param == undefined || param == null) {
		param = "";
	}
    var temp_rst
    $.ajax({
        url:  "../../N_MAIN/global_ado_type_dir.asp",
        type: "post",
        data:'SP=' + encodeUTF8(t_sql) + '&parm=' + encodeUTF8(param),
		traditional: true,	// ajax 배열 넘기기 옵션!
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        async : true, 
        cache : false,
        beforeSend: function () {
            Get_Json_Before();
        },
        success: function (data) {
            //console.log(data)
			temp_rst = (data.data)
            rst_type = (data.type[0])
            if (typeof data.header != undefined){
                header_merge = (data.header)
            }
            Get_Json_Done(temp_rst);
        },
        error: function (request, status, error) {
            console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            Get_Json_Error();
        }
    });

    return temp_rst
}
//--------------------------------------------------------------------------------
// -- 동기 방식으로 사용하는 함수(실행이전, 이후에 함수를 실행한다) // 끝나고 실행되는 함수가 다르게 실행
//--------------------------------------------------------------------------------
function Get_Json_common_direct2(t_sql, param)
{
	if (param == undefined || param == null) {
		param = "";
	}
    var temp_rst
    $.ajax({
        url:  "../../N_MAIN/global_ado_type_dir.asp",
        type: "post",
        data:'SP=' + encodeUTF8(t_sql) + '&parm=' + encodeUTF8(param),
		traditional: true,	// ajax 배열 넘기기 옵션!
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        async : true, 
        cache : false,
        beforeSend: function () {
            //Get_Json_Before();
        },
        success: function (data) {
            //console.log(data)
			temp_rst = (data.data)
            rst_type2 = (data.type[0])
            if (typeof data.header != undefined){
                header_merge2 = (data.header)
            }
            Get_Json_Done2(temp_rst);
        },
        error: function (request, status, error) {
            Get_Json_Error2();
            console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
        }
    });

    return temp_rst
}
//--------------------------------------------------------------------------------
// --인사기록카드에서사용 / 동기 방식으로 사용하는 함수(실행이전, 이후에 함수를 실행한다) // 끝나고 실행되는 함수가 다르게 실행
//--------------------------------------------------------------------------------
function Get_Json_common_direct_HRM(t_sql, param, t_sno)
{
	if (param == undefined || param == null) {
		param = "";
	}
    var temp_rst
    $.ajax({
        url:  "../../N_MAIN/global_ado_type_dir.asp",
        type: "post",
        data:'SP=' + encodeUTF8(t_sql) + '&parm=' + encodeUTF8(param),
		traditional: true,	// ajax 배열 넘기기 옵션!
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        async : true, 
        cache : false,
        beforeSend: function () {
            //Get_Json_Before();
        },
        success: function (data) {
            //console.log(data)
			temp_rst = (data.data)
      
            Get_Json_HRM_Done(temp_rst, data.type[0], data.header, t_sno);
        },
        error: function (request, status, error) {
            Get_Json_Error2();
            console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
        }
    });

    return temp_rst
}
//------------------------------------------------------------------------	
// 데이터 받아오기 전에 실행되는
//------------------------------------------------------------------------
function Get_Json_Before() {
    progress_modal_init();      // 프로그래스바 초기화
    progress_show();            // 프로그래스바 보이기
    progress_auto_exe(0, 100)   // 프로그래스바 진행
}
//------------------------------------------------------------------------	
// 데이터 받아온뒤 실행하는 함수
//------------------------------------------------------------------------
function Get_Json_Done(temp_rst) {
    if(typeof Get_Json_After == "function"){   // 각 폼별로 실행해야할 함수/ 없으면 실행안함
        Get_Json_After(temp_rst)         
    }
    progress_exe(100)               // 프로그래스바 100%로 만들기
    setTimeout(async function(){
		await  progress_hide();
	}   , 300);                     // 프로그래스바 숨기기
}
//------------------------------------------------------------------------	
// 데이터 받아오다 오류발생시 실행하는 함수
//------------------------------------------------------------------------
function Get_Json_Error() {
    if(typeof Get_Json_Error_result == "function"){   // 각 폼별로 실행해야할 함수/ 없으면 실행안함
        Get_Json_Error_result()         
    }
    progress_hide();                // 프로그래스바 숨기기
    //alert("조회된자료가 없습니다.")  
}
//------------------------------------------------------------------------	
// 데이터 받아온뒤 실행하는 함수
//------------------------------------------------------------------------
function Get_Json_Done2(temp_rst) {
    if(typeof Get_Json_After2 == "function"){   // 각 폼별로 실행해야할 함수/ 없으면 실행안함
        Get_Json_After2(temp_rst)         
    }
}
//------------------------------------------------------------------------	
// 데이터 받아온뒤 실행하는 함수(인사기록카드전용)
//------------------------------------------------------------------------
function Get_Json_HRM_Done(temp_rst, hrm_type_rst, hrm_header_rst, t_sno) {
    if(typeof Get_Json_HRM_After == "function"){   // 각 폼별로 실행해야할 함수/ 없으면 실행안함
        Get_Json_HRM_After(temp_rst,hrm_type_rst, hrm_header_rst, t_sno)         
    }
}
//------------------------------------------------------------------------	
// 데이터 받아오다 오류발생시 실행하는 함수
//------------------------------------------------------------------------
function Get_Json_Error2() {
    if(typeof Get_Json_Error_result == "function"){   // 각 폼별로 실행해야할 함수/ 없으면 실행안함
        Get_Json_Error_result2()         
    }
}
//-----------------------------------------------------------------------
//**********************************************************************
// 프로그래스바 관련 함수 // progress_Modal, progress 등이 폼에 있어야함
//**********************************************************************
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//  프로그래스바를 포함안 modal창 보이기 (시작 10%)
//-----------------------------------------------------------------------
function progress_show(){
    $("#progress_Modal").modal('show');
    $("#progress_Modal").css("display", "block");
    progress_exe(10)
}
//-----------------------------------------------------------------------
//  프로그래스바 진행률 업데이트 (100%달성시 modal창 숨기기)
//-----------------------------------------------------------------------
function progress_exe(t_num){
    var progress_width = $("#progress_div").width()
    var bar_width = $("#progress").width()
    $("#progress").width(progress_width *(t_num/100));
    //$("#progress").text(t_num + "%")
    //if (t_num == 100){
    //    progress_hide();
    //}
}
//-----------------------------------------------------------------------
//  프로그래스바 modal창 닫기
//-----------------------------------------------------------------------
function progress_hide(){
    $("#progress_Modal").modal("hide");
    $("#progress_Modal").css("display", "none");
}
//-----------------------------------------------------------------------
//  프로그래스바 모달창 초기화(프로그래스바 색상, 메세지, 버튼 등)
//-----------------------------------------------------------------------
function progress_modal_init(){
    progress_hide();
    $("#progress").removeClass("progress-bar-warning")
    $("#progressModalLabel").text("조회중입니다. 잠시만 기다려주세요.")
    $("#modal-footer").empty()
    progress_exe(0)
}
//-----------------------------------------------------------------------
//  프로그래스바 모달창 에러창으로 변경(프로그래스바 색상, 메세지, 버튼 등)
//-----------------------------------------------------------------------
function progress_modal_init_error(){
    progress_hide();
    alert("조회된자료가 없습니다.")
    $("#verify").attr("disabled",false);
    /*
    $("#progress").addClass("progress-bar-warning")
    $("#progressModalLabel").text("조회된 자료가 없습니다.")
    $("#modal-footer").append("<button type='button' class='btn btn-secondary' onclick='progress_hide()'>닫기</button>")
    */
}
//-----------------------------------------------------------------------
//  프로그래스바 자동실행
//-----------------------------------------------------------------------
function progress_auto_exe(start_num, end_num){
    var t_prog = start_num 
    progress_plus = setInterval(function() {
        t_prog = (t_prog % 100) + 3; 
        //$("#progressModalLabel").text("조회중입니다.("+t_prog+")" )
        progress_exe(t_prog);
    } 
    , 200);
}
//------------------------------------------------------------------------	
// 날짜타입 지정
//------------------------------------------------------------------------	
function Get_SubFrmDate(T_Type) {
alert(	1 )
	if (T_Type == "00") { return } 

	var date_rst = Get_Json("Exec [H_DEFINE_SUBFRM_DATE]  " , "'" + T_Type + "'")
//	console.log(date_rst)
	var x = date_rst[0].기간부터;
	var y = date_rst[0].기간까지;


//	x="2021-12-01"
//	y="2021-12-31"
	//console.log(x + " " + y)
		$("#기간부터").val(x)
		$("#기간까지").val(y)

	if ( x === undefined || x === null){	return	};	// hschoi 추가. "#기간부터" 안쓰는데서는 여기서 종료.

		$("#년도").val(x.substring(0, 4))
}

//------------------------------------------------------------------------	
//DB에서 데이터 받아오기
//------------------------------------------------------------------------	
function RM_Verify_Click() {
    if ( $("#기간부터").val() >  $("#기간까지").val() ) 		{
		progress_modal_init_error();
		clearInterval(progress_plus);
        alert("날짜 지정이 잘못 되었습니다")
        return
    }
	//-------------------------------------------------------------------------
	// 쿼리 생성
	//-------------------------------------------------------------------------
	var strSql = "Exec [" + Procedure_Name + "] " + seSawonid  +  Sub_LIst("subform") + Sub_LIst("option")
	console.log(strSql)
	
	//-------------------------------------------------------------------------
	// DB에서 데이터 받아오기 (실행완료되면 RM_Verify_Click_Done 실행)
	//-------------------------------------------------------------------------
	t_data = Get_Json_type_direct(strSql)	
	
}
//------------------------------------------------------------------------	
//그리드 생성
//------------------------------------------------------------------------
function RM_Verify_Click_Done(t_data , t_grid_name, strSql, t_div_name) {
	
	//-------------------------------------------------------------------------
	// 그래드생성
	//-------------------------------------------------------------------------
	RM_Create(t_data, t_grid_name, t_div_name)
	
	//-------------------------------------------------------------------------
    //-조회 로그데이터 생성
	//-------------------------------------------------------------------------
    Get_Json_async("Exec [E_LOG_ERP_INS] '"+seSawonid+ "','조회','" +MenuName+ "','" + Workid +"','" + Procedure_Name + "','" + strSql.replace(/'/gi,"") + "','','"+IP_Address+"'")
    if ($("#progress_div").length > 0){ // 모달창이 있을때만 숨기기
        progress_exe(100)
        setTimeout(async function(){
            await  progress_hide();
            $("#verify").attr("disabled",false);
        }   , 300);
    }
	
}

//------------------------------------------------------------------------	
// sp명으로 직접 rm 그리드생성
//------------------------------------------------------------------------	
function RM_SP_Create(spname, param, gridname) {

    // ----------------------------------------------------------------------
    var strSql = "Exec [" + spname + "] " + param
    ///-------------------------------------------------------------------------
	// DB에서 데이터 받아오기 (실행완료되면 RM_Verify_Click_Done 실행)
	//-------------------------------------------------------------------------
	var t_data = Get_Json_type_direct(strSql)
    //console.log(strSql)
    //RM_Create(t_data, gridname) 
    //----조회 로그데이터 생성--------------------------------------------------
    //Get_Json_async("Exec [E_LOG_ERP_INS] '"+seSawonid+ "','조회','팝업("+spname+")','" + Workid +"','" + spname + "','" + strSql.replace(/'/gi,"") + "','','"+IP_Address+"'")

}


//------------------------------------------------------------------------	
//엑셀 출력버튼 
//------------------------------------------------------------------------	
function RM_PRT_PVW_Click(){
	excelExport('EXCEL')
}
//------------------------------------------------------------------------	
//프린트 출력버튼 
//------------------------------------------------------------------------	
function RM_PRT_OUT_Click(){
	excelExport('PRINT')
//	alert("프린트 출력버튼 클릭")
//    var subform_json = JSON.parse(Sub_LIst_Json("subform"))
//    var option_json = JSON.parse(Sub_LIst_Json("option"))
//    subform_json = JSON.stringify(subform_json)
//    option_json = JSON.stringify(option_json)
//    Get_Json_async("Exec [E_LOG_ERP_INS] '"+seSawonid+ "','PRINT','" +MenuName+ "','" + Workid +"','" + Procedure_Name + "','" + subform_json.replace(/'/gi,"") + " " + option_json.replace(/'/gi,"") + "','','"+IP_Address+"'")
}

//------------------------------------------------------------------------	
// null, undefined 공백으로 전환 함수
//------------------------------------------------------------------------	
function null_To_Blank(t_value, opt){
    if (t_value == "" || t_value == null || t_value == "undefined"){
             if (opt==1){ t_value = "0"  }   //--- 옵션 1 : 숫자
        else if (opt==2){ t_value = ""   }   //--- 옵션 2 : 문자
        else if (opt==3){ t_value = null }   //--- 옵션 3 : 날짜(null)
        else if (opt==4){ t_value = " "  }   //--- 옵션 4 : 기타 한칸 공백
    }
    return t_value
}

//------------------------------------------------------------------------	
// 공백, null, undefined 체크 합수 
//------------------------------------------------------------------------	
function nbu_check(t_value){
    if (typeof t_value == "undefined") { return false}
    if (t_value == "" || t_value == null || t_value == "undefined"){
        return false
    }
    return true
}
 
//------------------------------------------------------------------------	
// 등록폼 헤더부분 저장 쿼리문 생성
//------------------------------------------------------------------------	
function reg_Header_Sql_Create(temp_para , t_input){
    //console.log(t_input)
	t_input.each(function(){

		if ($(this).attr("type")=='text' || $(this).attr("type")=='hidden' || $(this).attr("type")=='date')	{	
			var t_this_val = $(this).val()
			if (t_this_val.includes("'") > 0) {
				t_this_val = t_this_val.replace(/'/g, "''")
				console.log("따옴표있음 " + t_this_val + " id " + $(this).attr("id"))
			}
			temp_para = temp_para + "'" +t_this_val +"',"
		}
		else if ($(this).attr("type")=='textarea')			{
			var t_this_val = $(this).val()
			if (t_this_val.includes("'") > 0) {
				t_this_val = t_this_val.replace("'", "\'")
			}
			temp_para = temp_para + "'" +t_this_val +"',"
		}
		else if ($(this).attr("type")=='checkbox')			{
			var t_chek =  $(this).is(':checked'); //$("input:checkbox[id='" + this.id + "']").attr("checked"); 
			temp_para = temp_para + "'" + t_chek +"',"
		}else if ($(this).attr("type")=='select')	{
            var t_select = "','0"
            if ($("#"+this.id + " > option:selected").length >= 1) {
                var t_select =  $(this).val() +"','" + $("#"+this.id + " > option:selected").attr("s_id")       // select 박스는 id도 함께저장
                //console.log(t_select)
            }
			
            temp_para = temp_para + "'" + t_select +"',"
		}else if ($(this).attr("type")=='radio' && 
                    (this.id != "인도네시아" && this.id != "베트남"))	{   // 인도네시아, 베트남은 오더등록에서 예외처림해서 제외
           
		}
	});
	return temp_para
}

//-----------------------------------------------------------------------------------
// 레코드셋이 없더라도 그리드생성을 위해 빈값으로 한줄 받아왔지만
// 한줄이고 전체 공백이라면 setData를 하지 않기위해 체크 // t_data_check = 1 이면 공백만 있는 한줄짜리 행
//-----------------------------------------------------------------------------------
function grid_Data_Check(t_rst){
    var col_cnt = 0
    var data_cnt = 0
    var t_data_check = 0
    if (typeof t_rst === undefined){ return t_data_check}    
    if (t_rst.length==1){
        $.each(t_rst[0], function(key, value){
            if (value == " "){
                data_cnt = data_cnt + 1
            }
            col_cnt = col_cnt + 1
        })
        if (col_cnt == data_cnt) {
            t_data_check = 1
        }
    }
    return t_data_check
}

//-----------------------------------------------------------------------------------
 // 엑셀 export
 // excelExportSave(url:String, async:Boolean);
 //    url : 업로드할 서버의 url, 기본값 null
 //    async : 비동기 모드로 수행여부, 기본값 false
 //-----------------------------------------------------------------------------------
 function excelExport(OPT) {
  //  dataGrid.exportOnlyData = inputForm.dataOnly.checked;
    console.log("출력")
    var sel_opt = $("#Xls_Cfg").val()
    //---데이터만, 합계만은 별도의 팝업을 띄워서 엑셀변환-----------------------------
    if (sel_opt == 1 || sel_opt == 3){ 
        // N_Excel_Export_onlySum
        var t_open_com = "/N_ERP/erp_func/N_Excel_Export_onlySum.ASP"
        var t_popup = window.open( t_open_com , "엑셀출력_합계만", "width=1000px , height=300px , scrollbars=yes");
        t_popup.focus()
        return;
    }
    var subform_json = JSON.parse(Sub_LIst_Json("subform"))
    var option_json = JSON.parse(Sub_LIst_Json("option"))
	dataGrid.exportTitles = [
		  {height:40, fontSize:18, 
				cells: [
						 {text:$("#t_header").text(), colSpan:5 , fontWeight:"bold", backgroundColor:"#286090" , color:"#ffffff"}
					  ]   
		  },
		  {height:24, fontSize:12, 
				cells: [
						 {text:"",}
					  ]   
		  },
		  {height:24, fontSize:13, 
				cells: [
                        subform_json// {text:"[기간] [부터] [까지]", colSpan:5 ,textAlign:"left"  }
					  ]   
		  },
		  {height:24, fontSize:13, 
				cells: [
                        option_json//{text:"[기간] [부터] [까지]", colSpan:5 ,textAlign:"left" }
					  ]   
		  },
		  {height:24, fontSize:12, 
				cells: [
						 {text:"",}
					  ]   
		  }
          
 
	];
 
	dataGrid.exportFooters = [
		  {height:14, text:""},
		  {height:18, fontSize:10, color:"#888888", textAlign:"left", backgroundColor:"#EEEEEE", text:"이 문서는 대외비입니다. 외부에 유출이 안되도록 유의해 주시기 바랍니다."},        // 행의 속성을 정의하여 넣습니다.
		  null                                   // 빈라인 - 라인 높이는 DataGrid의 exportFooterHeight를 따릅니다.
	];
 
	dataGrid.exportType = "xls"
	 dataGrid.exportFileName = $("#t_header").text() + getTodayTime() +  ".xls" // dataGrid.exportType;
     dataGrid.exportOnlyVisibleColumns = true;  // 보이는열만 출력되도록 변경 // 업체삼당현황등에서 숨김열로 문서전체내용이 있어서
 //  dataGrid.exportSheetName = "Sheet1";
     //23.03.01 출력프로그램을 통해서 출력됨으로 엑셀다운로드는 주석처리
	 //gridRoot.excelExportSave("", false);
     
	// excel export 실행
	//    url : 업로드할 서버의 url, 기본값 null
	//    async : 비동기 모드로 수행여부, 기본값 false

	gridRoot.excelExportUpload("/N_EXCEL/Excel_RMATE_SERVER.ASP?Sawonid=" + seSawonid + "&OPT=" + OPT , false);

  //   Get_Json_async("Exec [E_LOG_ERP_INS] '"+seSawonid+ "'," + OPT + ",'" +MenuName+ "','" + Workid +"','" + Procedure_Name + "','" + subform_json.replace(/'/gi,"") + " " + option_json.replace(/'/gi,"") + "','','"+IP_Address+"'")
 }

//-----------------------------------------------------------------------------------
/*	N_Search_Pop 사용법 
    Gubun = normal 입력값을 검색 // select : 검색값무시하고 전체 검색
    Form_Name = 메뉴의 이름 // FindTBL의 FormName // 특별한 경우 아니면 공용으로 설정
    Search_text = 검색어 값
    --------------------------------------------------------------
    Upd_Gubun = Grid   그리드에 업데이트할때 사용
            Row_Index : 선택된 값을 업데이트할 그리드의 행 인덱스
            Col_Index : 선택된 값을 업데이트할 그리드의 열 인덱스
    --------------------------------------------------------------
    Upd_Gubun = Reg   등록폼에 업데이트할때 사용
                Row_Index : 선택된 값을 업데이트할 객체ID
                Col_Index : 사용안함
    --------------------------------------------------------------
    Upd_Gubun = Reg_ID   등록폼에서 ID와 값을 함께 업데이트할때 사용
                Row_Index : 선택된 값을 업데이트할 객체ID
                Col_Index : 선택된 값의 ID를 업데이틀할 객체ID
*/
//------------------------------------------------------------------------	
// 검색창 팝업 오픈
//------------------------------------------------------------------------	
 function RM_Popup_search(t_Upd_Gubun, t_Gubun, t_MenuName,t_conname,t_search,t_rowIndex,t_colIndex, t_param1, t_param2, t_param3){
 var t_width = '400'
 var t_height = '300'
 var t_left = Math.ceil((window.screen.width - t_width)/2);
 var t_top = Math.ceil((window.screen.height - t_height)/2);

 if (t_search=="undefined" || t_search==null || t_search== " "){
    t_search = ""
 }
 if (t_param1 ==undefined || t_param1==null || t_param1 =="" ) { t_param1 =""  } else {t_param1 = ",'"+t_param1 + "'"}
 if (t_param2 ==undefined || t_param2==null || t_param2 =="" ) { t_param2 =""  } else {t_param2 = ",'"+t_param2 + "'"}
 if (t_param3 ==undefined || t_param3==null || t_param3 =="" ) { t_param3 =""  } else {t_param3 = ",'"+t_param3 + "'"}
 var t_All_Param = t_param1 + t_param2 + t_param3
 var Find_Rst = Get_Json(" [AA_GET_FINDTBL] '" +t_MenuName+ "','" + t_conname +"'")
 if (Find_Rst.length==0){
     alert("검색항목 설정되지 않았습니다.");
     return;
 }
 Sp_name ="[" +Find_Rst[0].Sp_name + "] "
 //----------FindTBL에 자료 없는 경우 ------------------------------------------
 if (Sp_name=="undefined" || Sp_name==""){
     alert("검색된 자료가 없습니다.");
     return;
 }
 //---------받아온 SP로 검색 Json 받아오기 --------------------------------------
 var t_sql = Sp_name + " '" +t_search+"'" + t_All_Param
 console.log(t_sql)
 Search_Rst =  Get_Json(t_sql)
 //---------결과가 없을경우--------------------------------------------
 if (Search_Rst){
    if (Search_Rst.length<=0){
        alert("검색된내용이 없습니다.");
        return;
    }
 }else { alert("검색결과가 없습니다."); return ;}
 //------------------------------------------------------------------------
 //  검색값이 하나일경우 팝업되지않고 자동입력
 //------------------------------------------------------------------------
 if (Search_Rst.length==1){
    var j = 0
    var t_val, t_id;
    //-----json 에서 열순서로 값을 못가져와서 첫번재, 두번재의 열을 가져오기위함---
    $.each(Search_Rst[0], function(key, value){
        if (j==0){
            t_id = value
        } else if (j==1){
            t_val = value
        }
        j = j+1
    })
    //------------------------------------------------------------------------
    //  검색값이 하나일경우 팝업되지않고 자동입력되는 함수 // 현재소스에 있음
    //------------------------------------------------------------------------
    Search_One_Select(t_Upd_Gubun, t_val, t_id, t_rowIndex, t_colIndex, "", t_conname, Search_Rst)  
    return
 }
 console.log("t_param1 " + t_param1)
 var t_open_com = "/N_ERP/erp_func/N_Search_Pop.ASP?Upd_Gubun="+t_Upd_Gubun + "&Gubun="+t_Gubun +"&Form_Name="+t_MenuName+"&Con_Name="+t_conname+"&Search_text="+t_search+"&Row_Index="+t_rowIndex+"&Col_Index="+t_colIndex+"&Param01="+t_param1+"&Param02="+t_param2+"&Param03="+t_param3
 var t_popup = window.open( t_open_com , "검색창", "width="+t_width+" , height="+t_height+" , left="+t_left+" , top ="+t_top+" ,scrollbars=yes");
 t_popup.focus()
}
//------------------------------------------------------------------------	
// 검색창 팝업 오픈 // 등록폼 웹그리드
//------------------------------------------------------------------------	
function RM_Popup_search_Edit(t_Upd_Gubun, t_Gubun, t_MenuName,t_conname,t_search,t_rowIndex,t_colIndex, t_colIdex_ID, t_param1, t_param2, t_param3){
    var t_width = '400'
    var t_height = '300'
    var t_left = Math.ceil((window.screen.width-t_width)/2);
    var t_top = Math.ceil((window.screen.height -t_height)/2);

    console.log("t_param1 "+ t_param1 + " t_param2 " + t_param2 + " t_param3 "+ t_param3)
    if (t_search=="undefined" || t_search==null || t_search== " "){
        t_search = ""
     }
     if (t_param1 == undefined || t_param1==null || t_param1 =="" ) { t_param1 =""  } else {t_param1 = ",'"+t_param1 + "'"}
     if (t_param2 == undefined || t_param2==null || t_param2 =="" ) { t_param2 =""  } else {t_param2 = ",'"+t_param2 + "'"}
     if (t_param3 == undefined || t_param3==null || t_param3 =="" ) { t_param3 =""  } else {t_param3 = ",'"+t_param3 + "'"}
     var t_All_Param = t_param1 + t_param2 + t_param3
     var Find_Rst = Get_Json(" [AA_GET_FINDTBL] '" +t_MenuName+ "','" + t_conname +"'")
     if (Find_Rst.length==0){
         alert("검색항목 설정되지 않았습니다.");
         return;
     }
     Sp_name ="[" +Find_Rst[0].Sp_name + "] "
     //----------FindTBL에 자료 없는 경우 ------------------------------------------
     if (Sp_name=="undefined" || Sp_name==""){
         alert("검색된 자료가 없습니다.");
         return;
     }
     //---------받아온 SP로 검색 Json 받아오기 --------------------------------------
     var t_sql = Sp_name + " '" +t_search+"'" + t_All_Param
     console.log(t_sql)
     Search_Rst =  Get_Json(t_sql)
     //---------결과가 없을경우--------------------------------------------
     if (Search_Rst){
        if (Search_Rst.length<=0){
            alert("검색된내용이 없습니다.");
            return;
        }
     }else { alert("검색결과가 없습니다."); return ;}
     //------------------------------------------------------------------------
     //  검색값이 하나일경우 팝업되지않고 자동입력
     //------------------------------------------------------------------------
     if (Search_Rst.length==1){
        var j = 0
        var t_val, t_id;
        //-----json 에서 열순서로 값을 못가져와서 첫번재, 두번재의 열을 가져오기위함---
        $.each(Search_Rst[0], function(key, value){
            if (j==0){
                t_id = value
            } else if (j==1){
                t_val = value
            }
            j = j+1
        })
        //------------------------------------------------------------------------
        //  검색값이 하나일경우 팝업되지않고 자동입력되는 함수 // 현재소스에 있음
        //------------------------------------------------------------------------
        Search_One_Select(t_Upd_Gubun, t_val, t_id, t_rowIndex, t_colIndex, t_colIdex_ID, t_conname, Search_Rst)  
        return
     }
  
    var t_open_com = ("/N_ERP/erp_func/N_Search_Pop.ASP?Upd_Gubun="+t_Upd_Gubun + "&Gubun="+t_Gubun +"&Form_Name="+t_MenuName+"&Con_Name="+t_conname+"&Search_text="+t_search+"&Row_Index="+t_rowIndex+"&Col_Index="+t_colIndex+"&Col_Index_ID="+t_colIdex_ID+"&Param01="+t_param1+"&Param02="+t_param2+"&Param03="+t_param3)
    var t_popup = window.open(t_open_com, "검색창", "width="+t_width+",height="+t_height+", left="+t_left+" , top ="+t_top+" ,scrollbars=yes");
	//t_popup.location.hash = t_colIdex_ID
    t_popup.focus()
   }
//------------------------------------------------------------------------	
// 검색창 팝업 오픈(모달창)
//------------------------------------------------------------------------	
function RM_Popup_search_modal(t_Upd_Gubun, t_Gubun, t_MenuName,t_conname,t_search,t_rowIndex,t_colIndex, t_colIdex_ID, t_param1, t_param2, t_param3, t_skip){
    
	if (t_search=="undefined" || t_search==null || t_search== " "){
	   t_search = ""
	}
	if (t_param1 ==undefined || t_param1==null || t_param1 =="" ) { t_param1 =""  } else {t_param1 = ",'"+t_param1 + "'"}
	if (t_param2 ==undefined || t_param2==null || t_param2 =="" ) { t_param2 =""  } else {t_param2 = ",'"+t_param2 + "'"}
	if (t_param3 ==undefined || t_param3==null || t_param3 =="" ) { t_param3 =""  } else {t_param3 = ",'"+t_param3 + "'"}
	var t_All_Param = t_param1 + t_param2 + t_param3
	var Find_Rst = Get_Json(" [AA_GET_FINDTBL] '" +t_MenuName+ "','" + t_conname +"'")
	G_Find_Rst = Find_Rst		// 전역변수
	if (Find_Rst.length==0){
		alert("검색항목 설정되지 않았습니다.");
		return;
	}
	Sp_name ="[" +Find_Rst[0].Sp_name + "] "
	//----------FindTBL에 자료 없는 경우 ------------------------------------------
	if (Sp_name=="undefined" || Sp_name==""){
		alert("검색된 자료가 없습니다.");
		return;
	}
    if (t_search.legnth > 1 && t_search.toString().substring(0,1) == " ") { t_search = t_search.toString().substring(1, t_search.length)}
	//---------받아온 SP로 검색 Json 받아오기 --------------------------------------
	var t_sql = Sp_name + " '" +t_search+"'" + t_All_Param
	console.log(t_sql)
	Search_Rst =  Get_Json(t_sql)
	G_Search_Rst = Search_Rst	// 전역변수
    //console.log(Search_Rst)
	//---------결과가 없을경우--------------------------------------------
	if (Search_Rst){
        var chk = 0
        var t_cnt = 0
        // 검색결과가 없는것은 1행은 있고 모든열리 공백이 하나있을때
        $.each(Search_Rst[0], function(key, value){ 
            t_cnt = t_cnt + 1
            if (value == " "){
                chk = chk + 1
            }
        })
        console.log(t_conname)
        console.log(t_cnt + " "  +chk)
        // 빈행일 경우
        if (chk == t_cnt){
            console.log("검색결과없음 t_param1 " + t_param1)
            if (File_Name == "REG_001_ORDERREG"){   // 오더등록일경우
                t_param1 = t_param1.replace(",", "")
                if (t_param1 == "'10422'" || t_param1 == "'10097'" || t_param1 == "'10052'"){    // 5376 LOGO, HEATTRANFER , 5376
                    if (t_conname =="칼라C"){
                        if(confirm("등록되지 않은 칼라입니다. 바로 등록하시겠습니까?")){
                            var t_sql = "EXEC [AA_REG_001_ORDERREG_COLOR_CHK] " + t_param1 + ",'" + t_search + "' , 1"
                            var t_color_rst = Get_Json(t_sql)
                            var t_color_id = t_color_rst[0].칼라ID

                            Edit_gridRoot.setItemFieldAt(t_search, t_rowIndex, "칼라") 
                            Edit_gridRoot.setItemFieldAt(t_color_id, t_rowIndex, "#칼라ID") 
                            return;
                        }
                    }else if (t_conname =="사이즈D"){
                        if(confirm("등록되지 않은 사이즈입니다. 바로 등록하시겠습니까?")){
                            var t_sql = "EXEC [AA_REG_001_ORDERREG_SIZE_CHK] " + t_param1 + ",'" + t_search + "' , 1"
                            var t_size_rst = Get_Json(t_sql)
                            var t_size_id = t_size_rst[0].사이즈ID

                            Edit_gridRoot.setItemFieldAt(t_search, t_rowIndex, "사이즈") 
                            Edit_gridRoot.setItemFieldAt(t_size_id, t_rowIndex, "#사이즈ID") 
                            return;
                        }
                    }else if (t_conname =="바이어품명"){
                        if(confirm("등록되지 않은 바이어품명입니다. 바로 등록하시겠습니까?")){
                            var t_sql = "EXEC [AA_REG_001_ORDERREG_ITEM_CHK] " + t_param1 + ",'" + t_search + "' , 1"
                            var t_size_rst = Get_Json(t_sql)

                            Edit_gridRoot.setItemFieldAt(t_search, t_rowIndex, "바이어품명") 
                            return;
                        }
                    }
                }else {     // 그외의 품번일경우
                    if (t_conname =="바이어품명"){
                        console.log("그대로입력 t_search " + t_search)
                        Edit_gridRoot.setItemFieldAt(t_search, t_rowIndex, "바이어품명") 
                        Edit_dataGrid.setEditedItemPosition( {rowIndex:t_rowIndex, columnIndex:4} )     // 칼라로 수정포지션이동 // 칼라로 이동후 수정모드가 풀려서 다시지정
                        return;
                    }
                }
				if (t_conname == "거래처담당"){
					$("#거래처담당").val(t_search)
					return;
				}
            }
            //입금내역등록 /거래처명 일치하는것 없어도 입력가능하게
            if (File_Name =="REG_019_RECEIPT_REG"){
                if (t_conname =="매출거래처명"){
                    Edit_gridRoot.setItemFieldAt("", t_rowIndex, "거래처명")        //23.08.23 일치하는거래처명 없으면 입력안되게 수정요청
                    //Edit_gridRoot.setItemFieldAt(t_search, t_rowIndex, "거래처명")    
                    return;
                }
            }
        }
        /*
	   if (Search_Rst.length<=0){
		   alert("검색된내용이 없습니다.");
		   return;
	   }
       */
	}else { alert("검색결과가 없습니다."); return ;}
	//------------------------------------------------------------------------
	//  검색값이 하나일경우 팝업되지않고 자동입력
	//------------------------------------------------------------------------
	if (Search_Rst.length==1){
	   var j = 0
	   var t_val, t_id;
	   //-----json 에서 열순서로 값을 못가져와서 첫번재, 두번재의 열을 가져오기위함---
	   $.each(Search_Rst[0], function(key, value){
		   if (j==0){
			   t_id = value
		   } else if (j==1){
			   t_val = value
		   }
		   j = j+1
	   })
	   
	   //------------------------------------------------------------------------
	   //  검색값이 하나일경우 팝업되지않고 자동입력되는 함수 // 현재소스에 있음
	   //------------------------------------------------------------------------
	   Search_One_Select(t_Upd_Gubun, t_val, t_id, t_rowIndex, t_colIndex, t_colIdex_ID, t_conname, Search_Rst)  
	   return
	}
	//------------------------------------------------------------------------
	//  검색값이 여러개여도, 아이디가 있는 항목이고, 아이디와 텍스트가 일치하면 검색안함
	//------------------------------------------------------------------------
	var id_value = $("#"+t_colIndex).val()
	var Search_Array = new Array()
    //------------------------------------------------------------------------
    // 스킵옵션이 1이고 공백인데 결과값이 여러개있을경우 검색실행안하고, 다음동작(fnAfterIns)
    //------------------------------------------------------------------------
    if (t_skip == 1 &&  t_search ==""){     
        if(t_Upd_Gubun == "Reg_ID"){
            if(typeof(fnAfterIns) == "function") {
                fnAfterIns(t_rowIndex);   //-- 항목 입력 후 추가 등록해야 하는 부분 처리함수 2022-05-27
            }
            return; 
        }   
    }
    //------------------------------------------------------------------------
    // 검색내용여러개 있을 경우 팝업
    //------------------------------------------------------------------------
	if ($("#"+t_colIndex)){
		for(var k in Search_Rst){	
			Search_Array.push(Object.values(Search_Rst[k]))		// json 형식이라, 순서로 열의 값을 찾아올수없어서 배열화함
	    }
	   	for(var j in Search_Array){
			var search_id_val = Search_Array[j][0]		// 첫번째항목은 아이디
			var search_text_val = Search_Array[j][1]	// 두번째항목은 텍스트값
			//console.log("id_value=" + id_value + " // search_id_val="+ search_id_val + " // t_search="+ t_search + " // search_text_val=" + search_text_val)
			if (id_value == search_id_val && t_search == search_text_val){
				return;
			}
	   	}
	}
	   
	var t_open_com = "/N_ERP/erp_func/N_Search_Pop_modal.ASP?Upd_Gubun="+t_Upd_Gubun + "&Gubun="+t_Gubun +"&Form_Name="+t_MenuName+"&Con_Name="+t_conname+"&Search_text="+t_search+"&Row_Index="+t_rowIndex+"&Col_Index="+t_colIndex+"&Col_Index_ID="+t_colIdex_ID+"&Param01="+t_param1+"&Param02="+t_param2+"&Param03="+t_param3
	$("#search_madal_iframe").attr("src", t_open_com)
	search_modal_show()

   }
//-----------------------------------------------------------------------
//  검색창 포함안 modal창 보이기 (시작 10%)
//-----------------------------------------------------------------------
function search_modal_show(){
    $("#search_Modal").modal('show');
    $("#search_Modal").css("display", "block");
}
//-----------------------------------------------------------------------
//  검색창 modal창 닫기
//-----------------------------------------------------------------------
function search_modal_hide(){
    $("#search_Modal").modal("hide");
    $("#search_Modal").css("display", "none");
}
//-----------------------------------------------------------------------
//  검색창 모달창 초기화(프로그래스바 색상, 메세지, 버튼 등)
//-----------------------------------------------------------------------
function search_modal_init(){
    search_modal_hide();
	$("#search_madal_iframe").empty();
	$("#search_madal_iframe").attr("src", "")
}
//-----------------------------------------------------------------------
//  검색창 모달창 에러창으로 변경(프로그래스바 색상, 메세지, 버튼 등)
//-----------------------------------------------------------------------
function search_modal_init_error(){
    search_modal_hide();
    alert("조회된자료가 없습니다.")
}
//-----------------------------------------------------------------------
//  공용 modal창 보이기 (시작 10%)
//-----------------------------------------------------------------------
function common_modal_show(t_common_modal_id, t_width, t_height, t_margin){
	//-입력받은 모달창의 크기가 없으면 기본값 ------------------------------
	if (t_margin == "" || t_margin == null || t_margin == undefined ) {t_margin = "-15%"	}
	if (t_width == ""  || t_width == null  || t_width == undefined )  {t_width = "80%"	}
	if (t_height == "" || t_height == null  || t_height == undefined ) {t_height = "90%"	}
	//-------------------------------------------------------------------
	$("#common_Modal_dialog").css("margin-top", t_margin);
	$("#common_Modal_dialog").css("width", t_width);
	$("#common_Modal_dialog").css("height", t_height)
	console.log("t_margin "+ t_margin + " t_width " + t_width + " t_height " + t_height)
	//-------------------------------------------------------------------
    $("#"+t_common_modal_id).modal('show');
    $("#"+t_common_modal_id).css("display", "block");
}
//-----------------------------------------------------------------------
//  공용 modal창 닫기
//-----------------------------------------------------------------------
function common_modal_hide(t_common_modal_id){
    $("#"+t_common_modal_id).modal("hide");
    $("#"+t_common_modal_id).css("display", "none");
}
//-----------------------------------------------------------------------
//  공용 모달창 초기화(프로그래스바 색상, 메세지, 버튼 등)
//-----------------------------------------------------------------------
function common_modal_init(t_common_modal_id, t_common_modal_iframe){
    common_modal_hide(t_common_modal_id);
	$("#"+t_common_modal_iframe).empty();
	$("#"+t_common_modal_iframe).attr("src", "")
}
//-----------------------------------------------------------------------
//  공용 모달창 에러창으로 변경
//-----------------------------------------------------------------------
function common_modal_init_error(){
    common_modal_hide();
    alert("조회된자료가 없습니다.")
}
//------------------------------------------------------------------------	
// 출력실행 //Execute_Out // opt은 B_WorkName의 Btn_Out1 ~ 3 순서
//------------------------------------------------------------------------	
function Execute_Out(opt) {
	try
	{
		if (opt=="undefined" || opt==""){ opt=1; }	
		//console.log(dataGrid)		// 그리드 객체는 전역변수
		//------------------------------------------------------------------------	
		// 공급의뢰접수현황 공급의뢰서 전체 출력기능
		//------------------------------------------------------------------------
		if (Procedure_Name=='B_CCCC010L_LST_JSON' ) {
			if (opt==1)	 {
                var t_sql = "EXEC [AA_T_TABLE_SELECT_PRK_TEXT]  '"+seSawonid+"','T공급의뢰접수현황','#OrderDetailID','선택여부', 'PERM_ID' , 2"
                console.log(t_sql)
                var sel_invoid_rst = Get_Json(t_sql)
                if (sel_invoid_rst.length <= 0){
                    alert("선택된 내역이 없습니다.")
                    return;
                }
				if (confirm("선택된 공급의뢰를 출력하시겠습니까?")) {
					var	pop
                    for (var i in sel_invoid_rst){
                        console.log("i " + i)
                        pop = window.open ("/N_EXCEL/Excel_data_down(ERP).ASP?SAWONID=" + seSawonid + "&DOCU_ID=" + "9" + "&Parm1=" + sel_invoid_rst[i]["#OrderDetailID"]  ,"공급의뢰서" + i
											,"menubar=no,toolbar=no,scrollbars=yes,status=no,location=no,resizable=yes,top=400,left=1000,width=450,height=300","help=no")
                    }
                     
					//pop.focus();
				}
				return ;
			}
		}
		//------------------------------------------------------------------------	
		// 출고대기 / 샘플등록 경동택배 엑셀전환
		//------------------------------------------------------------------------
		if (Procedure_Name=='B_CCCC140L_LST_JSON' ) {
			if (opt==1)	 {
					var	pop = window.open ("/N_EXCEL/Excel_data_down(ERP).ASP?SAWONID=" + seSawonid + "&DOCU_ID=" + "18" + "&Parm1=" + P_Cur_Permit_ID   ,"EXCEL"
											,"menubar=no,toolbar=no,scrollbars=yes,status=no,location=no,resizable=yes,top=400,left=1000,width=450,height=300","help=no")   
					pop.focus();
				return ;
			}
		}

		if (Procedure_Name=='B_CCCC150L_LST_JSON' ) {
			if (opt==1)	 {
					var	pop = window.open ("/N_EXCEL/Excel_data_down(ERP).ASP?SAWONID=" + seSawonid + "&DOCU_ID=" + "43" + "&Parm1=" + P_Cur_Permit_ID   ,"EXCEL"
											,"menubar=no,toolbar=no,scrollbars=yes,status=no,location=no,resizable=yes,top=400,left=1000,width=450,height=300","help=no")   
					pop.focus();
				return ;
			}
		}


		//------------------------------------------------------------------------	
		// 거래처품목 판매현황 ecount 엑셀전환
		//------------------------------------------------------------------------
		if (Procedure_Name=='B_CCCC250L_LST_JSON' ) {
			if (opt==1)	 {
					var	pop = window.open ("/N_EXCEL/Excel_data_down(ERP).ASP?SAWONID=" + seSawonid + "&DOCU_ID=" + "30" + "&Parm1=" + seSawonid + "&Parm2=" + $("#기간부터").val() + "&Parm3=" + $("#기간까지").val() + "&Parm4=" + $("#search").val()  ,"EXCEL"
											,"menubar=no,toolbar=no,scrollbars=yes,status=no,location=no,resizable=yes,top=400,left=1000,width=450,height=300","help=no")   
					pop.focus();
				return ;
			}
		}


		//------------------------------------------------------------------------	
		// 창고실사과부족현황 재고조사표 엑셀전환
		//------------------------------------------------------------------------
		if (Procedure_Name=='H_AAAA300L_LST_JSON' ) {
			if (opt==1)	 {
					var	pop = window.open ("/N_EXCEL/Excel_data_down(ERP).ASP?SAWONID=" + seSawonid + "&DOCU_ID=" + "20" + "&Parm1=" + seSawonid + "&Parm2=" + $("#창고id").val() + "&Parm3=" + $("#기간까지").val() ,"EXCEL"
											,"menubar=no,toolbar=no,scrollbars=yes,status=no,location=no,resizable=yes,top=400,left=1000,width=450,height=300","help=no")   
					pop.focus();

				
					pop.focus();


				return ;
			}
		}

		//------------------------------------------------------------------------	
		// 오더진행현황 CI 엑셀전환
		//------------------------------------------------------------------------
		if (Procedure_Name=='AA_ORDER_PROG_LST_JSON' ) {
			if (opt==1)	 {
					var	pop = window.open ("/N_EXCEL/Excel_data_down(ERP).ASP?SAWONID=" + seSawonid + "&DOCU_ID=" + "25" + "&Parm1=" + P_Cur_Permit_ID  ,"CI PRINT"
											,"menubar=no,toolbar=no,scrollbars=yes,status=no,location=no,resizable=yes,top=400,left=1000,width=450,height=300","help=no")   
					pop.focus();
				return ;
			}
			if (opt==2)	 {
					var	pop = window.open ("/N_EXCEL/Excel_data_down(ERP).ASP?SAWONID=" + seSawonid + "&DOCU_ID=" + "26" + "&Parm1=" + P_Cur_Permit_ID   ,"CI DIRECT"
											,"menubar=no,toolbar=no,scrollbars=yes,status=no,location=no,resizable=yes,top=400,left=1000,width=450,height=300","help=no")   
					pop.focus();
				return ;
			}
		}

		//------------------------------------------------------------------------	
		// 미판매현황 거래명세표 엑셀전환
		//------------------------------------------------------------------------
		if (Procedure_Name=='B_CCCC030L_LST_JSON' ) {
			if (opt==1)	 {
					var	pop = window.open ("/N_EXCEL/Excel_data_down(ERP).ASP?SAWONID=" + seSawonid + "&DOCU_ID=" + "4" + "&Parm1=" + seSawonid  ,"거래명세서"
											,"menubar=no,toolbar=no,scrollbars=yes,status=no,location=no,resizable=yes,top=400,left=1000,width=450,height=300","help=no")   
					pop.focus();
				return ;
			}if (opt==2){
                var t_sql = "EXEC [AA_T_TABLE_SELECT_PRK_TEXT]  '"+seSawonid+"','T미판매현황','#PRK','확인', 'PERM_ID'"
                var sel_invoid_rst = Get_Json(t_sql)
                var sel_invoid = sel_invoid_rst[0]["#PRK"]
                if (sel_invoid == "" || sel_invoid == null){
                    alert("선택된 내역이 없습니다.")
                    return;
                }
                var t_open_com = "/N_ERP/Reg_Pop/Popup_Trade_change.ASP?OrderDetailID=" + sel_invoid
				$("#common_modal_iframe").attr("src", t_open_com)
                common_modal_show("common_Modal", "30%", "35%", "")
                
            }
		}


		//------------------------------------------------------------------------	
		// 고객클레임접수현황 클레임접수증 엑셀전환
		//------------------------------------------------------------------------
		if (Procedure_Name=='B_CLAIM_RECEIPT_JSON' ) {
			if (opt==1)	 {


				var cur_cell = dataGrid.getSelectedCells()

				if (cur_cell.length<=0)	{
					alert("[err] 출력할 행을 선택 후 작업하세요")
					return
				}

                key_row_Index = cur_cell[0].rowIndex 
				var dataRow = gridRoot.getItemAt(key_row_Index);	


				
					var	pop = window.open ("/N_EXCEL/Excel_data_down(ERP).ASP?SAWONID=" + seSawonid + "&DOCU_ID=" + "23" + "&Parm1=" + dataRow["#PRK"]  ,"거래명세서"
											,"menubar=no,toolbar=no,scrollbars=yes,status=no,location=no,resizable=yes,top=400,left=1000,width=450,height=300","help=no")   
					pop.focus();
				return ;
			}
		}


        //------------------------------------------------------------------------	
		// 증명서발금
		//------------------------------------------------------------------------
        if (Procedure_Name == "A_TDB_CE_REQ_LST_MY_JSON"){
            var SP_NAME = "AA_TDB_EXCEL_OUT_CE"

            var CheckBox = gridRoot.getObjectById("#C_선택");
            var true_row = new Array;
			true_row = CheckBox.getSelectedIndices()
            //--------------------------------------------------------------------
            // 선택된 행체크
            //--------------------------------------------------------------------
            if (true_row.length <= 0){
                alert("선택된 행이 없습니다.")
                return
            }else if (true_row.length > 1){
                alert("한번에 한개의 문서만 출력가능합니다.")
                return
            }
            var select_row = true_row[0]
            var dataRow = gridRoot.getItemAt(select_row);	
            var gubun 
            var gubun_opt = 0
            var t_epid 
            //--------------------------------------------------------------------
            // 신청서 구분체크
            //--------------------------------------------------------------------
            if (dataRow["신청서구분"]=="재직증명서"){
                gubun = "재직증명서";
                gubun_opt = 1;
            }else if (dataRow["신청서구분"]=="경력증명서"){
                gubun = "경력증명서";
                gubun_opt = 2;
            }else {
                alert("구분이 잘못되었습니다.")
                return
            }
            //--------------------------------------------------------------------
            // 발급여부 체크
            //--------------------------------------------------------------------
            if (dataRow["발급일자"]=="" || dataRow["발급일자"]==null){
                alert("발급승인 되지 않은 증명서입니다.")
                return
            }
            t_epid = dataRow["#EPID"]
            var bal_no = dataRow["발급번호"]
            var PARAM = "'" + t_epid + "','" + gubun_opt + "','" + bal_no + "'"
            var DOCU_NAME = gubun     //엑셀원본 파일명
            var Pnt_Excel = "EXCEL"
            var sURL = "/N_EXCEL/Excel_data_down(Normal).ASP?SAWONID=" + seSawonid + "&SP_NAME=" + SP_NAME + "&PARAM=" + PARAM + "&DOCU_NAME=" + DOCU_NAME + "&Prt_Excel_ch=" + Pnt_Excel;
            $("#iframe_action_File").attr("src",sURL);
            return false;   
        }
	}
	catch (err)
	{  
		alert(err.message)
	}
	
}
//------------------------------------------------------------------------	
// 확정/실행버튼 // Execute_Exec // opt은 B_WorkName의 Btn_Exec1 ~ 3 순서
//------------------------------------------------------------------------
function Execute_Exec(opt) {
	try
	{
		
		//progress_modal_init();      // 프로그래스바 초기화
    	//progress_show();     
		//------------------------------------------------------------------------
		if (opt=="undefined" || opt==""){ opt=1; }
		//console.log(dataGrid)
		//------------------------------------------------------------------------	
		// 공급의뢰 접수현황 /포장작업일지 오픈
		//------------------------------------------------------------------------
		if (Procedure_Name=='B_CCCC010L_LST_JSON' ) {
			if (opt==2)	 {
				var	pop = window.open ("../../IncPopup/Popup_WORK_PACK.ASP","작업일지"
										,"menubar=no,toolbar=no,scrollbars=no,status=no,location=no,resizable=no,fullscreen=yes ","help=no")   
				pop.focus();
				return ;
			}
		}
		//------------------------------------------------------------------------	
		// Test_Request_status or C/WD _Request_status
		//------------------------------------------------------------------------
		if (Procedure_Name=='H_TEST010L_LST_JSON' || Procedure_Name=='H_TEST020L_LST_JSON' ) {
			if (opt==1)	 {   // Enroll
				document.getElementById('parm_id').value='0'
				common_Popup_Open(Procedure_Name, "버튼", "Enroll")
				return ;
			}

			if (opt==2)	 {   // Copy
				document.getElementById('parm_id').value= document.getElementById('parm_id').value*-1
				common_Popup_Open(Procedure_Name, "버튼", "Copy")
				return ;
			}

		}		
		//------------------------------------------------------------------------	
		// 예산환율등록 오픈
		//------------------------------------------------------------------------
		if (Procedure_Name=='B_MANA120W_LST_JSON' ) {
			if (opt==1)	 {
				common_Popup_Open(Procedure_Name, "버튼", "등록")
				return ;
			}
		}

		//------------------------------------------------------------------------	
		// 사원별년차등록 년차생성 
		//------------------------------------------------------------------------
		if (Procedure_Name=='사원별년차등록' ) {
			if (opt==1)	 {
				strSql = "exec [D_YUNCHA_CREATE] " + seSawonid + ",'" + $("#년도").val() + "'"
				var result = Get_Json(strSql)
				main_bind("D_Yuncha")
				return ;
			}
		}

        //------------------------------------------------------------------------	
		// 오더진행현황 => 패킹리스트
		//------------------------------------------------------------------------
		if (Procedure_Name=='AA_ORDER_PROG_LST_JSON' ) {
			if (opt==1)	 {
                var t_sql = "EXEC [AA_T_TABLE_SELECT_PRK_TEXT]  '"+seSawonid+"','T오더진행현황','#PRK','선택', 'PERM_ID'"
                var sel_orderid_rst = Get_Json(t_sql)
                var sel_orderid = sel_orderid_rst[0]["#PRK"]
                if (sel_orderid == "" || sel_orderid == null){
                    alert("선택된 내역이 없습니다.")
                    return;
                }
				var t_open_com = "/N_ERP/REG_018_PACKING_REG.ASP?OrderDetailID=" + sel_orderid
				$("#common_modal_iframe").attr("src", t_open_com)
				common_modal_show("common_Modal")
				return ;
			}
		}
        //------------------------------------------------------------------------	
		// 미발행판매내역
		//------------------------------------------------------------------------
        if (Procedure_Name=='B_CCCC030L_LST_JSON'){
            var prk_rst = Get_Json("EXEC [AA_T_TABLE_SELECT_PRK_TEXT]  '"+seSawonid+"','T미판매현황','#PRK','확인', 'PERM_ID' ")
            var tmpStringPara = prk_rst[0]["#PRK"]
            if (opt==1){    //  매출확정
                
				if (tmpStringPara == '' || tmpStringPara == null) {
					alert("[err]판매확정을 체크하신 후 확정하세요")
					return
				}

				var t_sql = "Exec Usp_PROD310L_DateChk '" + tmpStringPara + "'"	 // 계산서일자, 환율 같은지 확인  
                
				objRs = Get_Json(t_sql)
                console.log(objRs)
				if (objRs.length == 1) {
					var pop = window.open("/N_ERP/Reg_Pop/Popup_Invoice_Certain.asp?Cino=" + tmpStringPara, "계산서확인", "menubar=no,toolbar=no,scrollbars=no,status=no,location=no,resizable=no,top=300,left=350,width=850,height=410")
					pop.focus();
					return;
				} else {
					alert("[err]계산서일자 또는 환율이 서로 일치하지 않습니다.") + "\n\n" + "자료 확인 후 다시 작업하세요."
                    return;
				}

			}else if (opt==2)   // 무상처리
			{
				if (tmpStringPara == '') {
					alert("무상처리할 항목을 선택 후 확정해주십시오.")
					return
				}

				var t_sql = "Exec B_CCCC030L_무상판매_INS '" + seSawonid + "','" + tmpStringPara + "', '1' "	 // 

				//console.log(strSql)
				objRs = Get_Json(t_sql)
				alert(objRs[0]["RETURNMSG"])
				verify_click_function()
                return;
			}
        }
        //------------------------------------------------------------------------	
		// 건별매입현황 // 계산서일자변경 업데이트
		//------------------------------------------------------------------------
        if (Procedure_Name=='B_CCCC200L_LST_JSON' ) {
            var prk_rst = Get_Json("EXEC [AA_T_TABLE_SELECT_PRK_TEXT]  '"+seSawonid+"','T건별매입현황','#PRK','확인', 'PERM_ID' ")
            var tmpStringPara = prk_rst[0]["#PRK"]
            if (opt==1){    //  매출확정
                
				if (tmpStringPara == '' || tmpStringPara == null) {
					alert("[err]매입확정을 체크하신 후 확정하세요")
					return
				}                
				var pop = window.open("/N_ERP/Reg_Pop/N_Popup_purchase_Certain.asp?prk=" + tmpStringPara, "건별매입확정", "menubar=no,toolbar=no,scrollbars=no,status=no,location=no,resizable=no,top=300,left=350,width=850,height=410")
                pop.focus();
                return;
			}
        }
        //------------------------------------------------------------------------	
		// 외상매출금내역 입금등록 팝업
		//------------------------------------------------------------------------
        if (Procedure_Name=="B_CCCC040L_LST_NEW_JSON"){
            // AA_RMGRID_GLOBVAL_BTN 에서 모달 팝업되게 처리 

            //var t_open_com = "/N_ERP/Reg_Pop/Popup_ReceiptReg_New.ASP?VendorID=" + dataRow["#VENDORID"] + "&ReceiptBasicID=" + PRK
            //$("#common_modal_iframe").attr("src", t_open_com)
            //common_modal_show("common_Modal")
        }
        //------------------------------------------------------------------------	
		// 단가등록조회 단가변경 팝업 // 서브폼을 파라매터로 보내야해서 까다로워서 소스에서 처리
		//------------------------------------------------------------------------
        if (Procedure_Name=="B_CCCC300L_LST_JSON"){
            var t_customer_id = $("#VendorID").val()
            var t_item_id = $("#아이템ID").val()
            var t_color_id = $("#칼라ID").val()
            var t_size_id = $("#사이즈ID").val()
            var t_open_com = "/N_ERP/Reg_Pop/Popup_DANGA.ASP?VENDORID=" + t_customer_id + "&ITEMID=" + t_item_id
                            + "&COLORID=" + t_color_id + "&SIZEID=" + t_size_id + "&seSawonid=" + seSawonid
            $("#common_modal_iframe").attr("src", t_open_com)
            common_modal_show("common_Modal", "50%", "40%", "")
            return;
        }
        //------------------------------------------------------------------------	
		// 판매단가변경 거래처단가변경 팝업 // t테이블이 없어서, 소스에서 처리
		//------------------------------------------------------------------------
        if (Procedure_Name=="B_SJ_WONGA_PRICE_LST_JSON"){
            if (opt==1)	 {
                var cur_cell = dataGrid.getSelectedCells()
                if (cur_cell.length <= 0) { alert("선택된 내역이 없습니다."); return; }
                else if (cur_cell.length > 1) { alert("하나의 행만 선택해주세요."); return; }
                key_row_Index = cur_cell[0].rowIndex 
                key_col_index = cur_cell[0].columnIndex
                var dataRow = gridRoot.getItemAt(key_row_Index);	
                var t_wonga_id = dataRow["#PRK"]
                //console.log(dataRow)
                //alert(t_wonga_id)
                var t_open_com = "/N_ERP/Reg_Pop/Popup_Wonga_Customer_Price.ASP?ID="+ t_wonga_id 
                $("#common_modal_iframe").attr("src", t_open_com)
                common_modal_show("common_Modal", "70%", "40%", "")
                return;
            }
        }
		//------------------------------------------------------------------------	
		// 창고재고현황 / 창고이동버튼
		//------------------------------------------------------------------------
        if (Procedure_Name=="H_AAAA180L_LST_JSON"){
			if (opt==3)	 {
				if (!dataGrid) { alert("조회 후 사용 가능합니다."); return;}
				var cur_cell = dataGrid.getSelectedCells()
                if (cur_cell.length <= 0) { alert("선택된 내역이 없습니다."); return; }
                else if (cur_cell.length > 1) { alert("하나의 행만 선택해주세요."); return; }
                key_row_Index = cur_cell[0].rowIndex 
                key_col_index = cur_cell[0].columnIndex
                var dataRow = gridRoot.getItemAt(key_row_Index);	
				var t_stock_id 	= dataRow["#창고ID"]
                var t_item 		= dataRow["#D_아이템품명"]
				var t_color 	= dataRow["칼라"]
				var t_size 		= dataRow["사이즈"]
				var t_item_id 	= dataRow["#아이템ID"]
				var t_color_id 	= dataRow["#칼라ID"]
				var t_size_id 	= dataRow["#사이즈ID"]
				var t_lotno 	= dataRow["로트번호"]
				var t_stock_cnt = dataRow["#D_기말재고"]
				var t_stock_name= dataRow["창고명"]

				if (t_stock_cnt <=0 ){
					alert("마이너스재고는 이동이 불가합니다.")
					return;
				}

				var t_param= seSawonid + "&STOCKID=" + t_stock_id + "&ITEMID=" + t_item_id + "&COLORID=" + t_color_id + "&SIZEID=" + t_size_id 
							+ "&ITEM=" + t_item + "&COLOR=" + t_color + "&SIZE=" + t_size + "&LOTNO=" + t_lotno + "&STOCK_CNT=" + t_stock_cnt + "&STOCK=" + t_stock_name
				common_Popup_Open(Procedure_Name, "버튼", "창고이동", t_param)
				return;
			}
        }
		//------------------------------------------------------------------------	
		// 장기재고현황 / 창고이동버튼
		//------------------------------------------------------------------------
        if (Procedure_Name=="H_AAAA180L_LST_LONG_JSON"){
			if (opt==1)	 {
				if (!dataGrid) { alert("조회 후 사용 가능합니다."); return;}
				var cur_cell = dataGrid.getSelectedCells()
                if (cur_cell.length <= 0) { alert("선택된 내역이 없습니다."); return; }
                else if (cur_cell.length > 1) { alert("하나의 행만 선택해주세요."); return; }
                key_row_Index = cur_cell[0].rowIndex 
                key_col_index = cur_cell[0].columnIndex
                var dataRow = gridRoot.getItemAt(key_row_Index);	
				var t_stock_id 	= dataRow["#창고ID"]
                var t_item 		= dataRow["#D_아이템품명"]
				var t_color 	= dataRow["칼라"]
				var t_size 		= dataRow["사이즈"]
				var t_item_id 	= dataRow["#아이템ID"]
				var t_color_id 	= dataRow["#칼라ID"]
				var t_size_id 	= dataRow["#사이즈ID"]
				var t_lotno 	= dataRow["로트번호"]
				var t_stock_cnt = dataRow["기말재고"]

				if (t_stock_cnt <=0 ){
					alert("마이너스재고는 이동이 불가합니다.")
					return;
				}

				var t_param= seSawonid + "&STOCKID=" + t_stock_id + "&ITEMID=" + t_item_id + "&COLORID=" + t_color_id + "&SIZEID=" + t_size_id 
							+ "&ITEM=" + t_item + "&COLOR=" + t_color + "&SIZE=" + t_size + "&LOTNO=" + t_lotno + "&STOCK_CNT=" + t_stock_cnt
				common_Popup_Open(Procedure_Name, "버튼", "창고이동", t_param)
				return;
			}
        }
		//------------------------------------------------------------------------	
		// 실사과부족현황 재고조정
		//------------------------------------------------------------------------
		if (Procedure_Name=="H_AAAA300L_LST_JSON"  ){

			var	strTitle =  (opt == 1?"재고조정 작업":"재고조정취소 작업")

			if (confirm(strTitle + "을 하시겠습니까?")) {
				var t_sql = "exec [H_AUTO_ADJUST_INS_WH_JSON] " + seSawonid + ",'" + $("#기간까지").val() + "'," +  $("#창고id").val() + "," + opt 
				var adjust_rst = Get_Json(t_sql)
				if (!adjust_rst[0]["VALID"]){
					alert(adjust_rst[0]["MSG"])
					return;
				}
				alert(strTitle + "이 완료되었습니다" )
				verify_click_function()
			}
			return;
		}
		//----------------------------------------------------------------------
		// 예외처리아닌것은 T테이블에 선택항목으로 확정처리
		//----------------------------------------------------------------------
		var strSql = "Exec [AA_RMGRID_GLOBVAL_BTN] '" + seSawonid  +  "','" + Procedure_Name + "'," + opt + Sub_LIst("option") 
		//------------------------------------------------------------------------------------
		console.log(strSql)
		var result = Get_Json(strSql)
		console.log(result[0].RETURNMSG)
		//----------------------------------------------------------------------
		// VALID가 true가 아니면 에러메시지 출력후 리턴
		//----------------------------------------------------------------------
		if (!result[0].VALID){
			alert(result[0].RETURNMSG)
			return;
		}
		//----------------------------------------------------------------------
		// 결과 카운트가 -1 이면 팝업창 실행
		//----------------------------------------------------------------------
		if (result[0].CNT == -1){
			if (Procedure_Name=='AA_ORDER_PROG_LST_JSON')	{

				var source_path = result[0].RETURNMSG
				//alert(source_path)
			//	var btn_pop = window.open(source_path, "팝업창"
			//	,"width=500, height=600, menubar=no,toolbar=no,scrollbars=no,status=no,location=no,resizable=no,fullscreen=yes ","help=no")
			//	btn_pop.focus();
				
				PopupCenter(source_path, "팝업창", 400, 400)


				return

			} else {
				var source_path = result[0].RETURNMSG
				//alert(source_path)
				var btn_pop = window.open(source_path, "팝업창"
				,"width=500, height=300, menubar=no,toolbar=no,scrollbars=no,status=no,location=no,resizable=no,fullscreen=yes ","help=no")
				btn_pop.focus();
				return
			}
		}
		//----------------------------------------------------------------------
		// 결과 카운트가 -2 이면 모달창 실행
		//----------------------------------------------------------------------
		if (result[0].CNT == -2){
			var source_path = result[0].RETURNMSG
			//alert(source_path)
			$("#common_modal_iframe").attr("src", source_path)
			common_modal_show("common_Modal")
			return
		}
		//----------------------------------------------------------------------
		alert(result[0].RETURNMSG + "\n\n(" + result[0].CNT + "건)")
		//----------------------------------------------------------------------
		// 처리후 추가동작 실행
		//----------------------------------------------------------------------
		if (result[0].CNT > 0){		//처리된 결과있을때만 리쿼리
			//----------------------------------------------------------------------
			// 오더진행현황의 공급의뢰확정
			//----------------------------------------------------------------------
            if (Procedure_Name =="AA_ORDER_PROG_LST_JSON" && opt==2){
                for (var i in result){
                    var t_prk = result[i].PRK
                    Grid_LineUpdate_OrderProg(t_prk)	// 한줄업데이트	
                }
            }else {
                verify_click_function()	// 일반적으로는 재조회
            }
		}
	}
	catch (err)
	{  
		progress_modal_init_error();
		alert(err.message)
	}
}

//------------------------------------------------------------------------	
// 확정/업데이트 버튼 // Execute_Upd // opt은 B_WorkName의 Btn_upd1 ~ 3 순서
//------------------------------------------------------------------------
function Execute_Upd(opt){
	if (opt=="undefined" || opt==""){ opt=1; }
    var t_param1 = ""
    var t_param2 = ""
    var t_sub_opt =  Sub_LIst("option")
		//------------------------------------------------------------------------	
		// 오더진행현황 옵션
		//------------------------------------------------------------------------
		if (Procedure_Name=='AA_ORDER_PROG_LST_JSON' ) {
			var sel_opt = $("#오더진행옵션").val()
			//------------------------------------------------------------------------
			// 기존에 exe버튼과 옵션이 겹침으로 10을 더해줌
			// [AA_RMGRID_GLOBVAL_BTN]실행시 옵션이 10을 더한값으로 실행됨
			// 예) 공급취소 1 + 10 = 11 /// 출고취소 2 + 10 = 12  // 오더수정 13
			//------------------------------------------------------------------------
			opt = Number(sel_opt) + 10		
            if (opt==13){   // 오더수정
                var prk_rst = Get_Json("EXEC [AA_T_TABLE_SELECT_PRK_TEXT]  '"+seSawonid+"','T오더진행현황','#PRK','선택', 'PERM_ID' ")
                var tmpStringPara = prk_rst[0]["#PRK"]
                if (tmpStringPara==null){
                    alert("선택된 항목이 없습니다.")
                    return;
                }
                if (tmpStringPara.includes(",") > 0){
                    alert("여러개가 선택되었습니다.\n선택은 하나만 가능합니다.")
                    return;
                }
                var prk_data = gridRoot.getCollection().getSource()
                var sel_rowindex = -1
                // 업데이트 된 행을 알수 없어서, 현재 그리드에서 PRK가 일치하는 행을 찾아서 업데이트
                for(var j in prk_data){
                    var PKID = prk_data[j]["#PRK"]
                    if (PKID == tmpStringPara){
                        sel_rowindex = j
                    }
                }
                var dataRow = gridRoot.getItemAt(sel_rowindex);	
                
                var t_idx = 290
                var t_file_name ="REG_001_ORDERREG.asp"
                var t_param = "&OrderNo=" + dataRow["#D_OrderNo"]
                parent.parent.frames['erp_top_tabs'].favo_add_click()
                parent.parent.frames['erp_list'].menu_click(t_file_name, t_idx, "오더등록",t_param);
                return;
            }
		}
        //------------------------------------------------------------------------	
		// 미발행판매내역 // 계산서일자변경 업데이트
		//------------------------------------------------------------------------
        if (Procedure_Name=='B_CCCC030L_LST_JSON' ) {
            opt = opt + 10 
            var t_param1 = $("#계산서일자").val()
        }
        //------------------------------------------------------------------------	
		// 건별매입현황 // 계산서일자변경 업데이트
		//------------------------------------------------------------------------
        if (Procedure_Name=='B_CCCC200L_LST_JSON' ) {
            opt = opt + 10 
            var t_param1 = $("#계산서일자").val()
            t_sub_opt = ",0"
        }
        //------------------------------------------------------------------------	
		// 년간매출목표등록
		//------------------------------------------------------------------------
        if (Procedure_Name=='H_AAAA500L_LST_JSON' ) {
            opt = opt + 10 
        }
    
	//----------------------------------------------------------------------
	// 예외처리아닌것은 T테이블에 선택항목으로 확정처리
	//----------------------------------------------------------------------
	var strSql = "Exec [AA_RMGRID_GLOBVAL_BTN] '" + seSawonid  +  "','" + Procedure_Name + "'," + opt + t_sub_opt + ", '" + t_param1 + "','" +t_param2+ "'"
	//------------------------------------------------------------------------------------
	console.log(strSql)
	var result = Get_Json(strSql)
	console.log(result[0].RETURNMSG)
	//----------------------------------------------------------------------
	// VALID가 true가 아니면 에러메시지 출력후 리턴
	//----------------------------------------------------------------------
	if (!result[0].VALID){
		alert(result[0].RETURNMSG)
		return;
	}
	//----------------------------------------------------------------------
	// 결과 카운트가 -1 이면 팝업창 실행
	//----------------------------------------------------------------------
	if (result[0].CNT == -1){
		var source_path = result[0].RETURNMSG
		//alert(source_path)
		var btn_pop = window.open(source_path, "팝업창"
		,"width=500, height=300, menubar=no,toolbar=no,scrollbars=no,status=no,location=no,resizable=no,fullscreen=yes ","help=no")
		btn_pop.focus();
		return
	}
	//----------------------------------------------------------------------
	// 결과 카운트가 -2 이면 모달창 실행
	//----------------------------------------------------------------------
	if (result[0].CNT == -2){
		var source_path = result[0].RETURNMSG
		//alert(source_path)
		$("#common_modal_iframe").attr("src", source_path)
		common_modal_show("common_Modal", "30%", "35%", "")
		return
	}
	//----------------------------------------------------------------------
	alert(result[0].RETURNMSG + "\n\n(" + result[0].CNT + "건)")
	//----------------------------------------------------------------------
	// 처리후 추가동작 실행
	//----------------------------------------------------------------------
	if (result[0].CNT > 0){		//처리된 결과있을때만 리쿼리
		//----------------------------------------------------------------------
		// 오더진행현황의 공급의뢰확정
		//----------------------------------------------------------------------
		if (Procedure_Name =="AA_ORDER_PROG_LST_JSON" && opt==12){
			for (var i in result){
				var t_prk = result[i].PRK
				Grid_LineUpdate_OrderProg(t_prk , 1)	// 한줄업데이트	
			}
        //----------------------------------------------------------------------
        // 미발행판매내역의 계산서일자변경
        //----------------------------------------------------------------------
		}else if (Procedure_Name =="B_CCCC030L_LST_JSON" && opt==11){
			for (var i in result){
				var t_prk = result[i].PRK
				Grid_LineUpdate_unsale(t_prk, 1)	// 한줄업데이트	
			}
		}else {
			verify_click_function()	// 일반적으로는 재조회
		}
	}
}
//------------------------------------------------------------------------	
// 메뉴의 권한 가져오기 
//------------------------------------------------------------------------
function Sawon_Perm_Check(t_permid, t_idx){
    var perm_sql = "exec [H_GLOBPERMIT_Workname] '" + t_permid + "','" + t_idx + "'"
    var perm_rst = Get_Json(perm_sql)
    var t_perm = perm_rst[0].UPermit

    return t_perm
}
//------------------------------------------------------------------------	
// 업무문서의 권한 가져오기 
//------------------------------------------------------------------------
function DOCU_Perm_Check(t_permid, t_DOCU_KIND){
    var perm_sql = "exec [AA_GLOBPERMIT_DOCU] '" + t_permid + "','" + t_DOCU_KIND + "'"
    var perm_rst = Get_Json(perm_sql)
    var t_perm = perm_rst[0].DOCU_PERM
    
    return t_perm
}
//------------------------------------------------------------------------	
// 현재선택된 탭의 탭이름 가져오기(조회시 어느 탭에 조회할건지 알기위해/ 없으면 임시이름으로)
//------------------------------------------------------------------------
function get_cur_tab_name(t_sno){
	var grid_name =""
	if (typeof window.parent.frames['erp_top_tabs'] != "undefined"){
		var t_cur_sel_favo_no = window.parent.frames['erp_top_tabs'].$("#cur_sel_favo_no").val()
    	grid_name = "RM_Grid" + t_cur_sel_favo_no		// Rm_Grid + 현재 탭번호로 그리드의 id생성
	}else {
        if (!nbu_check(t_sno)) { t_sno = ""}
		grid_name = "temp_Grid" + t_sno
	}
	return grid_name
}

//-----------------------------------------------------------------------------------
// 팝업창 실행시 공통모듈 (AA_FIND_POPUP 테이블에 정의되어있음)
//-----------------------------------------------------------------------------------
function common_Popup_Open (open_procname, exe_gubun, exe_name, param1, param2, param3, param4, param5){
    var t_sql = "EXEC [AA_FIND_POPUP_LST] '" + seSawonid + "','" + open_procname + "','" + exe_gubun + "','" + exe_name + "'"
	console.log(t_sql)
    var pop_rst = Get_Json_direct(t_sql);
    console.log(pop_rst)
    
	var t_param1 =""
	var t_param2 =""
	var t_param3 =""
	var t_param4 =""
	var t_param5 =""
	var source = pop_rst[0].SOURCE
	if (typeof(pop_rst[0].PARAM1) !== 'undefined'){	t_param1 = "?"+ pop_rst[0].PARAM1 +"="+ param1 }
	if (typeof(pop_rst[0].PARAM2) !== 'undefined'){	t_param2 = "&"+ pop_rst[0].PARAM2 +"="+ param2 }
	if (typeof(pop_rst[0].PARAM3) !== 'undefined'){	t_param3 = "&"+ pop_rst[0].PARAM3 +"="+ param3 }
	if (typeof(pop_rst[0].PARAM4) !== 'undefined'){	t_param4 = "&"+ pop_rst[0].PARAM4 +"="+ param4 }
	if (typeof(pop_rst[0].PARAM5) !== 'undefined'){	t_param5 = "&"+ pop_rst[0].PARAM5 +"="+ param5 }
	source = source + t_param1 + t_param2 + t_param3 + t_param4 + t_param5
	var opne_menu = pop_rst[0].OPEN_MENU + pop_rst[0].EXE_DISCR
	var popup_wdith = pop_rst[0].WIDTH 
	var popup_height = pop_rst[0].HEIGHT

	var t_width = popup_wdith
	var t_height = popup_height
	var t_left = Math.ceil((window.screen.width - t_width)/2);
	var t_top = Math.ceil((window.screen.height - t_height)/2);
    if (t_width <= 0 && t_height <=0 ){ t_width =screen.width; t_height=screen.height }
	var t_popup = window.open(source, opne_menu, "width="+t_width+" , height="+t_height+" , left="+t_left+" , top ="+t_top+" ,scrollbars=yes");
	t_popup.focus()
    //console.log(source)
}
//-----------------------------------------------------------------------------------
// 모달창 실행시 공통모듈 (AA_FIND_POPUP 테이블에 정의되어있음)
//-----------------------------------------------------------------------------------
function common_Modal_Open (open_procname, exe_gubun, exe_name, param1, param2, param3, param4, param5){
    var t_sql = "EXEC [AA_FIND_POPUP_LST] '" + seSawonid + "','" + open_procname + "','" + exe_gubun + "','" + exe_name + "'"
	console.log(t_sql)
    var pop_rst = Get_Json_direct(t_sql);
    console.log(pop_rst)
    
	var t_param1 =""
	var t_param2 =""
	var t_param3 =""
	var t_param4 =""
	var t_param5 =""
	var source = pop_rst[0].SOURCE
	if (typeof(pop_rst[0].PARAM1) != undefined){	t_param1 = "?"+ pop_rst[0].PARAM1 +"="+ param1 }
	if (typeof(pop_rst[0].PARAM2) != undefined){	t_param2 = "&"+ pop_rst[0].PARAM2 +"="+ param2 }
	if (typeof(pop_rst[0].PARAM3) != undefined){	t_param3 = "&"+ pop_rst[0].PARAM3 +"="+ param3 }
	if (typeof(pop_rst[0].PARAM4) != undefined){	t_param4 = "&"+ pop_rst[0].PARAM4 +"="+ param4 }
	if (typeof(pop_rst[0].PARAM5) != undefined){	t_param5 = "&"+ pop_rst[0].PARAM5 +"="+ param5 }
	source = source + t_param1 + t_param2 + t_param3 + t_param4 + t_param5
	var opne_menu = pop_rst[0].OPEN_MENU + pop_rst[0].EXE_DISCR
	var popup_wdith = pop_rst[0].WIDTH 
	var popup_height = pop_rst[0].HEIGHT

	var t_width = popup_wdith 
	var t_height = popup_height 
	$("#common_modal_iframe").attr("src", source)
    common_modal_show("common_Modal", t_width, t_height)

}
//-----------------------------------------------------------------------------------
// ASPSESSIONID 쿠키삭제
//-----------------------------------------------------------------------------------
function clearASPSESSIONID(){
    var cks = document.cookie.match(/\b(ASPSESSIONID[A-Z]+)(?==)/g),
        lskey = 'oldASPSESSIONID-'+location.protocol+'//'+location.host,
        old = window.localStorage ? localStorage.getItem(lskey) : '',
        keep, i;
    for(i=0;i<cks.length;i++){
        if((old && old.indexOf(cks[i])<0) || i==cks.length-1){
            keep = cks[i];
        }
    }
    for(i=0;i<cks.length;i++){
        if(keep != cks[i]){
            document.cookie = cks[i] + '=; expires=Thu, 01 Jan 1970 00:00:01 GMT;';
        }
    }
    if(window.localStorage){
        localStorage.setItem(lskey, keep ? keep : '');
    }
}
//-------------------------------------------------------------------------------------
//	발주서번호 가져오는 함수
//-------------------------------------------------------------------------------------
function GetPurchaseOrderNo(t_fdat,opt) {
    var strSql
    var objRs
    var retuVal;
    strSql = "SELECT [dbo].[GET_PurchaseOrderNo]('" + t_fdat + "', " + opt + ")   AS  POrderNo"        
    objRs = Get_Json(strSql);				

    if (objRs.length > 0 )
    {
        retuVal = objRs[0]["POrderNo"];            
    } else{
        retuVal = 1;
    }                
    return retuVal;		     
}
//-------------------------------------------------------------------------------------
//	입고로트번호가져오는 함수
//-------------------------------------------------------------------------------------
function jFunGetLotno(fDate,opt,WHID) {
    var strSql
    var objRs
    var retuVal;
    strSql = "SELECT [dbo].[GET_LOTNO]('" + fDate + "', " + opt + "," + WHID + ")   AS  POrderNo"        
    objRs = Get_Json(strSql);				

    if (objRs.length > 0 )
    {
        retuVal = objRs[0]["POrderNo"];            
    } else{
        retuVal = 1;
    }                
    return retuVal;		
}
//-------------------------------------------------------------------------------------
//  재고있는 로트번호인지 알려주는 함수
//-------------------------------------------------------------------------------------
function jFunGetLotnoYesno(SawonID,gLotno,ItemID,ColorID,SizeID,fDate) {
    var strSql
    var objRs
    var retuVal;
    strSql = "exec [H_LOTNO_LST] " + SawonID + ",'" + gLotno + "'," + ItemID + "," + ColorID + "," + SizeID + ",'" + fDate + "'"             
    objRs = Get_Json(strSql);				
    if (objRs.length > 0 )
    {
        retuVal = objRs[0]["재고수량"];            
    } else{
        retuVal = 0;
    }                
    return retuVal;		                     
}

//--------------------------------------------------------------------------------
// 검색값이 하나일때 선택하게해주는 함수 // 원래 팝업창 소스 안에 있지만, 검색값하나일때 팝업창 안열리고 자동선택하기위해 
//--------------------------------------------------------------------------------
function Search_One_Select (t_Upd_Gubun, t_value,t_value_ID, Row_Index, Col_Index, Col_Name_ID, Con_Name, t_rst){
    var self_close = 1
    //----------------------------------------------------------------------------
    // 그리드에 업데이트 
    //----------------------------------------------------------------------------
    if (t_Upd_Gubun == "Grid"){
        var t_gridRoot = gridRoot       // 부모창(View_Frm001의 그리드 객체)
        var t_dataGrid = dataGrid       // 부모창(View_Frm001의 그리드 객체)

        var dataRow = t_gridRoot.getItemAt(Row_Index);			    //---행의 전체정보 (jSON 형식)
        var column = t_dataGrid.getDisplayableColumns()[Col_Index];	//---열의 전체정보 가져오기

        var t_header_name = column.getDataField();			        //---열의 헤더명 가져오기 

        t_gridRoot.setItemFieldAt(t_value, Row_Index, t_header_name) // 그리드의 데이터 수정
        //----수정열 아니면 종료---------------------------------------------------
        if (t_header_name.substring(0,3) != "#D_" && t_header_name.substring(0,3) != "#E_") {	return;	}
        var PRK = dataRow["#PRK"] 							//---T테이블의 수정될 키 값
        t_header_name = Label_Tag_remove(t_header_name)
        //t_value= encodeURI(t_value)
        var edit_sql = "[AA_RMGRID_GLOBVAL_UPD] '" + seSawonid +"','" + Procedure_Name + "','" + t_header_name + "','" + t_value + "','" + PRK +"'"
        console.log(edit_sql)
        var edit_rst = Get_Json(edit_sql)
        var msg = edit_rst[0].MSG
        if(msg != ""){
            alert(msg)
        }
        //-------------------------------------------------------------------------
        // OPNER 그리드라인업데이트 실행
        //-------------------------------------------------------------------------
        if (Procedure_Name=='D_REMITTANCE_TREAT_JSON')		{
            self_close = 0
            Grid_LineUpdate_Document( Row_Index , PRK , Sub_LIst("option") ); 
            //setTimeout(function(){ window.close(); },200);  // 업데이트 실행하는데시간이 걸려서 0.2초후 창닫기 
        }
        if (Procedure_Name=="D_CREDIT_CARD_LST_JSON" ){
            self_close = 0
            Grid_LineUpdate_Creditcard( Row_Index , PRK , Sub_LIst("option") ); 
            //setTimeout(function(){ window.close(); },200);  // 업데이트 실행하는데시간이 걸려서 0.2초후 창닫기 
        }
        //-------------------------------------------------------------------------
    
    } 
    //----------------------------------------------------------------------------
    // 그리드에 업데이트 
    //----------------------------------------------------------------------------
    if (t_Upd_Gubun == "Edit_Grid"){
        var t_gridRoot = Edit_gridRoot       // 부모창(Edit_Grid의 그리드 객체)
        var t_dataGrid = Edit_dataGrid       // 부모창(Edit_Grid의 그리드 객체)

        var dataRow = t_gridRoot.getItemAt(Row_Index);			    //---행의 전체정보 (jSON 형식)
        var column = t_dataGrid.getColumns()[Col_Index];	//---열의 전체정보 가져오기

        var t_header_name = column.getDataField();			        //---열의 헤더명 가져오기 

        t_gridRoot.setItemFieldAt(t_value, Row_Index, t_header_name) // 그리드의 데이터 수정
        //alert(Col_Name_ID)
        //-------------------------------------------------------------------------
        // ID 필드명 있으면 ID도 업데이트
        //-------------------------------------------------------------------------
        if (Col_Name_ID != "" && Col_Name_ID != undefined  && Col_Name_ID != null){
            Col_Name_ID = "#"+ Col_Name_ID
            t_gridRoot.setItemFieldAt(t_value_ID, Row_Index, Col_Name_ID)
        }
        
        //-------------------------------------------------------------------------
        // 현재선택된것 이외에 업데이트되야할것
        //-------------------------------------------------------------------------
        if (File_Name=="REG_100_SAWONREG"){      // 사용자등록일 경우, 사원명 입력시 부서,직책 업데이트
            if (t_header_name =="사원명"){
                t_gridRoot.setItemFieldAt(t_rst[0]["#X_부서"], Row_Index, "#X_부서")
                t_gridRoot.setItemFieldAt(t_rst[0]["#X_직책"], Row_Index, "#X_직책")
            }
        }
        //--------------------------------------------------------------------------
        // 수정가능한 그리드에 업데이트할 내용 실행
        //--------------------------------------------------------------------------
        if(typeof(Popup_Select_Afer_EditGrid) == "function") {
            Popup_Select_Afer_EditGrid(Row_Index, Con_Name);   //-- 항목 입력 후 추가 등록해야 하는 부분 처리함수 2022-05-27
        }
        //--------------------------------------------------------------------------
        // 웹그리드에 수정가능한 열로 포커스이동
        //--------------------------------------------------------------------------
        Col_Index = Col_Index * 1 
        Next_focus_Move(Row_Index,Col_Index)  
    } 
    //----------------------------------------------------------------------------
    // 등록폼에 업데이트 
    //----------------------------------------------------------------------------
    else if(t_Upd_Gubun == "Reg"){
        //console.log(t_value)
        $("#"+Row_Index).val(t_value)

        if(typeof(fnAfterIns) == "function") {
            fnAfterIns(Row_Index);   //-- 항목 입력 후 추가 등록해야 하는 부분 처리함수 2022-05-27
        }
        //----선택후 처리해햐할 함수 실행(부모창에 함수가 있어야지 실행)-----------------
        if(typeof(Popup_Search_After) == "function") {
            Popup_Search_After(Row_Index);
        }
        var t_inputs = $("#"+Row_Index).closest('body').find("input:enabled[type='text'], select:enabled") //':input:visible');  //input:enabled[type='text'], select
        var t_index =t_inputs.index($("#"+Row_Index))
        t_inputs.eq(t_index+1).focus();
    }
    //----------------------------------------------------------------------------
    // 등록폼에 업데이트 (ID값 포함 // Row_Index=업데이트할 객체   Col_Index= 업데이트할 객체의 ID)
    //----------------------------------------------------------------------------
    else if(t_Upd_Gubun == "Reg_ID"){
        $("#"+Row_Index).val(t_value)
        $("#"+Col_Index).val(t_value_ID)

        if(typeof(fnAfterIns) == "function") {
            fnAfterIns(Row_Index);   //-- 항목 입력 후 추가 등록해야 하는 부분 처리함수 2022-05-27
            fnAfterIns(Col_Index);   //-- 항목 입력 후 추가 등록해야 하는 부분 처리함수 2022-05-27
        }
        //----선택후 처리해햐할 함수 실행(부모창에 함수가 있어야지 실행)-----------------
        if(typeof(Popup_Search_After) == "function") {
            Popup_Search_After(Row_Index);
        }
        var t_inputs = $("#"+Row_Index).closest('body').find("input:enabled[type='text'], select:enabled") //':input:visible');  //input:enabled[type='text'], select
        var t_index =t_inputs.index($("#"+Row_Index))
        t_inputs.eq(t_index+1).focus();
    }
    if (self_close==1){
        //window.close();
    }
}
//--------------------------------------------------------------------------------
// 입력된 날짜의 환율 가져오기
//--------------------------------------------------------------------------------
function Get_Exchange(t_ex_date, opt){
	if (opt=="" || opt==undefined){ opt = 1} // opt 는 통화구분ID // C_priceunit 테이블
    var t_sql =  "EXEC [C_Exchange] '"+t_ex_date+"'"
    var t_exchange_rst = Get_Json(t_sql)
	var t_exchange
	if (opt==2){
		t_exchange = t_exchange_rst[0]["UUSD"]	
	}else if (opt==3){
		t_exchange = t_exchange_rst[0]["UEUR"]	
	}else if (opt==4){
		t_exchange = t_exchange_rst[0]["UJPY"]	
	}else if (opt==5){
		t_exchange = t_exchange_rst[0]["UHKD"]	
	}else {
		t_exchange = 1
	}
     
    return t_exchange
}
		/*
		//------------------------------------------------------------------------	
		// 사원별년차등록
		//------------------------------------------------------------------------
		if (Procedure_Name=='사원별년차등록') {
			
			strSql = "exec [D_YUNCHA_CREATE] " + seSawonid + ",'" + $("#기간부터").val() + "'"

			objRs = Get_Ado_Rst(strSql,0,1)
			main_bind("D_Yuncha")

			return ;
		}			
		
		//------------------------------------------------------------------------	
		// 조회데이터 체크
		//------------------------------------------------------------------------
		if (gFG.explorerbar == 0 )		{
			alert("조회된 데이터가 없습니다.")
			return
		} 

		if (opt==null || opt=='')	{opt=1}

		//------------------------------------------------------------------------	
		// 원가관리 마감
		//------------------------------------------------------------------------
		if (Procedure_Name=='H_BBBB010W_LST' || Procedure_Name=='H_BBBB020W_LST' || Procedure_Name=='H_BBBB030W_LST' )		{

			if (opt==2)			{
				f_yyyymm = $("#기간부터").val()
				t_yyyymm = $("#기간까지").val()
				opt = (Procedure_Name=='H_BBBB010W_LST'?1: (Procedure_Name=='H_BBBB020W_LST'?2:3) )

				var pop = window.open ("../IncPopup/Popup_wonga_magam.ASP?f_yyyymm=" + f_yyyymm + "&t_yyyymm=" + t_yyyymm + "&opt=" + opt ,"마감확인","menubar=no,toolbar=no,scrollbars=yes,status=no,location=no,resizable=yes,top=250,left=450,width=550,height=250") 
				pop.focus();
				return;
			}


			var r = confirm( $("#기간까지").val() + "월 " + 
					(Procedure_Name=='H_BBBB010W_LST'?'자재수불부':(Procedure_Name=='H_BBBB020W_LST'?'제품수불부':'제조원가')) + "를 마감하시겠습니까?");
			if (r == false) {
				return
			} 

			var strSql = "Exec " + Procedure_Name + " " + seSawonid  +  Sub_LIst("subform") + Sub_LIst("option") + ",1"
			objRs = Get_Ado_Rst(strSql,0,1)

			vbMsgbox("마감 되었습니다.", 0, 64, "마감");
			
			return ;
		}

		//------------------------------------------------------------------------	
		// 판매현황 ECOUNT 엑셀전환
		//------------------------------------------------------------------------
		if (Procedure_Name=='B_CCCC250L_LST') {

			OpenExcel_ECOUNT()
			return ;
		}


		


		


		//------------------------------------------------------------------------	
		// 외상매출금내역 입금등록
		//------------------------------------------------------------------------
		if (Procedure_Name=='B_CCCC040L_LST') {
				//-------------------------------------------------------------
				//	관리자암호체크하는 함수
				//-------------------------------------------------------------                
				if ( $("#adminChk").val() == 0 )	{
					var pop = window.open ("../IncPopup/passChk_B.ASP?strFormName=CCCC040L&Opt2=9" ,"관리자기능","menubar=no,toolbar=no,scrollbars=no,status=no,location=no,resizable=no,top=250,left=450,width=380,height=180") 
					pop.focus();
					return;
				}      
				//-------------------------------------------------------------

				var VendorID  = gFG.Cell(0,gFG.Row,gFG.ColIndex("#VendorID"))
				var VendorName  = gFG.Cell(0,gFG.Row,gFG.ColIndex("거래처명"))       

				var pop = window.open ("../IncPopup/Popup_ReceiptReg_NEW_B.asp?VendorID=" + VendorID + "&VendorName=" + VendorName ,"입금등록", "width=820, height=630, left=200, top=200")                            

				pop.focus();
			return ;
		}
		//------------------------------------------------------------------------	
		// 미판매현황 판매확정
		//------------------------------------------------------------------------
		if (Procedure_Name == 'B_CCCC030L_LST') {
			//-------------------------------------------------------------
			//	관리자암호체크하는 함수
			//-------------------------------------------------------------                
			if ($("#adminChk").val() == 0) {
				var pop = window.open("../IncPopup/passChk_B.ASP?strFormName=CCCC030L&Opt2=9", "관리자기능", "menubar=no,toolbar=no,scrollbars=no,status=no,location=no,resizable=no,top=250,left=450,width=380,height=180")
				pop.focus();
				return;
			}
			//-------------------------------------------------------------

			var tmpStringPara = ''
			var tmpComma = ''

			for (i = 3; i < gFG.Rows; i++) {
				if (gFG.cell(5, i, (gFG.ColIndex("#C_확인"))) == 1) {
					tmpStringPara = tmpStringPara + tmpComma + gFG.Cell(0, i, (gFG.ColIndex("#PRK")))  // 주의 //  not #PRK
					tmpComma = ","
				}
			}
			
			if (opt==1){

				if (tmpStringPara == '') {
					alert("[err]판매확정을 체크하신 후 확정하세요")
					return
				}

				var strSql = "Exec Usp_PROD310L_DateChk '" + tmpStringPara + "'"	 // 계산서일자, 환율 같은지 확인  
				objRs = Get_Ado_Rst(strSql, 0, 1)

				if (objRs.recordcount == 1) {
					var pop = window.open("../IncPopup/Popup_Certain_B.asp?Cino=" + tmpStringPara, "계산서확인", "menubar=no,toolbar=no,scrollbars=no,status=no,location=no,resizable=no,top=300,left=350,width=700,height=410")
					pop.focus();

				} else {
					alert("[err]계산서일자 또는 환율이 서로 일치하지 않습니다.") + "\n\n" + "자료 확인 후 다시 작업하세요."
				}

			}else if (opt==2)
			{
				if (tmpStringPara == '') {
					alert("무상처리할 항목을 선택 후 확정해주십시오.")
					return
				}

				var strSql = "Exec B_CCCC030L_무상판매_INS '" + seSawonid + "','" + tmpStringPara + "', '1' "	 // 

				//console.log(strSql)
				objRs = Get_Ado_Rst(strSql, 0, 1)
				alert(objRs(0))
				Verify_Click(gFG,true)
			}

			return;
		}

		//------------------------------------------------------------------------	
		// 환율등록 예산환율 등록
		//------------------------------------------------------------------------
		if (Procedure_Name=='B_MANA120W_LST') {

				var pop = window.open("../include/Popup_BudgetExchange.ASP","","menubar=no,toolbar=no,scrollbars=no,status=no,location=no,resizable=no,top=100,left=100,width=620,height=200")                           
				pop.focus();
			return ;
		}


		//------------------------------------------------------------------------	
		// 실사과부족현황 재고조정
		//------------------------------------------------------------------------
		if (Procedure_Name=='H_AAAA300L_LST'  )		{

				if (opt==3)				{
					OpenExcel_jaego('재고조사표_실론',11)
					return;
				}
				var	strTitle =  (opt == 1?"재고조정 작업":"재고조정취소 작업")

				if (vbMsgbox(strTitle + "을 하시겠습니까?", 4, 64, "자료저장") == 6) {
					strSql = "exec [H_AUTO_ADJUST_INS_WH] " + seSawonid + ",'" + $("#기간까지").val() + "'," +  $("#창고id").val() + "," + opt 
					objRs = Get_Ado_Rst(strSql,0,1)
					alert(strTitle + "이 완료되었습니다" )
					Verify_Click(gFG,true)
				}
				return;
		}

		//------------------------------------------------------------------------	
		// 창고재고현황 재고조사표 // 20.02.24 opt=2추가 롤재고 팝업 
		//------------------------------------------------------------------------
		if (Procedure_Name=='H_AAAA180L_LST' || Procedure_Name=='H_AAAA180L_LST_LONG'  )		{
				//----------------------------------------------------------------
				if (opt==1)		{OpenExcel_jaego('재고조사표_실론',10)}
				//----------------------------------------------------------------
				if (opt==2)				{
					var STOCKID  = gFG.Cell(0,gFG.Row,gFG.ColIndex("#창고ID"));
					var ITEMID  = gFG.Cell(0,gFG.Row,gFG.ColIndex("#아이템ID"));
					var COLORID = gFG.Cell(0,gFG.Row,gFG.ColIndex("#칼라ID"));    
					var SIZEID  = gFG.Cell(0,gFG.Row,gFG.ColIndex("#사이즈ID"));    
					//------------------------------------------------------------
					var STOCKNAME= gFG.Cell(0,gFG.Row,gFG.ColIndex("창고명"));
					var ITEMNAME = gFG.Cell(0,gFG.Row,gFG.ColIndex("#D_아이템품명"));
					var COLORNAME= gFG.Cell(0,gFG.Row,gFG.ColIndex("칼라"));     
					var SIZENAME = gFG.Cell(0,gFG.Row,gFG.ColIndex("사이즈"));  
					var LOTNO 	 = gFG.Cell(0,gFG.Row,gFG.ColIndex("로트번호"));	
					var LotOpt	 = $("#LotNo").is(':checked');
					var LotOpt2	 = gFG.Cell(0,gFG.Row,gFG.ColIndex("#OPT2"));
					if (LotOpt2 == "") { LotOpt2= 0}
					//------------------------------------------------------------
					if (LotOpt == true){ LotOpt = 1 ;}
					else { LotOpt = 0 ;	}
					var pop = window.open ("../IncPopup/Popup_Roll_stock.ASP?SAWONID="+seSawonid 
											+ "&STOCKID=" + STOCKID + "&ITEMID=" + ITEMID + "&COLORID=" + COLORID + "&SIZEID=" + SIZEID
											+ "&STOCK=" +STOCKNAME+ "&ITEM="+ ITEMNAME +"&COLOR="+COLORNAME  + "&SIZE=" +SIZENAME 
											+ "&LotOpt=" + LotOpt + "&LOTNO=" + LOTNO + "&TDAT="+$("#기간까지").val() + "&LotOpt2=" +LotOpt2
											,"롤재고수량", "scrollbars=yes, width=420, height=330, left=200, top=200")                            
					pop.focus();
				}
				//----------------------------------------------------------------
				if (opt==3)				{
					var STOCKID  = gFG.Cell(0,gFG.Row,gFG.ColIndex("#창고ID"));
					var ITEMID  = gFG.Cell(0,gFG.Row,gFG.ColIndex("#아이템ID"));
					var COLORID = gFG.Cell(0,gFG.Row,gFG.ColIndex("#칼라ID"));    
					var SIZEID  = gFG.Cell(0,gFG.Row,gFG.ColIndex("#사이즈ID"));    
					//------------------------------------------------------------
					var STOCKNAME= gFG.Cell(0,gFG.Row,gFG.ColIndex("창고명"));
					var ITEMNAME = gFG.Cell(0,gFG.Row,gFG.ColIndex("#D_아이템품명"));
					var COLORNAME= gFG.Cell(0,gFG.Row,gFG.ColIndex("칼라"));     
					var SIZENAME = gFG.Cell(0,gFG.Row,gFG.ColIndex("사이즈"));  
					var LOTNO 	 = gFG.Cell(0,gFG.Row,gFG.ColIndex("로트번호"));	
					var STOCK_CNT = gFG.Cell(0,gFG.Row,gFG.ColIndex((Procedure_Name=='H_AAAA180L_LST'?"#D_기말재고":"기말재고")));	

					if (STOCK_CNT<=0)	{
						alert("마이너스 재고 또는 재고가 없는 경우 창고이동 할 수 없습니다")
						return
					}

					var pop = window.open ("../IncPopup/Popup_stock_move.ASP?SAWONID="+seSawonid 
											+ "&STOCKID=" + STOCKID + "&ITEMID=" + ITEMID + "&COLORID=" + COLORID + "&SIZEID=" + SIZEID
											+ "&STOCK=" +STOCKNAME+ "&ITEM="+ ITEMNAME +"&COLOR="+COLORNAME  + "&SIZE=" +SIZENAME 
											+ "&STOCK_CNT=" + STOCK_CNT + "&LOTNO=" + LOTNO  
											,"창고이동", "scrollbars=yes, width=570, height=330, left=400, top=200")                            
					pop.focus();
				}
				//----------------------------------------------------------------



				return;
		}

	
		//------------------------------------------------------------------------	
		// 매입청구등록 단가 없는거 체크 . 2019-01-09 주현주과장 해제 요청(불량입고 처리)
		//------------------------------------------------------------------------
		//if (Procedure_Name=='B_CCCC180L_LST'  )		{

		//    for (i=3;i<gFG.Rows ;i++ )            {
		//		if (gFG.cell(5,i,(gFG.ColIndex("#C_매입확정"))) == 1 )	{
		//			if (gFG.cell(0,i,gFG.ColIndex("#E_단가")) == 0 && gFG.cell(0,i,gFG.ColIndex("#E_외화단가")) == 0)		{
		//				alert("단가(외화단가)가 입력되지 않았습니다.")
		//				return; 
		//			}
		//		}
		//	}
		//}   

		//------------------------------------------------------------------------	
		// 건별매입현황 매입확정
		//------------------------------------------------------------------------
		if (Procedure_Name=='B_CCCC200L_LST'  )		{

			var tmpStringPara = ''
			var tmpComma = ''

			for (i=3;i<gFG.Rows ;i++ )            {
				if (gFG.cell(5,i,(gFG.ColIndex("#C_확인"))) == 1 )	{
						tmpStringPara = tmpStringPara + tmpComma + gFG.Cell(0,i,(gFG.ColIndex("#PROGID")))  // 주의 //  not #PRK
						tmpComma = ","
				}
			}
				var pop =  window.open ("../IncPopup/Popup_ProgressCertain_B.ASP?Progid=" + tmpStringPara,"확정","menubar=no,toolbar=no,scrollbars=no,status=no,location=no,resizable=no,top=300,left=350,width=750,height=410") 
				pop.focus();
				return;
		}


		//------------------------------------------------------------------------	
		// Document 등록폼
		//------------------------------------------------------------------------
		if (Procedure_Name=='D_DOCUMENT_LIST') {

			var ObjFromDll = new ActiveXObject("E_Docu.C_Docu")
		//	result = ObjFromDll.Open_Document(gConn, SAWONID, DOCUKIND, DOCUID);
			result = ObjFromDll.Open_Document(gConn(), P_Cur_Permit_ID, 5, 0);


			return ;
		}


		//------------------------------------------------------------------------	
		// 개발의뢰현황 2020-05-27
		//------------------------------------------------------------------------
		if (Procedure_Name=='D_DEV_REQ_LST') {

			strSql = "SELECT RESULT, RESULTMSG FROM [dbo].[Get_Station_Part_RND] (" + seSawonid + ",'0')"
			objRs = Get_Ado_Rst(strSql,0,1)
			if (objRs("RESULT")=="1")
			{			
				var Req_Docu_No= gFG.Cell(0,gFG.Row,gFG.ColIndex("의뢰문서번호"));
				var Ord_Docu_No= gFG.Cell(0,gFG.Row,gFG.ColIndex("지시문서번호"));
				var strSql = "EXEC D_DEV_REQ_LST_EXCEL '" +Req_Docu_No +"' , '" 	+ Ord_Docu_No+ "'"
				//alert(strSql)
				OpenExcel_DATA("개발보고서",strSql)
				return;
			}else{
				alert(objRs("RESULTMSG"));
				return;
			}
		}

		//------------------------------------------------------------------------	
		// 증명서발급 버튼
		//------------------------------------------------------------------------
		if (Procedure_Name=='A_TDB_CE_REQ_LST' || Procedure_Name=='A_TDB_CE_REQ_LST_MY') {

			strSql = "EXEC [A_TDB_CE_REQ_CHUL_VALID] '" + seSawonid + "'"
			objRs = Get_Ado_Rst(strSql,0,1)
			var err_chk = objRs("ERR")
			var msg = objRs("MSG")
			//--에러체크------------------------------------------------------------
			if(err_chk == 1) {
				alert(msg);
				return
			}
			//--정상동작------------------------------------------------------------
			else {
				var t_epid    = objRs("EPID")
				var t_no      = objRs("발급번호")
				var t_gubunid = objRs("신청서구분ID")
				var t_gubun   = objRs("신청서구분")
				OpenExcel_DATA(t_gubun,"[A_TDB_EXCEL_OUT_CE] '" + seSawonid + "','" + t_epid + "','"+t_gubunid+"','" + t_no + "'")
				Rebind();
				//alert(msg);
			}

			return ;
		}

		//------------------------------------------------------------------------	
		// 고객클레임접수현황 접수증 출력 JJH 2021-05-24
		//------------------------------------------------------------------------
		if (Procedure_Name=='B_CLAIM_RECEIPT') {

			var Receip_No= gFG.Cell(0,gFG.Row,gFG.ColIndex("#PRK"));
			var strSql = "EXEC B_CLAIM_RECEIPT_EXCEL '" +Receip_No +"'"
			//alert(strSql)
			Open_Excel_DATA_ALL(strSql,"클레임접수증");
			return;
		}
	
		//------------------------------------------------------------------------	
		// MBO실행등록 // 상단버튼클릭
		//------------------------------------------------------------------------
		if (Procedure_Name=='H_AAAA620L_LST') {
			
			var pop =  window.open ("../IncPopup/Popup_MBO_WORK.ASP?id=0","MBO수행등록","menubar=no,toolbar=no,scrollbars=no,status=no,location=no,resizable=no,top=300,left=350,width=700,height=600") 
			pop.focus();
			return;

		}
	
		//------------------------------------------------------------------------	
		// 판매단가변경 > 거래처아이템별판매단가등록 팝업 // 2022-01-24
		//------------------------------------------------------------------------
		if (Procedure_Name=='B_SJ_WONGA_PRICE_LST') {
			if(gFG.Row>2){
				var WongaID = gFG.Cell(0,gFG.Row,gFG.ColIndex("#PRK"));
				var pop =  window.open ("../IncPopup/Popup_Wonga_Customer_Price.asp?id="+WongaID,"거래처아이템판매단가등록","menubar=no,toolbar=no,scrollbars=1,status=no,location=no,resizable=no,top=300,left=350,width=700,height=600") 
				pop.focus();
				return;
			}
		}

		
		*/
	
	
 







//-----------------------------------------------------
// 오늘 날짜를 yyyymmdd 형태로 리턴
//-----------------------------------------------------
function getToday(){
    var date = new Date();
    var year = date.getFullYear();
    var month = ("0" + (1 + date.getMonth())).slice(-2);
    var day = ("0" + date.getDate()).slice(-2);

    return year + month + day;
}

function getTodayTime(){
    var date = new Date();
    var year = date.getFullYear();
    var month = ("0" + (1 + date.getMonth())).slice(-2);
    var day = ("0" + date.getDate()).slice(-2);

    return year + month + day + ('0'+ date.getHours()).slice(-2) + ('0'+date.getMinutes()).slice(-2) + ('0'+date.getSeconds()).slice(-2);
}
//-----------------------------------------------------
// 오늘 날짜를 yyyy-mm-dd 형태로 리턴
//-----------------------------------------------------
function getToday_yyyymmdd(){
    var date = new Date();
    var year = date.getFullYear();
    var month = ("0" + (1 + date.getMonth())).slice(-2);
    var day = ("0" + date.getDate()).slice(-2);

    return year + "-" + month + "-" + day;
}

//-----------------------------------------------------
// 오늘 날짜에서 변동값을 yyyy-mm-dd 형태로 리턴
//-----------------------------------------------------
function get_add_date_yyyymmdd(opt, add_val){
    var date = new Date();
    var add_date = new Date(date);
    if (opt =="yyyy") {add_date.setFullYear (date.getFullYear() + add_val)}
    if (opt =="mm")   {add_date.setMonth (date.getMonth() + add_val)}
    if (opt =="dd")   {add_date.setDate(date.getDate() + add_val) }
    var year = add_date.getFullYear();
    var month = ("0" + (1 + add_date.getMonth())).slice(-2);
    var day = ("0" + add_date.getDate()).slice(-2);
    return year + "-" + month + "-" + day;
}



function  date_format(t_date,format) {
	var ret_date
	switch (format)	{
	case "yyyy-mm-dd":
	     ret_date =  $.datepicker.formatDate('yy-mm-dd', t_date);
	case "yyyy-mm-dd hh:mm:ss":
	     ret_date =  $.datepicker.formatDate('yy-mm-dd', t_date) + " " 
					 + ('0'+t_date.getHours()).slice(-2) + ":" + ('0'+t_date.getMinutes()).slice(-2) + ":" + ('0'+t_date.getSeconds()).slice(-2);
	case "yyyy-mm-dd hh:mm":
	     ret_date =  $.datepicker.formatDate('yy-mm-dd', t_date) + " " 
					 + ('0'+t_date.getHours()).slice(-2) + ":" + ('0'+t_date.getMinutes()).slice(-2);	
	}
	return ret_date;

}


//-----------------------------------------------------------------
//	약식 날짜 입력시 전체 날짜값으로 변환
//  1. 월/일, 월.일, 월-일
//  2. 숫자4, 숫자6, 숫자8    
//-----------------------------------------------------------------
function jFuncDateValid(obj,opt)
{
	var nDate = new Date();
	var nowDate = nDate.getFullYear() + '-' + jLenChk(parseInt(nDate.getMonth()+1)) + '-' + nDate.getDate()
	var orgiString = obj.value;
	var tmpString = obj.value;
	var retuString;	    
	var fmt = /^\d{4}-\d{2}-\d{2}$/;    //정규식체크
    console.log(obj.value)
	//-------------------------------------------------------------
	//  월/일 일때 입력되게
	var intI = tmpString.indexOf('/');
	var arrDate = tmpString.split("/");

	if ((intI > -1) && (intI < 3)) {
		if ((tmpString.length >= 3) && (tmpString.length < 6)) {	            
			tmpString = jLenChk(arrDate[0]) + jLenChk(arrDate[1])
		}
	}
	intI = tmpString.indexOf('.');
	arrDate = tmpString.split(".");

	if ((intI > -1) && (intI < 3)) {
		if ((tmpString.length >= 3) && (tmpString.length < 6)) {
			tmpString = jLenChk(arrDate[0]) + jLenChk(arrDate[1])
		}
	}
	intI = tmpString.indexOf('-');
	arrDate = tmpString.split("-");

	if ((intI > -1) && (intI < 3)) {
		if ((tmpString.length >= 3) && (tmpString.length < 6)) {
			tmpString = jLenChk(arrDate[0]) + jLenChk(arrDate[1])
		}
	}
	//-------------------------------------------------------------
	tmpString = tmpString.replace(/\./gi, "");
	tmpString = tmpString.replace(/\-/gi, "");
	tmpString = tmpString.replace(/\//gi, "");
	
	if (tmpString.length == 8) {
		retuString = tmpString.substr(0, 4) + '-' + tmpString.substr(4, 2) + '-' + tmpString.substr(6, 2);
	} else if (tmpString.length == 6) {
		retuString = '20' + tmpString.substr(0, 2) + '-' + tmpString.substr(2, 2) + '-' + tmpString.substr(4, 2);
	} else if (tmpString.length == 4) {
		retuString = nDate.getFullYear() + '-' + tmpString.substr(0, 2) + '-' + tmpString.substr(2, 2);
	} else {
		retuString = tmpString;
	}        
	
	//  공백이면 패스되게
	if(obj.value == ""){
		return true;
	}

	if (!fmt.exec(retuString)) {
		alert("날자형식이 잘못되었습니다.");
		obj.value = orgiString;
		obj.select();
		return false;
	}

	if (dateCheck10(retuString, 'D') == false) {
		obj.value = orgiString;
		obj.select();
		return false;
	}
	obj.value = retuString;
	return true;
}

//-----------------------------------------------------------------
//	function jLenChk
//-----------------------------------------------------------------
function jLenChk(gVal)
{
	var strRetu;
	gVal = gVal.toString();

	strRetu = gVal;		

	if (gVal.length==1)
	{
		strRetu = '0'+gVal;			
	}
	return strRetu;	
}


//------------------------------------------------------------------------
// function dateCheck10  정확한 날짜를 구하는 함수
// opt= 'Y':년도만 체크. 'M':년,월체크 'D':년,월,일 체크
//------------------------------------------------------------------------
function dateCheck10(gVal,opt){
	var sDate1 = gVal.substr(0,4);
	var sDate2 = gVal.substr(5,2);
	var sDate3 = gVal.substr(8,2);

	var	fmt1 = /^[0-9]{4}$/;		
	var fmt2 = /^[0-9]{2}$/;
	
	if (sDate1 < 2000) sDate1 +=1900;
	var mon_arr = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
	if (((sDate1 % 4 == 0) && (sDate1 % 100 != 0)) || (sDate1 % 400 == 0)){
		mon_arr[1] = 29 ;
	}
	if ((opt == 'Y')||(opt == 'M')||(opt == 'D'))
	{
		if (!fmt1.exec(sDate1)) {
			alert("년이 잘못 입력되었습니다");
			return false;
		}
	}
	if ((opt == 'M')||(opt == 'D'))
	{
		if ((!fmt2.exec(sDate2)) || (sDate2 > 12 ) || (sDate2 == 0)){
			alert("월이 잘못 입력되었습니다");				
			return false;
		}
	}		
	if (opt == 'D')
	{		
		if ((!fmt2.exec(sDate3)) || (sDate3 > mon_arr[sDate2-1]) || (sDate3 == 0)){
			alert("일이 잘못 입력되었습니다");				
			return false;
		}
	}
	return true;
}

//--------------------------------------------------
//	날짜형식지정 (날짜 2/4 입력했을때 2008-02-04 로) - RM그리드에서사용
//------------------------------------------------------------------------
	function jFuncDateChk_10(rowIndex, ColName) {
		var dataRow = gridRoot.getItemAt(rowIndex);	
	    var nDate = new Date();

	    var O_dat = dataRow[ColName] + ""

		//-------------------------------------------------------------
	    //  월/일 일때 입력되게
	    var intI = O_dat.indexOf('/');
	    var arrDate = O_dat.split("/");

	    if ((intI > -1) && (intI < 3)) {
	        if ((O_dat.length >= 3) && (O_dat.length < 6)) {
	            O_dat = jLenChk(arrDate[0]) + jLenChk(arrDate[1])
	        }
	    }
	    //  월.일 일때 입력되게
	    intI = O_dat.indexOf('.');
	    arrDate = O_dat.split(".");
	    if ((intI > -1) && (intI < 3)) {
	        if ((O_dat.length >= 3) && (O_dat.length < 6)) {
	            O_dat = jLenChk(arrDate[0]) + jLenChk(arrDate[1])
	        }
	    }
	    //  월-일 일때 입력되게
	    intI = O_dat.indexOf('-');
	    arrDate = O_dat.split("-");
	    if ((intI > -1) && (intI < 3)) {
	        if ((O_dat.length >= 3) && (O_dat.length < 6)) {
	            O_dat = jLenChk(arrDate[0]) + jLenChk(arrDate[1])
	        }
	    }
	    O_dat = O_dat.replace(/\./gi, "");
	    O_dat = O_dat.replace(/\-/gi, "");
	    O_dat = O_dat.replace(/\//gi, "");


		var newVal = ''
	    switch (O_dat.length) {	        
	        case 4:
				newVal =  nDate.getFullYear() + "-" + O_dat.substr(0, 2) + "-" + O_dat.substr(2, 2)
				gridRoot.setItemFieldAt(newVal, rowIndex, ColName) 
	            break;	        
	        case 6:
				newVal =  '20' + O_dat.substr(0, 2) + "-" + O_dat.substr(2, 2) + "-" + O_dat.substr(4, 2)
				gridRoot.setItemFieldAt(newVal, rowIndex, ColName) 

	            break;
	        case 8:
				newVal =   O_dat.slice(0, 4) + "-" + O_dat.slice(4, 6) + "-" + O_dat.slice(6, 8)
				gridRoot.setItemFieldAt(newVal, rowIndex, ColName) 

	            break;
			default :
				gridRoot.setItemFieldAt("", rowIndex, ColName) 

	    }

		if ( dateCheck10( dataRow[ColName], 'D') == false) {
			gridRoot.setItemFieldAt("", rowIndex, ColName) 

			return ;
		}
        return newVal
	}
//--------------------------------------------------
//	날짜형식지정 (날짜 2/4 입력했을때 2008-02-04 로) - RM그리드(등록폼)에서사용
//------------------------------------------------------------------------
function jFuncDateChk_EDIT(rowIndex, ColName) {
    var dataRow = Edit_gridRoot.getItemAt(rowIndex);	
    var nDate = new Date();

    var O_dat = dataRow[ColName] + ""

    //-------------------------------------------------------------
    //  월/일 일때 입력되게
    var intI = O_dat.indexOf('/');
    var arrDate = O_dat.split("/");

    if ((intI > -1) && (intI < 3)) {
        if ((O_dat.length >= 3) && (O_dat.length < 6)) {
            O_dat = jLenChk(arrDate[0]) + jLenChk(arrDate[1])
        }
    }
    //  월.일 일때 입력되게
    intI = O_dat.indexOf('.');
    arrDate = O_dat.split(".");
    if ((intI > -1) && (intI < 3)) {
        if ((O_dat.length >= 3) && (O_dat.length < 6)) {
            O_dat = jLenChk(arrDate[0]) + jLenChk(arrDate[1])
        }
    }
    //  월-일 일때 입력되게
    intI = O_dat.indexOf('-');
    arrDate = O_dat.split("-");
    if ((intI > -1) && (intI < 3)) {
        if ((O_dat.length >= 3) && (O_dat.length < 6)) {
            O_dat = jLenChk(arrDate[0]) + jLenChk(arrDate[1])
        }
    }
    O_dat = O_dat.replace(/\./gi, "");
    O_dat = O_dat.replace(/\-/gi, "");
    O_dat = O_dat.replace(/\//gi, "");


    var newVal = ''
    switch (O_dat.length) {	        
        case 4:
            newVal =  nDate.getFullYear() + "-" + O_dat.substr(0, 2) + "-" + O_dat.substr(2, 2)
            Edit_gridRoot.setItemFieldAt(newVal, rowIndex, ColName) 
            break;	        
        case 6:
            newVal =  '20' + O_dat.substr(0, 2) + "-" + O_dat.substr(2, 2) + "-" + O_dat.substr(4, 2)
            Edit_gridRoot.setItemFieldAt(newVal, rowIndex, ColName) 

            break;
        case 8:
            newVal =   O_dat.slice(0, 4) + "-" + O_dat.slice(4, 6) + "-" + O_dat.slice(6, 8)
            Edit_gridRoot.setItemFieldAt(newVal, rowIndex, ColName) 

            break;
        default :
        Edit_gridRoot.setItemFieldAt("", rowIndex, ColName) 

    }

    if ( dateCheck10( dataRow[ColName], 'D') == false) {
        Edit_gridRoot.setItemFieldAt("", rowIndex, ColName) 

        return ;
    }
}
	//------------------------------------------------------------------------	
	// 필터히든
	//------------------------------------------------------------------------	
	function filter_hidden() {
		$("#d_filter").css("display","none")
	}

	//------------------------------------------------------------------------	
	// 년도 기본값
	//------------------------------------------------------------------------	
    function get_year() {

		var rst_year = Get_Ado_Rst("EXEC A_SEL_YEAR", 1, 1)
		rst_year.MoveLast

		$("#년도부터").val(rst_year("년도")+'')
		$("#년도까지").val(rst_year("년도")+'')
	}
	

	

	//------------------------------------------------------------------------	
	// 옵션코드 추가
	//------------------------------------------------------------------------	
    function add_option(WHopt1,LBL_OPT1,LBL_OPT2,LBL_OPT3,LBL_OPT4) {
		var LBL_OPT , ret_i

		for (i = 1; i < 5 ; i++) { 
			LBL_OPT = eval("LBL_OPT" + i)

			if ( LBL_OPT !== 'null' && WHopt1 !== 'null' && LBL_OPT != '' ) {
				$("#d_option").append("<label class='label-option' for=opt_" + i + ">" + LBL_OPT.replace("_1","") + "</label>")

				if (WHopt1=="SO001")	{
					$("#d_option").append("<input type='checkbox' id='opt_" + i + "' class='option' /><br>")
					if (LBL_OPT.search("_1") > 1 )	{
						$("#opt_" + i).attr("checked",true)
					}
				}
				else if (WHopt1=="SO002")	{
					if (i==1)	{
						$("#d_option").append("<input type='radio' value='" + i + "' name='opt_radio' class='option' checked id='opt_" + i + "'/><br>")
					}
					else {
						$("#d_option").append("<input type='radio' value='" + i + "' name='opt_radio' class='option' id='opt_" + i + "'/><br>")
					}

				} 
			ret_i = i
			}
		}
		if (ret_i>3)	{
			$("#d_option").css("padding-top","8px")
		}
	}

	//------------------------------------------------------------------------	
	//  헤더 엑셀용 텍스트 변환 Sub_XlsHeader
	//------------------------------------------------------------------------	
	function Sub_XlsHeader(div) {
		var T_Cnt , t_exist
		XHP_No_Of_Line = 1

		for (T_Cnt = 1; T_Cnt <= 50; T_Cnt++) { XHPR_Record_Value(T_Cnt) = "";	}
		T_Cnt = 0
		t_exist = false

		$("#d_" + div + " *").each(function(){
			if ( ( this.tagName=='BR' || this.className=='label-right') && t_exist == true )
			{
                XHPR_Record_Value(0) = T_Cnt
                Header_Save(XHP_No_Of_Line,div)
                XHP_No_Of_Line = XHP_No_Of_Line + 1
                for (T_Cnt = 1; T_Cnt <= 50; T_Cnt++) { XHPR_Record_Value(T_Cnt) = "";	}
                T_Cnt = 0
				return true  // NEXT each
			}

		   switch(this.tagName) {
		   case 'LABEL':
		   case 'TH':
				XHPR_Record_Value(T_Cnt * 5 + 1) = 1
				XHPR_Record_Value(T_Cnt * 5 + 2) = this.id
				XHPR_Record_Value(T_Cnt * 5 + 3) = $(this).text()
				XHPR_Record_Value(T_Cnt * 5 + 4) = 0
				XHPR_Record_Value(T_Cnt * 5 + 5) = $(this).width()
				t_exist = true
				T_Cnt++ 
				break
		   case 'INPUT':
				XHPR_Record_Value(T_Cnt * 5 + 1) = 2
				XHPR_Record_Value(T_Cnt * 5 + 2) = this.id
				if ($(this).attr("type")=='text')	{
					XHPR_Record_Value(T_Cnt * 5 + 3) = $(this).val()
				}
				else 	{
					XHPR_Record_Value(T_Cnt * 5 + 3) = $(this).is(":checked")
				}

				XHPR_Record_Value(T_Cnt * 5 + 4) = 0
				XHPR_Record_Value(T_Cnt * 5 + 5) = $(this).width()
				t_exist = true
				T_Cnt++ 
				break
		   case 'SELECT':
				XHPR_Record_Value(T_Cnt * 5 + 1) = 2
				XHPR_Record_Value(T_Cnt * 5 + 2) = this.id
				XHPR_Record_Value(T_Cnt * 5 + 3) = $("option:selected",this).text()
				XHPR_Record_Value(T_Cnt * 5 + 4) = 0
				XHPR_Record_Value(T_Cnt * 5 + 5) = $(this).width()
				t_exist = true
				T_Cnt++ 
				break
		   }
           
		 //  T_Cnt++ 

		});
		XHPR_Record_Value(0) = T_Cnt
        Header_Save(XHP_No_Of_Line,div)

	}


	//------------------------------------------------------------------------	
	// 서브폼 creteria 가져오기
	//------------------------------------------------------------------------	
	function Sub_LIst(div) {
		var creteria
		creteria = ''

		switch(div) {
		case "subform":
		    $("#d_subform input , #d_subform select").not("#Execute, #VendorName , #checkAll, #zeroAll, .execute , .input-radio2, .except").each(function(){
			//	creteria += ",'" + $(this).val() + "'"

				if ($(this).attr("type")=="checkbox")				{
				   if ($(this).is(":checked"))   {
					  creteria += "," + 1
				   }
				   else {
					  creteria += "," + 0
				   }	
				}
				else {
					creteria += ",'" + $(this).val() + "'"
				}
			});

			$("#d_subform :radio").each(function(){
                console.log($(this).val())
				   if ($(this).is(":checked"))   {
					  creteria += "," + $(this).val()
				   }
			});

			break;
		case "option":
			$("#d_option > :checkbox").each(function(){
			   if ($(this).is(":checked"))   {
					  creteria += "," + 1
				   }
				   else {
					  creteria += "," + 0
				   }	
			});

			$("#d_option > :radio").each(function(){
				   if ($(this).is(":checked"))   {
					  creteria += "," + $(this).val()
				   }
			});

			break;

		} 	
		return creteria;
	}

	//------------------------------------------------------------------------	
	// 엑셀변환시 필요한 서브폼 내용 json 형태로 출력
	//------------------------------------------------------------------------	
	function Sub_LIst_Json(div) {
		var creteria
		creteria = '{"text":"'
        var t_cnt = 1
		switch(div) {
		case "subform":
		    $("#d_subform input , #d_subform select, #d_subform .label-left, #d_subform .label-center, #d_subform .label-right").not("#Execute, #VendorName , #checkAll, #zeroAll, .execute , .input-radio2, .except").each(function(){
			//	creteria += ",'" + $(this).val() + "'"
             
                if ($(this).attr("class")=="label-left" || $(this).attr("class")=="label-center" || $(this).attr("class")=="label-right"){
                    creteria += "("+$(this).text() + ")";
                }
				if ($(this).attr("type")=="checkbox")				{
				   if ($(this).is(":checked"))   {
					  creteria += " " + 1
				   }
				   else {
					  creteria += " " + 0
				   }	
				}
				else {
					creteria += " " + $(this).val() + " "
				}
                t_cnt +=  1
			});

			$("#d_subform :radio").each(function(){
                if ($(this).attr("class")=="label-option"){
                    creteria += "("+$(this).val() + ")";
                }
                if ($(this).is(":checked"))   {
                    creteria += " " + $(this).val()
                }
                t_cnt +=  1
			});
            creteria += '", "colSpan": '+t_cnt+' , "textAlign":"left"}'
			break;
		case "option":
            $("#d_option .label-option").each(function(){
                creteria += "("+$(this).text() + ")";
                t_cnt +=  1
            });
			$("#d_option > :checkbox").each(function(){
   
			   if ($(this).is(":checked"))   {
                    creteria += " " + 1
                }
                else {
                    creteria += " " + 0
                }	
                t_cnt +=  1
			});

			$("#d_option > :radio").each(function(){
                if ($(this).is(":checked"))   {
                    //console.log($(this).id)
                    //creteria += "[" + $("label[for='"+$(this).id +"']").text() + "]";
                    creteria += " " + $(this).val()
                    t_cnt +=  1
                }
                
			});
            creteria += '", "colSpan": '+t_cnt+' , "textAlign":"left"}'
			break;

		} 	
		return creteria;
	}	
	/*
	//------------------------------------------------------------------------	
	//필터키 활성화
	//------------------------------------------------------------------------	
	function short_cut_show(x,y) {
		// twip 픽셀전환 , 1 pixel = 15 twip
		var x = x/15 //+ 5
		var y = y/15 //+ 5 

		// paernt 폼에서 기준 width 및 height 구해옴
		var dwidth = $("body",parent.document).width() - $("#dmenu",parent.document).outerWidth() - 3// 스크롤바 크기 
		var dheight = $("body",parent.document).height() - $("#dfwrap",parent.document).outerHeight()  - 12


		dheight = dheight - $("#d_header").height()
	
		// 가장자리에서 팝업할때 메뉴를 바운드안으로 이동하기 위한 수식
		if ( x > dwidth - $("#d_filter").width()){
			x = (x - $("#d_filter").width())
		}
		if ( y > ( dheight - $("#d_filter").height() ) ){
			 y =  y - $("#d_filter").height()   
		}
		// 정해진 위치로 이동
		$("#d_filter").css("display","inline").css("left",x).css("top",y)


	}*/
	
//----------------------------------------------------------
//   창고재고 보기
//----------------------------------------------------------
function stock_show(item_no,col){ 

	var	pop = window.open ("../IncPopup/Popup_order_stock.ASP?dn="+escape(item_no)+"&col="+escape(col),"창고재고"
							,"menubar=no,toolbar=no,scrollbars=yes,status=no,location=no,resizable=yes,top=400,left=1000,width=450,height=300","help=no")   
	pop.focus();
	
}

//------------------------------------------------------------------------	
// height 길이조정 
//------------------------------------------------------------------------	
function height_resize() {

	var inc_h = ( 925 -  $("body").height() )  / 53  

	$("#d_fg").height($("body").height() - $("#d_header").outerHeight() - inc_h);
}	
	

//------------------------------------------------------------------------	
// 서버 시간 get
//------------------------------------------------------------------------	
function servertime(){ 
//	var rst = Get_Ado_Rst("SELECT 현재시간 FROM PresentTime" , 1, 1)
//	var r_date = $.datepicker.formatDate('yy-mm-dd', new Date(rst("현재시간")) ) 

	var str_sql = "SELECT [현재시간] FROM [PresentTime]"
	var rst = Get_Json(str_sql)  
	var r_date = $.datepicker.formatDate('yy-mm-dd', new Date(rst[0].현재시간) ) 

	return r_date
};


//---------------------------------------------------------------------------
//	다운로드 파일 체크
//---------------------------------------------------------------------------
function jFunExcelChk(tmpName)
{
//	vFunSavePath()
	document.location.href = "../INCLUDE/DownLoad_Ex.asp?tmpDocu=" + tmpName;
}


//---------------------------------------------------------------------------
//	그리드 전체선택
//---------------------------------------------------------------------------
function gridSelectAll(obj, gFG, fieldName , T_Table_Name ) {    
	//var PRKs
	//	PRKs = "";
try
{
	
	var fieldNameEX = fieldName.replace("#C_","")
	console.log(fieldName)
	var CheckBoxColumn = gridRoot.getObjectById(fieldName);
	CheckBoxColumn.setAllItemSelected(!CheckBoxColumn.getAllItemSelected());
    
    nomal_grid_Init()
    var prk_data = gridRoot.getCollection().getSource()
    var prk_text = ""
    // 업데이트 된 행을 알수 없어서, 현재 그리드에서 PRK가 일치하는 행을 찾아서 업데이트
    for(var j in prk_data){
        var t_prk = prk_data[j]["#PRK"]
        prk_text = prk_text + "'" + t_prk + "',"
    }
    prk_text = prk_text.substring(0, prk_text.length-1)
    var t_sql ="UPDATE " + T_Table_Name + " SET " +  fieldNameEX + "=" + (obj.checked==true?1:0) + " WHERE [Perm_ID] =" +  P_Cur_Permit_ID + " AND [#PRK] IN (" + prk_text + ")"
    //console.log(t_sql)
    Get_Json(t_sql)
		//PRKs = PRKs.substring(1, PRKs.length);
		//var strSql = "UPDATE " + T_Table_Name + " SET " +  fieldNameEX + "=" + (obj.checked==true?1:0) + " WHERE Perm_ID =" +  P_Cur_Permit_ID + " AND #PRK in (" + PRKs + ")"
		//objRs = Get_Ado_Rst(strSql,1,1)

	//objRs = null

}
catch (err)
{
	console.log(err.message)
}	

}

//---------------------------------------------------------------------------
//	리바인드 구폼에서 호출
//---------------------------------------------------------------------------
function Rebind() {
	RM_Verify_Click() 
}


//---------------------------------------------------------------------------
//	fg background Image
//---------------------------------------------------------------------------
function fg_image(gFG) {
    gFG.Rows = 1
    gFG.Cols = 1
    gFG.ColWidth(0) = gFG.Width
    gFG.RowHeight(0) = gFG.Height

}

//------------------------------------------------------------------------
//오토컴플리트 검색 2020.05.28 JJH
//------------------------------------------------------------------------
function AutoComplate(tsql, DivName, Divid, rstname, rstid)
{

    var auto_rst =  Get_Ado_Rst(tsql , 1, 1)
    
        var auto_list = []
        // 아이디값 없으면 아이디없이 텍스트만
        if (Divid=="" || rstid=="")
        {
            if(auto_rst.RecordCount > 0)
                {
                    auto_rst.MoveFirst();
                    //alert(DivName)
                    var i = 0 
                    while (auto_rst.EOF != true)    {
                        var auto_name = auto_rst(rstname)+""
                        auto_list[i] = {
                            value:auto_name
                        }
                        //console.log(auto_list[i].value + " "+ auto_list[i].id);
                        auto_rst.MoveNext();
                        i = i + 1;
                    }
                }
            $(DivName).autocomplete({
                source: auto_list,
                select: function(event, ui){
                    //console.log("선택 :" + ui.item.value);
                    //console.log("선택 :" + ui.item.id);

                    return false;
                },
                //focus: function(event, ui){
                //    return false
                //},
                close: function(event){
                    //console.log("닫음 :" +event.ui.item.value);
                }
            });
        }
        // 아이디값 있으면 아이디값까지
        else {
            if(auto_rst.RecordCount > 0)
                {
                    auto_rst.MoveFirst();
                    
                    var i = 0 
                    while (auto_rst.EOF != true)    {
                        var auto_id = auto_rst(rstid)+""
                        var auto_name = auto_rst(rstname)+""
                        auto_list[i] = {
                            value:auto_name,
                            id:auto_id
                        }
                        //console.log(auto_list[i].value + " "+ auto_list[i].id);
                        auto_rst.MoveNext();
                        i = i + 1;
                    }
                }
            $(DivName).autocomplete({
                source: auto_list,
                select: function(event, ui){
                    //console.log("선택 :" + ui.item.value);
                    //console.log("선택 :" + ui.item.id);
                    if($(Divid).val() != ui.item.id){
                        $(Divid).val(ui.item.id);
                        
                    }                
                    $(Divid).val(ui.item.id);

                    return false;
				},
				
                //focus: function(event, ui){
                //    return false
                //},
                close: function(event){
                    //console.log("닫음 :" +event.ui.item.value);
                }
            });
        }
        
}
//------------------------------------------------------------------------
// ajax로 DB데이터 받아오기 // Json 형태로 받아짐
//------------------------------------------------------------------------
function ajax_Json(t_sql)
{
    var t_url
    t_url="../INCLUDE/Ajax_Conn.asp"
    var t_obj 
    $.ajax({
        type: "GET",
        dataType: "json",
        url: t_url,
        async : false,
        data: "t_sql=" +t_sql, 
        
        success: function(JsonObj) {
            //console.log(JsonObj.data);
            t_obj = JsonObj.data
        },
        error: function(xhr, option, error) {
            //alert(xhr.status);
            alert(option + " : "+error +"   "+xhr.status);
        }
    });   
    return t_obj
}


//----------------------------------------------------------------------
// 윈도우 팝업 화면 가운데 띄우는 함수   PopupCenter(url, title, w, h)
//----------------------------------------------------------------------

function PopupCenter(url, title, w, h) {
    // Fixes dual-screen position                         Most browsers      Firefox
    var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
    var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;
    var width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
    var height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;
    var left = ((width / 2) - (w / 2)) + dualScreenLeft;
    var top = ((height / 2) - (h / 2)) + dualScreenTop;
    var newWindow = window.open(url, title, 'scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
    // Puts focus on the newWindow
    if (window.focus) {
        newWindow.focus();
    }
}