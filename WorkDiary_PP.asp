<!--#include virtual="N_MAIN/global.asp" -->
<%
call vFunChkSession(2)	'����üũ �� �ߺ������üũ     �Լ���ġ: /INCLUDE/function.asp
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
<title>�۾��������(�ڸ�)</title>
<!-- ���� ���� ���� -->
<script src="../../N_Main/jQuery/jquery-1.12.4.min.js"></script>
<script src="../../N_Main/jQuery/jquery-ui.js"></script>
<script type="text/javascript" src="../erp_func/common_func.js?230103a"></script>
<script type="text/javascript" src="../../N_CSS/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="../../N_CSS/bootstrap/3.3.2/css/bootstrap.min.css"/>
<link rel="stylesheet" href="../../IncJquery/jquery-ui.min.css"/>
<!-- datepicker -->

<link rel="stylesheet" type="text/css" href="../../N_CSS/datepicker2.css" />

<style>
    /* ��ü ���� */
    html, body { width: 99.5%; margin: 5px 5px 5px 5px;  }
    
    /* title */
    #title_bar{ float: left; width:22%; height:60px; margin: 5px 9% 0px 2%; vertical-align: auto; position: relative; background-size: 100%, 42px; background-position: center; background-repeat: no-repeat;  }
    #title_bar_img{ width: 100%; height: 100%;  }
    #t_header{ width: 100%; font-size: 18pt; font-weight: bold; font-family: Noto Sans KR; margin: 0px; color:white; text-align:center; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); letter-spacing: 2.5px;  }

    /* ��ư */
    .btn{ width: 100px; height: 60px; background-color: #337ab7; color: #fff; float: left; font-size: 16px; border-radius: 0px; text-align: center; vertical-align: auto;  }
    .btn_02{ width: 118px; border-radius: 3px; margin: 10px 0.5% 10px 0px;  }
    .btn_02_2{ border-radius: 3px; margin: 10px 3% 10px 0px;  }
    .btn_03{ border-radius: 3px; background-color: #FF0000; float: none; clear: right; margin: 10px 0% 10px 0px; line-height: 50px; font-size: 18px; font-weight: bold; color: #fff;  }
    .btn_02:hover { color: white; background-color: #195E9B; cursor: pointer;  }
    .btn_03:hover { color: #fff; background-color: #FF8080; cursor: pointer;  }
    .btn_02:disabled { color: white; background-color: #195E9B; cursor: pointer;  }
    .btn_03:disabled { color: #fff; background-color: #FF8080; cursor: pointer;  }
    .btn_add { position: absolute; border: none; margin: 4px 4px 4px 4px; color: #fff; left: 80%; top: 450px; background-color: tomato;  }

    /* �� ���� ������ / ������ css �۾� */
    .TopBtn{ height: 100px; margin: 0px 0px 5px 0px; padding: 10px 0px 0px 0px; background-color: #dff0ed;  }
    .bottom{ width: 100%;  }

    .searchDate{ width: 20%; height: 30px; float: left; margin: 30px 22% 0px 0px;  }
    .searchDate label{ border: 1px solid #195E9B; background-color: #0EBDDD; color: #fff; margin: 0px 2px 0px 0px;  }
    .searchDate input{ border: 1px solid #195E9B; text-align: center;  }

    .date_insert{ width: 100%; height: 40px; max-height: 40px; margin: 0px 0px 5px 0px;  }
    .date{ border-collapse: collapse; width: 100%; background-color: #FCEED6;  }
    .date label{ display: block; border: 1px solid #f0bd5e; background-color: #FCEED6;  }
    .date input{ border: 1px solid #f0bd5e; text-align: center;  }

    /* th �±� */
    .th_01{ box-sizing: border-box; width: 7.5%; height: 40px; font-size: 13pt; border-spacing: 0px; text-align: center;  }
	.th_search_01{ box-sizing: border-box; width: 22%; height: 40px; font-size: 13pt; border-spacing: 0px;  }
    .th_table_01{ box-sizing: border-box; text-align: center;  }

    /* td �±� */
    .td_01{ box-sizing: border-box; width: 17.5%; height: 40px; font-size: 13pt; border-spacing: 0px;  }
	.td_search_01{ box-sizing: border-box; width: 48%; height: 40px; font-size: 13pt; border-spacing: 0px;  }

    /* label */
    label{ display: block; border-radius: 3px; color: #000000; height: 34px; max-height: 34px; line-height: 34px; text-align: center; vertical-align: middle; font-weight: bold; white-space: nowrap; margin: 0px;  }

    /* input �±� */
    input{ border-radius: 3px; background-color: #ffffff;  }
    input:focus{ border: 2px solid #f00; outline: none; }
    input:disabled{ color: #999;  }
    .input_tag{ width: 95%; height: 34px; max-height: 34px; line-height: 34px; vertical-align: middle; font-size: 13pt; border: 0; margin: 0px 1% 0px 2%;  }
    .input_tag_readonly_01{ background-color: #eee; pointer-events: none; text-align: center;  }  
    .input_tag_end_01{ width: 98%;  }
	.input_list{ height: 100%; width: 100%; text-align: center; border: none; border-radius: 0px;  }

    /* �����Ƿڼ� ��ȸ */
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

	/* �ڸ���� ��ȸ */
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

    /* ��ȸ ���Ľ� ������ */
    .ui-icon { zoom: 200%; margin-top: 1px; position: absolute; display: none; background-image: url("../IncJquery/images/ui-icons_ffffff_256x240.png");  }

    /* autocomplete */
    .autocomplete > div.active{ background: #333; color: #eee;  }
    .ui-autocomplete{ width: auto; height: auto; max-height: 300px; overflow-y: auto; overflow-x: hidden;  }
    html .ui-autocomplete{ font-size: 16px; font-family: Noto Sans KR;  }
    .ui-menu-item-wrapper{ height: 40px; line-height: 30px; vertical-align: middle;  }
    .ui-state-active{ margin: 0px !important;  }

</style>

<script type="text/javascript">
    //  �ð�, ���� ���ϴ� ���� ���������� ����
    var timeString = getTime();
    var dateString = getDay();

    //  URL���� �����ȣ, IP�ּ�, â���ȣ �޾ƿ���
    var seSawonid = new URLSearchParams(window.location.search).get("seSawonid");
    var IP_Address = new URLSearchParams(window.location.search).get("IP_Address");
    var defaultStocID = new URLSearchParams(window.location.search).get("defaultStocID");

    //  ��� ��ȣ�� ����̸� ��������
    var get_saWon = Get_Json("SELECT SawonName FROM G_SAWON WHERE USECHK = 0 AND SawonID = " + seSawonid);
    var seSawonname = get_saWon[0].SawonName;

    //  â�� ��ȣ�� â���̸� ��������
    var get_defaultStocName = Get_Json("SELECT â��� AS defaultStocName FROM C_â�� WHERE â��ID =" + defaultStocID);
    var defaultStocName = get_defaultStocName[0].defaultStocName;

    //  autocomplete ��ġ�� �ʵ��� �ϴ� ���� ����       / �۾�����, ����� ��Ŀ���� ���� �ڵ��ϼ��� ȭ��ǥ Ʈ���Ű� ���� �۵��Ǿ� ��Ŀ�� ��ġ ���� �ذ��
    let dontFocus = 0;

	// ���� ���� ����
	p_item = "";			// ǰ��
	p_color = "";			// Į��
	p_size = "";			// ������
	p_item_lot = "";		// ��Ʈ��ȣ
	p_cnt = 0;				// �������
	p_Gcnt = 0;				// ����
	p_chk = "";				// ����(�����Ƿ�)
	p_ID = "";				// key ��

	Pcnt = 0;				// �ڸ�
	Wcnt = 0;				// ����
	WGcnt = 0;				// �ڸ����
	p_date = "";			// �ڸ�����
	p_remark = "";			// ���

	$(document).ready(function(){
		try{
            // ------------------------------------------------------------------------
            // �ʱ� ������ ����
            // ------------------------------------------------------------------------
            window.focus();
			$("#IP_Address").val(IP_Address);
			$("#�۾�����").val(getDay());
			var date = new Date();
			// date.setDate(date.getDate() - 14);       //  14���� ��¥ ���
			// var twoWeekAgo = date.toISOString().substring(0, 10);       //  ��� �� ��¥ YYYY-MM-DD ������ ��ȯ ������ �ȴ�� �ٷ� val() �ص� ����
            var twoWeekAgo = get_add_date_yyyymmdd('dd', -14);
			$("#��ȸ����").val(twoWeekAgo);
			$("#�۾���").val(seSawonname);
			$("#â���").val(defaultStocName);

			$("#�۾�����").attr("disabled", true);
            
            // ------------------------------------------------------------------------
            // ��ȸ
            // ------------------------------------------------------------------------
            $("#��ȸ����").on("change", function(){
				if(jFuncDateValid(this) == true){
					init_disp();
					SUPPLY_DISP();
				}else{
					$("#��ȸ����").val("");
					return false;
				};
            });     //  ��ȸ end

            // ------------------------------------------------------------------------
            // �۾����� ��ư Ŭ��
            // ------------------------------------------------------------------------
            $("#�۾�����").on("click", function(){
                if(save_line(5) == true){
                    $("#�۾�����").attr("disabled", true);
                    $("#�۾�����").attr("disabled", false);
				};
            });   //  �۾����� ��ư end

            // ------------------------------------------------------------------------
            // �۾����� ��ư Ŭ��
            // ------------------------------------------------------------------------
            $("#�۾�����").on("click", function(){
                if(save_line(6) == true){
					alert("����Ǿ����ϴ�.");
					opener.main_bind();
					self.close();
				};
            });   //  �۾����� ��ư end

            // ------------------------------------------------------------------------
            // �ڸ����� Ŭ���� ���� / �ڸ� / �ҷ� ���� �ڵ� ���� ������Ʈ �̺�Ʈ
            // ------------------------------------------------------------------------
			$("#table_forHeadList").on("click", "td", function(){
				if($(this).children().hasClass("edit-number") == false){		// ���� / �ڸ� / �ҷ� input �±׿� �ִ� edit-number�� �����Ͽ� ������� �۵���Ű�� ����
					return;
				};
				var rowindex = $(this).parent().parent().children().index($(this).parent()) + 1;					// ���̺� ��ü���� 0��°�� ����̱� ������ 1��° index�� �ֱ����� +1
				p_item = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(1)").text();							// ǰ��
				p_color = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(2)").text();							// Į��
				p_size = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(3)").text();							// ������
				p_item_lot = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(4)").text();						// ��Ʈ��ȣ
				p_cnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(5)").text(), 10);				// ����
				p_Gcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(6)").children().val(), 10);	// ����
				Pcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(7)").children().val(), 10);		// �ڸ�
				Wcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(8)").children().val(), 10);		// ����
				p_date = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(9)").children().val();					// �ڸ�����
				p_remark = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(10)").children().val();				// ���
				p_ID = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(12)").text();							// �԰���ǥ����ID
				if((p_Gcnt + Pcnt + Wcnt) == p_cnt){
					$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(6)").children().val(0);						// ���� 0 ���θ����
					$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(7)").children().val(0);						// �ڸ� 0 ���θ����
					$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(8)").children().val(0);						// ���� 0 ���θ����
					$(this).children().val(p_cnt);																	// ���� | �ڸ� | ���� �� ������ �׸� ��ü��(cnt) �ֱ�
				}else{
					$(this).children().val(p_cnt - (p_Gcnt + Pcnt + Wcnt));
				};
				// ����� �� ������Ʈ
				p_Gcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(6)").children().val(), 10);
				Pcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(7)").children().val(), 10);
				Wcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(8)").children().val(), 10);
				save_line(3);
			});		// �ڸ����� Ŭ���� ���� / �ڸ� / �ҷ� ���� �ڵ� ���� ������Ʈ �̺�Ʈ end

            // ------------------------------------------------------------------------
            // �ڸ����� ������ ������Ʈ �̺�Ʈ
            // ------------------------------------------------------------------------
			$("#table_forHeadList").on("change", "td", function(){
				if($(this).children().attr("name") == "�ڸ�����"){		// �Է³�¥ ��üũ
					if(jFuncDateValid($(this).children()[0]) == false){
						return;
					};
				};
				if($(this).children().attr("name") != "�۾��Ϸ�"){
                	var rowindex = $(this).parent().parent().children().index($(this).parent()) + 1;        			// ���̺� ��ü���� 0��°�� ����̱� ������ 1��° index�� �ֱ����� +1
					// �����ʵ� �Է°� ������ 0����
					if($(this).children().hasClass("edit-number") && $(this).children().val() == ""){
						$(this).children().val(0);
					};
					p_cnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(5)").text(), 10);				// ����
					if($(this).children().val() > p_cnt){
						alert("����������� ū ������ �Է��� �� �����ϴ�.");
						$(this).children().val(p_cnt);
						$(this).focus();
						return;
					};
					p_item = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(1)").text();							// ǰ��
					p_color = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(2)").text();							// Į��
					p_size = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(3)").text();							// ������
					p_item_lot = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(4)").text();						// ��Ʈ��ȣ
					p_cnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(5)").text(), 10);				// ����
					p_Gcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(6)").children().val(), 10);	// ����
					Pcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(7)").children().val(), 10);		// �ڸ�
					Wcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(8)").children().val(), 10);		// ����
					p_date = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(9)").children().val();					// �ڸ�����
					p_remark = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(10)").children().val();				// ���
					p_ID = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(12)").text();							// �԰���ǥ����ID
					save_line(3);		// �Է�  �ʵ尡 ������� Ȯ���ϰ� �ش� �ʵ� �� ������ ������Ʈ(ex)��� ��������� ��� �� ������ ������Ʈ) / ������ �׿� ���� �ϳ��ϳ� ���� ������ ������ ��¥ ������Ʈ
				};
			});		// �ڸ����� ������ ������Ʈ �̺�Ʈ end
            
            // ------------------------------------------------------------------------
            // �ڸ����� �Ϸ�� ������Ʈ �̺�Ʈ
            // ------------------------------------------------------------------------
			$("#table_forHeadList").on("click", "td", function(){
				if($(this).children().attr("name") == "�۾��Ϸ�"){
					chk = $(this).children().val();
					var rowindex = $(this).parent().parent().children().index($(this).parent()) + 1;        			// ���̺� ��ü���� 0��°�� ����̱� ������ 1��° index�� �ֱ����� +1
					p_item = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(1)").text();							// ǰ��
					p_color = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(2)").text();							// Į��
					p_size = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(3)").text();							// ������
					p_item_lot = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(4)").text();						// ��Ʈ��ȣ
					p_cnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(5)").text(), 10);				// ����
					p_Gcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(6)").children().val(), 10);	// ����
					Pcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(7)").children().val(), 10);		// �ڸ�
					Wcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(8)").children().val(), 10);		// ����
					p_date = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(9)").children().val();					// �ڸ�����
					p_remark = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(10)").children().val();				// ���
					p_ID = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(12)").text();							// �԰���ǥ����ID

					if(save_line(2) != true){
						return false;
					};
					$(this).children().val(chk == "" ? "V" : "");
					SUPPLY_DISP();
					if($(this).children().val() == ""){
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(6)").children().attr("class", "input_list edit-field edit-number").prop("readonly", false);		// ����
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(7)").children().attr("class", "input_list edit-field edit-number").prop("readonly", false);		// �ڸ�
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(8)").children().attr("class", "input_list edit-field edit-number").prop("readonly", false);		// ����
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(9)").children().attr("class", "input_list edit-field ins-date").prop("readonly", false);		// �ڸ�����
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(10)").children().attr("class", "input_list edit-field").prop("readonly", false);				// ���
					}else{
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(6)").children().attr("class", "input_list edit-field edit-number").prop("readonly", true);		// ����
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(7)").children().attr("class", "input_list edit-field edit-number").prop("readonly", true);		// �ڸ�
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(8)").children().attr("class", "input_list edit-field edit-number").prop("readonly", true);		// ����
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(9)").children().attr("class", "input_list edit-field ins-date").prop("readonly", true);			// �ڸ�����
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(10)").children().attr("class", "input_list edit-field").prop("readonly", true);					// ���
					};
					$("#table_forHeadList tr:eq(" + rowindex + ") td").each(function(){
						if(chk == ""){
							$(this).css("background-color", "#e3e3e3");
						}else{
							$(this).css("background-color", "#ffffff");
						};
					});
				};
			});		// �ڸ����� �Ϸ�� ������Ʈ �̺�Ʈ end

            // ------------------------------------------------------------------------
            // �����Ƿ� ��ȸ ���� ����
            // ------------------------------------------------------------------------
			$("#forBodyList_body").on("click", "tr", function(){
				var rowindex = $(this).index();
				p_item = $("#forBodyList_body tr:eq(" + rowindex + ") td:eq(4)").text();					// ǰ��
				p_color = $("#forBodyList_body tr:eq(" + rowindex + ") td:eq(5)").text();					// Į��
				p_size = $("#forBodyList_body tr:eq(" + rowindex + ") td:eq(6)").text();					// ������
				p_item_lot = $("#forBodyList_body tr:eq(" + rowindex + ") td:eq(7)").text();				// ��Ʈ��ȣ
				p_cnt = parseInt($("#forBodyList_body tr:eq(" + rowindex + ") td:eq(8)").text());			// �������
				p_Gcnt = parseInt($("#forBodyList_body tr:eq(" + rowindex + ") td:eq(9)").text());			// ����
				WGcnt = parseInt($("#forBodyList_body tr:eq(" + rowindex + ") td:eq(10)").text());			// �ڸ����
				p_Gcnt = p_Gcnt + WGcnt;
				p_chk = $("#forBodyList_body tr:eq(" + rowindex + ") td:eq(11)").text();					// ����
				p_ID = $("#forBodyList_body tr:eq(" + rowindex + ") td:eq(12)").text();					    // �԰���ǥ����ID
				if(p_chk == "V"){		// üũ ����, �ڸ���� ����
					$("#forBodyList_body tr:eq(" + rowindex + ") td:eq(11)").text();
					save_line(4);
				}else{					// üũ, �ڸ���� �߰�
					$("#forBodyList_body tr:eq(" + rowindex + ") td:eq(11)").text("V");
					save_line(1);
				};
				init_disp();
				SUPPLY_DISP();
			});		// �����Ƿ� ��ȸ ���� ���� end
            
            // ------------------------------------------------------------------------
            // ��ȸ ���� ��� Ŭ������ ����
            // ------------------------------------------------------------------------
            $("#table_forBodyList").on("click", "th", function(){
                var regex = /[^��-��|��-��|��-�R|aA-zZ]/gi;     //  �ѱ� ��� �Է�
                var sort_kind = $(this).text().replace(regex, "");      //  �׳� $(this).text() �� ����� �ٸ� ���ڰ� �־� replace�� �ѱ۸� �����
                if(sort_kind == "����"){
                    return;
                };
                $("#supply_header_02 > th span").each(function(){      //  this�� �ƴѰ�� display none�� ������ �����
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
            });     //  ��ȸ ���� ��� Ŭ������ ���� end

            // ------------------------------------------------------------------------
            // input-auto ��Ŀ���� ���� �Ʒ�����Ű Ʈ���� �۵����� �˻� ��� ��ġ�� / autocomplete ����
            // ------------------------------------------------------------------------
            $(".input-auto").on("focus", function(){
                if(dontFocus == 0){
                    data_find(this.id);       //  �ڵ��ϼ� ����
                }else{
                    dontFocus = 0;
                    return;
                };
                var e = $.Event("keydown", {
                    keyCode : 40         //  �Ʒ�����Ű Ű�ڵ� 40
                });
                var t_this = this;
                setTimeout(function(){      //  �ٷ� ����� autoFocus ���׷� ���� ��Ŀ�� ����� setTimeout ������ ���� �����
                    $(t_this).trigger(e);
                }, 100);
                if(this.id == "â���"){     // ������Ŀ�� ����� �̰� �߰���
                    return;
                }else{
                    $(this).trigger(e);
                };
            });   //  �Ʒ�����Ű Ʈ���� end

            $("#â���").on("focus", function(){      // �̰��ؾ� �Է°��� ������� �˻��� â�� �����ִµ� �׷��� autoFocus�� ���峲...
                $(this).autocomplete("search", "");             // �׷��� autoFocus ����� Ʈ���ŷ� autoFocus ��� �߰� �ۼ���
            });

            // ------------------------------------------------------------------------
            // input�� Ű �Է½� �̺�Ʈ ����(move_next)
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
            });   //  Ű �Է½� �̺�Ʈ end

            // ------------------------------------------------------------------------
            // class edit-field �׸� ���ڸ� �Է��ϵ��� ����
            // ------------------------------------------------------------------------
            // $(".edit-number").on("blur keyup keydown", function(){			// $(".edit-number") �� �ϸ� ��ȸ�� ����Ʈ���� �ν��� �������� ���ϱ� ?
            $("body").on("blur keyup keydown", ".edit-number", function(){
                // var regex = /[^0-9]/gi;    //  ���ڻ��� �Է� �ȵ� .���ȵ�
                var regex = /[��-��|��-��|��-�R|aA-zZ]/gi;     //  �ѱ� ��� ����
                $(this).val($(this).val().replace(regex, ""));
            });   //  ���ڸ� �Է� end

            // ------------------------------------------------------------------------	
            // ���۽� ��Ŀ��
            // ------------------------------------------------------------------------	
			$("#â���").focus();

			// ------------------------------------------------------------------------
			// datepicker ����
			// ------------------------------------------------------------------------
			$("body").on("focus", ".datepicker", function(){
				$(this).datepicker({
					dateFormat : "yy-mm-dd",
					prevText : "<",
					nextText : ">",
					monthNames : ["1��", "2��", "3��", "4��", "5��", "6��", "7��", "8��", "9��", "10��", "11��", "12��"],
					monthNamesShort : ["1��", "2��", "3��", "4��", "5��", "6��", "7��", "8��", "9��", "10��", "11��", "12��"],
					dayNames : ["��", "��", "ȭ", "��", "��", "��", "��"],
					dayNamesShort : ["��", "��", "ȭ", "��", "��", "��", "��"],
					dayNamesMin : ["��", "��", "ȭ", "��", "��", "��", "��"],
					showMonthAfterYear : true,
					yearSuffix : "��",
					autoClose : true
				});
				// $(this).datepicker("option", "disbled", true);		// �ɼ��� ������ �ʰ��Ѵ�... ? �ε� ���⿡ ��� ���� �������� �� ������ �ȵ� �������� �������� �𸣰���.
			});		// datepicker ���� end

			$("body").on("change", ".datepicker", function(){
				if(jFuncDateValid(this) == false){
					$(this).val("");
					$(this).focus();
					return;
				};
			});		// �Է°� Ȯ��

		}catch(err){
			alert(err.message);
            self.close();
		};
	});



	// ------------------------------------------------------------------------
	// �ڸ��۾� ��� ��ȸ
	// ------------------------------------------------------------------------
	function init_disp(){
		try{
			var rst = Get_Json("EXEC B_WORK_PEEL_LST 1, '" + $("#â���").val() + "', '" + $("#�۾�����").val() + "'");
			var appendHTML = "";
			if(rst[0].SNO == "" || rst[0].SNO == " " || rst[0].SNO == null){
				appendHTML = "<tr><td>��ȸ ������ �����ϴ�.</td></tr>";
			}else{
                var rstLength = rst.length > 7 ? 5.1 : 6;
                for(i = 0; i < rst.length; i++){
                    appendHTML += '<tr><td style="width: 3%;">' + rst[i].SNO +'</td><td style="width: 12%;">' + rst[i].ǰ�� +'</td>'
                                + '<td style="width: 15%;">' + rst[i].Į�� +'</td><td style="width: 7%;">' + rst[i].������ +'</td>'
                                + '<td style="width: 10%;">' + rst[i].�����۷�Ʈ��ȣ +'</td><td style="width: 6%;">' + rst[i].������� +'</td>'
                                + '<td style="width: 6%;"><input type="text" class="input_list edit-field edit-number" name="����" value="' + rst[i].���� + '" autocomplete="off"></td>'
                                + '<td style="width: 6%;"><input type="text" class="input_list edit-field edit-number" name="�ڸ�" value="' + rst[i].�ڸ� + '" autocomplete="off"></td>'
                                + '<td style="width: 6%;"><input type="text" class="input_list edit-field edit-number" name="����" value="' + rst[i].���� + '" autocomplete="off"></td>'
                                + '<td style="width: 9%;"><input type="text" class="input_list edit-field ins-date datepicker" name="�ڸ�����" value="' + rst[i].�ڸ����� + '" autocomplete="off"></td>'
                                + '<td style="width: 14%;"><input type="text" class="input_list edit-field" name="���" value="' + rst[i].��� + '" autocomplete="off"></td>'
                                + '<td style="width: ' + rstLength + '%;"><input type="text" class="input_list edit-field pack" name="�۾��Ϸ�" value="' + rst[i].�۾��Ϸ� + '"></td>'
                                + '<td style="display:none;">' + rst[i].�԰���ǥ����ID + '</td></tr>'
                };
			};
			$("#forHeadList_body").empty();
			$("#forHeadList_body").append(appendHTML);
			
			// ���õ� �� ������ Į�� ����
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
	};		// �ڸ��۾� ��� ��ȸ end

	// ------------------------------------------------------------------------
	// �����Ƿ� ��ȸ
	// ------------------------------------------------------------------------
	function SUPPLY_DISP(sortName, sortOrder){
		try{
            sortName = sortName == null ? "" : sortName == undefined ? "" : sortName;		//	sortName�� �Է°� �ִ��� Ȯ��
            sortOrder = sortOrder == null ? "" : sortOrder == undefined ? "" : sortOrder;		//	sortOrder�� �Է°� �ִ��� Ȯ��
			var rst = Get_Json("EXEC B_WORK_PEELING_LST 1, '" + $("#â���").val() + "', '" + $("#��ȸ����").val() + "', '" + sortName + "', '" + sortOrder + "'");
			console.log("EXEC B_WORK_PEELING_LST 1, '" + $("#â���").val() + "', '" + $("#��ȸ����").val() + "', '" + sortName + "', '" + sortOrder + "'")
			var appendHTML = "";
			if(rst[0].�������� == "" || rst[0].�������� == " " || rst[0].�������� == null){
				appendHTML = "<tr><td>��ȸ ������ �����ϴ�.</td></tr>";
			}else{
                var rstLength = rst.length > 7 ? 7.1 : 8;
                for(i = 0; i < rst.length; i++){
                    appendHTML += '<tr><td style="width: 8%;">' + rst[i].�������� +'</td><td style="width: 7%;">' + rst[i].â��� +'</td>'
                            + '<td style="width: 7%;">' + rst[i].��񱸺� +'</td><td style="width: 7%;">' + rst[i].����� +'</td>'
                            + '<td style="width: 12%;">' + rst[i].ǰ�� +'</td><td style="width: 16%;">' + rst[i].Į�� +'</td>'
                            + '<td style="width: 9%;">' + rst[i].������ +'</td>' + '<td style="width: 10%;">' + rst[i].��Ʈ��ȣ +'</td>'
                            + '<td style="width: 8%;">' + rst[i].������� +'</td>' + '<td style="width: 8%;">' + rst[i].���� +'</td>'
                            + '<td style="width: ' + rstLength + '%;">' + rst[i].�ڸ���� +'</td>' + '<td style="display:none;">' + rst[i].���� +'</td>'
                            + '<td style="display:none;">' + rst[i].�԰���ǥ����ID + '</td></tr>'
                };
			};
			$("#forBodyList_body").empty();
			$("#forBodyList_body").append(appendHTML);

			// ���õ� �� ��׶��� Į�� ����
			$("#forBodyList_body > tr").each(function(){
				if($("td:eq(11)", this).text() == "V"){
					$("td", this).css("background-color", "#DBD6E8");
				};
			});
			
		}catch(err){
			alert(err.message);
		};
	};		// �����Ƿ� ��ȸ end

    // ------------------------------------------------------------------------
    // ���پ� ����
    // ------------------------------------------------------------------------
	function save_line(order){		// order 1: �����Ƿڼ� ���� 1�� ���ý� �ڸ���� �߰� / 2: �ڸ���� �Ϸ� üũ�� / 3: �ڸ���� ���� ���� ������ / 4: �ڸ���� ���� ����(�����Ƿڼ� ���� �ٽ� ���ý�)
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
			// console.log("EXEC [AA_WORKDIARY_�ڸ�] '" + id + "'" + save_data + ", '" + p_ID + "', " + order);
			var insert = Get_Json("EXEC [AA_WORKDIARY_�ڸ�] '" + id + "'" + save_data + ", '" + p_ID + "', " + order);
			if(insert[0].VALID == 0){
				if(insert[0].RETURN_INPUT != ""){
                    dontFocus = 1;      // �ڵ��ϼ� ȭ��ǥ Ʈ���Ÿ� �۵��ϵ��� �۾�
					alert(insert[0].MSG);
					$("#" + insert[0].RETURN_INPUT).focus();
				}else{
					alert(insert[0].MSG);
				};
				return false;
			}else if(insert[0].VALID == 1){
				$("#�۾����۽ð�").val(insert[0].�۾����۽ð�);
				$("#�۾�����ð�").val(insert[0].�۾�����ð�);
				$("#�۾��ð�").val(insert[0].�۾��ð�);

				// ���� ���� ����
				p_item = "";			// ǰ��
				p_color = "";			// Į��
				p_size = "";			// ������
				p_item_lot = "";		// ��Ʈ��ȣ
				p_cnt = 0;				// �������
				p_Gcnt = 0;				// ����
				p_chk = "";				// ����(�����Ƿ�)
				p_ID = "";				// key ��

				Pcnt = 0;				// �ڸ�
				Wcnt = 0;				// ����
				WGcnt = 0;				// �ڸ����
				p_date = "";			// �ڸ�����
				p_remark = "";			// ���
				return true;
			};
		}catch(err){
			alert(err.message);
		};
	};		// ���پ� ���� end

    // ------------------------------------------------------------------------
    // �˻��� �Է� �ڵ��ϼ� sql
    // ------------------------------------------------------------------------
	function data_find(id){
		try{
			var t_sql = "EXEC AA_WORKDIARY_Search '', '�ڸ��۾�â��', ''";
			var find_rst = "";
			var find_data_array = new Array();
			find_rst = Get_Json(t_sql);
			find_data_array[id] = find_rst;
			if(find_rst["FND_DATA"] == "" || find_rst[0]["FND_DATA"] == " "){
				find_data_array.push("��ȸ ������ �����ϴ�. �������� �Ѿ��");
			}else{
                for(var i in find_rst){
                    find_data_array.push(find_rst[i]["FND_DATA"]);
                };
			};
			autocomplete_abc(find_data_array, id);
		}catch(err){
			alert(err.message);
		};
	};		// �˻��� �Է� �ڵ��ϼ� sql end

    // ------------------------------------------------------------------------
    // �ڵ��ϼ� ��ü ����
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
                // $(this).autocomplete("search", $(this).val());    //  focus�� �ٷ� �˻�â�� ON   Ʈ���ŷ� �Ʒ�����Ű �����°� �߰� ���� ������ autoFocus �� ���װɷ��� ��Ŀ�� �����
			});
		}catch(err){
			alert(err.message);
		};
	};		// �ڵ��ϼ� ��ü ���� end

    // ------------------------------------------------------------------------
    // ����ĭ �̵�
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
    };    //  ����ĭ �̵� end

    // ------------------------------------------------------------------------
    // ���� �ð� ���ϱ�
    // ------------------------------------------------------------------------
    function getTime(){
        var date = new Date();
        var hours = ('0' + date.getHours()).slice(-2);
        var minutes = ('0' + date.getMinutes()).slice(-2);
        var timeString = hours + ':' + minutes;
        return timeString;
    };    //  ���� �ð� ���ϱ� end

    // ------------------------------------------------------------------------
    // ���� ��¥
    // ------------------------------------------------------------------------
    function getDay(){
        var offset = new Date().getTimezoneOffset() * 60000;        // getTimezoneOffset() = ���� �ð����� ���̸� �д����� ��ȯ�ϱ� ������ 1000(�и���) * 60(��) �� ����Ͽ� �и��� ������ ���
        // var date = new Date()       // toISOString() �ҽ� ����ǥ�ؽ÷� ��ȯ �Ǳ� ������ getTimezoneOffset�� ���
        var date = new Date(Date.now() - offset);       // toISOString() �ϱ� �� ����ǥ�ؽÿ� �ѱ� ���� ��ŭ �� �߰��ϱ�
        var day = date.toISOString().substring(0, 10);      // ���ڰ��� �����
        return day;
    };    //  ���� ��¥ end


</script>

<head>

<body>

	<div class="Topbtn">
		<div id="title_bar">
			<img id="title_bar_img" src="../image/title/title2.png">
			<p id="t_header">�ڸ��۾�����</p>
		</div>

		<table class="searchDate">
			<tr>
				<th class="th_search_01">
					<label class="label_tag">��ǰ������</label>
				</th>
				<td class="td_search_01">
					<input type="text" id="��ȸ����" class="input_tag datepicker">
				</td>
				<td class="th_search_01">
					<label class="label_tag">����</label>
				</td>
			</tr>
		</table>

		<button id="�۾�����" class="btn btn_02">
			<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-play-fill" viewBox="0 0 12 12">
				<path d="m11.596 8.697-6.363 3.692c-.54.313-1.233-.066-1.233-.697V4.308c0-.63.692-1.01 1.233-.696l6.363 3.692a.802.802 0 0 1 0 1.393z"/>
			</svg>
			<i class="bi bi-play-fill"></i>
			�۾�����
		</button>
		<button id="�۾�����" class="btn btn_02 btn_02_2">
			<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-stop-fill" viewBox="0 0 12 12">
				<path d="M5 3.5h6A1.5 1.5 0 0 1 12.5 5v6a1.5 1.5 0 0 1-1.5 1.5H5A1.5 1.5 0 0 1 3.5 11V5A1.5 1.5 0 0 1 5 3.5z"/>
			</svg>
			<i class="bi bi-stop-fill"></i>
			�۾�����
		</button>
		<button id="���" class="btn btn_03" onclick="self.close();">
			���
		</button>

	</div>

	<div class="bottom">
		<div class="date_insert">
            <table class="date">
                <tr>
                    <th class="th_01">
                        <label class="label_tag">�۾�����</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�۾�����" class="input_tag input_tag_date datepicker input-field input_tag_date input_tag_readonly_01" autocomplete="off" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">�۾��ð�</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�۾��ð�" class="input_tag input-field" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">â���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="â���" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">�۾���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�۾���" class="input_tag input_tag_readonly_01 input_tag_end_01 input-field" tabindex="-1" readonly>
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
                            ǰ��<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 15%">
                            Į��<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 7%">
                            ������<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 10%">
                            ��Ʈ��ȣ<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 6%">
                            �������<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 6%">
                            ����<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 6%">
                            �ڸ�<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 6%">
                            ����<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 9%">
                            �ڸ�����<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 14%">
                            ���<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 6%">
                            �Ϸ�<span class="ui-icon ui-icon-triangle-1-n">
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
                            ��������<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 7%">
                            â���<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 7%">
                            ��񱸺�<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 7%">
                            �����<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 12%">
                            ǰ��<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 16%">
                            Į��<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 9%">
                            ������<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 10%">
                            ��Ʈ��ȣ<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 8%">
                            �������<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 8%">
                            ����<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 8%">
                            �ڸ����<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                    </tr>
                </thead>
                
                <tbody id="forBodyList_body" class="forBodyList_body">
                </tbody>
            </table>
        </div>

	</div>
 
<input type="hidden" id="�۾����۽ð�" class="input-field">
<input type="hidden" id="�۾�����ð�" class="input-field">
<input type="hidden" id="IP_Address" class="input-field">

</body>

</html>