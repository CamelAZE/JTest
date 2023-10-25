var rst_type, rst_type2
var header_merge, header_merge2
//--------------------------------------------------------------------------------
// -- �������� ���ڵ�� �޾Ƽ� json ���·� �޾ƿ��� /(������Ÿ�� ����)
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
                //alert("��ȸ�� �ڷᰡ �����ϴ�.");
                return "��ȸ�� �ڷᰡ �����ϴ�."//false;
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
// -- �������� ���ڵ�� �޾Ƽ� json ���·� �޾ƿ��� /(������Ÿ�� ������)
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
                //alert("�����Դϴ�.")
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
// -- �������� ���ڵ�� �޾Ƽ� json ���·� �޾ƿ���
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
                alert("��ȸ�� �ڷᰡ �����ϴ�.");
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
// -- �������� ���ڵ�� �޾Ƽ� json ���·� �޾ƿ��� /(������Ÿ�� ����// header_merge�κ��� ����)
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
                //alert("��ȸ�� �ڷᰡ �����ϴ�.");
                return "��ȸ�� �ڷᰡ �����ϴ�."//false;
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
//   UTF8�� ���ڴ� ���ڴ�
//------------------------------------------------------------------------
function decodeUTF8(str){
    return decodeURI(str); // �Ǵ� return decodeURIComponent(str);
}
function encodeUTF8(str){
// Ư�����ڵ� ���ڵ� �ϱ� ���ؼ��� encodeURIComponent �� ����Ѵ�.
    return encodeURI(str);
}
//--------------------------------------------------------------------------------
// -- Get_Json_type_direct
// -- ���� ��Ȳ�� ��ȸ�� ��� (data, header, type 3���� json�ʿ� / �񵿱�Ÿ��) 
// -- �Ϸ��� RM_Verify_Click_Done ����
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
		//traditional: true,	// ajax �迭 �ѱ�� �ɼ�!
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
			var t_grid_name = get_cur_tab_name(divname)	//���缱�õ� ���� ���̸� ��������
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
// -- Get_Json_type_direct2 (�׸��� �������϶�)
// -- ���� ��Ȳ�� ��ȸ�� ��� (data, header, type 3���� json�ʿ� / �񵿱�Ÿ��) 
// -- �Ϸ��� RM_Verify_Click_Done ����
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
		//traditional: true,	// ajax �迭 �ѱ�� �ɼ�!
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		dataType: "json",
		async : true, 
        cache : false,
		success: function (data) {	
			temp_rst = (data.data)
			rst_type = (data.type[0])
			header_merge = (data.header)
			var t_grid_name = get_cur_tab_name()	//���缱�õ� ���� ���̸� ��������
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
// -- �������� ���ڵ�� �ؽ�ƮŸ�����·� �޾Ƽ� json ���·� �޾ƿ���
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
		traditional: true,	// ajax �迭 �ѱ�� �ɼ�!
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
// -- ���� ������� ����ϴ� �Լ�(��������, ���Ŀ� �Լ��� �����Ѵ�)
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
		traditional: true,	// ajax �迭 �ѱ�� �ɼ�!
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
// -- ���� ������� ����ϴ� �Լ�(��������, ���Ŀ� �Լ��� �����Ѵ�) // ������ ����Ǵ� �Լ��� �ٸ��� ����
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
		traditional: true,	// ajax �迭 �ѱ�� �ɼ�!
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
// --�λ���ī�忡����� / ���� ������� ����ϴ� �Լ�(��������, ���Ŀ� �Լ��� �����Ѵ�) // ������ ����Ǵ� �Լ��� �ٸ��� ����
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
		traditional: true,	// ajax �迭 �ѱ�� �ɼ�!
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
// ������ �޾ƿ��� ���� ����Ǵ�
//------------------------------------------------------------------------
function Get_Json_Before() {
    progress_modal_init();      // ���α׷����� �ʱ�ȭ
    progress_show();            // ���α׷����� ���̱�
    progress_auto_exe(0, 100)   // ���α׷����� ����
}
//------------------------------------------------------------------------	
// ������ �޾ƿµ� �����ϴ� �Լ�
//------------------------------------------------------------------------
function Get_Json_Done(temp_rst) {
    if(typeof Get_Json_After == "function"){   // �� ������ �����ؾ��� �Լ�/ ������ �������
        Get_Json_After(temp_rst)         
    }
    progress_exe(100)               // ���α׷����� 100%�� �����
    setTimeout(async function(){
		await  progress_hide();
	}   , 300);                     // ���α׷����� �����
}
//------------------------------------------------------------------------	
// ������ �޾ƿ��� �����߻��� �����ϴ� �Լ�
//------------------------------------------------------------------------
function Get_Json_Error() {
    if(typeof Get_Json_Error_result == "function"){   // �� ������ �����ؾ��� �Լ�/ ������ �������
        Get_Json_Error_result()         
    }
    progress_hide();                // ���α׷����� �����
    //alert("��ȸ���ڷᰡ �����ϴ�.")  
}
//------------------------------------------------------------------------	
// ������ �޾ƿµ� �����ϴ� �Լ�
//------------------------------------------------------------------------
function Get_Json_Done2(temp_rst) {
    if(typeof Get_Json_After2 == "function"){   // �� ������ �����ؾ��� �Լ�/ ������ �������
        Get_Json_After2(temp_rst)         
    }
}
//------------------------------------------------------------------------	
// ������ �޾ƿµ� �����ϴ� �Լ�(�λ���ī������)
//------------------------------------------------------------------------
function Get_Json_HRM_Done(temp_rst, hrm_type_rst, hrm_header_rst, t_sno) {
    if(typeof Get_Json_HRM_After == "function"){   // �� ������ �����ؾ��� �Լ�/ ������ �������
        Get_Json_HRM_After(temp_rst,hrm_type_rst, hrm_header_rst, t_sno)         
    }
}
//------------------------------------------------------------------------	
// ������ �޾ƿ��� �����߻��� �����ϴ� �Լ�
//------------------------------------------------------------------------
function Get_Json_Error2() {
    if(typeof Get_Json_Error_result == "function"){   // �� ������ �����ؾ��� �Լ�/ ������ �������
        Get_Json_Error_result2()         
    }
}
//-----------------------------------------------------------------------
//**********************************************************************
// ���α׷����� ���� �Լ� // progress_Modal, progress ���� ���� �־����
//**********************************************************************
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//  ���α׷����ٸ� ���Ծ� modalâ ���̱� (���� 10%)
//-----------------------------------------------------------------------
function progress_show(){
    $("#progress_Modal").modal('show');
    $("#progress_Modal").css("display", "block");
    progress_exe(10)
}
//-----------------------------------------------------------------------
//  ���α׷����� ����� ������Ʈ (100%�޼��� modalâ �����)
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
//  ���α׷����� modalâ �ݱ�
//-----------------------------------------------------------------------
function progress_hide(){
    $("#progress_Modal").modal("hide");
    $("#progress_Modal").css("display", "none");
}
//-----------------------------------------------------------------------
//  ���α׷����� ���â �ʱ�ȭ(���α׷����� ����, �޼���, ��ư ��)
//-----------------------------------------------------------------------
function progress_modal_init(){
    progress_hide();
    $("#progress").removeClass("progress-bar-warning")
    $("#progressModalLabel").text("��ȸ���Դϴ�. ��ø� ��ٷ��ּ���.")
    $("#modal-footer").empty()
    progress_exe(0)
}
//-----------------------------------------------------------------------
//  ���α׷����� ���â ����â���� ����(���α׷����� ����, �޼���, ��ư ��)
//-----------------------------------------------------------------------
function progress_modal_init_error(){
    progress_hide();
    alert("��ȸ���ڷᰡ �����ϴ�.")
    $("#verify").attr("disabled",false);
    /*
    $("#progress").addClass("progress-bar-warning")
    $("#progressModalLabel").text("��ȸ�� �ڷᰡ �����ϴ�.")
    $("#modal-footer").append("<button type='button' class='btn btn-secondary' onclick='progress_hide()'>�ݱ�</button>")
    */
}
//-----------------------------------------------------------------------
//  ���α׷����� �ڵ�����
//-----------------------------------------------------------------------
function progress_auto_exe(start_num, end_num){
    var t_prog = start_num 
    progress_plus = setInterval(function() {
        t_prog = (t_prog % 100) + 3; 
        //$("#progressModalLabel").text("��ȸ���Դϴ�.("+t_prog+")" )
        progress_exe(t_prog);
    } 
    , 200);
}
//------------------------------------------------------------------------	
// ��¥Ÿ�� ����
//------------------------------------------------------------------------	
function Get_SubFrmDate(T_Type) {
alert(	1 )
	if (T_Type == "00") { return } 

	var date_rst = Get_Json("Exec [H_DEFINE_SUBFRM_DATE]  " , "'" + T_Type + "'")
//	console.log(date_rst)
	var x = date_rst[0].�Ⱓ����;
	var y = date_rst[0].�Ⱓ����;


//	x="2021-12-01"
//	y="2021-12-31"
	//console.log(x + " " + y)
		$("#�Ⱓ����").val(x)
		$("#�Ⱓ����").val(y)

	if ( x === undefined || x === null){	return	};	// hschoi �߰�. "#�Ⱓ����" �Ⱦ��µ����� ���⼭ ����.

		$("#�⵵").val(x.substring(0, 4))
}

//------------------------------------------------------------------------	
//DB���� ������ �޾ƿ���
//------------------------------------------------------------------------	
function RM_Verify_Click() {
    if ( $("#�Ⱓ����").val() >  $("#�Ⱓ����").val() ) 		{
		progress_modal_init_error();
		clearInterval(progress_plus);
        alert("��¥ ������ �߸� �Ǿ����ϴ�")
        return
    }
	//-------------------------------------------------------------------------
	// ���� ����
	//-------------------------------------------------------------------------
	var strSql = "Exec [" + Procedure_Name + "] " + seSawonid  +  Sub_LIst("subform") + Sub_LIst("option")
	console.log(strSql)
	
	//-------------------------------------------------------------------------
	// DB���� ������ �޾ƿ��� (����Ϸ�Ǹ� RM_Verify_Click_Done ����)
	//-------------------------------------------------------------------------
	t_data = Get_Json_type_direct(strSql)	
	
}
//------------------------------------------------------------------------	
//�׸��� ����
//------------------------------------------------------------------------
function RM_Verify_Click_Done(t_data , t_grid_name, strSql, t_div_name) {
	
	//-------------------------------------------------------------------------
	// �׷������
	//-------------------------------------------------------------------------
	RM_Create(t_data, t_grid_name, t_div_name)
	
	//-------------------------------------------------------------------------
    //-��ȸ �α׵����� ����
	//-------------------------------------------------------------------------
    Get_Json_async("Exec [E_LOG_ERP_INS] '"+seSawonid+ "','��ȸ','" +MenuName+ "','" + Workid +"','" + Procedure_Name + "','" + strSql.replace(/'/gi,"") + "','','"+IP_Address+"'")
    if ($("#progress_div").length > 0){ // ���â�� �������� �����
        progress_exe(100)
        setTimeout(async function(){
            await  progress_hide();
            $("#verify").attr("disabled",false);
        }   , 300);
    }
	
}

//------------------------------------------------------------------------	
// sp������ ���� rm �׸������
//------------------------------------------------------------------------	
function RM_SP_Create(spname, param, gridname) {

    // ----------------------------------------------------------------------
    var strSql = "Exec [" + spname + "] " + param
    ///-------------------------------------------------------------------------
	// DB���� ������ �޾ƿ��� (����Ϸ�Ǹ� RM_Verify_Click_Done ����)
	//-------------------------------------------------------------------------
	var t_data = Get_Json_type_direct(strSql)
    //console.log(strSql)
    //RM_Create(t_data, gridname) 
    //----��ȸ �α׵����� ����--------------------------------------------------
    //Get_Json_async("Exec [E_LOG_ERP_INS] '"+seSawonid+ "','��ȸ','�˾�("+spname+")','" + Workid +"','" + spname + "','" + strSql.replace(/'/gi,"") + "','','"+IP_Address+"'")

}


//------------------------------------------------------------------------	
//���� ��¹�ư 
//------------------------------------------------------------------------	
function RM_PRT_PVW_Click(){
	excelExport('EXCEL')
}
//------------------------------------------------------------------------	
//����Ʈ ��¹�ư 
//------------------------------------------------------------------------	
function RM_PRT_OUT_Click(){
	excelExport('PRINT')
//	alert("����Ʈ ��¹�ư Ŭ��")
//    var subform_json = JSON.parse(Sub_LIst_Json("subform"))
//    var option_json = JSON.parse(Sub_LIst_Json("option"))
//    subform_json = JSON.stringify(subform_json)
//    option_json = JSON.stringify(option_json)
//    Get_Json_async("Exec [E_LOG_ERP_INS] '"+seSawonid+ "','PRINT','" +MenuName+ "','" + Workid +"','" + Procedure_Name + "','" + subform_json.replace(/'/gi,"") + " " + option_json.replace(/'/gi,"") + "','','"+IP_Address+"'")
}

//------------------------------------------------------------------------	
// null, undefined �������� ��ȯ �Լ�
//------------------------------------------------------------------------	
function null_To_Blank(t_value, opt){
    if (t_value == "" || t_value == null || t_value == "undefined"){
             if (opt==1){ t_value = "0"  }   //--- �ɼ� 1 : ����
        else if (opt==2){ t_value = ""   }   //--- �ɼ� 2 : ����
        else if (opt==3){ t_value = null }   //--- �ɼ� 3 : ��¥(null)
        else if (opt==4){ t_value = " "  }   //--- �ɼ� 4 : ��Ÿ ��ĭ ����
    }
    return t_value
}

//------------------------------------------------------------------------	
// ����, null, undefined üũ �ռ� 
//------------------------------------------------------------------------	
function nbu_check(t_value){
    if (typeof t_value == "undefined") { return false}
    if (t_value == "" || t_value == null || t_value == "undefined"){
        return false
    }
    return true
}
 
//------------------------------------------------------------------------	
// ����� ����κ� ���� ������ ����
//------------------------------------------------------------------------	
function reg_Header_Sql_Create(temp_para , t_input){
    //console.log(t_input)
	t_input.each(function(){

		if ($(this).attr("type")=='text' || $(this).attr("type")=='hidden' || $(this).attr("type")=='date')	{	
			var t_this_val = $(this).val()
			if (t_this_val.includes("'") > 0) {
				t_this_val = t_this_val.replace(/'/g, "''")
				console.log("����ǥ���� " + t_this_val + " id " + $(this).attr("id"))
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
                var t_select =  $(this).val() +"','" + $("#"+this.id + " > option:selected").attr("s_id")       // select �ڽ��� id�� �Բ�����
                //console.log(t_select)
            }
			
            temp_para = temp_para + "'" + t_select +"',"
		}else if ($(this).attr("type")=='radio' && 
                    (this.id != "�ε��׽þ�" && this.id != "��Ʈ��"))	{   // �ε��׽þ�, ��Ʈ���� ������Ͽ��� ����ó���ؼ� ����
           
		}
	});
	return temp_para
}

//-----------------------------------------------------------------------------------
// ���ڵ���� ������ �׸�������� ���� ������ ���� �޾ƿ�����
// �����̰� ��ü �����̶�� setData�� ���� �ʱ����� üũ // t_data_check = 1 �̸� ���鸸 �ִ� ����¥�� ��
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
 // ���� export
 // excelExportSave(url:String, async:Boolean);
 //    url : ���ε��� ������ url, �⺻�� null
 //    async : �񵿱� ���� ���࿩��, �⺻�� false
 //-----------------------------------------------------------------------------------
 function excelExport(OPT) {
  //  dataGrid.exportOnlyData = inputForm.dataOnly.checked;
    console.log("���")
    var sel_opt = $("#Xls_Cfg").val()
    //---�����͸�, �հ踸�� ������ �˾��� ����� ������ȯ-----------------------------
    if (sel_opt == 1 || sel_opt == 3){ 
        // N_Excel_Export_onlySum
        var t_open_com = "/N_ERP/erp_func/N_Excel_Export_onlySum.ASP"
        var t_popup = window.open( t_open_com , "�������_�հ踸", "width=1000px , height=300px , scrollbars=yes");
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
                        subform_json// {text:"[�Ⱓ] [����] [����]", colSpan:5 ,textAlign:"left"  }
					  ]   
		  },
		  {height:24, fontSize:13, 
				cells: [
                        option_json//{text:"[�Ⱓ] [����] [����]", colSpan:5 ,textAlign:"left" }
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
		  {height:18, fontSize:10, color:"#888888", textAlign:"left", backgroundColor:"#EEEEEE", text:"�� ������ ��ܺ��Դϴ�. �ܺο� ������ �ȵǵ��� ������ �ֽñ� �ٶ��ϴ�."},        // ���� �Ӽ��� �����Ͽ� �ֽ��ϴ�.
		  null                                   // ����� - ���� ���̴� DataGrid�� exportFooterHeight�� �����ϴ�.
	];
 
	dataGrid.exportType = "xls"
	 dataGrid.exportFileName = $("#t_header").text() + getTodayTime() +  ".xls" // dataGrid.exportType;
     dataGrid.exportOnlyVisibleColumns = true;  // ���̴¿��� ��µǵ��� ���� // ��ü�����Ȳ��� ���迭�� ������ü������ �־
 //  dataGrid.exportSheetName = "Sheet1";
     //23.03.01 ������α׷��� ���ؼ� ��µ����� �����ٿ�ε�� �ּ�ó��
	 //gridRoot.excelExportSave("", false);
     
	// excel export ����
	//    url : ���ε��� ������ url, �⺻�� null
	//    async : �񵿱� ���� ���࿩��, �⺻�� false

	gridRoot.excelExportUpload("/N_EXCEL/Excel_RMATE_SERVER.ASP?Sawonid=" + seSawonid + "&OPT=" + OPT , false);

  //   Get_Json_async("Exec [E_LOG_ERP_INS] '"+seSawonid+ "'," + OPT + ",'" +MenuName+ "','" + Workid +"','" + Procedure_Name + "','" + subform_json.replace(/'/gi,"") + " " + option_json.replace(/'/gi,"") + "','','"+IP_Address+"'")
 }

//-----------------------------------------------------------------------------------
/*	N_Search_Pop ���� 
    Gubun = normal �Է°��� �˻� // select : �˻��������ϰ� ��ü �˻�
    Form_Name = �޴��� �̸� // FindTBL�� FormName // Ư���� ��� �ƴϸ� �������� ����
    Search_text = �˻��� ��
    --------------------------------------------------------------
    Upd_Gubun = Grid   �׸��忡 ������Ʈ�Ҷ� ���
            Row_Index : ���õ� ���� ������Ʈ�� �׸����� �� �ε���
            Col_Index : ���õ� ���� ������Ʈ�� �׸����� �� �ε���
    --------------------------------------------------------------
    Upd_Gubun = Reg   ������� ������Ʈ�Ҷ� ���
                Row_Index : ���õ� ���� ������Ʈ�� ��üID
                Col_Index : ������
    --------------------------------------------------------------
    Upd_Gubun = Reg_ID   ��������� ID�� ���� �Բ� ������Ʈ�Ҷ� ���
                Row_Index : ���õ� ���� ������Ʈ�� ��üID
                Col_Index : ���õ� ���� ID�� ������Ʋ�� ��üID
*/
//------------------------------------------------------------------------	
// �˻�â �˾� ����
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
     alert("�˻��׸� �������� �ʾҽ��ϴ�.");
     return;
 }
 Sp_name ="[" +Find_Rst[0].Sp_name + "] "
 //----------FindTBL�� �ڷ� ���� ��� ------------------------------------------
 if (Sp_name=="undefined" || Sp_name==""){
     alert("�˻��� �ڷᰡ �����ϴ�.");
     return;
 }
 //---------�޾ƿ� SP�� �˻� Json �޾ƿ��� --------------------------------------
 var t_sql = Sp_name + " '" +t_search+"'" + t_All_Param
 console.log(t_sql)
 Search_Rst =  Get_Json(t_sql)
 //---------����� �������--------------------------------------------
 if (Search_Rst){
    if (Search_Rst.length<=0){
        alert("�˻��ȳ����� �����ϴ�.");
        return;
    }
 }else { alert("�˻������ �����ϴ�."); return ;}
 //------------------------------------------------------------------------
 //  �˻����� �ϳ��ϰ�� �˾������ʰ� �ڵ��Է�
 //------------------------------------------------------------------------
 if (Search_Rst.length==1){
    var j = 0
    var t_val, t_id;
    //-----json ���� �������� ���� �������ͼ� ù����, �ι����� ���� ������������---
    $.each(Search_Rst[0], function(key, value){
        if (j==0){
            t_id = value
        } else if (j==1){
            t_val = value
        }
        j = j+1
    })
    //------------------------------------------------------------------------
    //  �˻����� �ϳ��ϰ�� �˾������ʰ� �ڵ��ԷµǴ� �Լ� // ����ҽ��� ����
    //------------------------------------------------------------------------
    Search_One_Select(t_Upd_Gubun, t_val, t_id, t_rowIndex, t_colIndex, "", t_conname, Search_Rst)  
    return
 }
 console.log("t_param1 " + t_param1)
 var t_open_com = "/N_ERP/erp_func/N_Search_Pop.ASP?Upd_Gubun="+t_Upd_Gubun + "&Gubun="+t_Gubun +"&Form_Name="+t_MenuName+"&Con_Name="+t_conname+"&Search_text="+t_search+"&Row_Index="+t_rowIndex+"&Col_Index="+t_colIndex+"&Param01="+t_param1+"&Param02="+t_param2+"&Param03="+t_param3
 var t_popup = window.open( t_open_com , "�˻�â", "width="+t_width+" , height="+t_height+" , left="+t_left+" , top ="+t_top+" ,scrollbars=yes");
 t_popup.focus()
}
//------------------------------------------------------------------------	
// �˻�â �˾� ���� // ����� ���׸���
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
         alert("�˻��׸� �������� �ʾҽ��ϴ�.");
         return;
     }
     Sp_name ="[" +Find_Rst[0].Sp_name + "] "
     //----------FindTBL�� �ڷ� ���� ��� ------------------------------------------
     if (Sp_name=="undefined" || Sp_name==""){
         alert("�˻��� �ڷᰡ �����ϴ�.");
         return;
     }
     //---------�޾ƿ� SP�� �˻� Json �޾ƿ��� --------------------------------------
     var t_sql = Sp_name + " '" +t_search+"'" + t_All_Param
     console.log(t_sql)
     Search_Rst =  Get_Json(t_sql)
     //---------����� �������--------------------------------------------
     if (Search_Rst){
        if (Search_Rst.length<=0){
            alert("�˻��ȳ����� �����ϴ�.");
            return;
        }
     }else { alert("�˻������ �����ϴ�."); return ;}
     //------------------------------------------------------------------------
     //  �˻����� �ϳ��ϰ�� �˾������ʰ� �ڵ��Է�
     //------------------------------------------------------------------------
     if (Search_Rst.length==1){
        var j = 0
        var t_val, t_id;
        //-----json ���� �������� ���� �������ͼ� ù����, �ι����� ���� ������������---
        $.each(Search_Rst[0], function(key, value){
            if (j==0){
                t_id = value
            } else if (j==1){
                t_val = value
            }
            j = j+1
        })
        //------------------------------------------------------------------------
        //  �˻����� �ϳ��ϰ�� �˾������ʰ� �ڵ��ԷµǴ� �Լ� // ����ҽ��� ����
        //------------------------------------------------------------------------
        Search_One_Select(t_Upd_Gubun, t_val, t_id, t_rowIndex, t_colIndex, t_colIdex_ID, t_conname, Search_Rst)  
        return
     }
  
    var t_open_com = ("/N_ERP/erp_func/N_Search_Pop.ASP?Upd_Gubun="+t_Upd_Gubun + "&Gubun="+t_Gubun +"&Form_Name="+t_MenuName+"&Con_Name="+t_conname+"&Search_text="+t_search+"&Row_Index="+t_rowIndex+"&Col_Index="+t_colIndex+"&Col_Index_ID="+t_colIdex_ID+"&Param01="+t_param1+"&Param02="+t_param2+"&Param03="+t_param3)
    var t_popup = window.open(t_open_com, "�˻�â", "width="+t_width+",height="+t_height+", left="+t_left+" , top ="+t_top+" ,scrollbars=yes");
	//t_popup.location.hash = t_colIdex_ID
    t_popup.focus()
   }
