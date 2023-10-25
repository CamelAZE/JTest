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
' WorkDiary_BP.asp  KYJ

Dim junID , P_Lot_NO
junID = request("junID")
P_Lot_NO = request("P_Lot_NO")

%>

<head>
<meta charset="utf-8">
<title>ÀÛ¾÷ÀÏÁöµî·Ï(ºÐ´Ü)</title>
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

    /* °¢ ±¸¿ª ³ª´©±â / ±¸¿ªº° css ÀÛ¾÷ */
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

    /* ÀÇ·Ú¼­ Á¶È¸ */
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

    /* Á¶È¸ Á¤·Ä½Ã ¾ÆÀÌÄÜ */
    .ui-icon { zoom: 200%; margin-top: 1px; position: absolute; display: none; background-image: url("../IncJquery/images/ui-icons_ffffff_256x240.png");  }
    
    /* title */
    #title_bar{ float: left; width:22%; height:60px; margin: 5px 9% 0px 2%; vertical-align: auto; position: relative; background-size: 100%, 42px; background-position: center; background-repeat: no-repeat;  }
    #title_bar_img{ width: 100%; height: 100%;  }
    #t_header{ width: 100%; font-size: 18pt; font-weight: bold; font-family: Noto Sans KR; margin: 0px; color:white; text-align:center; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); letter-spacing: 2.5px;  }

    /* tr ÅÂ±× */
    .tr_disable_01{ display: table-row;  }
    .tr_disable_01 label{ background-color: #E6E4DA;  }

    /* th ÅÂ±× */
    .th_01{ box-sizing: border-box; width: 7.5%; height: 40px; font-size: 13pt; border-spacing: 0px; text-align: center;  }
    .th_table_01{ box-sizing: border-box; text-align: center;  }
    .th_search_01{ box-sizing: border-box; width: 22%; height: 40px; font-size: 13pt; border-spacing: 0px; text-align: center;  }

    /* td ÅÂ±× */
    .td_01{ box-sizing: border-box; width: 17.5%; height: 40px; font-size: 13pt; border-spacing: 0px;  }
    .td_search_01{ box-sizing: border-box; width: 48%; height: 40px; font-size: 13pt; border-spacing: 0px;  }
    .td_insertCount_01{ width: 8.75%;  }
    .td_insertCount_02{ width: 8.75%;  }
    .td_length_01{ width: 12.5%;  }
    .td_length_02{ width: 5%;  }

    /* label */
    label{ display: block; border-radius: 3px; color: #000000; height: 34px; max-height: 34px; line-height: 34px; text-align: center; vertical-align: middle; font-weight: bold; white-space: nowrap; margin: 0px;  }
    .label_tag_2row{ height: 74px; max-height: 74px; line-height: 74px;  }

    /* input ÅÂ±× */
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
    
    /* ºÐ´Ü ±æÀÌ/¼ö·® °¡¸®±â */
    #insertTable tr:nth-child(n+6) { display: none;  }

    /* datepicker */
    .datepicker{ text-align: center;  }

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

            if(seSawonid == ""){        //  ºÎ¸ð Ã¢¿¡¼­ Á¤º¸ À¯ÁöÁßÀÎÁö È®ÀÎ
                alert("·Î±×ÀÎ »óÅÂ¸¦ ´Ù½Ã È®ÀÎÇØ ÁÖ¼¼¿ä.");
                self.close();
            }else if(prk != ""){
                //  µ¥ÀÌÅÍºÒ·¯¿À±â
                init_disp(prk);     //  ¹øÈ£ °°ÀÌ Àü´Þ

                //  ±âÃÊ µ¥ÀÌÅÍ
                $("#ÀÛ¾÷Ãë¼Ò").attr("disabled", true);
                $("#ÀÛ¾÷½ÃÀÛ").attr("disabled", true);
                $("#ÀÛ¾÷¼öÁ¤").css("display","inline");     //  ¼öÁ¤ ÇÒ¼öÀÖµµ·Ï ÀÛ¾÷¼öÁ¤ ¹öÆ° º¸ÀÌ°Ô
                $("#ÀÛ¾÷Á¾·á").attr("disabled", true);
                $("#¾ÆÀÌÅÛ·ÎÆ®¹øÈ£").val("<%=P_Lot_NO%>");
                $(".btn_02_2").css("margin", "10px 2% 10px 0px");
                setTag();
            }else if(prk == ""){
                //  ±âÃÊ µ¥ÀÌÅÍ
                $("#ÀÛ¾÷¼öÁ¤").css("display","none");
                $(".btn_01_2").css("margin", "30px 4% 10px 0px");
                $("#ÀÛ¾÷ÀÏÀÚ").val(getDay());
                $("#ÀÛ¾÷ÀÏÀÚ").attr("min", getDay());       //  ´Þ·Â¿¡¼­ ÀÌÀü ÀÏÀÚ ¼±ÅÃ ºÒ°¡´ÉÇÏµµ·Ï
                $("#ÀÛ¾÷ÀÏÀÚ").attr("max", getDay());       //  ´Þ·Â¿¡¼­ ÀÌÈÄ ÀÏÀÚ ¼±ÅÃ ºÒ°¡´ÉÇÏµµ·Ï
                var date = new Date();
                // date.setDate(date.getDate() - 7);       //  7ÀÏÀü ³¯Â¥ °è»ê
                // var oneWeekAgo = date.toISOString().substring(0, 10);       //  °è»ê µÈ ³¯Â¥ YYYY-MM-DD ÇüÀ¸·Î º¯È¯ º¯¼ö¿¡ ¾È´ã°í ¹Ù·Î val() ÇØµµ ¹«°ü
                var oneWeekAgo = get_add_date_yyyymmdd('dd', -7);       // 7ÀÏ Àü ³¯Â¥ °è»ê
                $("#Á¶È¸ÀÏÀÚ").val(oneWeekAgo);
                $("#ÀÛ¾÷ÀÚ").val(seSawonname);
                $("#Ã¢°í¸í").val(defaultStocName);

                //  ¹Ì¿Ï·á µ¥ÀÌÅÍ È®ÀÎ
                var work_id = work_check($("#Ã¢°í¸í").val(), $("#ÀÛ¾÷ÀÏÀÚ").val(), $("#ÀÛ¾÷ÀÚ").val());     //  Ã¢°í¸í, ÀÛ¾÷ÀÏÀÚ, ÀÛ¾÷ÀÚ ÆÄ¶ó¸ÞÅ¸·Î Àü´Þ

                //  ¹Ì¿Ï·á µ¥ÀÌÅÍ¿¡ µû¶ó ÁøÇàÁß»óÅÂ È¤Àº »õ·Î ÁøÇàÇÒÁö ÁØºñ
                if(work_id != ""){      //  ¹Ì¿Ï·á µ¥ÀÌÅÍ°¡ ÀÖÀ½À¸·Î ÀÛ¾÷ÁøÇà»óÅÂ
                    remain_disp(work_id);       //  ÁøÇàÁßÀÎ workid ÆÄ¶ó¸ÞÅ¸·Î Àü´Þ
                    prk = 1;        //  ½ÃÀÛ Æ÷Ä¿½º ÁöÁ¤ÇÏÁö ¾Êµµ·Ï prk 1·Î ¼³Á¤ prk Ã£¾Æ°¡¸é ÀÌÀ¯ ¾Ë¼öÀÖÀ½
                    $("#ÀÛ¾÷½ÃÀÛ").attr("disabled", true);
                    //  ÁøÇàÁßÀÎÀÛ¾÷¿¡ Ãß°¡ÇÑ trÅÂ±× ÀÖÀ»°æ¿ì Ãß°¡ÇÏµµ·Ï
                    setTag();
                    //  PAD·Î Àü¼ÛÇÑ ³»¿ªÀÎ °æ¿ì ¼öÁ¤ ºÒ°¡´ÉÇÏµµ·Ï Ã³¸®
                    var PDA_rst = Get_Json("EXEC RF_PDA_CRE_WORKDIARY_CHECK 1, 'ºÐ´Ü', '" + work_id + "'");
                    PDA_rst_length = PDA_rst.length
                    if(PDA_rst[0].RFºÐ´ÜÅõÀÔID == "" || PDA_rst[0].RFºÐ´ÜÅõÀÔID == " "){
                        PDA_rst_length = 0;
                    }else{
                        $("#t_header").text($("#t_header").text() + "(PDAÀÛ¾÷)");
                        $("#ÅõÀÔ·Ñ±æÀÌ, #ÅõÀÔ·Ñ¼ö·®, #¾ÆÀÌÅÛ·ÎÆ®¹øÈ£,#ÅõÀÔ·Ñ±æÀÌ2, #ÅõÀÔ·Ñ¼ö·®2, #¾ÆÀÌÅÛ·ÎÆ®¹øÈ£2, #ÅõÀÔ·Ñ±æÀÌ3, #ÅõÀÔ·Ñ¼ö·®3, #¾ÆÀÌÅÛ·ÎÆ®¹øÈ£3").prop("readonly", true);
                        $("#ÅõÀÔ·Ñ±æÀÌ, #ÅõÀÔ·Ñ¼ö·®, #¾ÆÀÌÅÛ·ÎÆ®¹øÈ£,#ÅõÀÔ·Ñ±æÀÌ2, #ÅõÀÔ·Ñ¼ö·®2, #¾ÆÀÌÅÛ·ÎÆ®¹øÈ£2, #ÅõÀÔ·Ñ±æÀÌ3, #ÅõÀÔ·Ñ¼ö·®3, #¾ÆÀÌÅÛ·ÎÆ®¹øÈ£3").addClass("input_tag_readonly_01");
                        $("#Ã¢°í¸í, #ºÐ´Ü±â, #Ç°¸í, #Ä®¶ó, #»çÀÌÁî").prop("readonly", true);
                        $("#Ã¢°í¸í, #ºÐ´Ü±â, #Ç°¸í, #Ä®¶ó, #»çÀÌÁî").addClass("input_tag_readonly_01");
                        PDA_rst_length = 1;     //  autocomplete ÀÛµ¿ ¾ÈµÇ°Ô
                    };
                }else{      //  ¹Ì¿Ï·á µ¥ÀÌÅÍ ¾øÀ½À¸·Î ÀÛ¾÷½ÃÀÛÁØºñ
                    $("#ÀÛ¾÷Á¾·á").attr("disabled", true);
                };
            };    //  ÃÊ±â µ¥ÀÌÅÍ ¼³Á¤ end

            // ------------------------------------------------------------------------
            // ÀÛ¾÷½ÃÀÛ ¹öÆ° Å¬¸¯
            // ------------------------------------------------------------------------
            $("#ÀÛ¾÷½ÃÀÛ").on("click", function(){
                if(save() == true){
                    $("#ÀÛ¾÷½ÃÀÛ").attr("disabled", true);
                    $("#ÀÛ¾÷Á¾·á").attr("disabled", false);
                    $("#ºÒ·®±¸ºÐ1").val("01:Á¤»ó");
                };
            });   //  ÀÛ¾÷½ÃÀÛ ¹öÆ° end

            // ------------------------------------------------------------------------
            // ÀÛ¾÷Ãë¼Ò ¹öÆ° Å¬¸¯
            // ------------------------------------------------------------------------
            $("#ÀÛ¾÷Ãë¼Ò").on("click", function(){
                if(confirm("Á¤¸» Ãë¼ÒÇÏ½Ã°Ú½À´Ï±î ?") == true){
                    if($("#ÀÛ¾÷½ÃÀÛ½Ã°£").val() == ""){
                        alert("ÀÛ¾÷ÀÌ ½ÃÀÛµÇ¾ú´ÂÁö ´Ù½Ã È®ÀÎÇØÁÖ¼¼¿ä.");
                    }else{
                        var wareHouse = $("#Ã¢°í¸í").val();
                        var delSawonName = $("#ÀÛ¾÷ÀÚ").val();
                        var delGubun = 4;         //  1 : ¾ÐÃâ, 2 : ÇÕÆ÷, 3 : ÄÚÆÃ, 4 : ºÐ´Ü, 5 : Àç´Ü
                        var delWorkId = $("#WorkID").val();
                        var rst = Get_Json("EXEC RF_BUN_PDA_RFºÐ´ÜÅõÀÔ_ERP_CLEAR '" + delSawonName   + "', '" + delGubun + "', '" + delWorkId + "'");
                        alert(rst[0].MSG);
                        location.reload();
                    };
                };
            });   //  ÀÛ¾÷Ãë¼Ò ¹öÆ° end

            // ------------------------------------------------------------------------
            // ÀÛ¾÷Á¾·á ¹öÆ° Å¬¸¯
            // ------------------------------------------------------------------------
            $("#ÀÛ¾÷Á¾·á").on("click", function(){
                if(save() == true){
                    alert("ÀúÀåµÇ¾ú½À´Ï´Ù.");
                    opener.main_bind();
                    self.close();
                    };
            });   //  ÀÛ¾÷Á¾·á ¹öÆ° end

            // ------------------------------------------------------------------------
            // ÀÛ¾÷¼öÁ¤ ¹öÆ° Å¬¸¯
            // ------------------------------------------------------------------------
            $("#ÀÛ¾÷¼öÁ¤").on("click", function(){
                $(".input-field, .input-number").attr("disabled", false);
                $("#ÀÛ¾÷Á¾·á").attr("disabled", false);
                $("#ÀÛ¾÷¼öÁ¤").attr("disabled", true);
                //  PAD·Î Àü¼ÛÇÑ ³»¿ªÀÎ °æ¿ì ¼öÁ¤ ºÒ°¡´ÉÇÏµµ·Ï Ã³¸®
                var PDA_rst = Get_Json("EXEC RF_PDA_CRE_WORKDIARY_CHECK 1, 'ºÐ´Ü', '" + work_id + "'");
                PDA_rst_length = PDA_rst.length
                if(PDA_rst[0].RFºÐ´ÜÅõÀÔID == "" || PDA_rst[0].RFºÐ´ÜÅõÀÔID == " "){
                    PDA_rst_length = 0;
                }else{
                    $("#t_header").text($("#t_header").text() + "(PDAÀÛ¾÷)");
                    $("#ÅõÀÔ·Ñ±æÀÌ, #ÅõÀÔ·Ñ¼ö·®, #¾ÆÀÌÅÛ·ÎÆ®¹øÈ£,#ÅõÀÔ·Ñ±æÀÌ2, #ÅõÀÔ·Ñ¼ö·®2, #¾ÆÀÌÅÛ·ÎÆ®¹øÈ£2, #ÅõÀÔ·Ñ±æÀÌ3, #ÅõÀÔ·Ñ¼ö·®3, #¾ÆÀÌÅÛ·ÎÆ®¹øÈ£3").pro("readonly", true);
                    $("#ÅõÀÔ·Ñ±æÀÌ, #ÅõÀÔ·Ñ¼ö·®, #¾ÆÀÌÅÛ·ÎÆ®¹øÈ£,#ÅõÀÔ·Ñ±æÀÌ2, #ÅõÀÔ·Ñ¼ö·®2, #¾ÆÀÌÅÛ·ÎÆ®¹øÈ£2, #ÅõÀÔ·Ñ±æÀÌ3, #ÅõÀÔ·Ñ¼ö·®3, #¾ÆÀÌÅÛ·ÎÆ®¹øÈ£3").addClass("input_tag_readonly_01");
                    $("#Ã¢°í¸í, #ºÐ´Ü±â, #Ç°¸í, #Ä®¶ó, #»çÀÌÁî").pro("readonly", true);
                    $("#Ã¢°í¸í, #ºÐ´Ü±â, #Ç°¸í, #Ä®¶ó, #»çÀÌÁî").addClass("input_tag_readonly_01");
                    PDA_rst_length = 1;     //  autocomplete ÀÛµ¿ ¾ÈµÇ°Ô
                };
                //  ÁøÇàÁßÀÎÀÛ¾÷¿¡ Ãß°¡ÇÑ trÅÂ±× ÀÖÀ»°æ¿ì Ãß°¡ÇÏµµ·Ï
                setTag();

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
            // class input-number Ç×¸ñ ¼ýÀÚ¸¸ ÀÔ·ÂÇÏµµ·Ï Àû¿ë
            // ------------------------------------------------------------------------
            $(".input-number").on("blur keyup", function(){
                // var regex = /[^0-9]/gi;    //  ¼ýÀÚ»©°ï ÀÔ·Â ¾ÈµÊ .µµ¾ÈµÊ
                var regex = /[¤¡-¤¾|¤¿-¤Ó|°¡-ÆR|aA-zZ]/gi;     //  ÇÑ±Û ¿µ¾î¸¸ ¸·±â
                $(this).val($(this).val().replace(regex, ""));
            });   //  ¼ýÀÚ¸¸ ÀÔ·Â end

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
                if(dontFocus == 0){
                    data_find(this.id, item_sql);       //  ÀÚµ¿¿Ï¼º ½ÇÇà
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
                if(this.id == "Ã¢°í¸í" || this.id == "ºÐ´Ü±â"){     // ¿ÀÅäÆ÷Ä¿½º Áö¿ì°í ÀÌ°Å Ãß°¡ÇÔ
                    return;
                }else{
                    $(this).trigger(e);
                };
            });   //  ¾Æ·¡¹æÇâÅ° Æ®¸®°Å end
            
            $("#Ã¢°í¸í, #ºÐ´Ü±â").on("focus", function(){      // ÀÌ°ÉÇØ¾ß ÀÔ·Â°ª°ú »ó°ü¾øÀÌ °Ë»ö¾î Ã¢À» º¸¿©ÁÖ´Âµ¥ ±×·¯¸é autoFocus°¡ °íÀå³²...
                $(this).autocomplete("search", "");             // ±×·¡¼­ autoFocus Áö¿ì°í Æ®¸®°Å·Î autoFocus ´ë½Å Ãß°¡ ÀÛ¼ºÇÔ
            });
            
            // ------------------------------------------------------------------------
            // Á¶È¸
            // ------------------------------------------------------------------------
            $("#Á¶È¸ÀÏÀÚ").on("change", function(){
				if(jFuncDateValid(this) == true){
					SUPPLY_DISP();
				}else{
					$("#Á¶È¸ÀÏÀÚ").val(oneWeekAgo);
					return false;
				};
            });     //  Á¶È¸ end
            
            // ------------------------------------------------------------------------
            // Á¶È¸ ³»¿ë ¼±ÅÃ
            // ------------------------------------------------------------------------
            $("#forList_body").on("click", "tr", function(){
                //  ¸ñÀûÀº ÀÌÇØÇÏ¿´À¸³ª ÀÌ¸¦ Á¦¾îÇÏ´Â V ±â´ÉÀÌ ¾øÀ½ ¿ø¹®¿¡ ÀÖ¾î¼­ °¡Á®¿È
                $("#table_forList tbody tr").each(function(){
                    if(checkEven($(this).index() + 1) == true){     //  index¿¡ ¸ÂÃç¼­ È¦¼ö¿­ Â¦¼ö¿­ ±¸ºÐ
                        $("td", this).css("background", "#eee");
                        // $("td", this).css("color", "#000");
                    }else{
                        $("td", this).css("background", "#fff");
                        // $("td", this).css("color", "#000");
                    };
                });
                var chk = $("td:eq(4)", this).text();
                if(chk == "" || chk === "¡Ü"){       //  Á¶È¸ ³»¿ë »ó´Ü¿¡ ÀÚµ¿ ÀÛ¼º
                    $("#Ç°¸í").val($("td:eq(6)", this).text());
                    $("#Ä®¶ó").val($("td:eq(7)", this).text());
                    $("#»çÀÌÁî").val($("td:eq(8)", this).text());
                    $("#ÅõÀÔ·Ñ±æÀÌ").val($("td:eq(9)", this).text());
                    $("#ÅõÀÔ·Ñ¼ö·®").val(1);
                    sum();
                    $("#¾ÆÀÌÅÛ·ÎÆ®¹øÈ£").val($("td:eq(10)", this).text());
                    $("#ÀÔ°íÀüÇ¥ID").val($("td:eq(12)", this).text());
                    $("td", this).css("background-color", "#DBD6E8");
                };
            });     //  Á¶È¸ ³»¿ë ¼±ÅÃ end
            
            // ------------------------------------------------------------------------
            // Á¶È¸ ³»¿ë Çì´õ Å¬¸¯À¸·Î Á¤·Ä
            // ------------------------------------------------------------------------
            $("#table_forList").on("click", "th", function(){
                var regex = /[^¤¡-¤¾|¤¿-¤Ó|°¡-ÆR|aA-zZ]/gi;     //  ÇÑ±Û ¿µ¾î¸¸ ÀÔ·Â
                var sort_kind = $(this).text().replace(regex, "");      //  ±×³É $(this).text() ½Ã °ø¹éµî ´Ù¸¥ ¹®ÀÚ°¡ ÀÖ¾î replace·Î ÇÑ±Û¸¸ ³²±â±â
                console.log(sort_kind);
                if(sort_kind == "¼±ÅÃ"){
                    return;
                };
                $("#supply_header > th span").each(function(){      //  this°¡ ¾Æ´Ñ°æ¿ì display none·Î ¾ÆÀÌÄÜ Áö¿ì±â
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
            // ÅõÀÔÃÑ¼ö·® ÀÚµ¿°è»ê ÇÔ¼ö½ÇÇà
            // ------------------------------------------------------------------------
            $(".auto_sum_01").on("change", function(){
                sum();
            });     //  ÅõÀÔÃÑ¼ö·® ÀÚµ¿°è»ê ÇÔ¼ö½ÇÇà end

            // ------------------------------------------------------------------------
            // ºÐ´ÜÃÑ¼ö·® ÀÚµ¿°è»ê
            // ------------------------------------------------------------------------
            $(".auto_sum_02").on("change", function(){
                var sum = 0;
                for(i = 1; i < 11; i++){
                    $("#ºÐ´Ü¼ö·®" + i).val(parseInt($("#ºÐ´Ü·Ñ±æÀÌ" + i).val() == "" ? 0 : $("#ºÐ´Ü·Ñ±æÀÌ" + i).val()) * parseInt($("#ºÐ´Ü·Ñ¼ö·®" + i).val() == "" ? 0 : $("#ºÐ´Ü·Ñ¼ö·®" + i).val()));
                    sum += parseInt($("#ºÐ´Ü¼ö·®" + i).val());
                };
                $("#ºÐ´ÜÃÑ¼ö·®").val(sum);
            });     //  ºÐ´ÜÃÑ¼ö·® ÀÚµ¿°è»ê

            // ------------------------------------------------------------------------	
            // ½ÃÀÛ½Ã Æ÷Ä¿½º
            // ------------------------------------------------------------------------	
            if(prk + "" == ""){     //  ºÒ·¯¿Ã ÀÛ¾÷ÀÌ ¾øÀ»¶§¸¸ ½ÇÇàµÇ´Â°ÍÀÌ³ª ¸¶Âù°¡Áö
                $("#Ã¢°í¸í").focus();
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
            var rst = Get_Json("B_WORK_LST_BUN 'G_WorkDiary_ºÐ´Ü', " + id);
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
                        if(this.id == "ÀÛ¾÷ÀÏÀÚ"){
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
    //  ´çÀÏ ¹Ì¿Ï·á ÀÛ¾÷ÀÏÁö ¹øÈ£ È£Ãâ
    // ------------------------------------------------------------------------
    function work_check(war_name ,work_date, worker){
        try{
            var rst = Get_Json("B_WORK_CHECK 'G_WorkDiary_ºÐ´Ü', '" + war_name + "', '" + work_date + "', '" + worker + "'");

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
            var rst = Get_Json("B_WORK_LST_REMAIN 'G_WorkDiary_ºÐ´Ü'," + id);
            if(rst[0].WorkID != ""){
                $("#WorkID").val(rst[0].WorkID);
                $("#Ã¢°í¸í").val(rst[0].Ã¢°í¸í);
                $(".input-field, .input-number").each(function(){
                    if($(this).attr("type") == "text" || $(this).attr("type") == "date" || $(this).attr("type") == "textarea" || $(this).attr("type") == "hidden"){
                        var field = rst[0][this.id] + "";
                        field = ((field == 0 || field == "null") ? "" : field);
                        if(this.id == "ÀÛ¾÷ÀÏÀÚ"){
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
        };
    };    // ¹Ì¿Ï·á ÀÛ¾÷ÀÏÁö ºÒ·¯¿À±â end

    // ------------------------------------------------------------------------
    //  ÀúÀå
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
            // console.log("EXEC [AA_WORKDIARY_ºÐ´Ü] '" + id + "', '" + WorkID + "'" + save_data)
            var insert = Get_Json("EXEC [AA_WORKDIARY_ºÐ´Ü] '" + id + "', '" + WorkID + "'" + save_data);
            if(insert[0].VALID == 0){
                dontFocus = 1;      // ÀÚµ¿¿Ï¼º È­»ìÇ¥ Æ®¸®°Å¸¸ ÀÛµ¿ÇÏµµ·Ï ÀÛ¾÷
                alert(insert[0].MSG);
                $("#" + insert[0].RETURN_INPUT).focus();
                return false;
            }else if(insert[0].VALID == 1){
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
            var t_sql = "";
            var gubun = "";
            if(id == "Ã¢°í¸í" || id == "ºÐ´Ü±â" || id.includes("ºÐ´Ü±¸ºÐ")){
				gubun = id == "Ã¢°í¸í" ? "Ã¢°í¸í" : id == "ºÐ´Ü±â" ? "ºÐ´Ü±â" : "ºÐ´Ü±¸ºÐ"
                t_sql = "EXEC AA_WORKDIARY_Search '', '" + gubun + "', ''";
            }else if(id == "Ä®¶ó"){
                if($("#Ç°¸í").val() == ""){
                    dontFocus = 1;      // ÀÚµ¿¿Ï¼º È­»ìÇ¥ Æ®¸®°Å¸¸ ÀÛµ¿ÇÏµµ·Ï ÀÛ¾÷
                    alert("Ç°¸íÀ» ÀÔ·ÂÇØ ÁÖ¼¼¿ä.");
                    $("#Ç°¸í").focus();
                    return false;
                }else{
                    t_sql = "EXEC AA_WORKDIARY_Search '', 'Ä®¶ó', '" + $("#Ç°¸í").val() + "'";
                };
            }else if(id == "»çÀÌÁî"){
                if($("#Ç°¸í").val() == ""){
                    dontFocus = 1;      // ÀÚµ¿¿Ï¼º È­»ìÇ¥ Æ®¸®°Å¸¸ ÀÛµ¿ÇÏµµ·Ï ÀÛ¾÷
                    alert("Ç°¸íÀ» ÀÔ·ÂÇØ ÁÖ¼¼¿ä.");
                    $("#Ç°¸í").focus();
                    return false;
                }else{
                    t_sql = "EXEC AA_WORKDIARY_Search '', '»çÀÌÁî', '" + $("#Ç°¸í").val() + "'";
                };
            }else if(id.includes("·ÎÆ®¹øÈ£")){
                if($("#Ç°¸í").val() == "" || $("#Ä®¶ó").val() == "" || $("#»çÀÌÁî").val() == ""){
                    dontFocus = 1;      // ÀÚµ¿¿Ï¼º È­»ìÇ¥ Æ®¸®°Å¸¸ ÀÛµ¿ÇÏµµ·Ï ÀÛ¾÷
                    alert("ÅõÀÔÇ° ÀÔ·Â Á¤º¸¸¦ ÀçÈ®ÀÎ ÇØÁÖ¼¼¿ä.");
                    var focus = $("#Ç°¸í").val() == "" ? "Ä®¶ó" : $("#ÅõÀÔÄ®¶ó").val() == "" ? "»çÀÌÁî" : size;
                    $("#" + focus).focus();
                    return false;
                }else{
                    t_sql = "EXEC [AA_WORKDIARY_LOTNO] '', '" + $("#ÀÛ¾÷ÀÚ").val() + "', '" + $("#Ç°¸í").val() + "', '" + $("#Ä®¶ó").val() + "', '" + $("#»çÀÌÁî").val() + "', '" + $("#Ã¢°í¸í").val() + "'";
                };
            };
            var find_rst = "";
            var find_data_array = new Array();
            if(id == "Ç°¸í"){
                find_rst = item_sql;
            }else if(id.includes("·ÎÆ®¹øÈ£")){
                //Get_Json_Before() // ÇÁ·Î±×·¡½º¹Ù ½ÇÇà
                $("#"+ id).css("background-color", "#eee");
                Get_Json_common_direct2(t_sql);
                G_LotID = id;
                // °¡Á®¿À±â¿Ï·áÈÄ Get_Json_After2 ½ÇÇàµÊ
                return;
            }else{
                find_rst = Get_Json(t_sql);
            };

            find_data_array[id] = find_rst;
            if(find_rst[0]["FND_DATA"] == "" | find_rst[0]["FND_DATA"] == " "){
                find_data_array.push("Á¶È¸ ³»¿ëÀÌ ¾ø½À´Ï´Ù. ´ÙÀ½À¸·Î ³Ñ¾î°¡±â");
                // return false;        // return À¸·Î ¿¹¿ÜÃ³¸®¸¦ ÇØ¹ö¸®¸é ÀÚµ¿¿Ï¼ºÀÌ ¾Æ¿¹ ÀÛµ¿ÇÏÁö ¾ÊÀ½
            }else{
                for(var i in find_rst){
                    find_data_array.push(find_rst[i]["FND_DATA"]);
                };
            };
            autocomplete_dbc(find_data_array, id);
        }catch(err){
            alert(err.message);
            $("#Ç°¸í").focus();
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
                    if(this.id == "Ã¢°í¸í"){
                        SUPPLY_DISP();
                    };
                    var t_this = this;
                    setTimeout(function(){
                        move_next(t_this);
                    }, 100);
                },
                focus : function(event, ui){    //  focus ½Ã ÀÌº¥Æ®    ÇÑ±Û°ú »ç¿ë½Ã ³ª¸ÓÁö°¡ »ç¶óÁö´Â ¹ö±×°¡ ÀÖ´Ù ? ¸®ÅÏÆÞ½º½Ã ¹«½ÃÇÑ´Ù°íÇÔ
                    return false;
                },
                change : function(event, ui){    //  change ½Ã ÀÌº¥Æ®
                    if(this.id == "Ç°¸í"){       //  Ç°¸í, Ä®¶ó, »çÀÌÁî Á¾·ù ÀÔ·Â½Ã ÀÔ·Â³»¿ë È®ÀÎ
                        if(autocom_valid("Ç°¸í", $(this).val(), "") == "0"){
                            dontFocus = 1;      // ÀÚµ¿¿Ï¼º È­»ìÇ¥ Æ®¸®°Å¸¸ ÀÛµ¿ÇÏµµ·Ï ÀÛ¾÷
                            $(this).val("");
                            $(this).focus();
                            return false;
                        };
                    };
                    if(this.id == "Ä®¶ó"){
                        if(autocom_valid("Ä®¶ó", $(this).val(), $("#Ç°¸í").val()) == "0"){
                            dontFocus = 1;      // ÀÚµ¿¿Ï¼º È­»ìÇ¥ Æ®¸®°Å¸¸ ÀÛµ¿ÇÏµµ·Ï ÀÛ¾÷
                            $(this).val("");
                            $(this).focus();
                            return false;
                        };
                    };
                    if(this.id == "»çÀÌÁî"){
                        if(autocom_valid("»çÀÌÁî", $(this).val(), $("#Ç°¸í").val()) == "0"){
                            dontFocus = 1;      // ÀÚµ¿¿Ï¼º È­»ìÇ¥ Æ®¸®°Å¸¸ ÀÛµ¿ÇÏµµ·Ï ÀÛ¾÷
                            $(this).val("");
                            $(this).focus();
                            return false;
                        };
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
                // $(this).autocomplete("search", $(this).val());    //  focus½Ã ¹Ù·Î °Ë»öÃ¢ÀÌ ON   Æ®¸®°Å·Î ¾Æ·¡¹æÇâÅ° ´©¸£´Â°Í Ãß°¡ °°ÀÌ ÀÖÀ¸¸é autoFocus °¡ ¹ö±×°É·Á¼­ Æ÷Ä¿½º »ç¶óÁü
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
    // ÀÇ·Ú¼­ Á¶È¸
    // ------------------------------------------------------------------------
    function SUPPLY_DISP(sortName, sortOrder) {
        try{
            sortName = sortName == null ? "" : sortName == undefined ? "" : sortName;		//	sortNameÀÇ ÀÔ·Â°ª ÀÖ´ÂÁö È®ÀÎ
            sortOrder = sortOrder == null ? "" : sortOrder == undefined ? "" : sortOrder;		//	sortOrderÀÇ ÀÔ·Â°ª ÀÖ´ÂÁö È®ÀÎ
            var rst = Get_Json("EXEC B_WORK_PROD_LST 1, '" + $("#Ã¢°í¸í").val() + "', '" + $("#Á¶È¸ÀÏÀÚ").val() + "', '" + sortName + "', '" + sortOrder + "'");
            var appendHTML = "";
            if(rst[0].»ý»êÀÏÀÚ == "" || rst[0].»ý»êÀÏÀÚ == " " || rst[0].»ý»êÀÏÀÚ == null){       //  Á¶È¸ ³»¿ëÀÌ ¾ø´Â °æ¿ì
                appendHTML += "<tr><td>Á¶È¸ ³»¿ëÀÌ ¾ø½À´Ï´Ù</td></tr>";
            }else{
                if(rst.length > 10){
                    for(i = 0; i < rst.length; i++){
                        appendHTML += '<tr><td style="width: 8%">' + rst[i].»ý»êÀÏÀÚ + '</td><td style="width: 8%">' + rst[i].¹Ú¸®ÀÏÀÚ + '</td><td style="width: 7%">' + rst[i].Ã¢°í¸í + '</td><td style="width: 7%">' + rst[i].´ã´çÀÚ
                                + '</td><td class="select" style="width: 2%">' + rst[i].ºÐ´Ü»ç¿ë + '</td><td style="width: 7%">' + rst[i].Àåºñ±¸ºÐ
                                + '</td><td style="width: 13%">'+ rst[i].Ç°¸í + '</td><td style="width: 13%">' + rst[i].Ä®¶ó + '</td><td style="width: 8%">' + rst[i].»çÀÌÁî + '</td><td class="number" style="width: 5%">' + rst[i].¼ö·®
                                + '</td><td style="width: 10%">' + rst[i].·ÎÆ®¹øÈ£ + '</td><td style="width: 11.1%">' + rst[i].»ý»êºñ°í + '</td><td style="display:none">' + rst[i].ÀÔ°íÀüÇ¥ID + '</td></tr>';
                    };
                }else{
                    for(i = 0; i < rst.length; i++){
                        appendHTML += '<tr><td style="width: 8%">' + rst[i].»ý»êÀÏÀÚ + '</td><td style="width: 8%">' + rst[i].¹Ú¸®ÀÏÀÚ + '</td><td style="width: 7%">' + rst[i].Ã¢°í¸í + '</td><td style="width: 7%">' + rst[i].´ã´çÀÚ
                                + '</td><td class="select" style="width: 2%">' + rst[i].ºÐ´Ü»ç¿ë + '</td><td style="width: 7%">' + rst[i].Àåºñ±¸ºÐ
                                + '</td><td style="width: 13%">'+ rst[i].Ç°¸í + '</td><td style="width: 13%">' + rst[i].Ä®¶ó + '</td><td style="width: 8%">' + rst[i].»çÀÌÁî + '</td><td class="number" style="width: 5%">' + rst[i].¼ö·®
                                + '</td><td style="width: 10%">' + rst[i].·ÎÆ®¹øÈ£ + '</td><td style="width: 12%">' + rst[i].»ý»êºñ°í + '</td><td style="display:none">' + rst[i].ÀÔ°íÀüÇ¥ID + '</td></tr>';
                    };
                };
            };
            $("#forList_body").empty();
            $("#forList_body").append(appendHTML);
        }catch(err){
            alert(err.message);
        };
    };      //  ÀÇ·Ú¼­ Á¶È¸ end

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
    // ºÐ´Ü ±æÀÌ / ¼ö·® Ç×¸ñ ´Ã¸®±â
    // ------------------------------------------------------------------------
    function showTrTag(){
        try{
            var int = parseInt($("#countAdd").val());       //  ¸î¹øÂ° °ªÀÎÁö ÀúÀåÇÏ±â À§ÇÑ È÷µç°ª start 6
            var top = parseInt($("#topInt").val());       //  top À§Ä¡ ÀúÀåµÈ È÷µç°ª start 450
            var divHeight = parseInt($("#divHeight").val());        //  Å×ÀÌºí div height È÷µç°ª
            var tbodyHeight = parseInt($("#tbodyHeight").val());        //  Å×ÀÌºí tbody height È÷µç°ª
            if(int < 11){
                if (int > 5){        //  int ¹øÂ° tr ÅÂ±× display ¼Ó¼º º¯°æ
                    $("#insertTable tr:nth-child(" + int + ")").css("display", "table-row");
                    $("#addInput").text("+" + (int + 1));
                    $(".btn_add").css("top", (top + 40) + "px");
                };
            }else{
                return;
            };
            if(int > 7){        //  Å×ÀÌºí ´Ã¾îÁ®¼­ ÀüÃ¼ ½ºÅ©·Ñ »ý±â´Â°Í ¹æÁöÇÏ±â À§ÇØ ÀÚÃ¼ÀûÀÎ Å©±â Á¶Àý
                $(".div_forList").css("height", (divHeight - 40) + "px");
                $(".forList_body").css("height", (tbodyHeight - 40) + "px");
                $("#divHeight").val(parseInt($("#divHeight").val()) - 40);     //  È÷µç°ª ¼ýÀÚ - 40 Ã³¸®
                $("#tbodyHeight").val(parseInt($("#tbodyHeight").val()) - 40);     //  È÷µç°ª ¼ýÀÚ - 40 Ã³¸®
            };
            if(int == 10){      //  10 ¹øÂ°ÀÏ°æ¿ì ¹öÆ° ¾Èº¸ÀÌ°Ô
                $("#addInput").hide();
                return;
            };
            $("#countAdd").val(parseInt($("#countAdd").val()) + 1);     //  È÷µç°ª ¼ýÀÚ + 1 Ã³¸®
            $("#topInt").val(parseInt($("#topInt").val()) + 40);     //  È÷µç°ª ¼ýÀÚ + 40 Ã³¸®
        }catch(err){
            alert(err.message);
        };
    };      //  ºÐ´Ü ±æÀÌ / ¼ö·® Ç×¸ñ ´Ã¸®±â end

    // ------------------------------------------------------------------------
    // ºÐ´Ü ±æÀÌ / ¼ö·® Ç×¸ñ µ¥ÀÌÆ® ÀÖÀ¸¸é ¹Ù·Î ´Ã¸®±â
    // ------------------------------------------------------------------------
    function setTag(){
        for(i = 6; i < 11; i++){
            if($("#ºÐ´Ü·Ñ±æÀÌ" + i).val().length > 0){
                showTrTag();
            }else{
                return false;
            };
        };
    };
    

    // ------------------------------------------------------------------------
    // ÅõÀÔÃÑ¼ö·® ÇÔ¼ö
    // ------------------------------------------------------------------------
    function sum(){
        var roll_length = $("#ÅõÀÔ·Ñ±æÀÌ").val() == "" ? 0 : $("#ÅõÀÔ·Ñ±æÀÌ").val();
        var roll_cnt = $("#ÅõÀÔ·Ñ¼ö·®").val() == "" ? 0 : $("#ÅõÀÔ·Ñ¼ö·®").val();
        var roll_length2 = $("#ÅõÀÔ·Ñ±æÀÌ2").val() == "" ? 0 : $("#ÅõÀÔ·Ñ±æÀÌ2").val();
        var roll_cnt2 = $("#ÅõÀÔ·Ñ¼ö·®2").val() == "" ? 0 : $("#ÅõÀÔ·Ñ¼ö·®2").val();
        var roll_length3 = $("#ÅõÀÔ·Ñ±æÀÌ3").val() == "" ? 0 : $("#ÅõÀÔ·Ñ±æÀÌ3").val();
        var roll_cnt3 = $("#ÅõÀÔ·Ñ¼ö·®3").val() == "" ? 0 : $("#ÅõÀÔ·Ñ¼ö·®3").val();
        $("#ÅõÀÔÃÑ¼ö·®").val(parseInt(roll_length) * parseInt(roll_cnt) + parseInt(roll_length2) * parseInt(roll_cnt2) + parseInt(roll_length3) * parseInt(roll_cnt3));
    };      //  ÅõÀÔÃÑ¼ö·® ÇÔ¼ö end

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
    function checkEven(num){        //  È¦¼ö°¡ µé¾î¿À¸é false Â¦¼ö°¡ µé¾î¿À¸é true
        return (num % 2 == 0);
    };      //  È¦Â¦ ±¸ºÐÇÏ±â end



</script>

</head>

<body>
  
    <div class="TopBtn">
        <div id="title_bar">
            <img id="title_bar_img" src ="../image/title/title2.png">
            <p id="t_header">ºÐ´ÜÀÛ¾÷ÀÏÁö</p>
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
                        <input type="text" id="ÀÛ¾÷ÀÏÀÚ" class="input_tag input-field datepicker" max="9999-12-31" min="1970-01-01" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">Ã¢°í¸í</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="Ã¢°í¸í" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü±â</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Ü±â" class="input_tag input-field input-auto" autocomplete="off">
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

        <div class="item_insert">
            <table class="item">
                <tr>
                    <th class="th_01">
                        <label class="label_tag">Ç°¸í</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="Ç°¸í" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">Ä®¶ó</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="Ä®¶ó" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">»çÀÌÁî</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="»çÀÌÁî" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºñ°í</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ÅõÀÔºñ°í" class="input_tag input_tag_end_01 input-field" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔ±æÀÌ/¼ö·®</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="ÅõÀÔ·Ñ±æÀÌ" class="input_tag input_tag_insertCount_01 auto_sum_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="ÅõÀÔ·Ñ¼ö·®" class="input_tag input_tag_insertCount_02 auto_sum_01 input-number" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">·ÎÆ®¹øÈ£</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="¾ÆÀÌÅÛ·ÎÆ®¹øÈ£" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔÃÑ¼ö·®</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="ÅõÀÔÃÑ¼ö·®" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºÐ´ÜÃÑ¼ö·®</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´ÜÃÑ¼ö·®" class="input_tag input_tag_readonly_01 input_tag_end_01 input-number" tabindex="-1" readonly>
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔ±æÀÌ/¼ö·®</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="ÅõÀÔ·Ñ±æÀÌ2" class="input_tag input_tag_insertCount_01 auto_sum_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="ÅõÀÔ·Ñ¼ö·®2" class="input_tag input_tag_insertCount_02 auto_sum_01 input-number" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">·ÎÆ®¹øÈ£</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="¾ÆÀÌÅÛ·ÎÆ®¹øÈ£2" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔ±æÀÌ/¼ö·®</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="ÅõÀÔ·Ñ±æÀÌ3" class="input_tag input_tag_insertCount_01 auto_sum_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="ÅõÀÔ·Ñ¼ö·®3" class="input_tag input_tag_insertCount_02 auto_sum_01 input-number" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">·ÎÆ®¹øÈ£</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="¾ÆÀÌÅÛ·ÎÆ®¹øÈ£3" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>
            </table>
        </div>

        <div class="machine_insert">
            <table id="insertTable" class="machine">
                <tr id="tr_div_01">
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü±æÀÌ/¼ö·®</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="ºÐ´Ü·Ñ±æÀÌ1" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="ºÐ´Ü·Ñ¼ö·®1" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü¼ö·®</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Ü¼ö·®1" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü±¸ºÐ</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Ü±¸ºÐ1" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºñ°í</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Üºñ°í1" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
                
                <tr id="tr_div_2">
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü±æÀÌ/¼ö·®</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="ºÐ´Ü·Ñ±æÀÌ2" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="ºÐ´Ü·Ñ¼ö·®2" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü¼ö·®</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Ü¼ö·®2" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü±¸ºÐ</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Ü±¸ºÐ2" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºñ°í</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Üºñ°í2" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
                
                <tr id="tr_div_3">
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü±æÀÌ/¼ö·®</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="ºÐ´Ü·Ñ±æÀÌ3" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="ºÐ´Ü·Ñ¼ö·®3" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü¼ö·®</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Ü¼ö·®3" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü±¸ºÐ</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Ü±¸ºÐ3" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºñ°í</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Üºñ°í3" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
                
                <tr id="tr_div_4">
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü±æÀÌ/¼ö·®</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="ºÐ´Ü·Ñ±æÀÌ4" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="ºÐ´Ü·Ñ¼ö·®4" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü¼ö·®</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Ü¼ö·®4" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü±¸ºÐ</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Ü±¸ºÐ4" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºñ°í</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Üºñ°í4" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
                
                <tr id="tr_div_5">
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü±æÀÌ/¼ö·®</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="ºÐ´Ü·Ñ±æÀÌ5" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="ºÐ´Ü·Ñ¼ö·®5" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü¼ö·®</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Ü¼ö·®5" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü±¸ºÐ</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Ü±¸ºÐ5" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºñ°í</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Üºñ°í5" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
                
                <tr id="tr_div_6">
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü±æÀÌ/¼ö·®</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="ºÐ´Ü·Ñ±æÀÌ6" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="ºÐ´Ü·Ñ¼ö·®6" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü¼ö·®</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Ü¼ö·®6" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü±¸ºÐ</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Ü±¸ºÐ6" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºñ°í</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Üºñ°í6" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
                
                <tr id="tr_div_7">
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü±æÀÌ/¼ö·®</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="ºÐ´Ü·Ñ±æÀÌ7" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="ºÐ´Ü·Ñ¼ö·®7" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü¼ö·®</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Ü¼ö·®7" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü±¸ºÐ</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Ü±¸ºÐ7" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºñ°í</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Üºñ°í7" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
                
                <tr id="tr_div_8">
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü±æÀÌ/¼ö·®</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="ºÐ´Ü·Ñ±æÀÌ8" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="ºÐ´Ü·Ñ¼ö·®8" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü¼ö·®</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Ü¼ö·®8" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü±¸ºÐ</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Ü±¸ºÐ8" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºñ°í</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Üºñ°í8" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
                
                <tr id="tr_div_9">
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü±æÀÌ/¼ö·®</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="ºÐ´Ü·Ñ±æÀÌ9" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="ºÐ´Ü·Ñ¼ö·®9" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü¼ö·®</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Ü¼ö·®9" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü±¸ºÐ</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Ü±¸ºÐ9" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºñ°í</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Üºñ°í9" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
                
                <tr id="tr_div_10">
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü±æÀÌ/¼ö·®</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="ºÐ´Ü·Ñ±æÀÌ10" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="ºÐ´Ü·Ñ¼ö·®10" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü¼ö·®</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Ü¼ö·®10" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºÐ´Ü±¸ºÐ</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Ü±¸ºÐ10" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">ºñ°í</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ºÐ´Üºñ°í10" class="input_tag input_tag_end_01 input-field">
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
                            »ý»êÀÏÀÚ<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 8%">
                            ¹Ú¸®ÀÏÀÚ<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 7%">
                            Ã¢°í¸í<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 7%">
                            ´ã´çÀÚ<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 2%">
                            &nbsp;<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 7%">
                            Àåºñ±¸ºÐ<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 13%">
                            Ç°¸í<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 13%">
                            Ä®¶ó<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 8%">
                            »çÀÌÁî<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 5%">
                            ¼ö·®<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 10%">
                            ·ÎÆ®¹øÈ£<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 12%">
                            »ý»êºñ°í<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                    </tr>
                </thead>
                
                <tbody id="forList_body" class="forList_body">
                </tbody>
            </table>
        </div>
    </div>

          
<!-- hidden -->
<input type="hidden" id="ÀÛ¾÷½ÃÀÛ½Ã°£" class="input-field">
<input type="hidden" id="ÀÛ¾÷Á¾·á½Ã°£" class="input-field">
<input type="hidden" id="ÀÛ¾÷½Ã°£" class="input-field">

<input type="hidden" id="ÀÔ°íÀüÇ¥ID" class="input-field">
<input type="hidden" id="IP_Address" class="input-field">
<input type="hidden" id="WorkID" value="">

<input type="hidden" id="countAdd" value="6">
<input type="hidden" id="topInt" value="450">
<input type="hidden" id="divHeight" value="350">
<input type="hidden" id="tbodyHeight" value="300">

</body>
</HTML>