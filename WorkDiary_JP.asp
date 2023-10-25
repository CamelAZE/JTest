<!--#include virtual="N_MAIN/global.asp" -->
<!DOCTYPE html>
<html>
<%
call vFunChkSession(2)	'¼¼¼ÇÃ¼Å© ¹× Áßº¹»ç¿ëÀÚÃ¼Å©     ÇÔ¼öÀ§Ä¡: /INCLUDE/function.asp
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
<title>ÀÛ¾÷ÀÏÁöµî·Ï(Àç´Ü)</title>
<!-- ³»ºÎ¹®¼­ ÂüÁ¶ -->
<script src="../../N_Main/jQuery/jquery-1.12.4.min.js"></script>
<script src="../../N_Main/jQuery/jquery-ui.js"></script>
<script type="text/javascript" src="../erp_func/common_func.js?230103a"></script>
<script type="text/javascript" src="../../N_CSS/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="../../N_CSS/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="../../IncJquery/jquery-ui.min.css">
<!-- datepicker -->

<link rel="stylesheet" type="text/css" href="../../N_CSS/datepicker2.css" />

<style>
    /* ÀüÃ¼ ¿µ¿ª */
    html, body { width: 99.5%; margin: 5px 5px 5px 5px;  }

    /* ¹öÆ° */
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
    /* ºÒ·®·ÎÆ® ´Ý±â */
    .btn_td_01{ width: 100%; height: 36px; line-height: 34px; vertical-align: middle; border: 1px solid #195E9B; border-radius: 3px; background-color: #337ab7; color: #fff; font-weight: bold; font-size: 16px; margin: 0px;  }

    /* °¢ ±¸¿ª ³ª´©±â / ±¸¿ªº° css ÀÛ¾÷ */
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

    /* °ø±ÞÀÇ·Ú¼­ Á¶È¸ */
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
    
    /* Á¶È¸ Á¤·Ä½Ã ¾ÆÀÌÄÜ */
    .ui-icon { zoom: 200%; margin-top: 1px; position: absolute; display: none; background-image: url("../IncJquery/images/ui-icons_ffffff_256x240.png");  }

    /* title */
    #title_bar{ float: left; width:22%; height:60px; margin: 5px 2% 0px 2%; vertical-align: auto; position: relative; background-size: 100%, 42px; background-position: center; background-repeat: no-repeat;  }
    #title_bar_img{ width: 100%; height: 100%;  }
    #t_header{ width: 100%; font-size: 18pt; font-weight: bold; font-family: Noto Sans KR; margin: 0px; color:white; text-align:center; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); letter-spacing: 2.5px;  }

    /* tr ÅÂ±× */
    .tr_hide{ display: none; border-collapse: collapse; width: 100%; background-color: #E0F0FF;  }
    .tr_hide label{ display: block; border: 1px solid #ACCEF2; background-color: #E0F0FF; width: 100%;  }

    /* th ÅÂ±× */
    .th_01{ box-sizing: border-box; width: 7.5%; height: 40px; font-size: 13pt; border-spacing: 0px; text-align: center;  }

    /* td ÅÂ±× */
    .td_01{ box-sizing: border-box; width: 17.5%; height: 40px; font-size: 13pt; border-spacing: 0px;  }
    .td_search_01{ width: 1%;  }
    .td_insertCount_01{ width: 5%;  }
    .td_insertCount_02{ width: 12.5%;  }
    .td_length_01{ width: 12.5%;  }
    .td_length_02{ width: 5%;  }

    /* label */
    label{ display: block; border-radius: 3px; color: #000; height: 34px; max-height: 34px; line-height: 34px; text-align: center; vertical-align: middle; font-weight: bold; white-space: nowrap; margin: 0px;  }

    /* input ÅÂ±× */
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

    $(document).ready(function(){
        try{
            // ------------------------------------------------------------------------
            // ÃÊ±â µ¥ÀÌÅÍ ¼³Á¤
            // ------------------------------------------------------------------------
            window.focus();
            $("#IP_Address").val(IP_Address);
            // ·ÎÆ®¹øÈ£ °Ë»ö½Ã »ç¿ëÇÒ Àü¿ª º¯¼ö ¼±¾ð
            G_LotID = "";

            //  ÀÛ¾÷ Á¾·áµÈ ÀÛ¾÷ÀÏÁö È£Ãâ½Ã »ç¿ëÇÏ´Â ¹øÈ£
            var prk = "<%=junID%>";
            var PDA_rst_length = 0;
            var size_add_cnt = 1;

            if(seSawonid == ""){        //  ºÎ¸ð Ã¢¿¡¼­ Á¤º¸ À¯ÁöÁßÀÎÁö È®ÀÎ
                alert("·Î±×ÀÎ »óÅÂ¸¦ ´Ù½Ã È®ÀÎÇØ ÁÖ¼¼¿ä.");
                self.close();

            }else if(prk != ""){
                //  µ¥ÀÌÅÍºÒ·¯¿À±â
                init_disp(prk);     //  ¹øÈ£ °°ÀÌ Àü´Þ

                //  ±âÃÊ µ¥ÀÌÅÍ
                $("#OLDÀÛ¾÷ÀÏÀÚ").val($("#ÀÛ¾÷ÀÏÀÚ").val());
                $("#ÀÛ¾÷Ãë¼Ò").attr("disabled", true);
                $("#ÀÛ¾÷½ÃÀÛ").attr("disabled", true);
                $("#ÀÛ¾÷¼öÁ¤").css("display","inline");     //  ¼öÁ¤ ÇÒ¼öÀÖµµ·Ï ÀÛ¾÷¼öÁ¤ ¹öÆ° º¸ÀÌ°Ô
                $("#ÀÛ¾÷Á¾·á").attr("disabled", true);
                $("#¾ÆÀÌÅÛ·ÎÆ®¹øÈ£").val("<%=P_Lot_NO%>");
                $(".btn_01_2").css("margin", "30px 1.8% 10px 0px");
                $(".btn_02_2").css("margin", "10px 2% 10px 0px");
                
            }else{
                //  ±âÃÊ µ¥ÀÌÅÍ
                $("#ÀÛ¾÷¼öÁ¤").css("display", "none");      //  ¼öÁ¤ ÇÒ¼öÀÖµµ·Ï ÀÛ¾÷¼öÁ¤ ¹öÆ° º¸ÀÌ°Ô
                $("#¹ß»ýÀÏÀÚ").val(dateString);
                $("#¹ß»ýÀÏÀÚ").attr("min", getDay());       //  ´Þ·Â¿¡¼­ ÀÌÀü ÀÏÀÚ ¼±ÅÃ ºÒ°¡´ÉÇÏµµ·Ï
                $("#¹ß»ýÀÏÀÚ").attr("max", getDay());       //  ´Þ·Â¿¡¼­ ÀÌÈÄ ÀÏÀÚ ¼±ÅÃ ºÒ°¡´ÉÇÏµµ·Ï
                $("#´ã´çÀÚ").val(seSawonname);
                $("#Ã¢°í¸í").val(defaultStocName);
                $("#Àç´ÜLOT").val($("#¹ß»ýÀÏÀÚ").val().replace(/-/gi, "").substring(2));
                // var date = new Date();
                // date.setDate(date.getDate() - 7);       //  7ÀÏÀü ³¯Â¥ °è»ê
                // var oneWeekAgo = date.toISOString().substring(0, 10);       //  °è»ê µÈ ³¯Â¥ YYYY-MM-DD ÇüÀ¸·Î º¯È¯ º¯¼ö¿¡ ¾È´ã°í ¹Ù·Î val() ÇØµµ ¹«°ü
                var searchFirstDate = get_add_date_yyyymmdd('mm', -3);      // 3´Þ ÀüÀ¸·Î ¼öÁ¤
                $("#Á¶È¸ÀÏÀÚºÎÅÍ").val(searchFirstDate);
                $("#Á¶È¸ÀÏÀÚ±îÁö").val(dateString);

                //  ¹Ì¿Ï·á µ¥ÀÌÅÍ È®ÀÎ
                var work_id = work_check($("#Ã¢°í¸í").val(), $("#¹ß»ýÀÏÀÚ").val(), $("#´ã´çÀÚ").val());     //  Ã¢°í¸í, ¹ß»ýÀÏÀÚ, ´ã´çÀÚ ÆÄ¶ó¸ÞÅ¸·Î Àü´Þ

                //  ¹Ì¿Ï·á µ¥ÀÌÅÍ¿¡ µû¶ó ÁøÇàÁß»óÅÂ È¤Àº »õ·Î ÁøÇàÇÒÁö ÁØºñ
                if(work_id != ""){      //  ¹Ì¿Ï·á µ¥ÀÌÅÍ°¡ ÀÖÀ½À¸·Î ÀÛ¾÷ÁøÇà»óÅÂ
                    remain_disp(work_id);       //  ÁøÇàÁßÀÎ workid ÆÄ¶ó¸ÞÅ¸·Î Àü´Þ
                    var prk = 1;        //  ½ÃÀÛ Æ÷Ä¿½º ÁöÁ¤ÇÏÁö ¾Êµµ·Ï prk 1·Î ¼³Á¤ prk Ã£¾Æ°¡¸é ÀÌÀ¯ ¾Ë¼öÀÖÀ½
                    $("#ÀÛ¾÷½ÃÀÛ").attr("disabled", true);

                    //  PAD·Î Àü¼ÛÇÑ ³»¿ªÀÎ °æ¿ì ¼öÁ¤ ºÒ°¡´ÉÇÏµµ·Ï Ã³¸®
                    var PDA_rst = Get_Json("EXEC RF_PDA_CRE_WORKDIARY_CHECK 1, 'Àç´Ü', '" + work_id + "'");
                    PDA_rst_length = PDA_rst.length
                    if(PDA_rst[0].RFÀç´ÜÅõÀÔID == "" || PDA_rst[0].RFÀç´ÜÅõÀÔID == " "){
                        PDA_rst_length = 0;
                    }else{
                        $("#t_header").text($("#t_header").text() + "(PDAÀÛ¾÷)");
                        $("#Ã¢°í¸í, #Àç´ÜÃ³¸í, #Àç´Ü±â, #ÅõÀÔÇ°¸í, #ÅõÀÔÄ®¶ó, #ÅõÀÔ»çÀÌÁî, #Ç°¸í, #Ä®¶ó, #ÅõÀÔ·Ñ¼ö·®").prop("readonly", true);
                        $("#Ã¢°í¸í, #Àç´ÜÃ³¸í, #Àç´Ü±â, #ÅõÀÔÇ°¸í, #ÅõÀÔÄ®¶ó, #ÅõÀÔ»çÀÌÁî, #Ç°¸í, #Ä®¶ó, #ÅõÀÔ·Ñ¼ö·®").addClass("input_tag_readonly_01");
                //	$("#ÅõÀÔ·Ñ±æÀÌ,#ÅõÀÔ·Ñ¼ö·®,#¾ÆÀÌÅÛ·ÎÆ®¹øÈ£").attr("class","input-readonly").prop("readonly",true)   //  ¿øº» ±¸¹®
                        PDA_rst_length = 1;     //  autocomplete ÀÛµ¿ ¾ÈµÇ°Ô
                    };
                }else{
                    $("#ÀÛ¾÷Á¾·á").attr("disabled", true);
                };
                $("#ºÒ·®±¸ºÐ1").val("01:Á¤»ó");
                $("#OutID").val("");
            };    //  ÃÊ±â µ¥ÀÌÅÍ ¼³Á¤ end

            // ------------------------------------------------------------------------
            // ÀÛ¾÷½ÃÀÛ ¹öÆ° Å¬¸¯
            // ------------------------------------------------------------------------
            $("#ÀÛ¾÷½ÃÀÛ").on("click", function(){
                if(save("G_Workdiary") == true){        //  ÀÛ¾÷ ½ÃÀÛ ÈÄ ¹öÆ° Á¦¾î
                    $("#ÀÛ¾÷½ÃÀÛ").attr("disabled", true);
                    $("#ÀÛ¾÷Á¾·á").attr("disabled", false);
                    $("#ºÒ·®±¸ºÐ1").val("01:Á¤»ó");
                };
            });   //  ÀÛ¾÷½ÃÀÛ ¹öÆ° end

            // ------------------------------------------------------------------------
            // ÀÛ¾÷Á¾·á ¹öÆ° Å¬¸¯
            // ------------------------------------------------------------------------
            $("#ÀÛ¾÷Á¾·á").on("click", function(){
                // if(stock_chk($("#ÅõÀÔÇ°¸í").val(), $("#ÅõÀÔÄ®¶ó").val(), $("#ÅõÀÔ»çÀÌÁî").val(), $("#ÅõÀÔ¼ö·®").val() - $("#OLDÅõÀÔ¼ö·®").val()) == false){      // ÀÛ¾÷ÀÏÁö ³»¿¡¼­ ¼öÁ¤ÇÒ°æ¿ì OLDÅõÀÔ¼ö·® ÀÌ ÇÊ¿ä ±×·¸Áö ¾Ê±â¶§¹®¿¡ »èÁ¦
                if(stock_chk($("#ÅõÀÔÇ°¸í").val(), $("#ÅõÀÔÄ®¶ó").val(), $("#ÅõÀÔ»çÀÌÁî").val(), $("#ÅõÀÔ¼ö·®").val()) == false){
                    alert("ÅõÀÔÇ° Àç°í¼ö·®ÀÌ ºÎÁ·ÇÕ´Ï´Ù.\nÀç°í¼ö·® È®ÀÎ ÈÄ ÅõÀÔÇÏ¼¼¿ä.");
                    $("#ÅõÀÔ·Ñ¼ö·®").focus();
                    return false;
                }else{
                    if($("#sizeAdd").val() == 1){       //  »çÀÌÁî Ãß°¡ »óÈ²ÀÏ ¶§
                        if(save("G_WorkDiary_Sub") != true){
                            return false;
                        };
                    }else{
                        if(save("G_WorkDiary") != true){		//	±âº» ÀúÀå
                            return false;
                        };
                    };
                };
                
                // $(opener.location).attr("href", "javascript:searchOnDblclickHandler();");        //  ¿øº» ±¸¹®¿¡ ÀÖ´Â ±â´É   °Ë»ö³»¿ë ´õºíÅ¬¸¯½Ã °Ë»ö°ªÁö¿öÁö¸ç ¸®¹ÙÀÎµå ¶ó°í ¼³¸íµÇ¾îÀÖÀ½(IncJs/GlobEventHandler.js)

                alert("ÀúÀåµÇ¾ú½À´Ï´Ù.");
                if(confirm("´Ù¸¥ »çÀÌÁî¸¦ Ãß°¡·Î µî·ÏÇÏ½Ã°Ú½À´Ï±î ?") == true){
                    $("#sizeAdd").val(1);
                    $("#ÀÛ¾÷½ÃÀÛ").val("disabled", true);
                    $("#ÀÛ¾÷Á¾·á").val("disabled", false);
                    if(size_add_cnt == 1){      //  Ã¹¹øÂ° »çÀÌÁî Ãß°¡ÀÏ½Ã ¿øº» Workid ÀúÀå
                        $("#workid_ori").val($("#WorkID").val());
                    };
                    size_add_cnt = size_add_cnt + 1;
                    // ÀúÀåÈÄ ÀÏºÎ ³»¿ë »èÁ¦ / ÅõÀÔ¼ö·®ÀÌ Áßº¹ Ã¼Å© µÇ´Â »çÇ× ÀÖ´Ù°íÇÔ
                    $(".input-field, .input-number").not("#¹ß»ýÀÏÀÚ, #Àç´ÜÃ³¸í, #Àç´Ü±â, #Ç°¸í, #Ä®¶ó, #ÅõÀÔÇ°¸í, #ÅõÀÔÄ®¶ó, #ÅõÀÔ»çÀÌÁî, #ÇÊ¸§LOT, #»ý»êLOT, #Àç´ÜLOT, #·Ñ±æÀÌ, #´ÜÀ§, #ºñ°í").each(function(){
                        if($(this).attr("type") == "text" || $(this).attr("type") == "date"){
                            $(this).val("");
                        }; 
                    });
                    $("#ÀÛ¾÷½ÃÀÛ½Ã°£").val($("#ÀÛ¾÷Á¾·á½Ã°£").val());
                    $("#forList_body").empty();
                    $("#ºÒ·®±¸ºÐ1").val("01:Á¤»ó");
                }else{
                    opener.main_bind();
                    self.close();
                };
            });   //  ÀÛ¾÷Á¾·á ¹öÆ° end

            // ------------------------------------------------------------------------
            // ÀÛ¾÷Ãë¼Ò ¹öÆ° Å¬¸¯
            // ------------------------------------------------------------------------
            $("#ÀÛ¾÷Ãë¼Ò").on("click", function(){
                if(confirm("Á¤¸» Ãë¼ÒÇÏ½Ã°Ú½À´Ï±î ?") == true){
                    if($("#ÀÛ¾÷½ÃÀÛ½Ã°£").val() == ""){     //  ÀÛ¾÷½ÃÀÛ½Ã°£ À¯¹«·Î ÀÛ¾÷ ½ÃÀÛ À¯¹« È®ÀÎ
                        alert("ÀÛ¾÷ÀÌ ½ÃÀÛµÇ¾ú´ÂÁö ´Ù½Ã È®ÀÎÇØÁÖ¼¼¿ä.");
                    }else{
                        var wareHouse = $("#Ã¢°í¸í").val();
                        var delSawonName = $("#´ã´çÀÚ").val();
                        var delGubun = 5;         //  1 : ¾ÐÃâ, 2 : ÇÕÆ÷, 3 : ÄÚÆÃ, 4 : ºÐ´Ü, 5 : Àç´Ü
                        var delWorkId = $("#WorkID").val();
                        var rst = Get_Json("EXEC RF_JAE_PDA_RFÀç´ÜÅõÀÔ_ERP_CLEAR '" + delSawonName   + "', '" + delGubun + "', '" + delWorkId + "'");
                        alert(rst[0].MSG);
                        location.reload();
                    };
                };
            });   //  ÀÛ¾÷Ãë¼Ò ¹öÆ° end

            // ------------------------------------------------------------------------
            // ÀÛ¾÷¼öÁ¤ ¹öÆ° Å¬¸¯
            // ------------------------------------------------------------------------
            $("#ÀÛ¾÷¼öÁ¤").on("click", function(){
                $(".input-field, .input-number").attr("disabled", false);
                $("#ÀÛ¾÷Á¾·á").attr("disabled", false);
                $("#ÀÛ¾÷¼öÁ¤").attr("disabled", true);

            });   //  ÀÛ¾÷¼öÁ¤ ¹öÆ° Å¬¸¯ end

            // ------------------------------------------------------------------------
            // class input-number Ç×¸ñ ¼ýÀÚ¸¸ ÀÔ·ÂÇÏµµ·Ï Àû¿ë
            // ------------------------------------------------------------------------
            $(".input-number").on("blur keyup keydown", function(){
                // var regex = /[^0-9]/gi;    //  ¼ýÀÚ»©°ï ÀÔ·Â ¾ÈµÊ .µµ¾ÈµÊ
                var regex = /[¤¡-¤¾|¤¿-¤Ó|°¡-ÆR|aA-zZ]/gi;     //  ÇÑ±Û ¿µ¾î¸¸ ¸·±â
                $(this).val($(this).val().replace(regex, ""));
            });   //  ¼ýÀÚ¸¸ ÀÔ·Â end

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
            // autocomplete Ç°¸í °Ë»ö ÆäÀÌÁö ·Îµå½Ã ¹Ù·Î½ÇÇà
            // ------------------------------------------------------------------------
            item_sql = "";      // ¾ÆÀÌÅÛ ·¹ÄÚµå¼Â Àü¿ªº¯¼ö
            var item_json = Get_Json_common_direct("EXEC [AA_WORKDIARY_Search2] '', 'Ç°¸í', ''");       // json Çüº¯È¯ ÇÏ¿© °¡Á®¿À´Â Ç°¸í Àü¿ë °Ë»ö sql
            // ¿Ï·áÈÄ Get_Json_After ÇÔ¼ö°¡ ½ÇÇàµÇ°í ±×¶§ item_sql ¿¡ µ¥ÀÌÅÍ µé¾î°¨

            // ------------------------------------------------------------------------
            // input-auto Æ÷Ä¿½º½Ã ½ÇÇà ¾Æ·¡¹æÇâÅ° Æ®¸®°Å ÀÛµ¿À¸·Î °Ë»ö ¸ñ·Ï ÆîÄ¡±â / autocomplete ½ÇÇà
            // ------------------------------------------------------------------------
            $(".input-auto").on("focus", function(){
                //if(PDA_rst_length == 0){		//	PDA·Î ºÒ·¯¿Â °æ¿ì ½ÇÇàµÇÁö ¾Êµµ·Ï 0ÀÎ°æ¿ì¿¡ ½ÇÇà		//	PDA ³»¿ªÀ¸·Î ºÒ·¯¿Ã°æ¿ì PDA_rst_length = 1 ·Î ¼±¾ðÇÔ
                    if(dontFocus == 0){
                    data_find(this.id, item_sql);       //  ÀÚµ¿¿Ï¼º ½ÇÇà
                    }else{
                        dontFocus = 0;
                        return;
                    };
                    var e = $.Event("keydown", {
                        keyCode : 40         //  ¾Æ·¡¹æÇâÅ° Å°ÄÚµå 40
                    });
                    var t_this = this;		//	setTimeout¿¡¼­ this ¸¦ »ç¿ëÇÏ¸é this°ªÀÌ º¯ÇÏ±â ¶§¹®¿¡ »çÀü¿¡ this¸¦ t_this¿¡ ´ã±â
                    setTimeout(function(){      //  ¹Ù·Î ½ÇÇà½Ã autoFocus ¹ö±×·Î ÀÎÇØ Æ÷Ä¿½º »ç¶óÁü setTimeout ¼³Á¤½Ã ¹ö±× »ç¶óÁü
                        $(t_this).trigger(e);
                    }, 100);
                    if(this.id == "Àç´ÜÃ³¸í" || this.id == "Àç´Ü±â"){     // ¿ÀÅäÆ÷Ä¿½º Áö¿ì°í ÀÌ°Å Ãß°¡ÇÔ
                        return;
                    }else{
                        $(this).trigger(e);
                    };
                // };
            });   //  ¾Æ·¡¹æÇâÅ° Æ®¸®°Å end
            
            $("#Àç´ÜÃ³¸í, #Àç´Ü±â").on("focus", function(){      // ÀÌ°ÉÇØ¾ß ÀÔ·Â°ª°ú »ó°ü¾øÀÌ °Ë»ö¾î Ã¢À» º¸¿©ÁÖ´Âµ¥ ±×·¯¸é autoFocus°¡ °íÀå³²...
                $(this).autocomplete("search", "");             // ±×·¡¼­ autoFocus Áö¿ì°í Æ®¸®°Å·Î autoFocus ´ë½Å Ãß°¡ ÀÛ¼ºÇÔ
            });
            
            // ------------------------------------------------------------------------
            // °ø±ÞÀÇ·ÚÀÏ Á¶È¸
            // ------------------------------------------------------------------------
            $("#Á¶È¸ÀÏÀÚºÎÅÍ, #Á¶È¸ÀÏÀÚ±îÁö").on("change", function(){
				if(jFuncDateValid(this) == true){
                    SUPPLY_DISP($("#Ç°¸í").val(), $("#Ä®¶ó").val(), $("#»çÀÌÁî").val());
				}else if(this.id == "Á¶È¸ÀÏÀÚºÎÅÍ"){
                    $("#Á¶È¸ÀÏÀÚºÎÅÍ").val(get_add_date_yyyymmdd('mm', -3));
					return false;
				}else if(this.id == "Á¶È¸ÀÏÀÚ±îÁö"){
                    $("#Á¶È¸ÀÏÀÚ±îÁö").val(dateString);
					return false;
                };
            });     //  °ø±ÞÀÇ·ÚÀÏ Á¶È¸ end

            // ------------------------------------------------------------------------
            // °ø±ÞÀÇ·Ú ¼±ÅÃ Ã¼Å©Ç¥½Ã, ¹é±×¶ó¿îµå »öÁöÁ¤
            // ------------------------------------------------------------------------
            $("#forList_body").on("click", "td", function(){
                var rowIndex = $(this).parent().parent().children().index($(this).parent()) + 1;        //  Å×ÀÌºí ÀüÃ¼¿¡¼­ 0¹øÂ°´Â Çì´õÀÌ±â ¶§¹®¿¡ 1¹øÂ° index¸¦ ÁÖ±âÀ§ÇØ +1
                var cnt = parseInt($("#table_forList tr:eq(" + rowIndex + ") td:eq(7)").text());
                var chk = $("#table_forList tr:eq(" + rowIndex + ") td:eq(8)");     //  .text()·Î ÁáÀ»¶§ °ª ¼öÁ¤ ÇÏ·Á¸é chk º¯¼ö¿¡¼­ .text()¸¦ ÅëÇØ ¼öÁ¤ÀÌ ºÒ°¡´ÉÇØ¼­ .text()¸¦ µû·Î »ç¿ë
                var OutID = $("#table_forList tr:eq(" + rowIndex + ") td:eq(9)").text();
                var work_cnt = $("#ÀÛ¾÷¼ö·®").val() == "" ? 0 : parseInt($("#ÀÛ¾÷¼ö·®").val());
                if(chk.text() == "?"){     //  ÀÌ¹Ì Ã¼Å©Ç¥½Ã°¡ ÀÖ´Â °æ¿ì ÀÌÀüÀ¸·Î µ¹¸®±â
                    chk.text("");
                    $("#ÀÛ¾÷¼ö·®").val(work_cnt - cnt);
                    $("#OutID").val("");
                    if(checkEven(rowIndex)){        //  È¦¼ö¹øÂ° ÁÙÀÎÁö Â¦¼ö¹øÂ° ÁÙÀÎÁö È®ÀÎÇÏ°í ¹è°æ»ö ÁöÁ¤
                        $("#table_forList tr:eq(" + rowIndex + ")").css("background-color", "#eee");
                    }else{
                        $("#table_forList tr:eq(" + rowIndex + ")").css("background-color", "#fff");
                    };
                }else{      //  Ã¼Å©Ç¥½Ã
                    chk.text("?");
                    $("#ÀÛ¾÷¼ö·®").val(work_cnt + cnt);
                    $("#OutID").val(OutID);
                    $("#table_forList tr:eq(" + rowIndex + ")").css("background-color", "#DBD6E8");
                };
            });     //  °ø±ÞÀÇ·Ú ¼±ÅÃ end
            
            // ------------------------------------------------------------------------
            // °ø±ÞÀÇ·Ú Çì´õ Å¬¸¯À¸·Î Á¤·Ä
            // ------------------------------------------------------------------------
            $("#table_forList").on("click", "th", function(){
                var regex = /[^¤¡-¤¾|¤¿-¤Ó|°¡-ÆR|aA-zZ]/gi;     //  ÇÑ±Û ¿µ¾î¸¸ ÀÔ·Â
                var sort_kind = $(this).text().replace(regex, "");      //  $(this).text() ½Ã °ø¹éµî ´Ù¸¥ ¹®ÀÚ°¡ ÀÖ¾î replace·Î ÇÑ±Û¸¸ ³²±â±â
                if(sort_kind == "¼±ÅÃ"){
                    return;
                };
                $("#supply_header > th span").each(function(){      //  this°¡ ¾Æ´Ñ°æ¿ì display none·Î ¾ÆÀÌÄÜ Áö¿ì±â
                    if($(this).parent().text().replace(regex, "") != sort_kind){
                        $(this).css("display", "none");
                    };
                });
                if($(this).children().css("display") == "none"){		//	Á¤·Ä ¼±ÅÃÀÌ µÇ¾î ÀÖÁö ¾ÊÀ»¶§ ¾ÆÀÌÄÜ À¯¹«·Î ÆÇº°
                    $(this).children().css("display", "inline").attr("class", "ui-icon ui-icon-triangle-1-n");
                    SUPPLY_DISP($("#Ç°¸í").val(), $("#Ä®¶ó").val(), $("#»çÀÌÁî").val(), sort_kind, "ASC");
                }else{
                    if($(this).children().hasClass("ui-icon-triangle-1-n") == true){		//	Å¬·¡½º À¯¹«·Î ¾ÆÀÌÄÜÀÇ ¸ð¾ç ÆÇº°ÈÄ Á¤·Ä ¼ø¼­ ¼±ÅÃ
                        $(this).children().attr("class", "ui-icon ui-icon-triangle-1-s");
                        SUPPLY_DISP($("#Ç°¸í").val(), $("#Ä®¶ó").val(), $("#»çÀÌÁî").val(), sort_kind, "DESC");
                    }else{
                        $(this).children().attr("class", "ui-icon ui-icon-triangle-1-n");
                        SUPPLY_DISP($("#Ç°¸í").val(), $("#Ä®¶ó").val(), $("#»çÀÌÁî").val(), sort_kind, "ASC");
                    };
                };
            });     //  °ø±ÞÀÇ·Ú Çì´õ Å¬¸¯À¸·Î Á¤·Ä end

            // ------------------------------------------------------------------------
            // Á¤»ó¼ö·®, ºÒ·®¼ö·® ÀÚµ¿°è»ê
            // ------------------------------------------------------------------------
            $('.auto_sum').on("change", function roll_sum(){
                if($("#·Ñ±æÀÌ").val() == "" || $("#·Ñ±æÀÌ").val() == "0"){      //  ·Ñ±æÀÌ ÀÔ·Â Ã¼Å©
                    alert("·Ñ±æÀÌ´Â ÇÊ¼ö ÀÔ·Â Ç×¸ñÀÔ´Ï´Ù.");
                    $("#·Ñ±æÀÌ").focus();
                    return false;
                };
                var roll_good = 0;      //  Á¤»ó¼ö·®¿¡ ´ãÀ» º¯¼ö
                var roll_bad = 0;       //  ºÒ·®¼ö·®¿¡ ´ãÀ» º¯¼ö
                for(i = 1; i < 9; i++){     //  1~ 8±îÁö ¹Ýº¹
                    if($("#·Ñ¼ö·®" + i).val() + "" != ""){      //  ·Ñ¼ö·® ÀÔ·Â Ã¼Å©
                        if($("#ºÒ·®±¸ºÐ" + i).val() == ""){     //  ·Ñ¼ö·®À» ÀÔ·ÂÇß´Âµ¥ ºÒ·®±¸ºÐÀ» ÀÔ·ÂÇÏÁö ¾ÊÀº°æ¿ì
                            alert("ºÒ·®±¸ºÐÀ» ¸ÕÀú ÀÔ·ÂÇØ ÁÖ¼¼¿ä.");
                            $("#·Ñ¼ö·®" + i).val("");		//	·Ñ¼ö·®ÀÌ ÀÛ¼ºµÇ¾îÀÖÀ¸¸é ºÒ·®±¸ºÐÀÇ °ªÀÌ °è»êµÇ±â ¶§¹®¿¡ ·Ñ¼ö·® Á¦°Å
                            $("#ºÒ·®±¸ºÐ" + i).focus();
                        }else{      //  ÀÔ·Â°ª °è»ê
                            roll_good = roll_good + ($("#ºÒ·®±¸ºÐ" + i).val() == "01:Á¤»ó" ? parseInt($("#·Ñ¼ö·®" + i).val()) : 0);     //  Á¤»óÀÇ °æ¿ì ·Ñ ¼ö·® °è»ê
                            roll_bad = roll_bad + ($("#ºÒ·®±¸ºÐ" + i).val() != "01:Á¤»ó" ? parseInt($("#·Ñ¼ö·®" + i).val()) : 0);       //  Á¤»óÀÌ ¾Æ´Ñ °æ¿ì ·Ñ ¼ö·® °è»ê
                        };
                    };
                };
                $("#Á¤»ó¼ö·®").val(parseInt($("#·Ñ±æÀÌ").val()) * roll_good);       //  Á¤»ó¼ö·® ÀüÃ¼ °è»ê °ª ´ëÀÔ
                $("#ºÒ·®¼ö·®").val(parseInt($("#·Ñ±æÀÌ").val()) * roll_bad);        //  ºÒ·®¼ö·® ÀüÃ¼ °è»ê °ª ´ëÀÔ
            });   //  ¼ö·® ÀÚµ¿°è»ê end

            // ------------------------------------------------------------------------
            // ÅõÀÔ¼ö·® ÀÚµ¿°è»ê
            // ------------------------------------------------------------------------
            $("#ÅõÀÔ·Ñ¼ö·®, #·Ñ±æÀÌ").on("change", function(){
                if($("#·Ñ±æÀÌ").val() == "" || $("#·Ñ±æÀÌ").val() == "0"){      //	·Ñ±æÀÌ ÀÔ·Â Ã¼Å©
                    alert("·Ñ±æÀÌ´Â ÇÊ¼ö ÀÔ·Â Ç×¸ñÀÔ´Ï´Ù.");
                    $("#·Ñ±æÀÌ").focus();
                    $("#ÅõÀÔ¼ö·®").val("");
                    return false;
                };
                if($("#ÅõÀÔ·Ñ¼ö·®").val() != "" && $("#ÅõÀÔ·Ñ¼ö·®").val() != "0"){		//	ÅõÀÔ·Ñ¼ö·® ÀÔ·Â Ã¼Å©
                    $("#ÅõÀÔ¼ö·®").val(parseInt($("#·Ñ±æÀÌ").val()) * parseInt($("#ÅõÀÔ·Ñ¼ö·®").val()));		//	ÅõÀÔ¼ö·® ÀÚµ¿ °è»ê
                }else{
                    $("#ÅõÀÔ·Ñ¼ö·®").val(0);
                };
            });     //  ÅõÀÔ¼ö·® ÀÚµ¿°è»ê end

            // ------------------------------------------------------------------------
            // ÅõÀÔ¼ö·® OLD ÀúÀå
            // ------------------------------------------------------------------------
            $("#ÅõÀÔ¼ö·®").focusin(function(){
                if((prk > 1) && ($("#OLDÀÛ¾÷ÀÏÀÚ").val() == $("#ÀÛ¾÷ÀÏÀÚ").val())){
                    if($("#ÅõÀÔ¼ö·®").val() == "0"){
                        $("#OLDÅõÀÔ¼ö·®").val($("#ÅõÀÔ¼ö·®").val());
                    };
                };
            });

            // ------------------------------------------------------------------------	
            // ½ÃÀÛ½Ã Æ÷Ä¿½º
            // ------------------------------------------------------------------------	
            if(prk + "" == ""){     //  ºÒ·¯¿Ã ÀÛ¾÷ÀÌ ¾øÀ»¶§¸¸ ½ÇÇàµÇ´Â°ÍÀÌ³ª ¸¶Âù°¡Áö
                $("#Àç´ÜÃ³¸í").focus();
            };    //  ½ÃÀÛ½Ã Æ÷Ä¿½º end

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
					$(this).val(getDay());
					$(this).focus();
					return;
				};
			});		// ÀÔ·Â°ª È®ÀÎ



        }catch(err){
            alert(err.message);
        };    //  catch end
    });     //  document.reaty end

    // ------------------------------------------------------------------------
    // ÀÐ±âÀü¿ë µ¥ÀÌÅÍ ºÒ·¯¿À±â
    // ------------------------------------------------------------------------
    function init_disp(id){
        try{
            var rst = Get_Json("B_WORK_LST_BUN 'G_WorkDiary', " + id);
            if(rst[0].WorkID == "" || rst[0].WorkID == " " || rst[0].WorkID == null){
                alert("ÀÛ¾÷ÀÏÁö°¡ µî·ÏµÇÁö ¾Ê¾Ò½À´Ï´Ù.");
                self.close();
            }else{
                $("#WorkID").val(rst[0].WorkID);
                $("#Ã¢°í¸í").val(rst[0].Ã¢°í¸í);
                $(".input-field, .input-number").each(function(){
                    $(this).attr("disabled", true);      //  ÀÐ±â Àü¿ëÀ¸·Î ºÒ·¯¿À±â
                    if($(this).attr("type") == "text" || $(this).attr("type") == "date" || $(this).attr("type") == "textarea" || $(this).attr("type") == "hidden"){
                        var field = rst[0][this.id] + "";
                        field = ((field == 0 || field == "null") ? "" : field);
                        if(this.id == "¹ß»ýÀÏÀÚ"){
                            $("#" + this.id).val(field.substring(0, 10));       //  db¿¡ ÀúÀåµÈ ÀÛ¾÷ÀÏÀÚ¿¡ ½Ã°£°ª Á¦°Å
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
    };    // ÀÐ±âÀü¿ë µ¥ÀÌÅÍ end

    // ------------------------------------------------------------------------
    // ´çÀÏ ¹Ì¿Ï·á ÀÛ¾÷ÀÏÁö ¹øÈ£ È£Ãâ
    // ------------------------------------------------------------------------
    function work_check(war_name ,work_date, worker){
        try{
            var rst = Get_Json("B_WORK_CHECK 'G_WorkDiary', '" + war_name + "', '" + work_date + "', '" + worker + "'");

            if(rst[0].WORKID != " "){       //  WORKID °¡ ÀÖ´ÂÁö ¾ø´ÂÁö È®ÀÎ
                var valid = rst[0].WORKID + "";
            }else{
                valid = "";
            };
            return valid;
        }catch(err){
            alert(err.message);
        };
    };    //  ´çÀÏ ¹Ì¿Ï·á ÀÛ¾÷ÀÏÁö ¹øÈ£ end

    // ------------------------------------------------------------------------
    // ¹Ì¿Ï·á ÀÛ¾÷ÀÏÁö ºÒ·¯¿À±â
    // ------------------------------------------------------------------------
    function remain_disp(id){
        try{
            var rst = Get_Json("B_WORK_LST_REMAIN 'G_WorkDiary'," + id);		//	Àç´ÜÀÛ¾÷ ÁøÇàÁßÀÎ°Í ÀÖ´ÂÁö Ã¼Å© »çÀÌÁî Ãß°¡·çÆ¾Àº È®ÀÎÇÏÁö ¾ÊÀ½ ½ÃÀÛ¹öÆ° ÀÚÃ¼°¡ º°µµ·Î ¾øÀ½
            if(rst[0].WorkID != ""){
                $("#WorkID").val(rst[0].WorkID);
                $("#Ã¢°í¸í").val(rst[0].Ã¢°í¸í);
                $(".input-field, .input-number, .input-readonly").each(function(){
                    if($(this).attr("type") == "text" || $(this).attr("type") == "date" || $(this).attr("type") == "textarea" || $(this).attr("type") == "hidden"){
                        var field = rst[0][this.id] + "";
                        field = ((field == 0 || field == "null") ? "" : field);
                        if(this.id == "¹ß»ýÀÏÀÚ"){
                            $("#" + this.id).val(field.substring(0, 10));       //  db¿¡ ÀúÀåµÈ ¹ß»ýÀÏÀÚ¿¡ ½Ã°£°ª Á¦°Å
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
    };    // ¹Ì¿Ï·á ÀÛ¾÷ÀÏÁö ºÒ·¯¿À±â end

    // ------------------------------------------------------------------------
    //  Àç°í Ã¼Å©
    // ------------------------------------------------------------------------
    function stock_chk(item, color, size, cnt){
        if(item == "" || color == "" || size == "" || cnt == "" || size.includes("³­´Ü") == true){
            return true;
        };
        var enabled;
        var date = $("#¹ß»ýÀÏÀÚ").val();
        var wareID = $("#Ã¢°í¸í").val() == "Àç´ÜÃ¢°í" ? 8 : $("#Ã¢°í¸í").val() == "»óÇ°Ã¢°í" ? 14 : 7;
        //  GET_ITEMZIZE ÀÚÃ¼°¡ ´À·Á ID 3°³¸¸ °¡Á®¿Ã°ÍÀÌ±â ¶§¹®¿¡ select ±¸¹® µû·Î ÀÛµ¿
        // var rst_item = Get_Json("SELECT * FROM [dbo].[Get_ITEMSIZE](1) WHERE ¾ÆÀÌÅÛÇ°¸í = '" + item + "' AND Ä®¶ó = '" + color + "' AND »çÀÌÁî = '" + size + "'");
        // console.log("SELECT * FROM [dbo].[Get_ITEMSIZE](1) WHERE ¾ÆÀÌÅÛÇ°¸í = '" + item + "' AND Ä®¶ó = '" + color + "' AND »çÀÌÁî = '" + size + "'");
        // var itemID = rst_item[0].¾ÆÀÌÅÛID;
        // var colorID = rst_item[0].Ä®¶óID;
        // var sizeID = rst_item[0].»çÀÌÁîID;
        var rst_itemid = Get_Json("SELECT ¾ÆÀÌÅÛID FROM H_¾ÆÀÌÅÛ WHERE ¾ÆÀÌÅÛÇ°¸í = '" + item + "'");
        var rst_colorid = Get_Json("SELECT detailid FROM C_Ä®¶ó WHERE detailname = '" + color + "'");
        var rst_sizeid = Get_Json("SELECT detailid FROM C_»çÀÌÁî WHERE detailname = '" + size + "'");
        var itemID = rst_itemid[0].¾ÆÀÌÅÛID;
        var colorID = rst_colorid[0].detailid;
        var sizeID = rst_sizeid[0].detailid;
        var rst = Get_Json("EXEC [H_Stock_NEW_CHUL_CHECK_RST] '" + date + "', '" + wareID + "', '" + itemID + "', '" + colorID + "', '" + sizeID + "', '" + cnt + "', 'Àç´ÜÅõÀÔÀüÇ¥', 0");
        console.log("EXEC [H_Stock_NEW_CHUL_CHECK_RST] '" + date + "', '" + wareID + "', '" + itemID + "', '" + colorID + "', '" + sizeID + "', '" + cnt + "', 'Àç´ÜÅõÀÔÀüÇ¥', 0");
        enabled = rst[0].ENABLED;       // Àç°í »óÅÂ¿¡ µû¶ó »ç¿ë°¡´ÉÀÏ½Ã 1 ºÒ°¡´ÉÀÏ½Ã 0 ÀÌ ¹ÝÈ¯µÊ
        return enabled;
    };

    // ------------------------------------------------------------------------
    //  ÀúÀå
    // ------------------------------------------------------------------------
    function save(table){
        try{
            var id = seSawonid;
            var WorkID = $("#WorkID").val();
            var t_val = "";
            var save_data = "";
            $('.input-field, .input-number, .input-readonly').each(function(){		//	ÀúÀå ´ë»óÀÇ input Ç×¸ñ Ã¼Å©
                if($(this).attr("type") == "text" || $(this).attr("type") == "date" || $(this).attr("type") == "hidden" || $(this).attr("type") == "textarea"){
                    t_val = $(this).val();
                }else if($(this).attr("type") == "checkbox"){
                    t_val = $(this).is(":checked") == true ? 1 : 0;
                }else if($(this).attr("type") == "select-one"){
                    t_val = $(this).val() == null ? 0 : $(this).val();
                };
                save_data += ", '" + t_val + "'";		//	Ã¼Å©ÇÏ¸ç ÀÔ·Â°ª º¯¼ö¿¡ ´ã±â
            });
            var insert = Get_Json("EXEC [AA_WORKDIARY_Àç´Ü] '" + id + "', '" + WorkID + "'" + save_data + ", '" + table + "'");		//	ÀúÀå sp ½ÇÇà
            if(insert[0].VALID == 0){		//	sql ½ÇÇà½Ã validation ¹®Á¦ÀÖÀ»°æ¿ì ¸Þ¼¼Áö¿Í Æ÷Ä¿½º°ª °¡Á®¿À±â
                dontFocus = 1;      // ÀÚµ¿¿Ï¼º È­»ìÇ¥ Æ®¸®°Å¸¸ ÀÛµ¿ÇÏµµ·Ï ÀÛ¾÷
                alert(insert[0].MSG);
                $("#" + insert[0].RETURN_INPUT).focus();
                return false;
            }else if(insert[0].VALID == 1){		//	ÀúÀå ¼º°ø½Ã µ¥ÀÌÅÍ ¹ÝÈ¯
                $("#ÀÛ¾÷½ÃÀÛ½Ã°£").val(insert[0].ÀÛ¾÷½ÃÀÛ½Ã°£);
                $("#ÀÛ¾÷Á¾·á½Ã°£").val(insert[0].ÀÛ¾÷Á¾·á½Ã°£);
                $("#ÀÛ¾÷½Ã°£").val(insert[0].ÀÛ¾÷½Ã°£);
                $("#WorkID").val(insert[0].WorkID);
                return true;
            };
        }catch(err){
            alert(err.message);
        };
    };    //  save end

    // ------------------------------------------------------------------------
    // Ç°¸í autocomplete Àü¿ªº¯¼ö Àç ¼±¾ð       // common_func.js ÀÇ Get_Json_Done() ¿¡¼­ ÀÛµ¿µÊ
    // ------------------------------------------------------------------------
    function Get_Json_After(temp_rst){
        // console.log("Get_Json_After");
        item_json = temp_rst;
        // console.log(item_json);
        item_sql = item_json;
    };      // Ç°¸í Àü¿ª¹ø¼ö Àç ¼±¾ð end
    
    // ------------------------------------------------------------------------
    // ·ÎÆ®¹øÈ£ °Ë»ö³»¿ë °¡Á®¿ÂÈÄ ½ÇÇà          // common_func.js ÀÇ Get_Json_Done2() ¿¡¼­ ÀÛµ¿µÊ
    // ------------------------------------------------------------------------
    function Get_Json_After2(temp_rst){
        var t_find_data_array = new Array();
        if(temp_rst.length <= 1 && !temp_rst[0].valueOf() == "" ){        //  µ¥ÀÌÅÍ°¡ ¾ø´Â°æ¿ì move_next ¹ßµ¿½ÃÅ°Å°À§ÇÑ ´ÙÀ½À¸·Î ³Ñ¾î°¡±â »ðÀÔ
            t_find_data_array.push("Á¶È¸ ³»¿ëÀÌ ¾ø½À´Ï´Ù. ´ÙÀ½À¸·Î ³Ñ¾î°¡±â");
        }else{
            for(var i in temp_rst){
                t_find_data_array.push(temp_rst[i]["FieldName"]);
            };
        };
        $("#"+ G_LotID).css("background-color", "#ffffff");
        autocomplete_dbc(t_find_data_array, G_LotID);
        // ·ÎÆ®¹øÈ£ÀÇ °æ¿ì Áß°£¿¡ return ÇØ¼­ µû·Î ½ÇÇàµÇ±â ¶§¹®¿¡ Æ®¸®°Å ÀçÀÛ¼º
        var e = $.Event("keydown", {        // autocomplete ¿Ï·á½Ã °Ë»ö³»¿ë È®Àå µÇµµ·Ï ¾Æ·¡¹æÇâÅ° Æ®¸®°Å ¸¸µé±â
            keyCode : 40         //  ¾Æ·¡¹æÇâÅ° Å°ÄÚµå 40   µÚ¿¡ ¼¼¹ÌÄÝ·Ð ºÙÀÌ¸é ¿À·ù³²
        });
        setTimeout(function(){      //  ¹Ù·Î ½ÇÇà½Ã autoFocus ¹ö±×·Î ÀÎÇØ Æ÷Ä¿½º »ç¶óÁü setTimeout ¼³Á¤½Ã ¹ö±× »ç¶óÁü
            $("#" + G_LotID).trigger(e);        // ¾Æ·¡ ¹æÇâÅ° Æ®¸®°Å ÀÛµ¿
        }, 100);
    };

    // ------------------------------------------------------------------------
    // °Ë»ö¾î ÀÔ·Â ÀÚµ¿¿Ï¼º sql
    // ------------------------------------------------------------------------
    function data_find(id, item_sql){
        try{
            var item = "";
            var color = "";
            var size = "";
            var t_sql = "";
            var Stoc = $("#Ã¢°í¸í").val();
            var gubun = "";
            if(id == "Àç´ÜÃ³¸í" || id == "Àç´Ü±â" || id.includes("ºÒ·®±¸ºÐ")){		//	Àç´ÜÃ³¸í, Àç´Ü±â, ºÒ·®±¸ºÐ ÀÇ °æ¿ì ½ÇÇà sql¹® ÁöÁ¤
                gubun = id == "Àç´ÜÃ³¸í" ? "Àç´ÜÃ³¸í" : id == "Àç´Ü±â" ? "Àç´Ü±â" : "ºÒ·®±¸ºÐ";
                t_sql = "EXEC AA_WORKDIARY_Search '', '" + gubun + "', ''";
            }else if(id == "Ä®¶ó" || id == "ÅõÀÔÄ®¶ó"){		//	Ä®¶ó, ÅõÀÔÄ®¶ó ÀÇ °æ¿ì ½ÇÇà sql¹® ÁöÁ¤
                item = id == "Ä®¶ó" ? "Ç°¸í" : "ÅõÀÔÇ°¸í";
                if($("#" + item).val() == ""){
                    dontFocus = 1;      // ÀÚµ¿¿Ï¼º È­»ìÇ¥ Æ®¸®°Å¸¸ ÀÛµ¿ÇÏµµ·Ï ÀÛ¾÷
                    alert(item + "À» ÀÔ·ÂÇØ ÁÖ¼¼¿ä.");
                    $("#" + item).focus();
                    return false;
                }else{
                    t_sql = "EXEC AA_WORKDIARY_Search '', 'Ä®¶ó', '" + $("#" + item).val() + "'";
                };
            }else if(id == "»çÀÌÁî" || id == "ÅõÀÔ»çÀÌÁî" || id == "³­´Ü»çÀÌÁî"){		//	»çÀÌÁî, ÅõÀÔ»çÀÌÁî, ³­´Ü»çÀÌÁî ÀÇ °æ¿ì ½ÇÇà sql¹® ÁöÁ¤
                item = id == "»çÀÌÁî" ? "Ç°¸í" : "ÅõÀÔÇ°¸í";		//	»çÀÌÁî, ÅõÀÔ»çÀÌÁî ¿¡ µû¶ó ¸ÂÃçÁÙ Ç°¸í ÁöÁ¤
                color = id == "»çÀÌÁî" ? "Ä®¶ó" : "ÅõÀÔÄ®¶ó";
                if(($("#" + item).val() == "" || $("#" + color).val() == "") && id != "³­´Ü»çÀÌÁî"){		//	»çÀü ÀÔ·Â ¿ä¼Ò È®ÀÎ ³­´Ü»çÀÌÁîÀÇ °æ¿ì Ç°¸í°ú °ü°è ¾ø±â ¶§¹®¿¡ Á¦¿Ü
                    dontFocus = 1;      // ÀÚµ¿¿Ï¼º È­»ìÇ¥ Æ®¸®°Å¸¸ ÀÛµ¿ÇÏµµ·Ï ÀÛ¾÷
                    var focus = $("#" + item).val() == "" ? item : color;
                    alert(focus + "À» ÀÔ·ÂÇØ ÁÖ¼¼¿ä.");
                    $("#" + focus).focus();
                    return false;
                }else{
                    if(id == "»çÀÌÁî"){
                        t_sql = "EXEC AA_WORKDIARY_Search '', 'Àç´Ü', '" + $("#" + item).val() + "'";
                    }else if(id == "ÅõÀÔ»çÀÌÁî"){
                        t_sql = "EXEC AA_WORKDIARY_Search '', 'ÅõÀÔ', '" + $("#" + item).val() + "'";
                    }else if(id == "³­´Ü»çÀÌÁî"){
                        t_sql = "EXEC AA_WORKDIARY_Search '', '³­´Ü', ''";
                    };
                };
            }else if(id == "»ý»êLOT"){		//	»ý»êLOT ÀÇ °æ¿ì ½ÇÇà sql¹® ÁöÁ¤
                if($("#ÅõÀÔÇ°¸í").val() == "" || $("#ÅõÀÔÄ®¶ó").val() == "" || $("#ÅõÀÔ»çÀÌÁî").val() == ""){		//	»çÀü ÀÔ·Â ¿ä¼Ò È®ÀÎ
                    // dontFocus = 1;      // ÀÚµ¿¿Ï¼º È­»ìÇ¥ Æ®¸®°Å¸¸ ÀÛµ¿ÇÏµµ·Ï ÀÛ¾÷
                    // alert("ÅõÀÔÇ° ÀÔ·Â Á¤º¸¸¦ ÀçÈ®ÀÎ ÇØÁÖ¼¼¿ä.");
                    // var focus = $("#ÅõÀÔÇ°¸í").val() == "" ? "ÅõÀÔÇ°¸í" : $("#ÅõÀÔÄ®¶ó").val() == "" ? "ÅõÀÔÄ®¶ó" : "ÅõÀÔ»çÀÌÁî";
                    // $("#" + focus).focus();
                    return false;
                }else{
                    t_sql = "EXEC [AA_WORKDIARY_LOTNO] '', '" + $("#´ã´çÀÚ").val() + "', '" + $("#ÅõÀÔÇ°¸í").val() + "', '" + $("#ÅõÀÔÄ®¶ó").val() + "', '" + $("#ÅõÀÔ»çÀÌÁî").val() + "', '" + Stoc + "'";
                };
            };
            console.log(t_sql)
            var find_rst = "";		//	½ÇÇà½ÃÅ³ sql¹® ´ãÀ» º¯¼ö ÁöÁ¤
            var find_data_array = new Array();		//	sqlÀÇ Á¤º¸ ¹ÝÈ¯ ¹ÞÀ» µ¥ÀÌÅÍ Array »ý¼º
            var find_unit_array = new Array();		//	Ç°¸íÀÇ ´ÜÀ§ ¹ÝÈ¯ ¹ÞÀ» µ¥ÀÌÅÍ Array »ý¼º
            var find_roll_array = new Array();		//	Ç°¸íÀÇ ±æÀÌ ¹ÝÈ¯ ¹ÞÀ» µ¥ÀÌÅÍ Array »ý¼º
            if(id.includes("Ç°¸í")){		//	Ç°¸íÀÇ °æ¿ì ÆäÀÌÁö ·Îµå½Ã ¹Ù·Î sql ½ÇÇàÇÏ¿© ´ã¾ÆµÎ¾î ÇÔ¼ö ½ÇÇà º¯¼ö·Î ¹Þ¾Æ¿Â°Í »ç¿ë
                find_rst = item_sql;
            }else if(id == "»ý»êLOT"){
                //Get_Json_Before() // ÇÁ·Î±×·¡½º¹Ù ½ÇÇà
                $("#"+ id).css("background-color", "#eee");
                Get_Json_common_direct2(t_sql);
                G_LotID = id;
                // °¡Á®¿À±â¿Ï·áÈÄ Get_Json_After2 ½ÇÇàµÊ
                return;
            }else{		//	±× ¿ÜÀÇ °æ¿ì sql¹® Get_Json()À¸·Î ½ÇÇà
                find_rst = Get_Json(t_sql);
            };
            find_data_array[id] = find_rst;
            if(id == "ÀÛ¾÷±¸ºÐ"){		//	ÀÛ¾÷±¸ºÐÀÇ °æ¿ì Á÷Á¢ µ¥ÀÌÅÍ ÀÛ¼º
                find_data_array = ["°ø±ÞÀÇ·Ú", "»ùÇÃÃâ°í", "°¡°øÃâ°í"];
            }else if(id == "Ç°¸í" || id == "ÅõÀÔÇ°¸í"){
                if(find_rst[0]["FND_DATA"] ==  ""){        //  µ¥ÀÌÅÍ°¡ ¾ø´Â°æ¿ì move_next ¹ßµ¿½ÃÅ°Å°À§ÇÑ ´ÙÀ½À¸·Î ³Ñ¾î°¡±â »ðÀÔ
                    find_data_array.push("Á¶È¸ ³»¿ëÀÌ ¾ø½À´Ï´Ù. ´ÙÀ½À¸·Î ³Ñ¾î°¡±â");
                }else{
                    for(var i in find_rst){     //  Ç°¸íÀÇ °æ¿ì ·Ñ ±æÀÌ¿Í ´ÜÀ§±îÁö Á¶È¸ÇØ¼­ °¡Á®¿À±â ¶§¹®¿¡ ¹è¿­·Î key ¿Í value ¸¦ Á÷Á¢ ÁöÁ¤½ÃÅ´
                        find_data_array.push({label : find_rst[i]["FND_DATA"], value : find_rst[i]["FND_DATA"], unit : find_rst[i]["unitName"], roll : find_rst[i]["rollName"]});
                    };
                };
            }else if(id == "»ý»êLOT"){
                if(find_rst[0]["FieldName"] == "" || find_rst[0]["FieldName"] == " "){
                    find_data_array.push("Á¶È¸ ³»¿ëÀÌ ¾ø½À´Ï´Ù. ´ÙÀ½À¸·Î ³Ñ¾î°¡±â");
                }else{
                    for(var i in find_rst){		//	»ý»êLOTÀÇ °æ¿ì ÁöÁ¤ÇÑ º°Äª(AS(Alias))ÀÌ ´Ù¸£±â ¶§¹®¿¡ ´Ù¸£°Ô ÀÛ¼º
                        find_data_array.push(find_rst[i]["FieldName"]);
                    };
                };
            }else{
                if(find_rst[0]["FND_DATA"] == "" || find_rst[0]["FND_DATA"] == " "){
                    find_data_array.push("Á¶È¸ ³»¿ëÀÌ ¾ø½À´Ï´Ù. ´ÙÀ½À¸·Î ³Ñ¾î°¡±â");
                }else{
                    for(var i in find_rst){		//	¿Ü¿¡ °æ¿ì¿¡ ¸ðµÎ °°Àº º°Äª(AS(Alias))¸¦ »ç¿ëÇÏ¿´±â¿¡ ¾Ë¸Â°Ô º¯¼ö¿¡ ´ã±â
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
    // ÀÚµ¿¿Ï¼º ÀüÃ¼ ±¸¹®
    // ------------------------------------------------------------------------
    function autocomplete_dbc(find_data_array, id){
        try {
            $("#" + id).autocomplete({    // autocomplete ½ÃÀÛ
                source : find_data_array,    //  ÀÚµ¿¿Ï¼º¿¡ ³ÖÀ» ÀÚ·á
                select : function(event, ui){   //  ÀÚ·á ¼±ÅÃ½Ã ÀÌº¥Æ®      $(this).val()Àº ÀÌ¹Ì ÀÔ·ÂµÈ °ªÀ» ÀÛ¼ºÇÏ¿© ÀÛµ¿ÇÏ°ÔµÊ ¼±ÅÃÇÏ±â ÀüÀÇ °ªÀÌ Àü´ÞµÊ / ui.item.value·Î ÀÛ¼º½Ã ¼±ÅÃÇÑ °ªÀ¸·Î ÆÄ¶ó¸ÞÅ¸ Àü´Þ
                    $("#" + id).val(ui.item.value);
                    if(this.id == "Àç´ÜÃ³¸í"){
                        var date = new Date();
                        if(ui.item.value == "Àç´Ü¶óÀÎ"){        //  Àç´Ü¶óÀÎÀÏ °æ¿ì ¼¼ÆÃ
                            $("#Ã¢°í¸í").val("Àç´ÜÃ¢°í");
                            $("#search_title").html("°ø±ÞÀÇ·ÚÀÏ");
                            // date.setDate(date.getDate() - 7);       //  7ÀÏÀü ³¯Â¥ °è»ê
                            // var oneWeekAgo = date.toISOString().substring(0, 10);       //  °è»ê µÈ ³¯Â¥ YYYY-MM-DD ÇüÀ¸·Î º¯È¯ º¯¼ö¿¡ ¾È´ã°í ¹Ù·Î val()¿¡ ´ã¾Æµµ ¹«°ü
                            //  toISOString() ¾²¸é ±âº»°ªÀÌ ¼¼°è Ç¥ÁØ½Ã·Î ¹Ù²î¾î¼­ °è»ê°ªÀÌ ´Þ¶óÁü > get_add_date_yyyymmdd »ç¿ë
                            var searchFirstDate = get_add_date_yyyymmdd('mm', -3);      // 3´ÞÀü À¸·Î ¼öÁ¤
                            $("#Á¶È¸ÀÏÀÚºÎÅÍ").val(searchFirstDate);
                            $("#Á¶È¸ÀÏÀÚ±îÁö").val(dateString);
                            $("#Àç´ÜLOT").val($("#¹ß»ýÀÏÀÚ").val().replace(/-/gi, "").substring(2));
                            $("#»ý»êLOT").val("");
                        }else if(ui.item.value == "Áö¿ø¶óÀÎ"){      //  Áö¿ø¶óÀÎÀÏ °æ¿ì ¼¼ÆÃ
                            $("#Ã¢°í¸í").val("»óÇ°Ã¢°í");
                            $("#Àç´Ü±â").val("¼ÒÆø ½½¸®ÅÍ 2¹ø");
                            $("#search_title").html("Ãâ°íÀÇ·ÚÀÏ");
                            // date.setDate(date.getDate() + 2);       //  2ÀÏÈÄ ³¯Â¥ °è»ê
                            // var twoDaysLater = date.toISOString().substring(0, 10);     // °è»ê µÈ ³¯Â¥ YYYY-MM-DD ÇüÀ¸·Î º¯È¯ º¯¼ö¿¡ ¾È´ã°í ¹Ù·Î val()¿¡ ´ã¾Æµµ ¹«°ü
                            var twoDaysLater = get_add_date_yyyymmdd('dd', +2);      // 2ÀÏ ÈÄ ³¯Â¥ °è»ê
                            $("#Á¶È¸ÀÏÀÚºÎÅÍ").val(dateString);
                            $("#Á¶È¸ÀÏÀÚ±îÁö").val(twoDaysLater);
                            $("#»ý»êLOT").val($("#¹ß»ýÀÏÀÚ").val().replace(/-/gi, "").substring(2));
                            $("#Àç´ÜLOT").val("");
                            $("#Ç°¸í").focus();     //  Áö¿ø¶óÀÎÀÇ °æ¿ì Àç´Ü±âµµ ÀÛ¼ºÀ» ÇØÁÖ±â ¶§¹®¿¡ Ç°¸íÀ¸·Î Æ÷Ä¿½º ÀÌµ¿ÇÏ°í move_next ¹ßµ¿ÇÏÁö ¾Êµµ·Ï return false; À¸·Î Å»Ãâ
                            return false;       //  ÀÛ¼º ¾ÈÇÏ¸é move_next ¹ßµ¿À¸·Î Ä®¶ó ±îÁö °¡°Ô µÊ
                        }else{		//	ÇÕÆ÷¶óÀÎÀÏ °æ¿ì ¼¼ÆÃ
                            $("#Ã¢°í¸í").val("ÇÕÆ÷Ã¢°í");
                        };
                    };
                    if(this.id == "Ç°¸í" || this.id == "ÅõÀÔÇ°¸í"){     //  Ç°¸í ÀÔ·Â½Ã ·Ñ±æÀÌ, ´ÜÀ§, ÅõÀÔÇ°¸í ±îÁö ÀüÃ¼ ÀÔ·Â
                        $("#·Ñ±æÀÌ").val(ui.item.roll);
                        $("#´ÜÀ§").val(ui.item.unit);
                        if(id == "Ç°¸í"){		//	Ç°¸í ÀÔ·Â½Ã ÅõÀÔÇ°¸íµµ ÀÔ·Â
                            $("#ÅõÀÔÇ°¸í").val(ui.item.value);
                        };
                    };
                    if(this.id == "Ä®¶ó" || this.id == "ÅõÀÔÄ®¶ó"){		//	Ä®¶ó ÀÔ·Â½Ã ÅõÀÔÄ®¶óµµ ÀÔ·Â
                        $("#ÅõÀÔÄ®¶ó").val(ui.item.value);
                    };
                    if(this.id == "»çÀÌÁî"){		//	»çÀÌÁî ÀÔ·Â½Ã ÀÇ·Ú¼­ Á¶È¸
                        SUPPLY_DISP($("#Ç°¸í").val(), $("#Ä®¶ó").val(), ui.item.value);
                    };
                    var t_this = this;		//	setTimeout¿¡¼­ this ¸¦ »ç¿ëÇÏ¸é this°ªÀÌ º¯ÇÏ±â ¶§¹®¿¡ »çÀü¿¡ this¸¦ t_this¿¡ ´ã±â
                    setTimeout(function(){		//	setTimeoutÀ» °ÉÁö ¾ÊÀ¸¸é À§ÀÇ ³»¿ëÀÌ Á¤»ó ½ÇÇàµÇÁö ¾ÊÀ»¶§°¡ ÀÖÀ½
                        move_next(t_this);		//	´ÙÀ½ ÀÔ·Â Ç×¸ñÀ¸·Î ÀÌµ¿ ½ÇÇà
                    }, 100);
                },
                focus : function(event, ui){    //  focus ½Ã ÀÌº¥Æ®    ÇÑ±Û°ú »ç¿ë½Ã ³ª¸ÓÁö°¡ »ç¶óÁö´Â ¹ö±×°¡ ÀÖ´Ù ? ¸®ÅÏÆÞ½º½Ã ¹«½ÃÇÑ´Ù°íÇÔ
                    return false;
                },
                change : function(event, ui){    //  change ½Ã ÀÌº¥Æ®
                    if(id == "Ç°¸í" || id == "ÅõÀÔÇ°¸í"){       //  Ç°¸í, ÅõÀÔÇ°¸í ÀÔ·Â½Ã ÀÔ·Â°ª È®ÀÎ
                        if(autocom_valid("Ç°¸í", $(this).val(), "") == "0"){
                            dontFocus = 1;      // ÀÚµ¿¿Ï¼º È­»ìÇ¥ Æ®¸®°Å¸¸ ÀÛµ¿ÇÏµµ·Ï ÀÛ¾÷
                            $(this).val("");
                            $(this).focus();
                            if(id == "Ç°¸í"){
                                $("#ÅõÀÔÇ°¸í").val("");
                            };
                            return false;
                        };
                    };
                    if(id == "Ä®¶ó" || id == "ÅõÀÔÄ®¶ó"){		//	Ä®¶ó, ÅõÀÔÄ®¶ó ÀÔ·Â½Ã ÀÔ·Â°ª È®ÀÎ
                        item = id == "Ä®¶ó" ? "Ç°¸í" : "ÅõÀÔÇ°¸í";
                        if(autocom_valid("Ä®¶ó", $(this).val(), $("#" + item).val()) == "0"){
                            dontFocus = 1;      // ÀÚµ¿¿Ï¼º È­»ìÇ¥ Æ®¸®°Å¸¸ ÀÛµ¿ÇÏµµ·Ï ÀÛ¾÷
                            $(this).val("");
                            $(this).focus();
                            if(id == "Ä®¶ó"){
                                $("#ÅõÀÔÄ®¶ó").val("");
                            };
                            return false;
                        };
                    };
                    if(this.id == "»çÀÌÁî" || this.id == "ÅõÀÔ»çÀÌÁî"){		//	»çÀÌÁî, ÅõÀÔ»çÀÌÁî ÀÔ·Â½Ã ÀÔ·Â°ª È®ÀÎ
                        item = id == "»çÀÌÁî" ? "Ç°¸í" : "ÅõÀÔÇ°¸í";
                        var t_this = this;
                        setTimeout(function(){
                            if(autocom_valid("»çÀÌÁî", $(t_this).val(), $("#" + item).val()) == "0"){
                                if($(t_this).val() != ""){
                                    if($(t_this).val().includes("³­´Ü")){
                                        // ³­´ÜÀÌ Æ÷ÇÔµÈ °æ¿ì º§¸®µå°¡ ÀÏÄ¡ÇÏÁö ¾Ê¾Æµµ ³Ñ¾î°¡µµ·Ï ¿ÀÅ»ÀÚ Ã³¸®´Â ¾î¶»°ÔÇÏÁö ?
                                        // ÀúÀå SP¿¡¼­ ¿ÀÅ»ÀÚ µî È®ÀÎ À§ÇØ ÅõÀÔ»çÀÌÁî Àç°Ë»ö ÇÏ¿© ÀÏÄ¡ÇÏ´ÂÁö È®ÀÎ ±¸¹® ÀÛ¼ºÇÔ
                                    }else{
                                        dontFocus = 1;      // ÀÚµ¿¿Ï¼º È­»ìÇ¥ Æ®¸®°Å¸¸ ÀÛµ¿ÇÏµµ·Ï ÀÛ¾÷
                                        alert("ÀÔ·Â°ªÀÌ ¿Ã¹Ù¸£Áö ¾Ê½À´Ï´Ù.");
                                        $(t_this).val("");
                                        $(t_this).focus();
                                        return false;
                                    };
                                };
                            };
                        }, 200);
                    };
                    if($(this).val().includes("´ÙÀ½À¸·Î")){       //  move_next ¹ßµ¿¿ë ÀÔ·Â°ª »èÁ¦
                        $(this).val("");
                    };
                },
                minLength : 0,    //  ÃÖ¼Ò ±ÛÀÚ ¼ö
                // autoFocus : true,   //  true·Î ¼³Á¤ ½Ã Ã¹ ¹øÂ° Ç×¸ñ¿¡ ÀÚµ¿ Æ÷Ä¿½º
                classes : {   //  À§Á¬ ¿ä¼Ò¿¡ Ãß°¡ ÇÒ Å¬·¡½º ÁöÁ¤
                    'ui-autocomplete' : 'highlight'
                },
                delay : 100,    //  ÀÛµ¿ Áö¿¬½Ã°£
                disable : false,    //  true ½Ã ÀÚµ¿¿Ï¼º ±â´É ²¨Áü
                position : {    //  À§Ä¡
                    my : 'left top',
                    at : 'left bottom',
                    collision : "flip"      //  È­¸é ¾îµò°¡¿Í Ãæµ¹½Ã Ãæµ¹ÇÏÁö ¾Ê´Â ¹æÇâÀ¸·Î ÆîÄ¡±â
                }
            }).focus(function(){
                // if(this.id == "Àç´ÜÃ³" || this.id == "Àç´Ü±â"){
                //     $(this).autocomplete("search", "");    //  focus½Ã ¹Ù·Î °Ë»öÃ¢ÀÌ ON   Æ®¸®°Å·Î ¾Æ·¡¹æÇâÅ° ´©¸£´Â°Í Ãß°¡ °°ÀÌ ÀÖÀ¸¸é autoFocus °¡ ¹ö±×°É·Á¼­ Æ÷Ä¿½º »ç¶óÁü
                // }else{
                //     $(this).autocomplete("search", $(this).val());    //  focus½Ã ¹Ù·Î °Ë»öÃ¢ÀÌ ON   Æ®¸®°Å·Î ¾Æ·¡¹æÇâÅ° ´©¸£´Â°Í Ãß°¡ °°ÀÌ ÀÖÀ¸¸é autoFocus °¡ ¹ö±×°É·Á¼­ Æ÷Ä¿½º »ç¶óÁü
                // };
            });
        }catch(err){
            alert(err.message);
        };
    };    //  autocomplete_dbc end

    // ------------------------------------------------------------------------
    // ÀÚµ¿¿Ï¼º valid check
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
    };    //  ÀÚµ¿¿Ï¼º valid check end

    // ------------------------------------------------------------------------
    // °ø±ÞÀÇ·Ú¼­ Á¶È¸
    // ------------------------------------------------------------------------
    function SUPPLY_DISP(item, color, size, sortName, sortOrder){
        try{
            if(color == "" || size == ""){
                return false;
            };
            sortName = sortName == null ? "" : sortName == undefined ? "" : sortName;		//	sortNameÀÇ ÀÔ·Â°ª ÀÖ´ÂÁö È®ÀÎ
            sortOrder = sortOrder == null ? "" : sortOrder == undefined ? "" : sortOrder;		//	sortOrderÀÇ ÀÔ·Â°ª ÀÖ´ÂÁö È®ÀÎ
            var rst = Get_Json("B_WORK_SUPPLY_LST 1, '" + item + "', '" + color + "', '" + size + "', '" + $("#Á¶È¸ÀÏÀÚºÎÅÍ").val() + "', '" + $("#Á¶È¸ÀÏÀÚ±îÁö").val() + "', '"
                                                        + ($("#Àç´ÜÃ³¸í").val() == "Àç´Ü¶óÀÎ" ? 1 : 2) + "', '"
                                                        + sortName + "', '" + sortOrder + "'");
            console.log("B_WORK_SUPPLY_LST 1, '" + item + "', '" + color + "', '" + size + "', '" + $("#Á¶È¸ÀÏÀÚºÎÅÍ").val() + "', '" + $("#Á¶È¸ÀÏÀÚ±îÁö").val() + "', '"
                                                        + ($("#Àç´ÜÃ³¸í").val() == "Àç´Ü¶óÀÎ" ? 1 : 2) + "', '"
                                                        + sortName + "', '" + sortOrder + "'");
            var appendHTML = "";
            if(rst[0].Ãâ°íÀÇ·ÚÀÏ == "" || rst[0].Ãâ°íÀÇ·ÚÀÏ == " " || rst[0].Ãâ°íÀÇ·ÚÀÏ == null){       //  Á¶È¸ ³»¿ëÀÌ ¾ø´Â °æ¿ì
                appendHTML += "<tr><td>Á¶È¸ ³»¿ëÀÌ ¾ø½À´Ï´Ù</td></tr>";
            }else{
                if(rst.length > 10){
                    for(i = 0; i < rst.length; i++){
                        appendHTML += '<tr><td style="width: 9%;">' + rst[i].°ø±ÞÀÇ·ÚÀÏ + '</td><td style="width: 9%;">' + rst[i].Ãâ°íÀÇ·ÚÀÏ + '</td><td style="width: 11%;">' + rst[i].°ø±ÞÀÇ·Ú¹øÈ£
                            + '</td><td style="width: 19%;">' + rst[i].°Å·¡Ã³¸í + '</td><td style="width: 13%;">' + rst[i].Ç°¸í + '</td><td style="width: 15%;">' + rst[i].°ø±Þ¼ö·®
                            + '</td><td style="width: 10%;">' + rst[i].Àç´Ü¼ö·® + '</td><td style="width: 8%;" class="number">' + rst[i].ÀÜ¿©¼ö·®
                            + '</td><td class="select" style="width: 5.1%;"></td><td style="display:none">' + rst[i].OUTID + '</td></tr>';
                    };
                }else{
                    for(i = 0; i < rst.length; i++){
                        appendHTML += '<tr><td style="width: 9%;">' + rst[i].°ø±ÞÀÇ·ÚÀÏ + '</td><td style="width: 9%;">' + rst[i].Ãâ°íÀÇ·ÚÀÏ + '</td><td style="width: 11%;">' + rst[i].°ø±ÞÀÇ·Ú¹øÈ£
                            + '</td><td style="width: 19%;">' + rst[i].°Å·¡Ã³¸í + '</td><td style="width: 13%;">' + rst[i].Ç°¸í + '</td><td style="width: 15%;">' + rst[i].°ø±Þ¼ö·®
                            + '</td><td style="width: 10%;">' + rst[i].Àç´Ü¼ö·® + '</td><td style="width: 8%;" class="number">' + rst[i].ÀÜ¿©¼ö·®
                            + '</td><td class="select" style="width: 6%;"></td><td style="display:none">' + rst[i].OUTID + '</td></tr>';
                    };
                };
            };
            $("#forList_body").empty();
            $("#forList_body").append(appendHTML);
        }catch(err){
            alert(err.message);
        };
    };      //  °ø±ÞÀÇ·Ú¼­ Á¶È¸ end

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
    // ºÒ·®·ÎÆ® ¿­±â        onfocus ·Î ÀÛµ¿		¿­°í ´Ý±â ÀÛµ¿ Á¶°ÇÀÌ ´Þ¶ó ÇÏ³ª·Î ÇÕÄ¡¸é °íÀå³²
    // ------------------------------------------------------------------------
    function openLine(num){
        $(".tr_hide_0" + num).css("display", "table-row");
    };      //  ºÒ·®·ÎÆ® ¿­±â end

    // ------------------------------------------------------------------------
    // ºÒ·®·ÎÆ® ´Ý±â        onclick ·Î ÀÛµ¿
    // ------------------------------------------------------------------------
    function closeLine(num){
        $(".tr_hide_0" + num).css("display", "none");
    };      //  ºÒ·®·ÎÆ® ´Ý±â end

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

    // ------------------------------------------------------------------------
    // È¦Â¦ ±¸ºÐÇÏ±â
    // ------------------------------------------------------------------------
    function checkEven(num){        //  È¦¼ö°¡ µé¾î¿À¸é 0(false) Â¦¼ö°¡ µé¾î¿À¸é 1(true)
        return (num % 2 == 0);
    };      //  È¦Â¦ ±¸ºÐÇÏ±â end

</script>


</head>

<body>
  
    <div class="TopBtn">
        <div id="title_bar">
            <img id="title_bar_img" src ="../image/title/title2.png">
            <p id="t_header">Àç´ÜÀÛ¾÷ÀÏÁö</p>
        </div>

        <table class="searchDate">
            <tr>
                <th class="th_01">
                    <label id="search_title" class="label_tag">°ø±ÞÀÇ·ÚÀÏ</label>
                </th>
                <td class="td_01">
                    <input type="text" id="Á¶È¸ÀÏÀÚºÎÅÍ" class="input_tag input_tag_date datepicker" max="9999-12-31" min="1970-01-01" autocomplete="off">
                </td>
                <td class="td_01 td_search_01">
                    <label class="label_tag">ºÎÅÍ</label>
                </td>
                <td class="td_01">
                    <input type="text" id="Á¶È¸ÀÏÀÚ±îÁö" class="input_tag input_tag_date datepicker" max="9999-12-31" min="1970-01-01" autocomplete="off">
                </td>
                <td class="td_01 td_search_01">
                    <label class="label_tag">±îÁö</label>
                </td>
            </tr>
        </table>

        <button id="»õ·Î°íÄ§" class="btn btn_01" onclick="location.reload();">
            <svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" fill="currentColor" class="bi bi-arrow-clockwise" viewBox="0 0 14 14">
                <path fill-rule="evenodd" d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2v1z"/>
                <path d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466z"/>
            </svg>
            <i class="bi bi-arrow-clockwise"></i>
            »õ·Î°íÄ§
        </button>

        <button id="ÀÛ¾÷Ãë¼Ò" class="btn btn_01 btn_01_2">
            ÀÛ¾÷Ãë¼Ò
        </button>

        <button id="ÀÛ¾÷¼öÁ¤" class="btn btn_02 btn_02_1">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-fill" viewBox="0 0 16 16">
                <path d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708l-3-3zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207l6.5-6.5zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.499.499 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11l.178-.178z"/>
            </svg>
            <i class="bi bi-pencil-fill"></i>
            ÀÛ¾÷¼öÁ¤
        </button>

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
                        <input type="text" id="¹ß»ýÀÏÀÚ" class="input_tag input_tag_date input-field datepicker input_tag_readonly_01"  tabindex="-1" readonly autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">Àç´ÜÃ³¸í</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="Àç´ÜÃ³¸í" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">Àç´Ü±â</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="Àç´Ü±â" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">´ã´çÀÚ</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="´ã´çÀÚ" class="input_tag input_tag_readonly_01 input_tag_end_01 input-field" tabindex="-1" readonly>
                    </td>
                </tr>
            </table>
        </div>

        <div class="item_insert">
            <table class="item">
                <tr>
                    <th class="th_01">
                        <label class="label_tag">Àç´ÜÇ°¸í</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="Ç°¸í" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">Àç´ÜÄ®¶ó</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="Ä®¶ó" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">Àç´Ü»çÀÌÁî</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="»çÀÌÁî" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÀÛ¾÷¿¹Á¤¼ö·®</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ÀÛ¾÷¼ö·®" class="input_tag input_tag_end_01 input-number" autocomplete="off">
                    </td>
                </tr>
            </table>
        </div>

        <div class="machine_insert">
            <table class="machine">
                <tr>
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔÇ°¸í</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ÅõÀÔÇ°¸í" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔÄ®¶ó</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ÅõÀÔÄ®¶ó" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔ»çÀÌÁî</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ÅõÀÔ»çÀÌÁî" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔ¼ö·®</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="ÅõÀÔ·Ñ¼ö·®" class="input_tag input_tag_insertCount_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_insertCount_02" colspan="2;">
                        <input type="text" id="ÅõÀÔ¼ö·®" class="input_tag input_tag_insertCount_02 input_tag_readonly_01 input-number" tabindex="-1" readonly autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">ÇÊ¸§ LOT</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ÇÊ¸§LOT" class="input_tag input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">»ý»ê LOT</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="»ý»êLOT" class="input_tag input-field input-auto" autocomplete="off">
                    </td>


                    <th class="th_01">
                        <label class="label_tag">Àç´Ü LOT</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="Àç´ÜLOT" class="input_tag input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">·Ñ±æÀÌ</label>
                    </th>
                    <td class="td_01 td_length_01" colspan="2;">
                        <input type="text" id="·Ñ±æÀÌ" class="input_tag input_tag_length_01 auto_sum input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_length_02">
                        <input type="text" id="´ÜÀ§" class="input_tag input_tag_length_02 input_tag_end_02 input-field" autocomplete="off">
                    </td>
                </tr>
            </table>
        </div>

        <div class="ingredient_insert">
            <table class="ingredient">
                <tr>
                    <th class="th_01">
                        <label class="label_tag">ºÒ·®±¸ºÐ</label>
                    </th>
                    <td class="td_01 td_length_01">
                        <input type="text" id="ºÒ·®±¸ºÐ1" class="input_tag input_tag_length_01 input-field input-auto" onfocus="openLine(1);" autocomplete="off">
                    </td>
                    <td class="td_01 td_length_02">
                        <input type="text" id="·Ñ¼ö·®1" class="input_tag input_tag_length_02 auto_sum input-number" onfocus="openLine(1);" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">ºÒ·®±¸ºÐ</label>
                    </th>
                    <td class="td_01 td_length_01">
                        <input type="text" id="ºÒ·®±¸ºÐ2" class="input_tag input_tag_length_01 input-field input-auto" onfocus="openLine(1);" autocomplete="off">
                    </td>
                    <td class="td_01 td_length_02">
                        <input type="text" id="·Ñ¼ö·®2" class="input_tag input_tag_length_02 auto_sum input-number" onfocus="openLine(1);" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ºÒ·®±¸ºÐ</label>
                    </th>
                    <td class="td_01 td_length_01">
                        <input type="text" id="ºÒ·®±¸ºÐ3" class="input_tag input_tag_length_01 input-field input-auto" onfocus="openLine(1);" autocomplete="off">
                    </td>
                    <td class="td_01 td_length_02">
                        <input type="text" id="·Ñ¼ö·®3" class="input_tag input_tag_length_02 auto_sum input-number" onfocus="openLine(1);" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">Á¤»ó¼ö·®</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="Á¤»ó¼ö·®" class="input_tag input_tag_end_01 input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                </tr>

                <tr class="tr_hide tr_hide_01">
                    <th class="th_01">
                        <label class="label_tag">ºÒ·® LOT</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="ºÒ·®·ÎÆ®1" class="input_tag input-field" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">ºÒ·® LOT</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="ºÒ·®·ÎÆ®2" class="input_tag input-field" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ºÒ·® LOT</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="ºÒ·®·ÎÆ®3" class="input_tag input-field" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <button class="btn_01 btn_td_01" onclick="closeLine(1);">´Ý±â</button>
                    </th>
                    <td class="td_01">
                        <span> </span>
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">ºÒ·®±¸ºÐ</label>
                    </th>
                    <td class="td_01 td_length_01">
                        <input type="text" id="ºÒ·®±¸ºÐ4" class="input_tag input_tag_length_01 input-field input-auto" onfocus="openLine(2);" autocomplete="off">
                    </td>
                    <td class="td_01 td_length_02">
                        <input type="text" id="·Ñ¼ö·®4" class="input_tag input_tag_length_02 auto_sum input-number" onfocus="openLine(2);" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">ºÒ·®±¸ºÐ</label>
                    </th>
                    <td class="td_01 td_length_01">
                        <input type="text" id="ºÒ·®±¸ºÐ5" class="input_tag input_tag_length_01 input-field input-auto" onfocus="openLine(2);" autocomplete="off">
                    </td>
                    <td class="td_01 td_length_02">
                        <input type="text" id="·Ñ¼ö·®5" class="input_tag input_tag_length_02 auto_sum input-number" onfocus="openLine(2);" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ºÒ·®±¸ºÐ</label>
                    </th>
                    <td class="td_01 td_length_01">
                        <input type="text" id="ºÒ·®±¸ºÐ6" class="input_tag input_tag_length_01 input-field input-auto" onfocus="openLine(2);" autocomplete="off">
                    </td>
                    <td class="td_01 td_length_02">
                        <input type="text" id="·Ñ¼ö·®6" class="input_tag input_tag_length_02 auto_sum input-number" onfocus="openLine(2);" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ºÒ·®¼ö·®</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÒ·®¼ö·®" class="input_tag input_tag_end_01 input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                </tr>

                <tr class="tr_hide tr_hide_02">
                    <th class="th_01">
                        <label class="label_tag">ºÒ·® LOT</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="ºÒ·®·ÎÆ®4" class="input_tag input-field" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">ºÒ·® LOT</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="ºÒ·®·ÎÆ®5" class="input_tag input-field" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ºÒ·® LOT</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="ºÒ·®·ÎÆ®6" class="input_tag input-field" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <button class="btn_01 btn_td_01" onclick="closeLine(2);">´Ý±â</button>
                    </th>
                    <td class="td_01">
                        <span> </span>
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">ºÒ·®±¸ºÐ</label>
                    </th>
                    <td class="td_01 td_length_01">
                        <input type="text" id="ºÒ·®±¸ºÐ7" class="input_tag input_tag_length_01 input-field input-auto" onfocus="openLine(3);" autocomplete="off">
                    </td>
                    <td class="td_01 td_length_02">
                        <input type="text" id="·Ñ¼ö·®7" class="input_tag input_tag_length_02 auto_sum input-number" onfocus="openLine(3);" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">ºÒ·®±¸ºÐ</label>
                    </th>
                    <td class="td_01 td_length_01">
                        <input type="text" id="ºÒ·®±¸ºÐ8" class="input_tag input_tag_length_01 input-field input-auto" onfocus="openLine(3);" autocomplete="off">
                    </td>
                    <td class="td_01 td_length_02">
                        <input type="text" id="·Ñ¼ö·®8" class="input_tag input_tag_length_02 auto_sum input-number" onfocus="openLine(3);" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">³­´Ü»çÀÌÁî</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="³­´Ü»çÀÌÁî" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÈÄµµ</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ÈÄµµ" class="input_tag input_tag_end_01 input-number" autocomplete="off">
                    </td>
                </tr>

                <tr class="tr_hide tr_hide_03">
                    <th class="th_01">
                        <label class="label_tag">ºÒ·® LOT</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="ºÒ·®·ÎÆ®7" class="input_tag input-field" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">ºÒ·® LOT</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="ºÒ·®·ÎÆ®8" class="input_tag input-field" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <button class="btn_01 btn_td_01" onclick="closeLine(3);">´Ý±â</button>
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
                        <label class="label_tag">ÀÛ¾÷±¸ºÐ</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="ÀÛ¾÷±¸ºÐ" class="input_tag input-field input-auto" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">ºñ°í</label>
                    </th>
                    <td class="td_01" colspan="7;">
                        <input type="text" id="ºñ°í" class="input_tag input_remark_01 input-field" autocomplete="off">
                    </td>
                </tr>
            </table>
        </div>

        <div class="div_forList">
            <table id="table_forList" class="table_forList">
                <thead id="forList_header" class="forList_header">
                    <tr id="supply_header">
                        <th class="th_01" style="width: 9%">
                            °ø±ÞÀÇ·ÚÀÏ<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_01" style="width: 9%">
                            Ãâ°íÀÇ·ÚÀÏ<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_01" style="width: 11%">
                            °ø±ÞÀÇ·Ú¹øÈ£<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_01" style="width: 19%">
                            °Å·¡Ã³¸í<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_01" style="width: 13%">
                            Ç°¸í<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_01" style="width: 15%">
                            °ø±Þ¼ö·®<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_01" style="width: 10%">
                            Àç´Ü¼ö·®<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_01" style="width: 8%">
                            ÀÜ¿©¼ö·®<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_01" style="width: 6%">
                            ¼±ÅÃ<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                    </tr>
                </thead>

                <tbody id="forList_body" class="forList_body">
                </tbody>
            </table>
        </div>
    </div>

          
<!-- hidden -->
<input type="hidden" id="Ã¢°í¸í" class="input-field">
<input type="hidden" id="ÀÛ¾÷½ÃÀÛ½Ã°£" class="input-field">
<input type="hidden" id="ÀÛ¾÷Á¾·á½Ã°£" class="input-field">
<input type="hidden" id="ÀÛ¾÷½Ã°£" class="input-field">
<input type="hidden" id="OutID" class="input-field">

<input type="hidden" id="IP_Address" class="input-field">
<input type="hidden" id="WorkID" value="">
<input type="hidden" id="Item" value="">
<input type="hidden" id="color" value="">
<input type="hidden" id="size" value="">
<input type="hidden" id="sizeOpt" value="">
<input type="hidden" id="OLDÅõÀÔ¼ö·®" value="0">
<input type="hidden" id="OLDÀÛ¾÷ÀÏÀÚ" value="0">
<input type="hidden" id="sizeAdd" value="0">
<input type="hidden" id="workid_ori" value="0">

</body>
</HTML>