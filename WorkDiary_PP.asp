<!--#include virtual="N_MAIN/global.asp" -->
<%
call vFunChkSession(2)	'¼¼¼ÇÃ¼Å© ¹× Áßº¹»ç¿ëÀÚÃ¼Å©     ÇÔ¼öÀ§Ä¡: /INCLUDE/function.asp
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
<title>ÀÛ¾÷ÀÏÁöµî·Ï(¹Ú¸®)</title>
<!-- ³»ºÎ ¹®¼­ ÂüÁ¶ -->
<script src="../../N_Main/jQuery/jquery-1.12.4.min.js"></script>
<script src="../../N_Main/jQuery/jquery-ui.js"></script>
<script type="text/javascript" src="../erp_func/common_func.js?230103a"></script>
<script type="text/javascript" src="../../N_CSS/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="../../N_CSS/bootstrap/3.3.2/css/bootstrap.min.css"/>
<link rel="stylesheet" href="../../IncJquery/jquery-ui.min.css"/>
<!-- datepicker -->

<link rel="stylesheet" type="text/css" href="../../N_CSS/datepicker2.css" />

<style>
    /* ÀüÃ¼ ¿µ¿ª */
    html, body { width: 99.5%; margin: 5px 5px 5px 5px;  }
    
    /* title */
    #title_bar{ float: left; width:22%; height:60px; margin: 5px 9% 0px 2%; vertical-align: auto; position: relative; background-size: 100%, 42px; background-position: center; background-repeat: no-repeat;  }
    #title_bar_img{ width: 100%; height: 100%;  }
    #t_header{ width: 100%; font-size: 18pt; font-weight: bold; font-family: Noto Sans KR; margin: 0px; color:white; text-align:center; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); letter-spacing: 2.5px;  }

    /* ¹öÆ° */
    .btn{ width: 100px; height: 60px; background-color: #337ab7; color: #fff; float: left; font-size: 16px; border-radius: 0px; text-align: center; vertical-align: auto;  }
    .btn_02{ width: 118px; border-radius: 3px; margin: 10px 0.5% 10px 0px;  }
    .btn_02_2{ border-radius: 3px; margin: 10px 3% 10px 0px;  }
    .btn_03{ border-radius: 3px; background-color: #FF0000; float: none; clear: right; margin: 10px 0% 10px 0px; line-height: 50px; font-size: 18px; font-weight: bold; color: #fff;  }
    .btn_02:hover { color: white; background-color: #195E9B; cursor: pointer;  }
    .btn_03:hover { color: #fff; background-color: #FF8080; cursor: pointer;  }
    .btn_02:disabled { color: white; background-color: #195E9B; cursor: pointer;  }
    .btn_03:disabled { color: #fff; background-color: #FF8080; cursor: pointer;  }
    .btn_add { position: absolute; border: none; margin: 4px 4px 4px 4px; color: #fff; left: 80%; top: 450px; background-color: tomato;  }

    /* °¢ ±¸¿ª ³ª´©±â / ±¸¿ªº° css ÀÛ¾÷ */
    .TopBtn{ height: 100px; margin: 0px 0px 5px 0px; padding: 10px 0px 0px 0px; background-color: #dff0ed;  }
    .bottom{ width: 100%;  }

    .searchDate{ width: 20%; height: 30px; float: left; margin: 30px 22% 0px 0px;  }
    .searchDate label{ border: 1px solid #195E9B; background-color: #0EBDDD; color: #fff; margin: 0px 2px 0px 0px;  }
    .searchDate input{ border: 1px solid #195E9B; text-align: center;  }

    .date_insert{ width: 100%; height: 40px; max-height: 40px; margin: 0px 0px 5px 0px;  }
    .date{ border-collapse: collapse; width: 100%; background-color: #FCEED6;  }
    .date label{ display: block; border: 1px solid #f0bd5e; background-color: #FCEED6;  }
    .date input{ border: 1px solid #f0bd5e; text-align: center;  }

    /* th ÅÂ±× */
    .th_01{ box-sizing: border-box; width: 7.5%; height: 40px; font-size: 13pt; border-spacing: 0px; text-align: center;  }
	.th_search_01{ box-sizing: border-box; width: 22%; height: 40px; font-size: 13pt; border-spacing: 0px;  }
    .th_table_01{ box-sizing: border-box; text-align: center;  }

    /* td ÅÂ±× */
    .td_01{ box-sizing: border-box; width: 17.5%; height: 40px; font-size: 13pt; border-spacing: 0px;  }
	.td_search_01{ box-sizing: border-box; width: 48%; height: 40px; font-size: 13pt; border-spacing: 0px;  }

    /* label */
    label{ display: block; border-radius: 3px; color: #000000; height: 34px; max-height: 34px; line-height: 34px; text-align: center; vertical-align: middle; font-weight: bold; white-space: nowrap; margin: 0px;  }

    /* input ÅÂ±× */
    input{ border-radius: 3px; background-color: #ffffff;  }
    input:focus{ border: 2px solid #f00; outline: none; }
    input:disabled{ color: #999;  }
    .input_tag{ width: 95%; height: 34px; max-height: 34px; line-height: 34px; vertical-align: middle; font-size: 13pt; border: 0; margin: 0px 1% 0px 2%;  }
    .input_tag_readonly_01{ background-color: #eee; pointer-events: none; text-align: center;  }  
    .input_tag_end_01{ width: 98%;  }
	.input_list{ height: 100%; width: 100%; text-align: center; border: none; border-radius: 0px;  }

    /* °ø±ÞÀÇ·Ú¼­ Á¶È¸ */
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

	/* ¹Ú¸®´ë»ó Á¶È¸ */
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

    /* Á¶È¸ Á¤·Ä½Ã ¾ÆÀÌÄÜ */
    .ui-icon { zoom: 200%; margin-top: 1px; position: absolute; display: none; background-image: url("../IncJquery/images/ui-icons_ffffff_256x240.png");  }

    /* autocomplete */
    .autocomplete > div.active{ background: #333; color: #eee;  }
    .ui-autocomplete{ width: auto; height: auto; max-height: 300px; overflow-y: auto; overflow-x: hidden;  }
    html .ui-autocomplete{ font-size: 16px; font-family: Noto Sans KR;  }
    .ui-menu-item-wrapper{ height: 40px; line-height: 30px; vertical-align: middle;  }
    .ui-state-active{ margin: 0px !important;  }

</style>

<script type="text/javascript">
    //  ½Ã°£, ³¯ÀÚ ±¸ÇÏ´Â º¯¼ö Àü¿ªº¯¼ö·Î ¼±¾ð
    var timeString = getTime();
    var dateString = getDay();

    //  URL¿¡¼­ »ç¿ø¹øÈ£, IPÁÖ¼Ò, Ã¢°í¹øÈ£ ¹Þ¾Æ¿À±â
    var seSawonid = new URLSearchParams(window.location.search).get("seSawonid");
    var IP_Address = new URLSearchParams(window.location.search).get("IP_Address");
    var defaultStocID = new URLSearchParams(window.location.search).get("defaultStocID");

    //  »ç¿ø ¹øÈ£·Î »ç¿øÀÌ¸§ °¡Á®¿À±â
    var get_saWon = Get_Json("SELECT SawonName FROM G_SAWON WHERE USECHK = 0 AND SawonID = " + seSawonid);
    var seSawonname = get_saWon[0].SawonName;

    //  Ã¢°í ¹øÈ£·Î Ã¢°íÀÌ¸§ °¡Á®¿À±â
    var get_defaultStocName = Get_Json("SELECT Ã¢°í¸í AS defaultStocName FROM C_Ã¢°í WHERE Ã¢°íID =" + defaultStocID);
    var defaultStocName = get_defaultStocName[0].defaultStocName;

    //  autocomplete ÆîÄ¡Áö ¾Êµµ·Ï ÇÏ´Â º¯¼ö ¼±¾ð       / ÀÛ¾÷½ÃÀÛ, Á¾·á½Ã Æ÷Ä¿½º·Î µé¾î°¥¶§ ÀÚµ¿¿Ï¼º°ú È­»ìÇ¥ Æ®¸®°Å°¡ °°ÀÌ ÀÛµ¿µÇ¾î Æ÷Ä¿½º À§Ä¡ ¹ö±× ÇØ°á¿ë
    let dontFocus = 0;

	// °ø¿ë º¯¼ö ¼±¾ð
	p_item = "";			// Ç°¸í
	p_color = "";			// Ä®¶ó
	p_size = "";			// »çÀÌÁî
	p_item_lot = "";		// ·ÎÆ®¹øÈ£
	p_cnt = 0;				// »ý»ê¼ö·®
	p_Gcnt = 0;				// ¼÷¼º
	p_chk = "";				// ¼±ÅÃ(°ø±ÞÀÇ·Ú)
	p_ID = "";				// key °ª

	Pcnt = 0;				// ¹Ú¸®
	Wcnt = 0;				// º¸·ù
	WGcnt = 0;				// ¹Ú¸®´ë±â
	p_date = "";			// ¹Ú¸®ÀÏÀÚ
	p_remark = "";			// ºñ°í

	$(document).ready(function(){
		try{
            // ------------------------------------------------------------------------
            // ÃÊ±â µ¥ÀÌÅÍ ¼³Á¤
            // ------------------------------------------------------------------------
            window.focus();
			$("#IP_Address").val(IP_Address);
			$("#ÀÛ¾÷ÀÏÀÚ").val(getDay());
			var date = new Date();
			// date.setDate(date.getDate() - 14);       //  14ÀÏÀü ³¯Â¥ °è»ê
			// var twoWeekAgo = date.toISOString().substring(0, 10);       //  °è»ê µÈ ³¯Â¥ YYYY-MM-DD ÇüÀ¸·Î º¯È¯ º¯¼ö¿¡ ¾È´ã°í ¹Ù·Î val() ÇØµµ ¹«°ü
            var twoWeekAgo = get_add_date_yyyymmdd('dd', -14);
			$("#Á¶È¸ÀÏÀÚ").val(twoWeekAgo);
			$("#ÀÛ¾÷ÀÚ").val(seSawonname);
			$("#Ã¢°í¸í").val(defaultStocName);

			$("#ÀÛ¾÷Á¾·á").attr("disabled", true);
            
            // ------------------------------------------------------------------------
            // Á¶È¸
            // ------------------------------------------------------------------------
            $("#Á¶È¸ÀÏÀÚ").on("change", function(){
				if(jFuncDateValid(this) == true){
					init_disp();
					SUPPLY_DISP();
				}else{
					$("#Á¶È¸ÀÏÀÚ").val("");
					return false;
				};
            });     //  Á¶È¸ end

            // ------------------------------------------------------------------------
            // ÀÛ¾÷½ÃÀÛ ¹öÆ° Å¬¸¯
            // ------------------------------------------------------------------------
            $("#ÀÛ¾÷½ÃÀÛ").on("click", function(){
                if(save_line(5) == true){
                    $("#ÀÛ¾÷½ÃÀÛ").attr("disabled", true);
                    $("#ÀÛ¾÷Á¾·á").attr("disabled", false);
				};
            });   //  ÀÛ¾÷½ÃÀÛ ¹öÆ° end

            // ------------------------------------------------------------------------
            // ÀÛ¾÷Á¾·á ¹öÆ° Å¬¸¯
            // ------------------------------------------------------------------------
            $("#ÀÛ¾÷Á¾·á").on("click", function(){
                if(save_line(6) == true){
					alert("ÀúÀåµÇ¾ú½À´Ï´Ù.");
					opener.main_bind();
					self.close();
				};
            });   //  ÀÛ¾÷Á¾·á ¹öÆ° end

            // ------------------------------------------------------------------------
            // ¹Ú¸®¼ö·® Å¬¸¯½Ã ¼÷¼º / ¹Ú¸® / ºÒ·® ¼ö·® ÀÚµ¿ ¼ÂÆÃ ¾÷µ¥ÀÌÆ® ÀÌº¥Æ®
            // ------------------------------------------------------------------------
			$("#table_forHeadList").on("click", "td", function(){
				if($(this).children().hasClass("edit-number") == false){		// ¼÷¼º / ¹Ú¸® / ºÒ·® input ÅÂ±×¿¡ ÀÖ´Â edit-number·Î ±¸ºÐÇÏ¿© ¾øÀ»°æ¿ì ÀÛµ¿½ÃÅ°Áö ¾ÊÀ½
					return;
				};
				var rowindex = $(this).parent().parent().children().index($(this).parent()) + 1;					// Å×ÀÌºí ÀüÃ¼¿¡¼­ 0¹øÂ°´Â Çì´õÀÌ±â ¶§¹®¿¡ 1¹øÂ° index¸¦ ÁÖ±âÀ§ÇØ +1
				p_item = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(1)").text();							// Ç°¸í
				p_color = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(2)").text();							// Ä®¶ó
				p_size = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(3)").text();							// »çÀÌÁî
				p_item_lot = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(4)").text();						// ·ÎÆ®¹øÈ£
				p_cnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(5)").text(), 10);				// »ý»ê
				p_Gcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(6)").children().val(), 10);	// ¼÷¼º
				Pcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(7)").children().val(), 10);		// ¹Ú¸®
				Wcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(8)").children().val(), 10);		// º¸·ù
				p_date = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(9)").children().val();					// ¹Ú¸®ÀÏÀÚ
				p_remark = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(10)").children().val();				// ºñ°í
				p_ID = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(12)").text();							// ÀÔ°íÀüÇ¥¼ö·®ID
				if((p_Gcnt + Pcnt + Wcnt) == p_cnt){
					$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(6)").children().val(0);						// ¼÷¼º 0 À¸·Î¸¸µé±â
					$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(7)").children().val(0);						// ¹Ú¸® 0 À¸·Î¸¸µé±â
					$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(8)").children().val(0);						// º¸·ù 0 À¸·Î¸¸µé±â
					$(this).children().val(p_cnt);																	// ¼÷¼º | ¹Ú¸® | º¸·ù Áß ¼±ÅÃÇÑ Ç×¸ñ¿¡ ÀüÃ¼°ª(cnt) ³Ö±â
				}else{
					$(this).children().val(p_cnt - (p_Gcnt + Pcnt + Wcnt));
				};
				// º¯°æµÈ °ª ¾÷µ¥ÀÌÆ®
				p_Gcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(6)").children().val(), 10);
				Pcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(7)").children().val(), 10);
				Wcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(8)").children().val(), 10);
				save_line(3);
			});		// ¹Ú¸®¼ö·® Å¬¸¯½Ã ¼÷¼º / ¹Ú¸® / ºÒ·® ¼ö·® ÀÚµ¿ ¼ÂÆÃ ¾÷µ¥ÀÌÆ® ÀÌº¥Æ® end

            // ------------------------------------------------------------------------
            // ¹Ú¸®³»¿ë ¼öÁ¤½Ã ¾÷µ¥ÀÌÆ® ÀÌº¥Æ®
            // ------------------------------------------------------------------------
			$("#table_forHeadList").on("change", "td", function(){
				if($(this).children().attr("name") == "¹Ú¸®ÀÏÀÚ"){		// ÀÔ·Â³¯Â¥ º§Ã¼Å©
					if(jFuncDateValid($(this).children()[0]) == false){
						return;
					};
				};
				if($(this).children().attr("name") != "ÀÛ¾÷¿Ï·á"){
                	var rowindex = $(this).parent().parent().children().index($(this).parent()) + 1;        			// Å×ÀÌºí ÀüÃ¼¿¡¼­ 0¹øÂ°´Â Çì´õÀÌ±â ¶§¹®¿¡ 1¹øÂ° index¸¦ ÁÖ±âÀ§ÇØ +1
					// ¼ýÀÚÇÊµå ÀÔ·Â°ª ¾øÀ»½Ã 0À¸·Î
					if($(this).children().hasClass("edit-number") && $(this).children().val() == ""){
						$(this).children().val(0);
					};
					p_cnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(5)").text(), 10);				// »ý»ê
					if($(this).children().val() > p_cnt){
						alert("»ý»ê¼ö·®º¸´Ù Å« °ªÀ¸·Î ÀÔ·ÂÇÒ ¼ö ¾ø½À´Ï´Ù.");
						$(this).children().val(p_cnt);
						$(this).focus();
						return;
					};
					p_item = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(1)").text();							// Ç°¸í
					p_color = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(2)").text();							// Ä®¶ó
					p_size = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(3)").text();							// »çÀÌÁî
					p_item_lot = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(4)").text();						// ·ÎÆ®¹øÈ£
					p_cnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(5)").text(), 10);				// »ý»ê
					p_Gcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(6)").children().val(), 10);	// ¼÷¼º
					Pcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(7)").children().val(), 10);		// ¹Ú¸®
					Wcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(8)").children().val(), 10);		// º¸·ù
					p_date = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(9)").children().val();					// ¹Ú¸®ÀÏÀÚ
					p_remark = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(10)").children().val();				// ºñ°í
					p_ID = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(12)").text();							// ÀÔ°íÀüÇ¥¼ö·®ID
					save_line(3);		// ÀÔ·Â  ÇÊµå°¡ ¾îµðÀÎÁö È®ÀÎÇÏ°í ÇØ´ç ÇÊµå ¸¸ µ¥ÀÌÅÍ ¾÷µ¥ÀÌÆ®(ex)ºñ°í ³»¿ë¼öÁ¤½Ã ºñ°í ¸¸ µ¥ÀÌÅÍ ¾÷µ¥ÀÌÆ®) / ÀÌÁö¸¸ ±×¿¡ ´ëÇØ ÇÏ³ªÇÏ³ª µû·Î ÀúÀåÇÒ ¹æ¹ý´ë½Å ÅëÂ¥ ¾÷µ¥ÀÌÆ®
				};
			});		// ¹Ú¸®³»¿ë ¼öÁ¤½Ã ¾÷µ¥ÀÌÆ® ÀÌº¥Æ® end
            
            // ------------------------------------------------------------------------
            // ¹Ú¸®³»¿ë ¿Ï·á½Ã ¾÷µ¥ÀÌÆ® ÀÌº¥Æ®
            // ------------------------------------------------------------------------
			$("#table_forHeadList").on("click", "td", function(){
				if($(this).children().attr("name") == "ÀÛ¾÷¿Ï·á"){
					chk = $(this).children().val();
					var rowindex = $(this).parent().parent().children().index($(this).parent()) + 1;        			// Å×ÀÌºí ÀüÃ¼¿¡¼­ 0¹øÂ°´Â Çì´õÀÌ±â ¶§¹®¿¡ 1¹øÂ° index¸¦ ÁÖ±âÀ§ÇØ +1
					p_item = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(1)").text();							// Ç°¸í
					p_color = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(2)").text();							// Ä®¶ó
					p_size = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(3)").text();							// »çÀÌÁî
					p_item_lot = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(4)").text();						// ·ÎÆ®¹øÈ£
					p_cnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(5)").text(), 10);				// »ý»ê
					p_Gcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(6)").children().val(), 10);	// ¼÷¼º
					Pcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(7)").children().val(), 10);		// ¹Ú¸®
					Wcnt = parseInt($("#table_forHeadList tr:eq(" + rowindex + ") td:eq(8)").children().val(), 10);		// º¸·ù
					p_date = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(9)").children().val();					// ¹Ú¸®ÀÏÀÚ
					p_remark = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(10)").children().val();				// ºñ°í
					p_ID = $("#table_forHeadList tr:eq(" + rowindex + ") td:eq(12)").text();							// ÀÔ°íÀüÇ¥¼ö·®ID

					if(save_line(2) != true){
						return false;
					};
					$(this).children().val(chk == "" ? "V" : "");
					SUPPLY_DISP();
					if($(this).children().val() == ""){
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(6)").children().attr("class", "input_list edit-field edit-number").prop("readonly", false);		// ¼÷¼º
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(7)").children().attr("class", "input_list edit-field edit-number").prop("readonly", false);		// ¹Ú¸®
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(8)").children().attr("class", "input_list edit-field edit-number").prop("readonly", false);		// º¸·ù
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(9)").children().attr("class", "input_list edit-field ins-date").prop("readonly", false);		// ¹Ú¸®ÀÏÀÚ
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(10)").children().attr("class", "input_list edit-field").prop("readonly", false);				// ºñ°í
					}else{
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(6)").children().attr("class", "input_list edit-field edit-number").prop("readonly", true);		// ¼÷¼º
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(7)").children().attr("class", "input_list edit-field edit-number").prop("readonly", true);		// ¹Ú¸®
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(8)").children().attr("class", "input_list edit-field edit-number").prop("readonly", true);		// º¸·ù
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(9)").children().attr("class", "input_list edit-field ins-date").prop("readonly", true);			// ¹Ú¸®ÀÏÀÚ
						$("#table_forHeadList tr:eq(" + rowindex + ") td:eq(10)").children().attr("class", "input_list edit-field").prop("readonly", true);					// ºñ°í
					};
					$("#table_forHeadList tr:eq(" + rowindex + ") td").each(function(){
						if(chk == ""){
							$(this).css("background-color", "#e3e3e3");
						}else{
							$(this).css("background-color", "#ffffff");
						};
					});
				};
			});		// ¹Ú¸®³»¿ë ¿Ï·á½Ã ¾÷µ¥ÀÌÆ® ÀÌº¥Æ® end

            // ------------------------------------------------------------------------
            // °ø±ÞÀÇ·Ú Á¶È¸ ³»¿ë ¼±ÅÃ
            // ------------------------------------------------------------------------
			$("#forBodyList_body").on("click", "tr", function(){
				var rowindex = $(this).index();
				p_item = $("#forBodyList_body tr:eq(" + rowindex + ") td:eq(4)").text();					// Ç°¸í
				p_color = $("#forBodyList_body tr:eq(" + rowindex + ") td:eq(5)").text();					// Ä®¶ó
				p_size = $("#forBodyList_body tr:eq(" + rowindex + ") td:eq(6)").text();					// »çÀÌÁî
				p_item_lot = $("#forBodyList_body tr:eq(" + rowindex + ") td:eq(7)").text();				// ·ÎÆ®¹øÈ£
				p_cnt = parseInt($("#forBodyList_body tr:eq(" + rowindex + ") td:eq(8)").text());			// »ý»ê¼ö·®
				p_Gcnt = parseInt($("#forBodyList_body tr:eq(" + rowindex + ") td:eq(9)").text());			// ¼÷¼º
				WGcnt = parseInt($("#forBodyList_body tr:eq(" + rowindex + ") td:eq(10)").text());			// ¹Ú¸®´ë±â
				p_Gcnt = p_Gcnt + WGcnt;
				p_chk = $("#forBodyList_body tr:eq(" + rowindex + ") td:eq(11)").text();					// ¼±ÅÃ
				p_ID = $("#forBodyList_body tr:eq(" + rowindex + ") td:eq(12)").text();					    // ÀÔ°íÀüÇ¥¼ö·®ID
				if(p_chk == "V"){		// Ã¼Å© ÇØÁ¦, ¹Ú¸®´ë»ó Á¦°Å
					$("#forBodyList_body tr:eq(" + rowindex + ") td:eq(11)").text();
					save_line(4);
				}else{					// Ã¼Å©, ¹Ú¸®´ë»ó Ãß°¡
					$("#forBodyList_body tr:eq(" + rowindex + ") td:eq(11)").text("V");
					save_line(1);
				};
				init_disp();
				SUPPLY_DISP();
			});		// °ø±ÞÀÇ·Ú Á¶È¸ ³»¿ë ¼±ÅÃ end
            
            // ------------------------------------------------------------------------
            // Á¶È¸ ³»¿ë Çì´õ Å¬¸¯À¸·Î Á¤·Ä
            // ------------------------------------------------------------------------
            $("#table_forBodyList").on("click", "th", function(){
                var regex = /[^¤¡-¤¾|¤¿-¤Ó|°¡-ÆR|aA-zZ]/gi;     //  ÇÑ±Û ¿µ¾î¸¸ ÀÔ·Â
                var sort_kind = $(this).text().replace(regex, "");      //  ±×³É $(this).text() ½Ã °ø¹éµî ´Ù¸¥ ¹®ÀÚ°¡ ÀÖ¾î replace·Î ÇÑ±Û¸¸ ³²±â±â
                if(sort_kind == "¼±ÅÃ"){
                    return;
                };
                $("#supply_header_02 > th span").each(function(){      //  this°¡ ¾Æ´Ñ°æ¿ì display none·Î ¾ÆÀÌÄÜ Áö¿ì±â
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
            });     //  Á¶È¸ ³»¿ë Çì´õ Å¬¸¯À¸·Î Á¤·Ä end

            // ------------------------------------------------------------------------
            // input-auto Æ÷Ä¿½º½Ã ½ÇÇà ¾Æ·¡¹æÇâÅ° Æ®¸®°Å ÀÛµ¿À¸·Î °Ë»ö ¸ñ·Ï ÆîÄ¡±â / autocomplete ½ÇÇà
            // ------------------------------------------------------------------------
            $(".input-auto").on("focus", function(){
                if(dontFocus == 0){
                    data_find(this.id);       //  ÀÚµ¿¿Ï¼º ½ÇÇà
                }else{
                    dontFocus = 0;
                    return;
                };
                var e = $.Event("keydown", {
                    keyCode : 40         //  ¾Æ·¡¹æÇâÅ° Å°ÄÚµå 40
                });
                var t_this = this;
                setTimeout(function(){      //  ¹Ù·Î ½ÇÇà½Ã autoFocus ¹ö±×·Î ÀÎÇØ Æ÷Ä¿½º »ç¶óÁü setTimeout ¼³Á¤½Ã ¹ö±× »ç¶óÁü
                    $(t_this).trigger(e);
                }, 100);
                if(this.id == "Ã¢°í¸í"){     // ¿ÀÅäÆ÷Ä¿½º Áö¿ì°í ÀÌ°Å Ãß°¡ÇÔ
                    return;
                }else{
                    $(this).trigger(e);
                };
            });   //  ¾Æ·¡¹æÇâÅ° Æ®¸®°Å end

            $("#Ã¢°í¸í").on("focus", function(){      // ÀÌ°ÉÇØ¾ß ÀÔ·Â°ª°ú »ó°ü¾øÀÌ °Ë»ö¾î Ã¢À» º¸¿©ÁÖ´Âµ¥ ±×·¯¸é autoFocus°¡ °íÀå³²...
                $(this).autocomplete("search", "");             // ±×·¡¼­ autoFocus Áö¿ì°í Æ®¸®°Å·Î autoFocus ´ë½Å Ãß°¡ ÀÛ¼ºÇÔ
            });

            // ------------------------------------------------------------------------
            // input¿¡ Å° ÀÔ·Â½Ã ÀÌº¥Æ® ¿£ÅÍ(move_next)
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
            });   //  Å° ÀÔ·Â½Ã ÀÌº¥Æ® end

            // ------------------------------------------------------------------------
            // class edit-field Ç×¸ñ ¼ýÀÚ¸¸ ÀÔ·ÂÇÏµµ·Ï Àû¿ë
            // ------------------------------------------------------------------------
            // $(".edit-number").on("blur keyup keydown", function(){			// $(".edit-number") ·Î ÇÏ¸é Á¶È¸µÈ ¸®½ºÆ®¿¡¼­ ÀÎ½ÄÀ» ÇÏÁö¸øÇÔ ¿ÖÀÏ±î ?
            $("body").on("blur keyup keydown", ".edit-number", function(){
                // var regex = /[^0-9]/gi;    //  ¼ýÀÚ»©°ï ÀÔ·Â ¾ÈµÊ .µµ¾ÈµÊ
                var regex = /[¤¡-¤¾|¤¿-¤Ó|°¡-ÆR|aA-zZ]/gi;     //  ÇÑ±Û ¿µ¾î¸¸ ¸·±â
                $(this).val($(this).val().replace(regex, ""));
            });   //  ¼ýÀÚ¸¸ ÀÔ·Â end

            // ------------------------------------------------------------------------	
            // ½ÃÀÛ½Ã Æ÷Ä¿½º
            // ------------------------------------------------------------------------	
			$("#Ã¢°í¸í").focus();

			// ------------------------------------------------------------------------
			// datepicker ¼³Á¤
			// ------------------------------------------------------------------------
			$("body").on("focus", ".datepicker", function(){
				$(this).datepicker({
					dateFormat : "yy-mm-dd",
					prevText : "<",
					nextText : ">",
					monthNames : ["1¿ù", "2¿ù", "3¿ù", "4¿ù", "5¿ù", "6¿ù", "7¿ù", "8¿ù", "9¿ù", "10¿ù", "11¿ù", "12¿ù"],
					monthNamesShort : ["1¿ù", "2¿ù", "3¿ù", "4¿ù", "5¿ù", "6¿ù", "7¿ù", "8¿ù", "9¿ù", "10¿ù", "11¿ù", "12¿ù"],
					dayNames : ["ÀÏ", "¿ù", "È­", "¼ö", "¸ñ", "±Ý", "Åä"],
					dayNamesShort : ["ÀÏ", "¿ù", "È­", "¼ö", "¸ñ", "±Ý", "Åä"],
					dayNamesMin : ["ÀÏ", "¿ù", "È­", "¼ö", "¸ñ", "±Ý", "Åä"],
					showMonthAfterYear : true,
					yearSuffix : "³â",
					autoClose : true
				});
				// $(this).datepicker("option", "disbled", true);		// ¿É¼ÇÀ» º¸ÀÌÁö ¾Ê°ÔÇÑ´Ù... ? ÀÎµ¥ ¿©±â¿¡ ¹­¾î¼­ ¾²¸é ¿¡·¯³ª¼­ ¿ù º¯°æÀÌ ¾ÈµÊ ›§À»¶§µµ Â÷ÀÌÁ¡À» ¸ð¸£°ÚÀ½.
			});		// datepicker ¼³Á¤ end

			$("body").on("change", ".datepicker", function(){
				if(jFuncDateValid(this) == false){
					$(this).val("");
					$(this).focus();
					return;
				};
			});		// ÀÔ·Â°ª È®ÀÎ

		}catch(err){
			alert(err.message);
            self.close();
		};
	});



	// ------------------------------------------------------------------------
	// ¹Ú¸®ÀÛ¾÷ ´ë»ó Á¶È¸
	// ------------------------------------------------------------------------
	function init_disp(){
		try{
			var rst = Get_Json("EXEC B_WORK_PEEL_LST 1, '" + $("#Ã¢°í¸í").val() + "', '" + $("#ÀÛ¾÷ÀÏÀÚ").val() + "'");
			var appendHTML = "";
			if(rst[0].SNO == "" || rst[0].SNO == " " || rst[0].SNO == null){
				appendHTML = "<tr><td>Á¶È¸ ³»¿ëÀÌ ¾ø½À´Ï´Ù.</td></tr>";
			}else{
                var rstLength = rst.length > 7 ? 5.1 : 6;
                for(i = 0; i < rst.length; i++){
                    appendHTML += '<tr><td style="width: 3%;">' + rst[i].SNO +'</td><td style="width: 12%;">' + rst[i].Ç°¸í +'</td>'
                                + '<td style="width: 15%;">' + rst[i].Ä®¶ó +'</td><td style="width: 7%;">' + rst[i].»çÀÌÁî +'</td>'
                                + '<td style="width: 10%;">' + rst[i].¾ÆÀÌÅÛ·ÎÆ®¹øÈ£ +'</td><td style="width: 6%;">' + rst[i].»ý»ê¼ö·® +'</td>'
                                + '<td style="width: 6%;"><input type="text" class="input_list edit-field edit-number" name="¼÷¼º" value="' + rst[i].¼÷¼º + '" autocomplete="off"></td>'
                                + '<td style="width: 6%;"><input type="text" class="input_list edit-field edit-number" name="¹Ú¸®" value="' + rst[i].¹Ú¸® + '" autocomplete="off"></td>'
                                + '<td style="width: 6%;"><input type="text" class="input_list edit-field edit-number" name="º¸·ù" value="' + rst[i].º¸·ù + '" autocomplete="off"></td>'
                                + '<td style="width: 9%;"><input type="text" class="input_list edit-field ins-date datepicker" name="¹Ú¸®ÀÏÀÚ" value="' + rst[i].¹Ú¸®ÀÏÀÚ + '" autocomplete="off"></td>'
                                + '<td style="width: 14%;"><input type="text" class="input_list edit-field" name="ºñ°í" value="' + rst[i].ºñ°í + '" autocomplete="off"></td>'
                                + '<td style="width: ' + rstLength + '%;"><input type="text" class="input_list edit-field pack" name="ÀÛ¾÷¿Ï·á" value="' + rst[i].ÀÛ¾÷¿Ï·á + '"></td>'
                                + '<td style="display:none;">' + rst[i].ÀÔ°íÀüÇ¥¼ö·®ID + '</td></tr>'
                };
			};
			$("#forHeadList_body").empty();
			$("#forHeadList_body").append(appendHTML);
			
			// ¼±ÅÃµÈ Çà ¹éµå¶ó¿îµå Ä®¶ó ÁöÁ¤
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
	};		// ¹Ú¸®ÀÛ¾÷ ´ë»ó Á¶È¸ end

	// ------------------------------------------------------------------------
	// °ø±ÞÀÇ·Ú Á¶È¸
	// ------------------------------------------------------------------------
	function SUPPLY_DISP(sortName, sortOrder){
		try{
            sortName = sortName == null ? "" : sortName == undefined ? "" : sortName;		//	sortNameÀÇ ÀÔ·Â°ª ÀÖ´ÂÁö È®ÀÎ
            sortOrder = sortOrder == null ? "" : sortOrder == undefined ? "" : sortOrder;		//	sortOrderÀÇ ÀÔ·Â°ª ÀÖ´ÂÁö È®ÀÎ
			var rst = Get_Json("EXEC B_WORK_PEELING_LST 1, '" + $("#Ã¢°í¸í").val() + "', '" + $("#Á¶È¸ÀÏÀÚ").val() + "', '" + sortName + "', '" + sortOrder + "'");
			console.log("EXEC B_WORK_PEELING_LST 1, '" + $("#Ã¢°í¸í").val() + "', '" + $("#Á¶È¸ÀÏÀÚ").val() + "', '" + sortName + "', '" + sortOrder + "'")
			var appendHTML = "";
			if(rst[0].»ý»êÀÏÀÚ == "" || rst[0].»ý»êÀÏÀÚ == " " || rst[0].»ý»êÀÏÀÚ == null){
				appendHTML = "<tr><td>Á¶È¸ ³»¿ëÀÌ ¾ø½À´Ï´Ù.</td></tr>";
			}else{
                var rstLength = rst.length > 7 ? 7.1 : 8;
                for(i = 0; i < rst.length; i++){
                    appendHTML += '<tr><td style="width: 8%;">' + rst[i].»ý»êÀÏÀÚ +'</td><td style="width: 7%;">' + rst[i].Ã¢°í¸í +'</td>'
                            + '<td style="width: 7%;">' + rst[i].Àåºñ±¸ºÐ +'</td><td style="width: 7%;">' + rst[i].´ã´çÀÚ +'</td>'
                            + '<td style="width: 12%;">' + rst[i].Ç°¸í +'</td><td style="width: 16%;">' + rst[i].Ä®¶ó +'</td>'
                            + '<td style="width: 9%;">' + rst[i].»çÀÌÁî +'</td>' + '<td style="width: 10%;">' + rst[i].·ÎÆ®¹øÈ£ +'</td>'
                            + '<td style="width: 8%;">' + rst[i].»ý»ê¼ö·® +'</td>' + '<td style="width: 8%;">' + rst[i].¼÷¼º +'</td>'
                            + '<td style="width: ' + rstLength + '%;">' + rst[i].¹Ú¸®´ë±â +'</td>' + '<td style="display:none;">' + rst[i].¼±ÅÃ +'</td>'
                            + '<td style="display:none;">' + rst[i].ÀÔ°íÀüÇ¥¼ö·®ID + '</td></tr>'
                };
			};
			$("#forBodyList_body").empty();
			$("#forBodyList_body").append(appendHTML);

			// ¼±ÅÃµÈ Çà ¹é±×¶ó¿îµå Ä®¶ó ÁöÁ¤
			$("#forBodyList_body > tr").each(function(){
				if($("td:eq(11)", this).text() == "V"){
					$("td", this).css("background-color", "#DBD6E8");
				};
			});
			
		}catch(err){
			alert(err.message);
		};
	};		// °ø±ÞÀÇ·Ú Á¶È¸ end

    // ------------------------------------------------------------------------
    // ÇÑÁÙ¾¿ ÀúÀå
    // ------------------------------------------------------------------------
	function save_line(order){		// order 1: °ø±ÞÀÇ·Ú¼­ ¿¡¼­ 1ÁÙ ¼±ÅÃ½Ã ¹Ú¸®´ë»ó Ãß°¡ / 2: ¹Ú¸®´ë»ó ¿Ï·á Ã¼Å©½Ã / 3: ¹Ú¸®´ë»ó ¿¡¼­ ³»¿ë ¼öÁ¤½Ã / 4: ¹Ú¸®´ë»ó ¿¡¼­ Á¦¿Ü(°ø±ÞÀÇ·Ú¼­ ¿¡¼­ ´Ù½Ã ¼±ÅÃ½Ã)
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
			// console.log("EXEC [AA_WORKDIARY_¹Ú¸®] '" + id + "'" + save_data + ", '" + p_ID + "', " + order);
			var insert = Get_Json("EXEC [AA_WORKDIARY_¹Ú¸®] '" + id + "'" + save_data + ", '" + p_ID + "', " + order);
			if(insert[0].VALID == 0){
				if(insert[0].RETURN_INPUT != ""){
                    dontFocus = 1;      // ÀÚµ¿¿Ï¼º È­»ìÇ¥ Æ®¸®°Å¸¸ ÀÛµ¿ÇÏµµ·Ï ÀÛ¾÷
					alert(insert[0].MSG);
					$("#" + insert[0].RETURN_INPUT).focus();
				}else{
					alert(insert[0].MSG);
				};
				return false;
			}else if(insert[0].VALID == 1){
				$("#ÀÛ¾÷½ÃÀÛ½Ã°£").val(insert[0].ÀÛ¾÷½ÃÀÛ½Ã°£);
				$("#ÀÛ¾÷Á¾·á½Ã°£").val(insert[0].ÀÛ¾÷Á¾·á½Ã°£);
				$("#ÀÛ¾÷½Ã°£").val(insert[0].ÀÛ¾÷½Ã°£);

				// °ø¿ë º¯¼ö ºñ¿ì±â
				p_item = "";			// Ç°¸í
				p_color = "";			// Ä®¶ó
				p_size = "";			// »çÀÌÁî
				p_item_lot = "";		// ·ÎÆ®¹øÈ£
				p_cnt = 0;				// »ý»ê¼ö·®
				p_Gcnt = 0;				// ¼÷¼º
				p_chk = "";				// ¼±ÅÃ(°ø±ÞÀÇ·Ú)
				p_ID = "";				// key °ª

				Pcnt = 0;				// ¹Ú¸®
				Wcnt = 0;				// º¸·ù
				WGcnt = 0;				// ¹Ú¸®´ë±â
				p_date = "";			// ¹Ú¸®ÀÏÀÚ
				p_remark = "";			// ºñ°í
				return true;
			};
		}catch(err){
			alert(err.message);
		};
	};		// ÇÑÁÙ¾¿ ÀúÀå end

    // ------------------------------------------------------------------------
    // °Ë»ö¾î ÀÔ·Â ÀÚµ¿¿Ï¼º sql
    // ------------------------------------------------------------------------
	function data_find(id){
		try{
			var t_sql = "EXEC AA_WORKDIARY_Search '', '¹Ú¸®ÀÛ¾÷Ã¢°í', ''";
			var find_rst = "";
			var find_data_array = new Array();
			find_rst = Get_Json(t_sql);
			find_data_array[id] = find_rst;
			if(find_rst["FND_DATA"] == "" || find_rst[0]["FND_DATA"] == " "){
				find_data_array.push("Á¶È¸ ³»¿ëÀÌ ¾ø½À´Ï´Ù. ´ÙÀ½À¸·Î ³Ñ¾î°¡±â");
			}else{
                for(var i in find_rst){
                    find_data_array.push(find_rst[i]["FND_DATA"]);
                };
			};
			autocomplete_abc(find_data_array, id);
		}catch(err){
			alert(err.message);
		};
	};		// °Ë»ö¾î ÀÔ·Â ÀÚµ¿¿Ï¼º sql end

    // ------------------------------------------------------------------------
    // ÀÚµ¿¿Ï¼º ÀüÃ¼ ±¸¹®
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
                // $(this).autocomplete("search", $(this).val());    //  focus½Ã ¹Ù·Î °Ë»öÃ¢ÀÌ ON   Æ®¸®°Å·Î ¾Æ·¡¹æÇâÅ° ´©¸£´Â°Í Ãß°¡ °°ÀÌ ÀÖÀ¸¸é autoFocus °¡ ¹ö±×°É·Á¼­ Æ÷Ä¿½º »ç¶óÁü
			});
		}catch(err){
			alert(err.message);
		};
	};		// ÀÚµ¿¿Ï¼º ÀüÃ¼ ±¸¹® end

    // ------------------------------------------------------------------------
    // ´ÙÀ½Ä­ ÀÌµ¿
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
    };    //  ´ÙÀ½Ä­ ÀÌµ¿ end

    // ------------------------------------------------------------------------
    // Áö±Ý ½Ã°£ ±¸ÇÏ±â
    // ------------------------------------------------------------------------
    function getTime(){
        var date = new Date();
        var hours = ('0' + date.getHours()).slice(-2);
        var minutes = ('0' + date.getMinutes()).slice(-2);
        var timeString = hours + ':' + minutes;
        return timeString;
    };    //  Áö±Ý ½Ã°£ ±¸ÇÏ±â end

    // ------------------------------------------------------------------------
    // ¿À´Ã ³¯Â¥
    // ------------------------------------------------------------------------
    function getDay(){
        var offset = new Date().getTimezoneOffset() * 60000;        // getTimezoneOffset() = ÇöÀç ½Ã°£°úÀÇ Â÷ÀÌ¸¦ ºÐ´ÜÀ§·Î ¹ÝÈ¯ÇÏ±â ¶§¹®¿¡ 1000(¹Ð¸®ÃÊ) * 60(ÃÊ) ·Î °è»êÇÏ¿© ¹Ð¸®ÃÊ ´ÜÀ§·Î °è»ê
        // var date = new Date()       // toISOString() ÇÒ½Ã ±¹Á¦Ç¥ÁØ½Ã·Î º¯È¯ µÇ±â ¶§¹®¿¡ getTimezoneOffset°ú °è»ê
        var date = new Date(Date.now() - offset);       // toISOString() ÇÏ±â Àü ±¹Á¦Ç¥ÁØ½Ã¿Í ÇÑ±¹ ½ÃÂ÷ ¸¸Å­ °ª Ãß°¡ÇÏ±â
        var day = date.toISOString().substring(0, 10);      // ³¯ÀÚ°ª¸¸ ³²±â±â
        return day;
    };    //  ¿À´Ã ³¯Â¥ end


</script>

<head>

<body>

	<div class="Topbtn">
		<div id="title_bar">
			<img id="title_bar_img" src="../image/title/title2.png">
			<p id="t_header">¹Ú¸®ÀÛ¾÷ÀÏÁö</p>
		</div>

		<table class="searchDate">
			<tr>
				<th class="th_search_01">
					<label class="label_tag">Á¦Ç°»ý»êÀÏ</label>
				</th>
				<td class="td_search_01">
					<input type="text" id="Á¶È¸ÀÏÀÚ" class="input_tag datepicker">
				</td>
				<td class="th_search_01">
					<label class="label_tag">ºÎÅÍ</label>
				</td>
			</tr>
		</table>

		<button id="ÀÛ¾÷½ÃÀÛ" class="btn btn_02">
			<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-play-fill" viewBox="0 0 12 12">
				<path d="m11.596 8.697-6.363 3.692c-.54.313-1.233-.066-1.233-.697V4.308c0-.63.692-1.01 1.233-.696l6.363 3.692a.802.802 0 0 1 0 1.393z"/>
			</svg>
			<i class="bi bi-play-fill"></i>
			ÀÛ¾÷½ÃÀÛ
		</button>
		<button id="ÀÛ¾÷Á¾·á" class="btn btn_02 btn_02_2">
			<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-stop-fill" viewBox="0 0 12 12">
				<path d="M5 3.5h6A1.5 1.5 0 0 1 12.5 5v6a1.5 1.5 0 0 1-1.5 1.5H5A1.5 1.5 0 0 1 3.5 11V5A1.5 1.5 0 0 1 5 3.5z"/>
			</svg>
			<i class="bi bi-stop-fill"></i>
			ÀÛ¾÷Á¾·á
		</button>
		<button id="Ãë¼Ò" class="btn btn_03" onclick="self.close();">
			Ãë¼Ò
		</button>

	</div>

	<div class="bottom">
		<div class="date_insert">
            <table class="date">
                <tr>
                    <th class="th_01">
                        <label class="label_tag">ÀÛ¾÷ÀÏÀÚ</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ÀÛ¾÷ÀÏÀÚ" class="input_tag input_tag_date datepicker input-field input_tag_date input_tag_readonly_01" autocomplete="off" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ÀÛ¾÷½Ã°£</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ÀÛ¾÷½Ã°£" class="input_tag input-field" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">Ã¢°í¸í</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="Ã¢°í¸í" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ÀÛ¾÷ÀÚ</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ÀÛ¾÷ÀÚ" class="input_tag input_tag_readonly_01 input_tag_end_01 input-field" tabindex="-1" readonly>
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
                            Ç°¸í<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 15%">
                            Ä®¶ó<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 7%">
                            »çÀÌÁî<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 10%">
                            ·ÎÆ®¹øÈ£<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 6%">
                            »ý»ê¼ö·®<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 6%">
                            ¼÷¼º<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 6%">
                            ¹Ú¸®<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 6%">
                            º¸·ù<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 9%">
                            ¹Ú¸®ÀÏÀÚ<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 14%">
                            ºñ°í<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 6%">
                            ¿Ï·á<span class="ui-icon ui-icon-triangle-1-n">
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
                            »ý»êÀÏÀÚ<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 7%">
                            Ã¢°í¸í<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 7%">
                            Àåºñ±¸ºÐ<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 7%">
                            ´ã´çÀÚ<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 12%">
                            Ç°¸í<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 16%">
                            Ä®¶ó<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 9%">
                            »çÀÌÁî<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 10%">
                            ·ÎÆ®¹øÈ£<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 8%">
                            »ý»ê¼ö·®<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 8%">
                            ¼÷¼º<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 8%">
                            ¹Ú¸®´ë±â<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                    </tr>
                </thead>
                
                <tbody id="forBodyList_body" class="forBodyList_body">
                </tbody>
            </table>
        </div>

	</div>
 
<input type="hidden" id="ÀÛ¾÷½ÃÀÛ½Ã°£" class="input-field">
<input type="hidden" id="ÀÛ¾÷Á¾·á½Ã°£" class="input-field">
<input type="hidden" id="IP_Address" class="input-field">

</body>

</html>