//------------------------------------------------------------------------	
// �˻�â �˾� ����(���â)
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
	G_Find_Rst = Find_Rst		// ��������
	if (Find_Rst.length==0){
		alert("�˻��׸� �������� �ʾҽ��ϴ�.");
		return;
	}
	Sp_name ="[" +Find_Rst[0].Sp_name + "] "
	//----------FindTBL�� �ڷ� ���� ��� ------------------------------------------
	if (Sp_name=="undefined" || Sp_name==""){
		alert("�˻��� �ڷᰡ �����ϴ�.");
		return;
	}
    if (t_search.legnth > 1 && t_search.toString().substring(0,1) == " ") { t_search = t_search.toString().substring(1, t_search.length)}
	//---------�޾ƿ� SP�� �˻� Json �޾ƿ��� --------------------------------------
	var t_sql = Sp_name + " '" +t_search+"'" + t_All_Param
	console.log(t_sql)
	Search_Rst =  Get_Json(t_sql)
	G_Search_Rst = Search_Rst	// ��������
    //console.log(Search_Rst)
	//---------����� �������--------------------------------------------
	if (Search_Rst){
        var chk = 0
        var t_cnt = 0
        // �˻������ ���°��� 1���� �ְ� ��翭�� ������ �ϳ�������
        $.each(Search_Rst[0], function(key, value){ 
            t_cnt = t_cnt + 1
            if (value == " "){
                chk = chk + 1
            }
        })
        console.log(t_conname)
        console.log(t_cnt + " "  +chk)
        // ������ ���
        if (chk == t_cnt){
            console.log("�˻�������� t_param1 " + t_param1)
            if (File_Name == "REG_001_ORDERREG"){   // ��������ϰ��
                t_param1 = t_param1.replace(",", "")
                if (t_param1 == "'10422'" || t_param1 == "'10097'" || t_param1 == "'10052'"){    // 5376 LOGO, HEATTRANFER , 5376
                    if (t_conname =="Į��C"){
                        if(confirm("��ϵ��� ���� Į���Դϴ�. �ٷ� ����Ͻðڽ��ϱ�?")){
                            var t_sql = "EXEC [AA_REG_001_ORDERREG_COLOR_CHK] " + t_param1 + ",'" + t_search + "' , 1"
                            var t_color_rst = Get_Json(t_sql)
                            var t_color_id = t_color_rst[0].Į��ID

                            Edit_gridRoot.setItemFieldAt(t_search, t_rowIndex, "Į��") 
                            Edit_gridRoot.setItemFieldAt(t_color_id, t_rowIndex, "#Į��ID") 
                            return;
                        }
                    }else if (t_conname =="������D"){
                        if(confirm("��ϵ��� ���� �������Դϴ�. �ٷ� ����Ͻðڽ��ϱ�?")){
                            var t_sql = "EXEC [AA_REG_001_ORDERREG_SIZE_CHK] " + t_param1 + ",'" + t_search + "' , 1"
                            var t_size_rst = Get_Json(t_sql)
                            var t_size_id = t_size_rst[0].������ID

                            Edit_gridRoot.setItemFieldAt(t_search, t_rowIndex, "������") 
                            Edit_gridRoot.setItemFieldAt(t_size_id, t_rowIndex, "#������ID") 
                            return;
                        }
                    }else if (t_conname =="���̾�ǰ��"){
                        if(confirm("��ϵ��� ���� ���̾�ǰ���Դϴ�. �ٷ� ����Ͻðڽ��ϱ�?")){
                            var t_sql = "EXEC [AA_REG_001_ORDERREG_ITEM_CHK] " + t_param1 + ",'" + t_search + "' , 1"
                            var t_size_rst = Get_Json(t_sql)

                            Edit_gridRoot.setItemFieldAt(t_search, t_rowIndex, "���̾�ǰ��") 
                            return;
                        }
                    }
                }else {     // �׿��� ǰ���ϰ��
                    if (t_conname =="���̾�ǰ��"){
                        console.log("�״���Է� t_search " + t_search)
                        Edit_gridRoot.setItemFieldAt(t_search, t_rowIndex, "���̾�ǰ��") 
                        Edit_dataGrid.setEditedItemPosition( {rowIndex:t_rowIndex, columnIndex:4} )     // Į��� �����������̵� // Į��� �̵��� ������尡 Ǯ���� �ٽ�����
                        return;
                    }
                }
				if (t_conname == "�ŷ�ó���"){
					$("#�ŷ�ó���").val(t_search)
					return;
				}
            }
            //�Աݳ������ /�ŷ�ó�� ��ġ�ϴ°� ��� �Է°����ϰ�
            if (File_Name =="REG_019_RECEIPT_REG"){
                if (t_conname =="����ŷ�ó��"){
                    Edit_gridRoot.setItemFieldAt("", t_rowIndex, "�ŷ�ó��")        //23.08.23 ��ġ�ϴ°ŷ�ó�� ������ �Է¾ȵǰ� ������û
                    //Edit_gridRoot.setItemFieldAt(t_search, t_rowIndex, "�ŷ�ó��")    
                    return;
                }
            }
        }
        /*
	   if (Search_Rst.length<=0){
		   alert("�˻��ȳ����� �����ϴ�.");
		   return;
	   }
       */
	}else { alert("�˻������ �����ϴ�."); return ;}
	//------------------------------------------------------------------------
	//  �˻����� �ϳ��ϰ�� �˾������ʰ� �ڵ��Է�
	//------------------------------------------------------------------------
	if (Search_Rst.length==1){
	   var j = 0
	   var t_val, t_id;
	   //-----json ���� �������� ���� �������ͼ� ù����, �ι����� ���� ������������---
	   $.each(Search_Rst[0], function(key, value){
		   if (j==0){
			   t_id = value
		   } else if (j==1){
			   t_val = value
		   }
		   j = j+1
	   })
	   
	   //------------------------------------------------------------------------
	   //  �˻����� �ϳ��ϰ�� �˾������ʰ� �ڵ��ԷµǴ� �Լ� // ����ҽ��� ����
	   //------------------------------------------------------------------------
	   Search_One_Select(t_Upd_Gubun, t_val, t_id, t_rowIndex, t_colIndex, t_colIdex_ID, t_conname, Search_Rst)  
	   return
	}
	//------------------------------------------------------------------------
	//  �˻����� ����������, ���̵� �ִ� �׸��̰�, ���̵�� �ؽ�Ʈ�� ��ġ�ϸ� �˻�����
	//------------------------------------------------------------------------
	var id_value = $("#"+t_colIndex).val()
	var Search_Array = new Array()
    //------------------------------------------------------------------------
    // ��ŵ�ɼ��� 1�̰� �����ε� ������� ������������� �˻�������ϰ�, ��������(fnAfterIns)
    //------------------------------------------------------------------------
    if (t_skip == 1 &&  t_search ==""){     
        if(t_Upd_Gubun == "Reg_ID"){
            if(typeof(fnAfterIns) == "function") {
                fnAfterIns(t_rowIndex);   //-- �׸� �Է� �� �߰� ����ؾ� �ϴ� �κ� ó���Լ� 2022-05-27
            }
            return; 
        }   
    }
    //------------------------------------------------------------------------
    // �˻����뿩���� ���� ��� �˾�
    //------------------------------------------------------------------------
	if ($("#"+t_colIndex)){
		for(var k in Search_Rst){	
			Search_Array.push(Object.values(Search_Rst[k]))		// json �����̶�, ������ ���� ���� ã�ƿü���� �迭ȭ��
	    }
	   	for(var j in Search_Array){
			var search_id_val = Search_Array[j][0]		// ù��°�׸��� ���̵�
			var search_text_val = Search_Array[j][1]	// �ι�°�׸��� �ؽ�Ʈ��
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
//  �˻�â ���Ծ� modalâ ���̱� (���� 10%)
//-----------------------------------------------------------------------
function search_modal_show(){
    $("#search_Modal").modal('show');
    $("#search_Modal").css("display", "block");
}
//-----------------------------------------------------------------------
//  �˻�â modalâ �ݱ�
//-----------------------------------------------------------------------
function search_modal_hide(){
    $("#search_Modal").modal("hide");
    $("#search_Modal").css("display", "none");
}
//-----------------------------------------------------------------------
//  �˻�â ���â �ʱ�ȭ(���α׷����� ����, �޼���, ��ư ��)
//-----------------------------------------------------------------------
function search_modal_init(){
    search_modal_hide();
	$("#search_madal_iframe").empty();
	$("#search_madal_iframe").attr("src", "")
}
//-----------------------------------------------------------------------
//  �˻�â ���â ����â���� ����(���α׷����� ����, �޼���, ��ư ��)
//-----------------------------------------------------------------------
function search_modal_init_error(){
    search_modal_hide();
    alert("��ȸ���ڷᰡ �����ϴ�.")
}
//-----------------------------------------------------------------------
//  ���� modalâ ���̱� (���� 10%)
//-----------------------------------------------------------------------
function common_modal_show(t_common_modal_id, t_width, t_height, t_margin){
	//-�Է¹��� ���â�� ũ�Ⱑ ������ �⺻�� ------------------------------
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
//  ���� modalâ �ݱ�
//-----------------------------------------------------------------------
function common_modal_hide(t_common_modal_id){
    $("#"+t_common_modal_id).modal("hide");
    $("#"+t_common_modal_id).css("display", "none");
}
//-----------------------------------------------------------------------
//  ���� ���â �ʱ�ȭ(���α׷����� ����, �޼���, ��ư ��)
//-----------------------------------------------------------------------
function common_modal_init(t_common_modal_id, t_common_modal_iframe){
    common_modal_hide(t_common_modal_id);
	$("#"+t_common_modal_iframe).empty();
	$("#"+t_common_modal_iframe).attr("src", "")
}
//-----------------------------------------------------------------------
//  ���� ���â ����â���� ����
//-----------------------------------------------------------------------
function common_modal_init_error(){
    common_modal_hide();
    alert("��ȸ���ڷᰡ �����ϴ�.")
}
//------------------------------------------------------------------------	
// ��½��� //Execute_Out // opt�� B_WorkName�� Btn_Out1 ~ 3 ����
//------------------------------------------------------------------------	
function Execute_Out(opt) {
	try
	{
		if (opt=="undefined" || opt==""){ opt=1; }	
		//console.log(dataGrid)		// �׸��� ��ü�� ��������
		//------------------------------------------------------------------------	
		// �����Ƿ�������Ȳ �����Ƿڼ� ��ü ��±��
		//------------------------------------------------------------------------
		if (Procedure_Name=='B_CCCC010L_LST_JSON' ) {
			if (opt==1)	 {
                var t_sql = "EXEC [AA_T_TABLE_SELECT_PRK_TEXT]  '"+seSawonid+"','T�����Ƿ�������Ȳ','#OrderDetailID','���ÿ���', 'PERM_ID' , 2"
                console.log(t_sql)
                var sel_invoid_rst = Get_Json(t_sql)
                if (sel_invoid_rst.length <= 0){
                    alert("���õ� ������ �����ϴ�.")
                    return;
                }
				if (confirm("���õ� �����Ƿڸ� ����Ͻðڽ��ϱ�?")) {
					var	pop
                    for (var i in sel_invoid_rst){
                        console.log("i " + i)
                        pop = window.open ("/N_EXCEL/Excel_data_down(ERP).ASP?SAWONID=" + seSawonid + "&DOCU_ID=" + "9" + "&Parm1=" + sel_invoid_rst[i]["#OrderDetailID"]  ,"�����Ƿڼ�" + i
											,"menubar=no,toolbar=no,scrollbars=yes,status=no,location=no,resizable=yes,top=400,left=1000,width=450,height=300","help=no")
                    }
                     
					//pop.focus();
				}
				return ;
			}
		}
		//------------------------------------------------------------------------	
		// ����� / ���õ�� �浿�ù� ������ȯ
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
		// �ŷ�óǰ�� �Ǹ���Ȳ ecount ������ȯ
		//------------------------------------------------------------------------
		if (Procedure_Name=='B_CCCC250L_LST_JSON' ) {
			if (opt==1)	 {
					var	pop = window.open ("/N_EXCEL/Excel_data_down(ERP).ASP?SAWONID=" + seSawonid + "&DOCU_ID=" + "30" + "&Parm1=" + seSawonid + "&Parm2=" + $("#�Ⱓ����").val() + "&Parm3=" + $("#�Ⱓ����").val() + "&Parm4=" + $("#search").val()  ,"EXCEL"
											,"menubar=no,toolbar=no,scrollbars=yes,status=no,location=no,resizable=yes,top=400,left=1000,width=450,height=300","help=no")   
					pop.focus();
				return ;
			}
		}


		//------------------------------------------------------------------------	
		// â��ǻ��������Ȳ �������ǥ ������ȯ
		//------------------------------------------------------------------------
		if (Procedure_Name=='H_AAAA300L_LST_JSON' ) {
			if (opt==1)	 {
					var	pop = window.open ("/N_EXCEL/Excel_data_down(ERP).ASP?SAWONID=" + seSawonid + "&DOCU_ID=" + "20" + "&Parm1=" + seSawonid + "&Parm2=" + $("#â��id").val() + "&Parm3=" + $("#�Ⱓ����").val() ,"EXCEL"
											,"menubar=no,toolbar=no,scrollbars=yes,status=no,location=no,resizable=yes,top=400,left=1000,width=450,height=300","help=no")   
					pop.focus();

				
					pop.focus();


				return ;
			}
		}

		//------------------------------------------------------------------------	
		// ����������Ȳ CI ������ȯ
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
		// ���Ǹ���Ȳ �ŷ���ǥ ������ȯ
		//------------------------------------------------------------------------
		if (Procedure_Name=='B_CCCC030L_LST_JSON' ) {
			if (opt==1)	 {
					var	pop = window.open ("/N_EXCEL/Excel_data_down(ERP).ASP?SAWONID=" + seSawonid + "&DOCU_ID=" + "4" + "&Parm1=" + seSawonid  ,"�ŷ�����"
											,"menubar=no,toolbar=no,scrollbars=yes,status=no,location=no,resizable=yes,top=400,left=1000,width=450,height=300","help=no")   
					pop.focus();
				return ;
			}if (opt==2){
                var t_sql = "EXEC [AA_T_TABLE_SELECT_PRK_TEXT]  '"+seSawonid+"','T���Ǹ���Ȳ','#PRK','Ȯ��', 'PERM_ID'"
                var sel_invoid_rst = Get_Json(t_sql)
                var sel_invoid = sel_invoid_rst[0]["#PRK"]
                if (sel_invoid == "" || sel_invoid == null){
                    alert("���õ� ������ �����ϴ�.")
                    return;
                }
                var t_open_com = "/N_ERP/Reg_Pop/Popup_Trade_change.ASP?OrderDetailID=" + sel_invoid
				$("#common_modal_iframe").attr("src", t_open_com)
                common_modal_show("common_Modal", "30%", "35%", "")
                
            }
		}


		//------------------------------------------------------------------------	
		// ��Ŭ����������Ȳ Ŭ���������� ������ȯ
		//------------------------------------------------------------------------
		if (Procedure_Name=='B_CLAIM_RECEIPT_JSON' ) {
			if (opt==1)	 {


				var cur_cell = dataGrid.getSelectedCells()

				if (cur_cell.length<=0)	{
					alert("[err] ����� ���� ���� �� �۾��ϼ���")
					return
				}

                key_row_Index = cur_cell[0].rowIndex 
				var dataRow = gridRoot.getItemAt(key_row_Index);	


				
					var	pop = window.open ("/N_EXCEL/Excel_data_down(ERP).ASP?SAWONID=" + seSawonid + "&DOCU_ID=" + "23" + "&Parm1=" + dataRow["#PRK"]  ,"�ŷ�����"
											,"menubar=no,toolbar=no,scrollbars=yes,status=no,location=no,resizable=yes,top=400,left=1000,width=450,height=300","help=no")   
					pop.focus();
				return ;
			}
		}


        //------------------------------------------------------------------------	
		// �����߱�
		//------------------------------------------------------------------------
        if (Procedure_Name == "A_TDB_CE_REQ_LST_MY_JSON"){
            var SP_NAME = "AA_TDB_EXCEL_OUT_CE"

            var CheckBox = gridRoot.getObjectById("#C_����");
            var true_row = new Array;
			true_row = CheckBox.getSelectedIndices()
            //--------------------------------------------------------------------
            // ���õ� ��üũ
            //--------------------------------------------------------------------
            if (true_row.length <= 0){
                alert("���õ� ���� �����ϴ�.")
                return
            }else if (true_row.length > 1){
                alert("�ѹ��� �Ѱ��� ������ ��°����մϴ�.")
                return
            }
            var select_row = true_row[0]
            var dataRow = gridRoot.getItemAt(select_row);	
            var gubun 
            var gubun_opt = 0
            var t_epid 
            //--------------------------------------------------------------------
            // ��û�� ����üũ
            //--------------------------------------------------------------------
            if (dataRow["��û������"]=="��������"){
                gubun = "��������";
                gubun_opt = 1;
            }else if (dataRow["��û������"]=="�������"){
                gubun = "�������";
                gubun_opt = 2;
            }else {
                alert("������ �߸��Ǿ����ϴ�.")
                return
            }
            //--------------------------------------------------------------------
            // �߱޿��� üũ
            //--------------------------------------------------------------------
            if (dataRow["�߱�����"]=="" || dataRow["�߱�����"]==null){
                alert("�߱޽��� ���� ���� �����Դϴ�.")
                return
            }
            t_epid = dataRow["#EPID"]
            var bal_no = dataRow["�߱޹�ȣ"]
            var PARAM = "'" + t_epid + "','" + gubun_opt + "','" + bal_no + "'"
            var DOCU_NAME = gubun     //�������� ���ϸ�
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
// Ȯ��/�����ư // Execute_Exec // opt�� B_WorkName�� Btn_Exec1 ~ 3 ����
//------------------------------------------------------------------------
function Execute_Exec(opt) {
	try
	{
		
		//progress_modal_init();      // ���α׷����� �ʱ�ȭ
    	//progress_show();     
		//------------------------------------------------------------------------
		if (opt=="undefined" || opt==""){ opt=1; }
		//console.log(dataGrid)
		//------------------------------------------------------------------------	
		// �����Ƿ� ������Ȳ /�����۾����� ����
		//------------------------------------------------------------------------
		if (Procedure_Name=='B_CCCC010L_LST_JSON' ) {
			if (opt==2)	 {
				var	pop = window.open ("../../IncPopup/Popup_WORK_PACK.ASP","�۾�����"
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
				common_Popup_Open(Procedure_Name, "��ư", "Enroll")
				return ;
			}

			if (opt==2)	 {   // Copy
				document.getElementById('parm_id').value= document.getElementById('parm_id').value*-1
				common_Popup_Open(Procedure_Name, "��ư", "Copy")
				return ;
			}

		}		
		//------------------------------------------------------------------------	
		// ����ȯ����� ����
		//------------------------------------------------------------------------
		if (Procedure_Name=='B_MANA120W_LST_JSON' ) {
			if (opt==1)	 {
				common_Popup_Open(Procedure_Name, "��ư", "���")
				return ;
			}
		}

		//------------------------------------------------------------------------	
		// ������������ �������� 
		//------------------------------------------------------------------------
		if (Procedure_Name=='������������' ) {
			if (opt==1)	 {
				strSql = "exec [D_YUNCHA_CREATE] " + seSawonid + ",'" + $("#�⵵").val() + "'"
				var result = Get_Json(strSql)
				main_bind("D_Yuncha")
				return ;
			}
		}

        //------------------------------------------------------------------------	
		// ����������Ȳ => ��ŷ����Ʈ
		//------------------------------------------------------------------------
		if (Procedure_Name=='AA_ORDER_PROG_LST_JSON' ) {
			if (opt==1)	 {
                var t_sql = "EXEC [AA_T_TABLE_SELECT_PRK_TEXT]  '"+seSawonid+"','T����������Ȳ','#PRK','����', 'PERM_ID'"
                var sel_orderid_rst = Get_Json(t_sql)
                var sel_orderid = sel_orderid_rst[0]["#PRK"]
                if (sel_orderid == "" || sel_orderid == null){
                    alert("���õ� ������ �����ϴ�.")
                    return;
                }
				var t_open_com = "/N_ERP/REG_018_PACKING_REG.ASP?OrderDetailID=" + sel_orderid
				$("#common_modal_iframe").attr("src", t_open_com)
				common_modal_show("common_Modal")
				return ;
			}
		}
        //------------------------------------------------------------------------	
		// �̹����Ǹų���
		//------------------------------------------------------------------------
        if (Procedure_Name=='B_CCCC030L_LST_JSON'){
            var prk_rst = Get_Json("EXEC [AA_T_TABLE_SELECT_PRK_TEXT]  '"+seSawonid+"','T���Ǹ���Ȳ','#PRK','Ȯ��', 'PERM_ID' ")
            var tmpStringPara = prk_rst[0]["#PRK"]
            if (opt==1){    //  ����Ȯ��
                
				if (tmpStringPara == '' || tmpStringPara == null) {
					alert("[err]�Ǹ�Ȯ���� üũ�Ͻ� �� Ȯ���ϼ���")
					return
				}

				var t_sql = "Exec Usp_PROD310L_DateChk '" + tmpStringPara + "'"	 // ��꼭����, ȯ�� ������ Ȯ��  
                
				objRs = Get_Json(t_sql)
                console.log(objRs)
				if (objRs.length == 1) {
					var pop = window.open("/N_ERP/Reg_Pop/Popup_Invoice_Certain.asp?Cino=" + tmpStringPara, "��꼭Ȯ��", "menubar=no,toolbar=no,scrollbars=no,status=no,location=no,resizable=no,top=300,left=350,width=850,height=410")
					pop.focus();
					return;
				} else {
					alert("[err]��꼭���� �Ǵ� ȯ���� ���� ��ġ���� �ʽ��ϴ�.") + "\n\n" + "�ڷ� Ȯ�� �� �ٽ� �۾��ϼ���."
                    return;
				}

			}else if (opt==2)   // ����ó��
			{
				if (tmpStringPara == '') {
					alert("����ó���� �׸��� ���� �� Ȯ�����ֽʽÿ�.")
					return
				}

				var t_sql = "Exec B_CCCC030L_�����Ǹ�_INS '" + seSawonid + "','" + tmpStringPara + "', '1' "	 // 

				//console.log(strSql)
				objRs = Get_Json(t_sql)
				alert(objRs[0]["RETURNMSG"])
				verify_click_function()
                return;
			}
        }
        //------------------------------------------------------------------------	
		// �Ǻ�������Ȳ // ��꼭���ں��� ������Ʈ
		//------------------------------------------------------------------------
        if (Procedure_Name=='B_CCCC200L_LST_JSON' ) {
            var prk_rst = Get_Json("EXEC [AA_T_TABLE_SELECT_PRK_TEXT]  '"+seSawonid+"','T�Ǻ�������Ȳ','#PRK','Ȯ��', 'PERM_ID' ")
            var tmpStringPara = prk_rst[0]["#PRK"]
            if (opt==1){    //  ����Ȯ��
                
				if (tmpStringPara == '' || tmpStringPara == null) {
					alert("[err]����Ȯ���� üũ�Ͻ� �� Ȯ���ϼ���")
					return
				}                
				var pop = window.open("/N_ERP/Reg_Pop/N_Popup_purchase_Certain.asp?prk=" + tmpStringPara, "�Ǻ�����Ȯ��", "menubar=no,toolbar=no,scrollbars=no,status=no,location=no,resizable=no,top=300,left=350,width=850,height=410")
                pop.focus();
                return;
			}
        }
        //------------------------------------------------------------------------	
		// �ܻ����ݳ��� �Աݵ�� �˾�
		//------------------------------------------------------------------------
        if (Procedure_Name=="B_CCCC040L_LST_NEW_JSON"){
            // AA_RMGRID_GLOBVAL_BTN ���� ��� �˾��ǰ� ó�� 

            //var t_open_com = "/N_ERP/Reg_Pop/Popup_ReceiptReg_New.ASP?VendorID=" + dataRow["#VENDORID"] + "&ReceiptBasicID=" + PRK
            //$("#common_modal_iframe").attr("src", t_open_com)
            //common_modal_show("common_Modal")
        }
        //------------------------------------------------------------------------	
		// �ܰ������ȸ �ܰ����� �˾� // �������� �Ķ���ͷ� �������ؼ� ��ٷο��� �ҽ����� ó��
		//------------------------------------------------------------------------
        if (Procedure_Name=="B_CCCC300L_LST_JSON"){
            var t_customer_id = $("#VendorID").val()
            var t_item_id = $("#������ID").val()
            var t_color_id = $("#Į��ID").val()
            var t_size_id = $("#������ID").val()
            var t_open_com = "/N_ERP/Reg_Pop/Popup_DANGA.ASP?VENDORID=" + t_customer_id + "&ITEMID=" + t_item_id
                            + "&COLORID=" + t_color_id + "&SIZEID=" + t_size_id + "&seSawonid=" + seSawonid
            $("#common_modal_iframe").attr("src", t_open_com)
            common_modal_show("common_Modal", "50%", "40%", "")
            return;
        }
        //------------------------------------------------------------------------	
		// �ǸŴܰ����� �ŷ�ó�ܰ����� �˾� // t���̺��� ���, �ҽ����� ó��
		//------------------------------------------------------------------------
        if (Procedure_Name=="B_SJ_WONGA_PRICE_LST_JSON"){
            if (opt==1)	 {
                var cur_cell = dataGrid.getSelectedCells()
                if (cur_cell.length <= 0) { alert("���õ� ������ �����ϴ�."); return; }
                else if (cur_cell.length > 1) { alert("�ϳ��� �ุ �������ּ���."); return; }
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
		// â�������Ȳ / â���̵���ư
		//------------------------------------------------------------------------
        if (Procedure_Name=="H_AAAA180L_LST_JSON"){
			if (opt==3)	 {
				if (!dataGrid) { alert("��ȸ �� ��� �����մϴ�."); return;}
				var cur_cell = dataGrid.getSelectedCells()
                if (cur_cell.length <= 0) { alert("���õ� ������ �����ϴ�."); return; }
                else if (cur_cell.length > 1) { alert("�ϳ��� �ุ �������ּ���."); return; }
                key_row_Index = cur_cell[0].rowIndex 
                key_col_index = cur_cell[0].columnIndex
                var dataRow = gridRoot.getItemAt(key_row_Index);	
				var t_stock_id 	= dataRow["#â��ID"]
                var t_item 		= dataRow["#D_������ǰ��"]
				var t_color 	= dataRow["Į��"]
				var t_size 		= dataRow["������"]
				var t_item_id 	= dataRow["#������ID"]
				var t_color_id 	= dataRow["#Į��ID"]
				var t_size_id 	= dataRow["#������ID"]
				var t_lotno 	= dataRow["��Ʈ��ȣ"]
				var t_stock_cnt = dataRow["#D_�⸻���"]
				var t_stock_name= dataRow["â���"]

				if (t_stock_cnt <=0 ){
					alert("���̳ʽ����� �̵��� �Ұ��մϴ�.")
					return;
				}

				var t_param= seSawonid + "&STOCKID=" + t_stock_id + "&ITEMID=" + t_item_id + "&COLORID=" + t_color_id + "&SIZEID=" + t_size_id 
							+ "&ITEM=" + t_item + "&COLOR=" + t_color + "&SIZE=" + t_size + "&LOTNO=" + t_lotno + "&STOCK_CNT=" + t_stock_cnt + "&STOCK=" + t_stock_name
				common_Popup_Open(Procedure_Name, "��ư", "â���̵�", t_param)
				return;
			}
        }
		//------------------------------------------------------------------------	
		// ��������Ȳ / â���̵���ư
		//------------------------------------------------------------------------
        if (Procedure_Name=="H_AAAA180L_LST_LONG_JSON"){
			if (opt==1)	 {
				if (!dataGrid) { alert("��ȸ �� ��� �����մϴ�."); return;}
				var cur_cell = dataGrid.getSelectedCells()
                if (cur_cell.length <= 0) { alert("���õ� ������ �����ϴ�."); return; }
                else if (cur_cell.length > 1) { alert("�ϳ��� �ุ �������ּ���."); return; }
                key_row_Index = cur_cell[0].rowIndex 
                key_col_index = cur_cell[0].columnIndex
                var dataRow = gridRoot.getItemAt(key_row_Index);	
				var t_stock_id 	= dataRow["#â��ID"]
                var t_item 		= dataRow["#D_������ǰ��"]
				var t_color 	= dataRow["Į��"]
				var t_size 		= dataRow["������"]
				var t_item_id 	= dataRow["#������ID"]
				var t_color_id 	= dataRow["#Į��ID"]
				var t_size_id 	= dataRow["#������ID"]
				var t_lotno 	= dataRow["��Ʈ��ȣ"]
				var t_stock_cnt = dataRow["�⸻���"]

				if (t_stock_cnt <=0 ){
					alert("���̳ʽ����� �̵��� �Ұ��մϴ�.")
					return;
				}

				var t_param= seSawonid + "&STOCKID=" + t_stock_id + "&ITEMID=" + t_item_id + "&COLORID=" + t_color_id + "&SIZEID=" + t_size_id 
							+ "&ITEM=" + t_item + "&COLOR=" + t_color + "&SIZE=" + t_size + "&LOTNO=" + t_lotno + "&STOCK_CNT=" + t_stock_cnt
				common_Popup_Open(Procedure_Name, "��ư", "â���̵�", t_param)
				return;
			}
        }
		//------------------------------------------------------------------------	
		// �ǻ��������Ȳ �������
		//------------------------------------------------------------------------
		if (Procedure_Name=="H_AAAA300L_LST_JSON"  ){

			var	strTitle =  (opt == 1?"������� �۾�":"���������� �۾�")

			if (confirm(strTitle + "�� �Ͻðڽ��ϱ�?")) {
				var t_sql = "exec [H_AUTO_ADJUST_INS_WH_JSON] " + seSawonid + ",'" + $("#�Ⱓ����").val() + "'," +  $("#â��id").val() + "," + opt 
				var adjust_rst = Get_Json(t_sql)
				if (!adjust_rst[0]["VALID"]){
					alert(adjust_rst[0]["MSG"])
					return;
				}
				alert(strTitle + "�� �Ϸ�Ǿ����ϴ�" )
				verify_click_function()
			}
			return;
		}
		//----------------------------------------------------------------------
		// ����ó���ƴѰ��� T���̺� �����׸����� Ȯ��ó��
		//----------------------------------------------------------------------
		var strSql = "Exec [AA_RMGRID_GLOBVAL_BTN] '" + seSawonid  +  "','" + Procedure_Name + "'," + opt + Sub_LIst("option") 
		//------------------------------------------------------------------------------------
		console.log(strSql)
		var result = Get_Json(strSql)
		console.log(result[0].RETURNMSG)
		//----------------------------------------------------------------------
		// VALID�� true�� �ƴϸ� �����޽��� ����� ����
		//----------------------------------------------------------------------
		if (!result[0].VALID){
			alert(result[0].RETURNMSG)
			return;
		}
		//----------------------------------------------------------------------
		// ��� ī��Ʈ�� -1 �̸� �˾�â ����
		//----------------------------------------------------------------------
		if (result[0].CNT == -1){
			if (Procedure_Name=='AA_ORDER_PROG_LST_JSON')	{

				var source_path = result[0].RETURNMSG
				//alert(source_path)
			//	var btn_pop = window.open(source_path, "�˾�â"
			//	,"width=500, height=600, menubar=no,toolbar=no,scrollbars=no,status=no,location=no,resizable=no,fullscreen=yes ","help=no")
			//	btn_pop.focus();
				
				PopupCenter(source_path, "�˾�â", 400, 400)


				return

			} else {
				var source_path = result[0].RETURNMSG
				//alert(source_path)
				var btn_pop = window.open(source_path, "�˾�â"
				,"width=500, height=300, menubar=no,toolbar=no,scrollbars=no,status=no,location=no,resizable=no,fullscreen=yes ","help=no")
				btn_pop.focus();
				return
			}
		}
		//----------------------------------------------------------------------
		// ��� ī��Ʈ�� -2 �̸� ���â ����
		//----------------------------------------------------------------------
		if (result[0].CNT == -2){
			var source_path = result[0].RETURNMSG
			//alert(source_path)
			$("#common_modal_iframe").attr("src", source_path)
			common_modal_show("common_Modal")
			return
		}
		//----------------------------------------------------------------------
		alert(result[0].RETURNMSG + "\n\n(" + result[0].CNT + "��)")
		//----------------------------------------------------------------------
		// ó���� �߰����� ����
		//----------------------------------------------------------------------
		if (result[0].CNT > 0){		//ó���� ����������� ������
			//----------------------------------------------------------------------
			// ����������Ȳ�� �����Ƿ�Ȯ��
			//----------------------------------------------------------------------
            if (Procedure_Name =="AA_ORDER_PROG_LST_JSON" && opt==2){
                for (var i in result){
                    var t_prk = result[i].PRK
                    Grid_LineUpdate_OrderProg(t_prk)	// ���پ�����Ʈ	
                }
            }else {
                verify_click_function()	// �Ϲ������δ� ����ȸ
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
// Ȯ��/������Ʈ ��ư // Execute_Upd // opt�� B_WorkName�� Btn_upd1 ~ 3 ����
//------------------------------------------------------------------------
function Execute_Upd(opt){
	if (opt=="undefined" || opt==""){ opt=1; }
    var t_param1 = ""
    var t_param2 = ""
    var t_sub_opt =  Sub_LIst("option")
		//------------------------------------------------------------------------	
		// ����������Ȳ �ɼ�
		//------------------------------------------------------------------------
		if (Procedure_Name=='AA_ORDER_PROG_LST_JSON' ) {
			var sel_opt = $("#��������ɼ�").val()
			//------------------------------------------------------------------------
			// ������ exe��ư�� �ɼ��� ��ħ���� 10�� ������
			// [AA_RMGRID_GLOBVAL_BTN]����� �ɼ��� 10�� ���Ѱ����� �����
			// ��) ������� 1 + 10 = 11 /// ������ 2 + 10 = 12  // �������� 13
			//------------------------------------------------------------------------
			opt = Number(sel_opt) + 10		
            if (opt==13){   // ��������
                var prk_rst = Get_Json("EXEC [AA_T_TABLE_SELECT_PRK_TEXT]  '"+seSawonid+"','T����������Ȳ','#PRK','����', 'PERM_ID' ")
                var tmpStringPara = prk_rst[0]["#PRK"]
                if (tmpStringPara==null){
                    alert("���õ� �׸��� �����ϴ�.")
                    return;
                }
                if (tmpStringPara.includes(",") > 0){
                    alert("�������� ���õǾ����ϴ�.\n������ �ϳ��� �����մϴ�.")
                    return;
                }
                var prk_data = gridRoot.getCollection().getSource()
                var sel_rowindex = -1
                // ������Ʈ �� ���� �˼� ���, ���� �׸��忡�� PRK�� ��ġ�ϴ� ���� ã�Ƽ� ������Ʈ
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
                parent.parent.frames['erp_list'].menu_click(t_file_name, t_idx, "�������",t_param);
                return;
            }
		}
        //------------------------------------------------------------------------	
		// �̹����Ǹų��� // ��꼭���ں��� ������Ʈ
		//------------------------------------------------------------------------
        if (Procedure_Name=='B_CCCC030L_LST_JSON' ) {
            opt = opt + 10 
            var t_param1 = $("#��꼭����").val()
        }
        //------------------------------------------------------------------------	
		// �Ǻ�������Ȳ // ��꼭���ں��� ������Ʈ
		//------------------------------------------------------------------------
        if (Procedure_Name=='B_CCCC200L_LST_JSON' ) {
            opt = opt + 10 
            var t_param1 = $("#��꼭����").val()
            t_sub_opt = ",0"
        }
        //------------------------------------------------------------------------	
		// �Ⱓ�����ǥ���
		//------------------------------------------------------------------------
        if (Procedure_Name=='H_AAAA500L_LST_JSON' ) {
            opt = opt + 10 
        }
    
	//----------------------------------------------------------------------
	// ����ó���ƴѰ��� T���̺� �����׸����� Ȯ��ó��
	//----------------------------------------------------------------------
	var strSql = "Exec [AA_RMGRID_GLOBVAL_BTN] '" + seSawonid  +  "','" + Procedure_Name + "'," + opt + t_sub_opt + ", '" + t_param1 + "','" +t_param2+ "'"
	//------------------------------------------------------------------------------------
	console.log(strSql)
	var result = Get_Json(strSql)
	console.log(result[0].RETURNMSG)
	//----------------------------------------------------------------------
	// VALID�� true�� �ƴϸ� �����޽��� ����� ����
	//----------------------------------------------------------------------
	if (!result[0].VALID){
		alert(result[0].RETURNMSG)
		return;
	}
	//----------------------------------------------------------------------
	// ��� ī��Ʈ�� -1 �̸� �˾�â ����
	//----------------------------------------------------------------------
	if (result[0].CNT == -1){
		var source_path = result[0].RETURNMSG
		//alert(source_path)
		var btn_pop = window.open(source_path, "�˾�â"
		,"width=500, height=300, menubar=no,toolbar=no,scrollbars=no,status=no,location=no,resizable=no,fullscreen=yes ","help=no")
		btn_pop.focus();
		return
	}
	//----------------------------------------------------------------------
	// ��� ī��Ʈ�� -2 �̸� ���â ����
	//----------------------------------------------------------------------
	if (result[0].CNT == -2){
		var source_path = result[0].RETURNMSG
		//alert(source_path)
		$("#common_modal_iframe").attr("src", source_path)
		common_modal_show("common_Modal", "30%", "35%", "")
		return
	}
	//----------------------------------------------------------------------
	alert(result[0].RETURNMSG + "\n\n(" + result[0].CNT + "��)")
	//----------------------------------------------------------------------
	// ó���� �߰����� ����
	//----------------------------------------------------------------------
	if (result[0].CNT > 0){		//ó���� ����������� ������
		//----------------------------------------------------------------------
		// ����������Ȳ�� �����Ƿ�Ȯ��
		//----------------------------------------------------------------------
		if (Procedure_Name =="AA_ORDER_PROG_LST_JSON" && opt==12){
			for (var i in result){
				var t_prk = result[i].PRK
				Grid_LineUpdate_OrderProg(t_prk , 1)	// ���پ�����Ʈ	
			}
        //----------------------------------------------------------------------
        // �̹����Ǹų����� ��꼭���ں���
        //----------------------------------------------------------------------
		}else if (Procedure_Name =="B_CCCC030L_LST_JSON" && opt==11){
			for (var i in result){
				var t_prk = result[i].PRK
				Grid_LineUpdate_unsale(t_prk, 1)	// ���پ�����Ʈ	
			}
		}else {
			verify_click_function()	// �Ϲ������δ� ����ȸ
		}
	}
}
//------------------------------------------------------------------------	
// �޴��� ���� �������� 
//------------------------------------------------------------------------
function Sawon_Perm_Check(t_permid, t_idx){
    var perm_sql = "exec [H_GLOBPERMIT_Workname] '" + t_permid + "','" + t_idx + "'"
    var perm_rst = Get_Json(perm_sql)
    var t_perm = perm_rst[0].UPermit

    return t_perm
}
//------------------------------------------------------------------------	
// ���������� ���� �������� 
//------------------------------------------------------------------------
function DOCU_Perm_Check(t_permid, t_DOCU_KIND){
    var perm_sql = "exec [AA_GLOBPERMIT_DOCU] '" + t_permid + "','" + t_DOCU_KIND + "'"
    var perm_rst = Get_Json(perm_sql)
    var t_perm = perm_rst[0].DOCU_PERM
    
    return t_perm
}
//------------------------------------------------------------------------	
// ���缱�õ� ���� ���̸� ��������(��ȸ�� ��� �ǿ� ��ȸ�Ұ��� �˱�����/ ������ �ӽ��̸�����)
//------------------------------------------------------------------------
function get_cur_tab_name(t_sno){
	var grid_name =""
	if (typeof window.parent.frames['erp_top_tabs'] != "undefined"){
		var t_cur_sel_favo_no = window.parent.frames['erp_top_tabs'].$("#cur_sel_favo_no").val()
    	grid_name = "RM_Grid" + t_cur_sel_favo_no		// Rm_Grid + ���� �ǹ�ȣ�� �׸����� id����
	}else {
        if (!nbu_check(t_sno)) { t_sno = ""}
		grid_name = "temp_Grid" + t_sno
	}
	return grid_name
}

//-----------------------------------------------------------------------------------
// �˾�â ����� ������ (AA_FIND_POPUP ���̺� ���ǵǾ�����)
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
// ���â ����� ������ (AA_FIND_POPUP ���̺� ���ǵǾ�����)
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
// ASPSESSIONID ��Ű����
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
//	���ּ���ȣ �������� �Լ�
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
//	�԰��Ʈ��ȣ�������� �Լ�
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
//  ����ִ� ��Ʈ��ȣ���� �˷��ִ� �Լ�
//-------------------------------------------------------------------------------------
function jFunGetLotnoYesno(SawonID,gLotno,ItemID,ColorID,SizeID,fDate) {
    var strSql
    var objRs
    var retuVal;
    strSql = "exec [H_LOTNO_LST] " + SawonID + ",'" + gLotno + "'," + ItemID + "," + ColorID + "," + SizeID + ",'" + fDate + "'"             
    objRs = Get_Json(strSql);				
    if (objRs.length > 0 )
    {
        retuVal = objRs[0]["������"];            
    } else{
        retuVal = 0;
    }                
    return retuVal;		                     
}

//--------------------------------------------------------------------------------
// �˻����� �ϳ��϶� �����ϰ����ִ� �Լ� // ���� �˾�â �ҽ� �ȿ� ������, �˻����ϳ��϶� �˾�â �ȿ����� �ڵ������ϱ����� 
//--------------------------------------------------------------------------------
function Search_One_Select (t_Upd_Gubun, t_value,t_value_ID, Row_Index, Col_Index, Col_Name_ID, Con_Name, t_rst){
    var self_close = 1
    //----------------------------------------------------------------------------
    // �׸��忡 ������Ʈ 
    //----------------------------------------------------------------------------
    if (t_Upd_Gubun == "Grid"){
        var t_gridRoot = gridRoot       // �θ�â(View_Frm001�� �׸��� ��ü)
        var t_dataGrid = dataGrid       // �θ�â(View_Frm001�� �׸��� ��ü)

        var dataRow = t_gridRoot.getItemAt(Row_Index);			    //---���� ��ü���� (jSON ����)
        var column = t_dataGrid.getDisplayableColumns()[Col_Index];	//---���� ��ü���� ��������

        var t_header_name = column.getDataField();			        //---���� ����� �������� 

        t_gridRoot.setItemFieldAt(t_value, Row_Index, t_header_name) // �׸����� ������ ����
        //----������ �ƴϸ� ����---------------------------------------------------
        if (t_header_name.substring(0,3) != "#D_" && t_header_name.substring(0,3) != "#E_") {	return;	}
        var PRK = dataRow["#PRK"] 							//---T���̺��� ������ Ű ��
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
        // OPNER �׸�����ξ�����Ʈ ����
        //-------------------------------------------------------------------------
        if (Procedure_Name=='D_REMITTANCE_TREAT_JSON')		{
            self_close = 0
            Grid_LineUpdate_Document( Row_Index , PRK , Sub_LIst("option") ); 
            //setTimeout(function(){ window.close(); },200);  // ������Ʈ �����ϴµ��ð��� �ɷ��� 0.2���� â�ݱ� 
        }
        if (Procedure_Name=="D_CREDIT_CARD_LST_JSON" ){
            self_close = 0
            Grid_LineUpdate_Creditcard( Row_Index , PRK , Sub_LIst("option") ); 
            //setTimeout(function(){ window.close(); },200);  // ������Ʈ �����ϴµ��ð��� �ɷ��� 0.2���� â�ݱ� 
        }
        //-------------------------------------------------------------------------
    
    } 
    //----------------------------------------------------------------------------
    // �׸��忡 ������Ʈ 
    //----------------------------------------------------------------------------
    if (t_Upd_Gubun == "Edit_Grid"){
        var t_gridRoot = Edit_gridRoot       // �θ�â(Edit_Grid�� �׸��� ��ü)
        var t_dataGrid = Edit_dataGrid       // �θ�â(Edit_Grid�� �׸��� ��ü)

        var dataRow = t_gridRoot.getItemAt(Row_Index);			    //---���� ��ü���� (jSON ����)
        var column = t_dataGrid.getColumns()[Col_Index];	//---���� ��ü���� ��������

        var t_header_name = column.getDataField();			        //---���� ����� �������� 

        t_gridRoot.setItemFieldAt(t_value, Row_Index, t_header_name) // �׸����� ������ ����
        //alert(Col_Name_ID)
        //-------------------------------------------------------------------------
        // ID �ʵ�� ������ ID�� ������Ʈ
        //-------------------------------------------------------------------------
        if (Col_Name_ID != "" && Col_Name_ID != undefined  && Col_Name_ID != null){
            Col_Name_ID = "#"+ Col_Name_ID
            t_gridRoot.setItemFieldAt(t_value_ID, Row_Index, Col_Name_ID)
        }
        
        //-------------------------------------------------------------------------
        // ���缱�õȰ� �̿ܿ� ������Ʈ�Ǿ��Ұ�
        //-------------------------------------------------------------------------
        if (File_Name=="REG_100_SAWONREG"){      // ����ڵ���� ���, ����� �Է½� �μ�,��å ������Ʈ
            if (t_header_name =="�����"){
                t_gridRoot.setItemFieldAt(t_rst[0]["#X_�μ�"], Row_Index, "#X_�μ�")
                t_gridRoot.setItemFieldAt(t_rst[0]["#X_��å"], Row_Index, "#X_��å")
            }
        }
        //--------------------------------------------------------------------------
        // ���������� �׸��忡 ������Ʈ�� ���� ����
        //--------------------------------------------------------------------------
        if(typeof(Popup_Select_Afer_EditGrid) == "function") {
            Popup_Select_Afer_EditGrid(Row_Index, Con_Name);   //-- �׸� �Է� �� �߰� ����ؾ� �ϴ� �κ� ó���Լ� 2022-05-27
        }
        //--------------------------------------------------------------------------
        // ���׸��忡 ���������� ���� ��Ŀ���̵�
        //--------------------------------------------------------------------------
        Col_Index = Col_Index * 1 
        Next_focus_Move(Row_Index,Col_Index)  
    } 
    //----------------------------------------------------------------------------
    // ������� ������Ʈ 
    //----------------------------------------------------------------------------
    else if(t_Upd_Gubun == "Reg"){
        //console.log(t_value)
        $("#"+Row_Index).val(t_value)

        if(typeof(fnAfterIns) == "function") {
            fnAfterIns(Row_Index);   //-- �׸� �Է� �� �߰� ����ؾ� �ϴ� �κ� ó���Լ� 2022-05-27
        }
        //----������ ó�������� �Լ� ����(�θ�â�� �Լ��� �־���� ����)-----------------
        if(typeof(Popup_Search_After) == "function") {
            Popup_Search_After(Row_Index);
        }
        var t_inputs = $("#"+Row_Index).closest('body').find("input:enabled[type='text'], select:enabled") //':input:visible');  //input:enabled[type='text'], select
        var t_index =t_inputs.index($("#"+Row_Index))
        t_inputs.eq(t_index+1).focus();
    }
    //----------------------------------------------------------------------------
    // ������� ������Ʈ (ID�� ���� // Row_Index=������Ʈ�� ��ü   Col_Index= ������Ʈ�� ��ü�� ID)
    //----------------------------------------------------------------------------
    else if(t_Upd_Gubun == "Reg_ID"){
        $("#"+Row_Index).val(t_value)
        $("#"+Col_Index).val(t_value_ID)

        if(typeof(fnAfterIns) == "function") {
            fnAfterIns(Row_Index);   //-- �׸� �Է� �� �߰� ����ؾ� �ϴ� �κ� ó���Լ� 2022-05-27
            fnAfterIns(Col_Index);   //-- �׸� �Է� �� �߰� ����ؾ� �ϴ� �κ� ó���Լ� 2022-05-27
        }
        //----������ ó�������� �Լ� ����(�θ�â�� �Լ��� �־���� ����)-----------------
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
// �Էµ� ��¥�� ȯ�� ��������
//--------------------------------------------------------------------------------
function Get_Exchange(t_ex_date, opt){
	if (opt=="" || opt==undefined){ opt = 1} // opt �� ��ȭ����ID // C_priceunit ���̺�
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
		// ������������
		//------------------------------------------------------------------------
		if (Procedure_Name=='������������') {
			
			strSql = "exec [D_YUNCHA_CREATE] " + seSawonid + ",'" + $("#�Ⱓ����").val() + "'"

			objRs = Get_Ado_Rst(strSql,0,1)
			main_bind("D_Yuncha")

			return ;
		}			
		
		//------------------------------------------------------------------------	
		// ��ȸ������ üũ
		//------------------------------------------------------------------------
		if (gFG.explorerbar == 0 )		{
			alert("��ȸ�� �����Ͱ� �����ϴ�.")
			return
		} 

		if (opt==null || opt=='')	{opt=1}

		//------------------------------------------------------------------------	
		// �������� ����
		//------------------------------------------------------------------------
		if (Procedure_Name=='H_BBBB010W_LST' || Procedure_Name=='H_BBBB020W_LST' || Procedure_Name=='H_BBBB030W_LST' )		{

			if (opt==2)			{
				f_yyyymm = $("#�Ⱓ����").val()
				t_yyyymm = $("#�Ⱓ����").val()
				opt = (Procedure_Name=='H_BBBB010W_LST'?1: (Procedure_Name=='H_BBBB020W_LST'?2:3) )

				var pop = window.open ("../IncPopup/Popup_wonga_magam.ASP?f_yyyymm=" + f_yyyymm + "&t_yyyymm=" + t_yyyymm + "&opt=" + opt ,"����Ȯ��","menubar=no,toolbar=no,scrollbars=yes,status=no,location=no,resizable=yes,top=250,left=450,width=550,height=250") 
				pop.focus();
				return;
			}


			var r = confirm( $("#�Ⱓ����").val() + "�� " + 
					(Procedure_Name=='H_BBBB010W_LST'?'������Һ�':(Procedure_Name=='H_BBBB020W_LST'?'��ǰ���Һ�':'��������')) + "�� �����Ͻðڽ��ϱ�?");
			if (r == false) {
				return
			} 

			var strSql = "Exec " + Procedure_Name + " " + seSawonid  +  Sub_LIst("subform") + Sub_LIst("option") + ",1"
			objRs = Get_Ado_Rst(strSql,0,1)

			vbMsgbox("���� �Ǿ����ϴ�.", 0, 64, "����");
			
			return ;
		}

		//------------------------------------------------------------------------	
		// �Ǹ���Ȳ ECOUNT ������ȯ
		//------------------------------------------------------------------------
		if (Procedure_Name=='B_CCCC250L_LST') {

			OpenExcel_ECOUNT()
			return ;
		}


		


		


		//------------------------------------------------------------------------	
		// �ܻ����ݳ��� �Աݵ��
		//------------------------------------------------------------------------
		if (Procedure_Name=='B_CCCC040L_LST') {
				//-------------------------------------------------------------
				//	�����ھ�ȣüũ�ϴ� �Լ�
				//-------------------------------------------------------------                
				if ( $("#adminChk").val() == 0 )	{
					var pop = window.open ("../IncPopup/passChk_B.ASP?strFormName=CCCC040L&Opt2=9" ,"�����ڱ��","menubar=no,toolbar=no,scrollbars=no,status=no,location=no,resizable=no,top=250,left=450,width=380,height=180") 
					pop.focus();
					return;
				}      
				//-------------------------------------------------------------

				var VendorID  = gFG.Cell(0,gFG.Row,gFG.ColIndex("#VendorID"))
				var VendorName  = gFG.Cell(0,gFG.Row,gFG.ColIndex("�ŷ�ó��"))       

				var pop = window.open ("../IncPopup/Popup_ReceiptReg_NEW_B.asp?VendorID=" + VendorID + "&VendorName=" + VendorName ,"�Աݵ��", "width=820, height=630, left=200, top=200")                            

				pop.focus();
			return ;
		}
		//------------------------------------------------------------------------	
		// ���Ǹ���Ȳ �Ǹ�Ȯ��
		//------------------------------------------------------------------------
		if (Procedure_Name == 'B_CCCC030L_LST') {
			//-------------------------------------------------------------
			//	�����ھ�ȣüũ�ϴ� �Լ�
			//-------------------------------------------------------------                
			if ($("#adminChk").val() == 0) {
				var pop = window.open("../IncPopup/passChk_B.ASP?strFormName=CCCC030L&Opt2=9", "�����ڱ��", "menubar=no,toolbar=no,scrollbars=no,status=no,location=no,resizable=no,top=250,left=450,width=380,height=180")
				pop.focus();
				return;
			}
			//-------------------------------------------------------------

			var tmpStringPara = ''
			var tmpComma = ''

			for (i = 3; i < gFG.Rows; i++) {
				if (gFG.cell(5, i, (gFG.ColIndex("#C_Ȯ��"))) == 1) {
					tmpStringPara = tmpStringPara + tmpComma + gFG.Cell(0, i, (gFG.ColIndex("#PRK")))  // ���� //  not #PRK
					tmpComma = ","
				}
			}
			
			if (opt==1){

				if (tmpStringPara == '') {
					alert("[err]�Ǹ�Ȯ���� üũ�Ͻ� �� Ȯ���ϼ���")
					return
				}

				var strSql = "Exec Usp_PROD310L_DateChk '" + tmpStringPara + "'"	 // ��꼭����, ȯ�� ������ Ȯ��  
				objRs = Get_Ado_Rst(strSql, 0, 1)

				if (objRs.recordcount == 1) {
					var pop = window.open("../IncPopup/Popup_Certain_B.asp?Cino=" + tmpStringPara, "��꼭Ȯ��", "menubar=no,toolbar=no,scrollbars=no,status=no,location=no,resizable=no,top=300,left=350,width=700,height=410")
					pop.focus();

				} else {
					alert("[err]��꼭���� �Ǵ� ȯ���� ���� ��ġ���� �ʽ��ϴ�.") + "\n\n" + "�ڷ� Ȯ�� �� �ٽ� �۾��ϼ���."
				}

			}else if (opt==2)
			{
				if (tmpStringPara == '') {
					alert("����ó���� �׸��� ���� �� Ȯ�����ֽʽÿ�.")
					return
				}

				var strSql = "Exec B_CCCC030L_�����Ǹ�_INS '" + seSawonid + "','" + tmpStringPara + "', '1' "	 // 

				//console.log(strSql)
				objRs = Get_Ado_Rst(strSql, 0, 1)
				alert(objRs(0))
				Verify_Click(gFG,true)
			}

			return;
		}

		//------------------------------------------------------------------------	
		// ȯ����� ����ȯ�� ���
		//------------------------------------------------------------------------
		if (Procedure_Name=='B_MANA120W_LST') {

				var pop = window.open("../include/Popup_BudgetExchange.ASP","","menubar=no,toolbar=no,scrollbars=no,status=no,location=no,resizable=no,top=100,left=100,width=620,height=200")                           
				pop.focus();
			return ;
		}


		//------------------------------------------------------------------------	
		// �ǻ��������Ȳ �������
		//------------------------------------------------------------------------
		if (Procedure_Name=='H_AAAA300L_LST'  )		{

				if (opt==3)				{
					OpenExcel_jaego('�������ǥ_�Ƿ�',11)
					return;
				}
				var	strTitle =  (opt == 1?"������� �۾�":"���������� �۾�")

				if (vbMsgbox(strTitle + "�� �Ͻðڽ��ϱ�?", 4, 64, "�ڷ�����") == 6) {
					strSql = "exec [H_AUTO_ADJUST_INS_WH] " + seSawonid + ",'" + $("#�Ⱓ����").val() + "'," +  $("#â��id").val() + "," + opt 
					objRs = Get_Ado_Rst(strSql,0,1)
					alert(strTitle + "�� �Ϸ�Ǿ����ϴ�" )
					Verify_Click(gFG,true)
				}
				return;
		}

		//------------------------------------------------------------------------	
		// â�������Ȳ �������ǥ // 20.02.24 opt=2�߰� ����� �˾� 
		//------------------------------------------------------------------------
		if (Procedure_Name=='H_AAAA180L_LST' || Procedure_Name=='H_AAAA180L_LST_LONG'  )		{
				//----------------------------------------------------------------
				if (opt==1)		{OpenExcel_jaego('�������ǥ_�Ƿ�',10)}
				//----------------------------------------------------------------
				if (opt==2)				{
					var STOCKID  = gFG.Cell(0,gFG.Row,gFG.ColIndex("#â��ID"));
					var ITEMID  = gFG.Cell(0,gFG.Row,gFG.ColIndex("#������ID"));
					var COLORID = gFG.Cell(0,gFG.Row,gFG.ColIndex("#Į��ID"));    
					var SIZEID  = gFG.Cell(0,gFG.Row,gFG.ColIndex("#������ID"));    
					//------------------------------------------------------------
					var STOCKNAME= gFG.Cell(0,gFG.Row,gFG.ColIndex("â���"));
					var ITEMNAME = gFG.Cell(0,gFG.Row,gFG.ColIndex("#D_������ǰ��"));
					var COLORNAME= gFG.Cell(0,gFG.Row,gFG.ColIndex("Į��"));     
					var SIZENAME = gFG.Cell(0,gFG.Row,gFG.ColIndex("������"));  
					var LOTNO 	 = gFG.Cell(0,gFG.Row,gFG.ColIndex("��Ʈ��ȣ"));	
					var LotOpt	 = $("#LotNo").is(':checked');
					var LotOpt2	 = gFG.Cell(0,gFG.Row,gFG.ColIndex("#OPT2"));
					if (LotOpt2 == "") { LotOpt2= 0}
					//------------------------------------------------------------
					if (LotOpt == true){ LotOpt = 1 ;}
					else { LotOpt = 0 ;	}
					var pop = window.open ("../IncPopup/Popup_Roll_stock.ASP?SAWONID="+seSawonid 
											+ "&STOCKID=" + STOCKID + "&ITEMID=" + ITEMID + "&COLORID=" + COLORID + "&SIZEID=" + SIZEID
											+ "&STOCK=" +STOCKNAME+ "&ITEM="+ ITEMNAME +"&COLOR="+COLORNAME  + "&SIZE=" +SIZENAME 
											+ "&LotOpt=" + LotOpt + "&LOTNO=" + LOTNO + "&TDAT="+$("#�Ⱓ����").val() + "&LotOpt2=" +LotOpt2
											,"��������", "scrollbars=yes, width=420, height=330, left=200, top=200")                            
					pop.focus();
				}
				//----------------------------------------------------------------
				if (opt==3)				{
					var STOCKID  = gFG.Cell(0,gFG.Row,gFG.ColIndex("#â��ID"));
					var ITEMID  = gFG.Cell(0,gFG.Row,gFG.ColIndex("#������ID"));
					var COLORID = gFG.Cell(0,gFG.Row,gFG.ColIndex("#Į��ID"));    
					var SIZEID  = gFG.Cell(0,gFG.Row,gFG.ColIndex("#������ID"));    
					//------------------------------------------------------------
					var STOCKNAME= gFG.Cell(0,gFG.Row,gFG.ColIndex("â���"));
					var ITEMNAME = gFG.Cell(0,gFG.Row,gFG.ColIndex("#D_������ǰ��"));
					var COLORNAME= gFG.Cell(0,gFG.Row,gFG.ColIndex("Į��"));     
					var SIZENAME = gFG.Cell(0,gFG.Row,gFG.ColIndex("������"));  
					var LOTNO 	 = gFG.Cell(0,gFG.Row,gFG.ColIndex("��Ʈ��ȣ"));	
					var STOCK_CNT = gFG.Cell(0,gFG.Row,gFG.ColIndex((Procedure_Name=='H_AAAA180L_LST'?"#D_�⸻���":"�⸻���")));	

					if (STOCK_CNT<=0)	{
						alert("���̳ʽ� ��� �Ǵ� ��� ���� ��� â���̵� �� �� �����ϴ�")
						return
					}

					var pop = window.open ("../IncPopup/Popup_stock_move.ASP?SAWONID="+seSawonid 
											+ "&STOCKID=" + STOCKID + "&ITEMID=" + ITEMID + "&COLORID=" + COLORID + "&SIZEID=" + SIZEID
											+ "&STOCK=" +STOCKNAME+ "&ITEM="+ ITEMNAME +"&COLOR="+COLORNAME  + "&SIZE=" +SIZENAME 
											+ "&STOCK_CNT=" + STOCK_CNT + "&LOTNO=" + LOTNO  
											,"â���̵�", "scrollbars=yes, width=570, height=330, left=400, top=200")                            
					pop.focus();
				}
				//----------------------------------------------------------------



				return;
		}

	
		//------------------------------------------------------------------------	
		// ����û����� �ܰ� ���°� üũ . 2019-01-09 �����ְ��� ���� ��û(�ҷ��԰� ó��)
		//------------------------------------------------------------------------
		//if (Procedure_Name=='B_CCCC180L_LST'  )		{

		//    for (i=3;i<gFG.Rows ;i++ )            {
		//		if (gFG.cell(5,i,(gFG.ColIndex("#C_����Ȯ��"))) == 1 )	{
		//			if (gFG.cell(0,i,gFG.ColIndex("#E_�ܰ�")) == 0 && gFG.cell(0,i,gFG.ColIndex("#E_��ȭ�ܰ�")) == 0)		{
		//				alert("�ܰ�(��ȭ�ܰ�)�� �Էµ��� �ʾҽ��ϴ�.")
		//				return; 
		//			}
		//		}
		//	}
		//}   

		//------------------------------------------------------------------------	
		// �Ǻ�������Ȳ ����Ȯ��
		//------------------------------------------------------------------------
		if (Procedure_Name=='B_CCCC200L_LST'  )		{

			var tmpStringPara = ''
			var tmpComma = ''

			for (i=3;i<gFG.Rows ;i++ )            {
				if (gFG.cell(5,i,(gFG.ColIndex("#C_Ȯ��"))) == 1 )	{
						tmpStringPara = tmpStringPara + tmpComma + gFG.Cell(0,i,(gFG.ColIndex("#PROGID")))  // ���� //  not #PRK
						tmpComma = ","
				}
			}
				var pop =  window.open ("../IncPopup/Popup_ProgressCertain_B.ASP?Progid=" + tmpStringPara,"Ȯ��","menubar=no,toolbar=no,scrollbars=no,status=no,location=no,resizable=no,top=300,left=350,width=750,height=410") 
				pop.focus();
				return;
		}


		//------------------------------------------------------------------------	
		// Document �����
		//------------------------------------------------------------------------
		if (Procedure_Name=='D_DOCUMENT_LIST') {

			var ObjFromDll = new ActiveXObject("E_Docu.C_Docu")
		//	result = ObjFromDll.Open_Document(gConn, SAWONID, DOCUKIND, DOCUID);
			result = ObjFromDll.Open_Document(gConn(), P_Cur_Permit_ID, 5, 0);


			return ;
		}


		//------------------------------------------------------------------------	
		// �����Ƿ���Ȳ 2020-05-27
		//------------------------------------------------------------------------
		if (Procedure_Name=='D_DEV_REQ_LST') {

			strSql = "SELECT RESULT, RESULTMSG FROM [dbo].[Get_Station_Part_RND] (" + seSawonid + ",'0')"
			objRs = Get_Ado_Rst(strSql,0,1)
			if (objRs("RESULT")=="1")
			{			
				var Req_Docu_No= gFG.Cell(0,gFG.Row,gFG.ColIndex("�Ƿڹ�����ȣ"));
				var Ord_Docu_No= gFG.Cell(0,gFG.Row,gFG.ColIndex("���ù�����ȣ"));
				var strSql = "EXEC D_DEV_REQ_LST_EXCEL '" +Req_Docu_No +"' , '" 	+ Ord_Docu_No+ "'"
				//alert(strSql)
				OpenExcel_DATA("���ߺ���",strSql)
				return;
			}else{
				alert(objRs("RESULTMSG"));
				return;
			}
		}

		//------------------------------------------------------------------------	
		// �����߱� ��ư
		//------------------------------------------------------------------------
		if (Procedure_Name=='A_TDB_CE_REQ_LST' || Procedure_Name=='A_TDB_CE_REQ_LST_MY') {

			strSql = "EXEC [A_TDB_CE_REQ_CHUL_VALID] '" + seSawonid + "'"
			objRs = Get_Ado_Rst(strSql,0,1)
			var err_chk = objRs("ERR")
			var msg = objRs("MSG")
			//--����üũ------------------------------------------------------------
			if(err_chk == 1) {
				alert(msg);
				return
			}
			//--������------------------------------------------------------------
			else {
				var t_epid    = objRs("EPID")
				var t_no      = objRs("�߱޹�ȣ")
				var t_gubunid = objRs("��û������ID")
				var t_gubun   = objRs("��û������")
				OpenExcel_DATA(t_gubun,"[A_TDB_EXCEL_OUT_CE] '" + seSawonid + "','" + t_epid + "','"+t_gubunid+"','" + t_no + "'")
				Rebind();
				//alert(msg);
			}

			return ;
		}

		//------------------------------------------------------------------------	
		// ��Ŭ����������Ȳ ������ ��� JJH 2021-05-24
		//------------------------------------------------------------------------
		if (Procedure_Name=='B_CLAIM_RECEIPT') {

			var Receip_No= gFG.Cell(0,gFG.Row,gFG.ColIndex("#PRK"));
			var strSql = "EXEC B_CLAIM_RECEIPT_EXCEL '" +Receip_No +"'"
			//alert(strSql)
			Open_Excel_DATA_ALL(strSql,"Ŭ����������");
			return;
		}
	
		//------------------------------------------------------------------------	
		// MBO������ // ��ܹ�ưŬ��
		//------------------------------------------------------------------------
		if (Procedure_Name=='H_AAAA620L_LST') {
			
			var pop =  window.open ("../IncPopup/Popup_MBO_WORK.ASP?id=0","MBO������","menubar=no,toolbar=no,scrollbars=no,status=no,location=no,resizable=no,top=300,left=350,width=700,height=600") 
			pop.focus();
			return;

		}
	
		//------------------------------------------------------------------------	
		// �ǸŴܰ����� > �ŷ�ó�����ۺ��ǸŴܰ���� �˾� // 2022-01-24
		//------------------------------------------------------------------------
		if (Procedure_Name=='B_SJ_WONGA_PRICE_LST') {
			if(gFG.Row>2){
				var WongaID = gFG.Cell(0,gFG.Row,gFG.ColIndex("#PRK"));
				var pop =  window.open ("../IncPopup/Popup_Wonga_Customer_Price.asp?id="+WongaID,"�ŷ�ó�������ǸŴܰ����","menubar=no,toolbar=no,scrollbars=1,status=no,location=no,resizable=no,top=300,left=350,width=700,height=600") 
				pop.focus();
				return;
			}
		}

		
		*/
	
	
 







//-----------------------------------------------------
// ���� ��¥�� yyyymmdd ���·� ����
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
// ���� ��¥�� yyyy-mm-dd ���·� ����
//-----------------------------------------------------
function getToday_yyyymmdd(){
    var date = new Date();
    var year = date.getFullYear();
    var month = ("0" + (1 + date.getMonth())).slice(-2);
    var day = ("0" + date.getDate()).slice(-2);

    return year + "-" + month + "-" + day;
}

//-----------------------------------------------------
// ���� ��¥���� �������� yyyy-mm-dd ���·� ����
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
//	��� ��¥ �Է½� ��ü ��¥������ ��ȯ
//  1. ��/��, ��.��, ��-��
//  2. ����4, ����6, ����8    
//-----------------------------------------------------------------
function jFuncDateValid(obj,opt)
{
	var nDate = new Date();
	var nowDate = nDate.getFullYear() + '-' + jLenChk(parseInt(nDate.getMonth()+1)) + '-' + nDate.getDate()
	var orgiString = obj.value;
	var tmpString = obj.value;
	var retuString;	    
	var fmt = /^\d{4}-\d{2}-\d{2}$/;    //���Խ�üũ
    console.log(obj.value)
	//-------------------------------------------------------------
	//  ��/�� �϶� �Էµǰ�
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
	
	//  �����̸� �н��ǰ�
	if(obj.value == ""){
		return true;
	}

	if (!fmt.exec(retuString)) {
		alert("���������� �߸��Ǿ����ϴ�.");
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
// function dateCheck10  ��Ȯ�� ��¥�� ���ϴ� �Լ�
// opt= 'Y':�⵵�� üũ. 'M':��,��üũ 'D':��,��,�� üũ
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
			alert("���� �߸� �ԷµǾ����ϴ�");
			return false;
		}
	}
	if ((opt == 'M')||(opt == 'D'))
	{
		if ((!fmt2.exec(sDate2)) || (sDate2 > 12 ) || (sDate2 == 0)){
			alert("���� �߸� �ԷµǾ����ϴ�");				
			return false;
		}
	}		
	if (opt == 'D')
	{		
		if ((!fmt2.exec(sDate3)) || (sDate3 > mon_arr[sDate2-1]) || (sDate3 == 0)){
			alert("���� �߸� �ԷµǾ����ϴ�");				
			return false;
		}
	}
	return true;
}

//--------------------------------------------------
//	��¥�������� (��¥ 2/4 �Է������� 2008-02-04 ��) - RM�׸��忡�����
//------------------------------------------------------------------------
	function jFuncDateChk_10(rowIndex, ColName) {
		var dataRow = gridRoot.getItemAt(rowIndex);	
	    var nDate = new Date();

	    var O_dat = dataRow[ColName] + ""

		//-------------------------------------------------------------
	    //  ��/�� �϶� �Էµǰ�
	    var intI = O_dat.indexOf('/');
	    var arrDate = O_dat.split("/");

	    if ((intI > -1) && (intI < 3)) {
	        if ((O_dat.length >= 3) && (O_dat.length < 6)) {
	            O_dat = jLenChk(arrDate[0]) + jLenChk(arrDate[1])
	        }
	    }
	    //  ��.�� �϶� �Էµǰ�
	    intI = O_dat.indexOf('.');
	    arrDate = O_dat.split(".");
	    if ((intI > -1) && (intI < 3)) {
	        if ((O_dat.length >= 3) && (O_dat.length < 6)) {
	            O_dat = jLenChk(arrDate[0]) + jLenChk(arrDate[1])
	        }
	    }
	    //  ��-�� �϶� �Էµǰ�
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
//	��¥�������� (��¥ 2/4 �Է������� 2008-02-04 ��) - RM�׸���(�����)�������
//------------------------------------------------------------------------
function jFuncDateChk_EDIT(rowIndex, ColName) {
    var dataRow = Edit_gridRoot.getItemAt(rowIndex);	
    var nDate = new Date();

    var O_dat = dataRow[ColName] + ""

    //-------------------------------------------------------------
    //  ��/�� �϶� �Էµǰ�
    var intI = O_dat.indexOf('/');
    var arrDate = O_dat.split("/");

    if ((intI > -1) && (intI < 3)) {
        if ((O_dat.length >= 3) && (O_dat.length < 6)) {
            O_dat = jLenChk(arrDate[0]) + jLenChk(arrDate[1])
        }
    }
    //  ��.�� �϶� �Էµǰ�
    intI = O_dat.indexOf('.');
    arrDate = O_dat.split(".");
    if ((intI > -1) && (intI < 3)) {
        if ((O_dat.length >= 3) && (O_dat.length < 6)) {
            O_dat = jLenChk(arrDate[0]) + jLenChk(arrDate[1])
        }
    }
    //  ��-�� �϶� �Էµǰ�
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
	// ��������
	//------------------------------------------------------------------------	
	function filter_hidden() {
		$("#d_filter").css("display","none")
	}

	//------------------------------------------------------------------------	
	// �⵵ �⺻��
	//------------------------------------------------------------------------	
    function get_year() {

		var rst_year = Get_Ado_Rst("EXEC A_SEL_YEAR", 1, 1)
		rst_year.MoveLast

		$("#�⵵����").val(rst_year("�⵵")+'')
		$("#�⵵����").val(rst_year("�⵵")+'')
	}
	

	

	//------------------------------------------------------------------------	
	// �ɼ��ڵ� �߰�
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
	//  ��� ������ �ؽ�Ʈ ��ȯ Sub_XlsHeader
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
	// ������ creteria ��������
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
	// ������ȯ�� �ʿ��� ������ ���� json ���·� ���
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
	//����Ű Ȱ��ȭ
	//------------------------------------------------------------------------	
	function short_cut_show(x,y) {
		// twip �ȼ���ȯ , 1 pixel = 15 twip
		var x = x/15 //+ 5
		var y = y/15 //+ 5 

		// paernt ������ ���� width �� height ���ؿ�
		var dwidth = $("body",parent.document).width() - $("#dmenu",parent.document).outerWidth() - 3// ��ũ�ѹ� ũ�� 
		var dheight = $("body",parent.document).height() - $("#dfwrap",parent.document).outerHeight()  - 12


		dheight = dheight - $("#d_header").height()
	
		// �����ڸ����� �˾��Ҷ� �޴��� �ٿ������� �̵��ϱ� ���� ����
		if ( x > dwidth - $("#d_filter").width()){
			x = (x - $("#d_filter").width())
		}
		if ( y > ( dheight - $("#d_filter").height() ) ){
			 y =  y - $("#d_filter").height()   
		}
		// ������ ��ġ�� �̵�
		$("#d_filter").css("display","inline").css("left",x).css("top",y)


	}*/
	
//----------------------------------------------------------
//   â����� ����
//----------------------------------------------------------
function stock_show(item_no,col){ 

	var	pop = window.open ("../IncPopup/Popup_order_stock.ASP?dn="+escape(item_no)+"&col="+escape(col),"â�����"
							,"menubar=no,toolbar=no,scrollbars=yes,status=no,location=no,resizable=yes,top=400,left=1000,width=450,height=300","help=no")   
	pop.focus();
	
}

//------------------------------------------------------------------------	
// height �������� 
//------------------------------------------------------------------------	
function height_resize() {

	var inc_h = ( 925 -  $("body").height() )  / 53  

	$("#d_fg").height($("body").height() - $("#d_header").outerHeight() - inc_h);
}	
	

//------------------------------------------------------------------------	
// ���� �ð� get
//------------------------------------------------------------------------	
function servertime(){ 
//	var rst = Get_Ado_Rst("SELECT ����ð� FROM PresentTime" , 1, 1)
//	var r_date = $.datepicker.formatDate('yy-mm-dd', new Date(rst("����ð�")) ) 

	var str_sql = "SELECT [����ð�] FROM [PresentTime]"
	var rst = Get_Json(str_sql)  
	var r_date = $.datepicker.formatDate('yy-mm-dd', new Date(rst[0].����ð�) ) 

	return r_date
};


//---------------------------------------------------------------------------
//	�ٿ�ε� ���� üũ
//---------------------------------------------------------------------------
function jFunExcelChk(tmpName)
{
//	vFunSavePath()
	document.location.href = "../INCLUDE/DownLoad_Ex.asp?tmpDocu=" + tmpName;
}


//---------------------------------------------------------------------------
//	�׸��� ��ü����
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
    // ������Ʈ �� ���� �˼� ���, ���� �׸��忡�� PRK�� ��ġ�ϴ� ���� ã�Ƽ� ������Ʈ
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
//	�����ε� �������� ȣ��
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
//�������ø�Ʈ �˻� 2020.05.28 JJH
//------------------------------------------------------------------------
function AutoComplate(tsql, DivName, Divid, rstname, rstid)
{

    var auto_rst =  Get_Ado_Rst(tsql , 1, 1)
    
        var auto_list = []
        // ���̵� ������ ���̵���� �ؽ�Ʈ��
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
                    //console.log("���� :" + ui.item.value);
                    //console.log("���� :" + ui.item.id);

                    return false;
                },
                //focus: function(event, ui){
                //    return false
                //},
                close: function(event){
                    //console.log("���� :" +event.ui.item.value);
                }
            });
        }
        // ���̵� ������ ���̵𰪱���
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
                    //console.log("���� :" + ui.item.value);
                    //console.log("���� :" + ui.item.id);
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
                    //console.log("���� :" +event.ui.item.value);
                }
            });
        }
        
}
//------------------------------------------------------------------------
// ajax�� DB������ �޾ƿ��� // Json ���·� �޾���
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
// ������ �˾� ȭ�� ��� ���� �Լ�   PopupCenter(url, title, w, h)
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