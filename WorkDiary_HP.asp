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
' WorkDiary_HP.asp  KYJ

Dim junID , P_Lot_NO
junID = request("junID")
P_Lot_NO = request("P_Lot_NO")

%>

<head>
<meta charset="utf-8">
<title>ÀÛ¾÷ÀÏÁöµî·Ï(ÇÕÆ÷ANDÄÚÆÃ)</title>
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

    /* °¢ ±¸¿ª ³ª´©±â / ±¸¿ªº° css ÀÛ¾÷ */
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

    /* tr ÅÂ±× */
    .tr_hide{ display: none;  }

    /* th ÅÂ±× */
    .th_01{ box-sizing: border-box; width: 5%; height: 40px; font-size: 13pt; border-spacing: 0px;  }
    .th_remark_01{ width: 10%;  }

    /* td ÅÂ±× */
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

    /* input ÅÂ±× */
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

            //    prk´Â ÀÛ¾÷ H_»ý»êÅõÀÔÀüÇ¥ Å×ÀÌºíÀÇ »ý»êÅõÀÔÀüÇ¥ID   grid ¿¡¼­ »ý¼ºÇØ¼­ °¡Á®¿À´Â°Í
            var prk = "<%=junID%>";

            if(seSawonid == ""){        //  ºÎ¸ð Ã¢¿¡¼­ Á¤º¸ À¯ÁöÁßÀÎÁö È®ÀÎ
                alert("·Î±×ÀÎ »óÅÂ¸¦ ´Ù½Ã È®ÀÎÇØ ÁÖ¼¼¿ä.");
                self.close();
            }else if(prk != ""){        //  prk = grid ¿¡¼­ »ý¼ºµÈ ¹øÈ£ ¿Ï·áµÈ ÀÛ¾÷ ºÒ·¯¿À±âÀÎÁö È®ÀÎ
                //  µ¥ÀÌÅÍºÒ·¯¿À±â
                init_disp(prk);     //  ¹øÈ£ °°ÀÌ Àü´Þ

                //  ±âÃÊ µ¥ÀÌÅÍ
                $("#OLDÀÛ¾÷ÀÏÀÚ").val($("#ÀÛ¾÷ÀÏÀÚ").val());
                $("#ÀÛ¾÷Ãë¼Ò").attr("disabled", true);
                $("#ÀÛ¾÷½ÃÀÛ").attr("disabled", true);
                $("#ÀÛ¾÷¼öÁ¤").css("display","inline");     //  ¼öÁ¤ ÇÒ¼öÀÖµµ·Ï ÀÛ¾÷¼öÁ¤ ¹öÆ° º¸ÀÌ°Ô
                $("#ÀÛ¾÷Á¾·á").attr("disabled", true);
                $("#»ý»ê·ÎÆ®¹øÈ£").val("<%=P_Lot_NO%>");

            }else if(prk == ""){        //  ¿Ï·áµÇÁö ¾ÊÀº ÀÛ¾÷ÀÏ¶§
                //  ±âÃÊ µ¥ÀÌÅÍ
                $("#ÀÛ¾÷¼öÁ¤").css("display","none");
                $(".btn_01_2").css("margin", "30px 5.8% 10px 0px");     //  ÀÛ¾÷ ¼öÁ¤ ¹öÆ°ÀÌ ¾Èº¸ÀÌ±â¶§¹®¿¡ ±×¿¡ ¸ÂÃç¼­ À§Ä¡ Á¶Á¤
                $("#ÀÛ¾÷ÀÏÀÚ").val(getDay());       //  ¿À´Ã·Î ÀÛ¼º
                $("#ÀÛ¾÷ÀÏÀÚ").attr("min", getDay());       //  ´Þ·Â¿¡¼­ ÀÌÀü ÀÏÀÚ ¼±ÅÃ ºÒ°¡´ÉÇÏµµ·Ï
                $("#ÀÛ¾÷ÀÏÀÚ").attr("max", getDay());       //  ´Þ·Â¿¡¼­ ÀÌÈÄ ÀÏÀÚ ¼±ÅÃ ºÒ°¡´ÉÇÏµµ·Ï
                $("#ÀÛ¾÷ÀÚ").val(seSawonname);

                //  Ã¢°í ¼±¾ð
                if(defaultStocID == 7){     //  ±âº»Ã¢°í ¹øÈ£¿¡ µû¶ó Ã¢°í¸í°ú ÀÛ¾÷ÀÏÁö ÀÌ¸§ ¼öÁ¤
                    $("#Ã¢°í¸í").val("ÇÕÆ÷Ã¢°í");
                    $("#t_header").text("ÇÕÆ÷ÀÛ¾÷ÀÏÁö");
                }else if(defaultStocID == 6){
                    $("#Ã¢°í¸í").val("ÄÚÆÃÃ¢°í");
                    $("#t_header").text("ÄÚÆÃÀÛ¾÷ÀÏÁö");
                };

                //  ¹Ì¿Ï·á µ¥ÀÌÅÍ È®ÀÎ
                var work_id = work_check($("#Ã¢°í¸í").val(), $("#ÀÛ¾÷ÀÏÀÚ").val(), $("#ÀÛ¾÷ÀÚ").val());     //  Ã¢°í¸í, ÀÛ¾÷ÀÏÀÚ, ÀÛ¾÷ÀÚ ÆÄ¶ó¸ÞÅ¸·Î Àü´Þ

                //  ¹Ì¿Ï·á µ¥ÀÌÅÍ¿¡ µû¶ó ÁøÇàÁß»óÅÂ È¤Àº »õ·Î ÁøÇàÇÒÁö ÁØºñ
                if(work_id != ""){      //  ¹Ì¿Ï·á µ¥ÀÌÅÍ°¡ ÀÖÀ½À¸·Î ÀÛ¾÷ÁøÇà»óÅÂ
                    remain_disp(work_id);       //  ÁøÇàÁßÀÎ workid ÆÄ¶ó¸ÞÅ¸·Î Àü´Þ
                    prk = 1;        //  ½ÃÀÛ Æ÷Ä¿½º ÁöÁ¤ÇÏÁö ¾Êµµ·Ï prk 1·Î ¼³Á¤ prk Ã£¾Æ°¡¸é ÀÌÀ¯ ¾Ë¼öÀÖÀ½
                    $("#ÀÛ¾÷½ÃÀÛ").attr("disabled", true);
                }else{      //  ¹Ì¿Ï·á µ¥ÀÌÅÍ ¾øÀ½À¸·Î ÀÛ¾÷½ÃÀÛÁØºñ
                    $("#ÀÛ¾÷Á¾·á").attr("disabled", true);
                    auto_set_date($("#ÀÛ¾÷ÀÏÀÚ").val());        //  °°Àº³¯¿¡ ¿Âµµ, ½Àµµ µî µ¥ÀÌÅÍ ÀÖÀ»°æ¿ì ºÒ·¯¿À±â
                };
            };    //  ÃÊ±â µ¥ÀÌÅÍ ¼³Á¤ end

            // ------------------------------------------------------------------------
            // ÀÛ¾÷½ÃÀÛ ¹öÆ° Å¬¸¯
            // ------------------------------------------------------------------------
            $("#ÀÛ¾÷½ÃÀÛ").on("click", function(){
                if(save() == true){		//  ÀÛ¾÷ ½ÃÀÛ ÈÄ ¹öÆ° Á¦¾î
                    $("#ÀÛ¾÷½ÃÀÛ").attr("disabled", true);
                    $("#ÀÛ¾÷Á¾·á").attr("disabled", false);
                };
            });   //  ÀÛ¾÷½ÃÀÛ ¹öÆ° end

            // ------------------------------------------------------------------------
            // ÀÛ¾÷Á¾·á ¹öÆ° Å¬¸¯
            // ------------------------------------------------------------------------
            $("#ÀÛ¾÷Á¾·á").on("click", function(){
                if(inven_check() == true){		//	¼öÁ¤½Ã ÀÔ·Â°ª È®ÀÎ
                    if(save() == true){
                        alert("ÀúÀåµÇ¾ú½À´Ï´Ù.");
                        opener.main_bind();
                        self.close();
                    };
                };
            });   //  ÀÛ¾÷Á¾·á ¹öÆ° end

            // ------------------------------------------------------------------------
            // ÀÛ¾÷Ãë¼Ò ¹öÆ° Å¬¸¯
            // ------------------------------------------------------------------------
            $("#ÀÛ¾÷Ãë¼Ò").on("click", function(){
                if(confirm("Á¤¸» Ãë¼ÒÇÏ½Ã°Ú½À´Ï±î ?") == true){
                    if($("#ÀÛ¾÷½ÃÀÛ½Ã°£").val() == ""){     //  ÀÛ¾÷½ÃÀÛ½Ã°£ À¯¹«·Î ÀÛ¾÷ ½ÃÀÛ È®ÀÎ
                        alert("ÀÛ¾÷ÀÌ ½ÃÀÛµÇ¾ú´ÂÁö ´Ù½Ã È®ÀÎÇØÁÖ¼¼¿ä.");
                    }else{
                        var wareHouse = $("#Ã¢°í¸í").val();
                        var delSawonName = $("#ÀÛ¾÷ÀÚ").val();
                        var delGubun = wareHouse == "ÇÕÆ÷Ã¢°í" ? "2" : wareHouse == "ÄÚÆÃÃ¢°í" ? "3" : "false";         //  1 : ¾ÐÃâ, 2 : ÇÕÆ÷, 3 : ÄÚÆÃ, 4 : ºÐ´Ü, 5 : Àç´Ü
                        var delWorkId = $("#WorkID").val();
                        if(delGubun == "false"){
                            alert("ÁöÁ¤ Ã¢°í¸¦ ÀçÈ®ÀÎ ÇØÁÖ¼¼¿ä.");
                            return false;
                        };
                        var rst = Get_Json("EXEC RF_PROD_PDA_RFÅõÀÔ_ERP_CLEAR '" + delSawonName + "', '" + delGubun + "', '" + delWorkId + "'");
                        alert(rst[0].MSG);
                        location.reload();
                    };
                };
            });   //  ÀÛ¾÷Ãë¼Ò ¹öÆ° end

            // ------------------------------------------------------------------------
            // ÀÛ¾÷¼öÁ¤ ¹öÆ° Å¬¸¯
            // ------------------------------------------------------------------------
            $("#ÀÛ¾÷¼öÁ¤").on("click", function(){		//	ÀÔ·Â Ç×¸ñ ¼öÁ¤ÇÒ¼ö ÀÖµµ·Ï º¯°æ
                $(".input-field, .input-number").attr("disabled", false);
                $("#ÀÛ¾÷Á¾·á").attr("disabled", false);
                $("#ÀÛ¾÷¼öÁ¤").attr("disabled", true);

            });   //  ÀÛ¾÷¼öÁ¤ ¹öÆ° end

            // ------------------------------------------------------------------------
            // »ý»ê¼ö·® ÀÚµ¿°è»ê
            // ------------------------------------------------------------------------
            $('.auto_sum').on("keyup", function(){
                var pro_count = 0;		//	ÀÚµ¿ °è»êÇÒ °ª ´ãÀ» º¯¼ö ¼±¾ð
                for(i = 1; i < 5; i++){     //  1~ 4±îÁö ¹Ýº¹
                    if($("#»ý»ê·Ñ±æÀÌ" + i).val() + "" != "" && $("#»ý»ê·Ñ¼ö·®" + i).val() + "" != ""){		//	ÀÔ·Â°ª À¯¹« È®ÀÎ ÀÔ·Â°ªÀÌ ÀÖÀ»¶§ °è»ê ½ÇÇà
                        pro_count = pro_count + parseInt($("#»ý»ê·Ñ±æÀÌ" + i).val()) * parseInt($("#»ý»ê·Ñ¼ö·®" + i).val());
                    };
                };
                $("#»ý»ê¼ö·®").val(pro_count);		//	°è»êµÈ °ª »ý»ê¼ö·®¿¡ ´ëÀÔ
            });   //  »ý»ê¼ö·® ÀÚµ¿°è»ê end

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
                var e = $.Event("keydown", {        // autocomplete ¿Ï·á½Ã °Ë»ö³»¿ë È®Àå µÇµµ·Ï ¾Æ·¡¹æÇâÅ° Æ®¸®°Å ¸¸µé±â
                    keyCode : 40         //  ¾Æ·¡¹æÇâÅ° Å°ÄÚµå 40   µÚ¿¡ ¼¼¹ÌÄÝ·Ð ºÙÀÌ¸é ¿À·ù³²
                });
                var t_this = this;		//	setTimeout¿¡¼­ this ¸¦ »ç¿ëÇÏ¸é this°ªÀÌ º¯ÇÏ±â ¶§¹®¿¡ »çÀü¿¡ this¸¦ t_this¿¡ ´ã±â
                setTimeout(function(){      //  ¹Ù·Î ½ÇÇà½Ã autoFocus ¹ö±×·Î ÀÎÇØ Æ÷Ä¿½º »ç¶óÁü setTimeout ¼³Á¤½Ã ¹ö±× »ç¶óÁü
                    $(t_this).trigger(e);        // ¾Æ·¡ ¹æÇâÅ° Æ®¸®°Å ÀÛµ¿
                }, 100);
                if(this.id == "³¯¾¾" || this.id == "Àåºñ±¸ºÐ"){     // ¿ÀÅäÆ÷Ä¿½º Áö¿ì°í ÀÌ°Å Ãß°¡ÇÔ
                    return;
                }else{
                    $(this).trigger(e);
                };
            });   //  ¾Æ·¡¹æÇâÅ° Æ®¸®°Å end

            $("#³¯¾¾, #Àåºñ±¸ºÐ").on("focus", function(){      // ÀÌ°ÉÇØ¾ß ÀÔ·Â°ª°ú »ó°ü¾øÀÌ °Ë»ö¾î Ã¢À» º¸¿©ÁÖ´Âµ¥ ±×·¯¸é autoFocus°¡ °íÀå³²...
                $(this).autocomplete("search", "");             // ±×·¡¼­ autoFocus Áö¿ì°í Æ®¸®°Å·Î autoFocus ´ë½Å Ãß°¡ ÀÛ¼ºÇÔ
            });

            // ------------------------------------------------------------------------	
            // ÅõÀÔ¼ö·® old ÀúÀå                                                                                    ¼öÁ¤ ¿¡¼­¸¸ »ç¿ë ?
            // ------------------------------------------------------------------------	
            $(".must_03_04").focusin(function(){
                var className = $(".must_03_04");
                var className_old = $(".oldGlu");
                if((prk > 1) && $("#OLDÀÛ¾÷ÀÏÀÚ").val() == $("#ÀÛ¾÷ÀÏÀÚ").val()){
                    for(i = 1; i < className.length; i++){
                        if($("#" + className_old[i].id + "").val() == "0"){
                            $("#" + className_old[i].id + "").val($("#" + className[i].id + "").val());
                        };
                    };
                };
            });   //  ÅõÀÔ¼ö·® old ÀúÀå end

            // ------------------------------------------------------------------------
            // #Heating 2 ¶óÀÎ º¸ÀÌ±â ¶óº§ Å¬¸¯½Ã
            // ------------------------------------------------------------------------
            $("#Heating").on("click", function(){
                $(".tr_hide").toggle();     //  º¸ÀÌ°Ô ¾Èº¸ÀÌ°Ô ÇÏ´Â Method
                // if($(".tr_hide").css("display") == "none"){      //  display »óÅÂ¸¦ È®ÀÎÇÏ°í display »óÅÂ¸¦ º¯°æ
                //     $(".tr_hide").slideDown("slow");       //  slideDown / slideUp ¾²·Á¸é jquery ¹öÀü ¹Ù²ã¾ß ÇÔ /jquery/3.6.4/jquery.min.js
                //     $(".tr_hide").css("display", "table");
                // }else{
                //     $(".tr_hide").css("display", "none");
                //     $(".tr_hide").slideUp("slow");
                // };
            });   //  ¶óÀÎ º¸ÀÌ±â end

            // ------------------------------------------------------------------------
            // #Heating 2 ¶óÀÎ º¸ÀÌ±â2 input Æ÷Ä¿½º½Ã
            // ------------------------------------------------------------------------
            $("#Heating_SV, #Heating_PV").on("focus", function(){       //  toggle »ç¿ë½Ã È­¸éÀÌ ¿­·ÁÀÖÀ»¶§´Â »ç¶óÁö±â ¶§¹®¿¡ css Method·Î º¸ÀÌ°Ô¸¸ Ã³¸®
                if($(".tr_hide").css("display") == "none"){     //  display »óÅÂ¸¦ È®ÀÎÇÏ°í display »óÅÂ¸¦ º¯°æ
                    $(".tr_hide").css("display", "table");
                };
            });   //  ¶óÀÎ º¸ÀÌ±â end

            // ------------------------------------------------------------------------	
            // ½ÃÀÛ½Ã Æ÷Ä¿½º
            // ------------------------------------------------------------------------	
            if(prk + "" == ""){     //  ºÒ·¯¿Ã ÀÛ¾÷ÀÌ ¾øÀ»¶§¸¸ ½ÇÇàµÇ´Â°ÍÀÌ³ª ¸¶Âù°¡Áö
                $("#Àåºñ±¸ºÐ").focus();
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
            var rst = Get_Json("B_WORK_LST 'G_WorkDiary_ÇÕÆ÷', " + id);		//	µ¥ÀÌÅÍ °¡Á®¿Àµµ·Ï sql ½ÇÇà
            if(rst[0].WorkID == "" || rst[0].WorkID == " " || rst[0].WorkID == null){
                alert("ÀÛ¾÷ÀÏÁö°¡ µî·ÏµÇÁö ¾Ê¾Ò½À´Ï´Ù.");
                self.close();
            }else{
                $("#WorkID").val(rst[0].WorkID);
                $("#Ã¢°í¸í").val(rst[0].Ã¢°í¸í);
                if($("#Ã¢°í¸í").val() == "ÇÕÆ÷Ã¢°í"){
                    $("#t_header").text("ÇÕÆ÷ÀÛ¾÷ÀÏÁö");
                }else if($("#ÄÚÆÃÃ¢°í")){
                    $("#t_header").text("ÄÚÆÃÀÛ¾÷ÀÏÁö");
                };
                $(".input-field, .input-number, .input-readonly").each(function(){
                    $(this).attr("disabled", true);      //  ÀÐ±â Àü¿ëÀ¸·Î ºÒ·¯¿À±â
                    if($(this).attr("type") == "text" || $(this).attr("type") == "date" || $(this).attr("type") == "textarea" || $(this).attr("type") == "hidden"){		// °¡Á®¿Â µ¥ÀÌÅÍ inputÇ×¸ñ¿¡ ÀÔ·Â
                        var field = rst[0][this.id] + "";
                        field = (field == 0 || field == "null") ? "" : field;
                        if(this.id == "ÀÛ¾÷ÀÏÀÚ"){		//	ÀÛ¾÷ÀÏÀÚÀÇ °æ¿ì µ¥ÀÌÅÍ ÀÏºÎ ¼öÁ¤
                            $("#" + this.id).val(field.substring(0, 10));       //  db¿¡ ÀúÀåµÈ ÀÛ¾÷ÀÏÀÚ¿¡ ½Ã°£°ª Á¦°Å
                        // }else if(this.id == "ÀÛ¾÷½ÃÀÛ½Ã°£"){
                        //     $("#" + this.id).val(field.substring(11, 16));      //  db¿¡ ÀúÀåµÈ ÀÛ¾÷½ÃÀÛ½Ã°£¿¡ ³¯ÀÚ°ª Á¦°Å
                        // }else if(this.id == "ÀÛ¾÷Á¾·á½Ã°£"){     //  ³¯ÀÚ°ª Á¦°ÅÇÒ ÀÌÀ¯°¡ ¾øÀ½À¸·Î ±×´ë·Î °¡Á®¿À±â
                        //     $("#" + this.id).val(field.substring(11, 16));      //  db¿¡ ÀúÀåµÈ ÀÛ¾÷Á¾·á½Ã°£¿¡ ³¯ÀÚ°ª Á¦°Å
                        }else{
                            $("#" + this.id).val(field);
                        };
                    }else if($(this).attr("type") == "checkbox"){		//	Ã¼Å©¹Ú½ºÀÇ °æ¿ì Ã¼Å© ÇüÅÂ·Î ÀÔ·Â
                        $("input:checkbox[id='" + this.id + "']").prop("checked", rst[0][this.id]);        //  ±Û·ç ¿©ºÎ È®ÀÎ
                    };
                });
                if($("#±Û·ç").is(":checked")){      //  ±Û·ç ¿©ºÎ È®ÀÎÈÄ ³»¿ë ¼öÁ¤
                    $("#±Û·ç¿©ºÎ").text("±Û·ç");
                    $("#±Û·çºñ°í").css("background-color", "#FFEAD5");    
                };
                for(i = 1; i < 11; i++){        //  Ãß°¡ ±Û·ç ¿©ºÎ È®ÀÎÈÄ ³»¿ë ¼öÁ¤
                    if($("#±Û·ç" + i).is(":checked")){
                        $("#±Û·ç¿©ºÎ" + i).text("±Û·ç" + i);
                        $("#¿ø´Üºñ°í" + i).css("background-color", "#FFEAD5");    
                    };
                };
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
            var rst = Get_Json("B_WORK_CHECK 'G_WorkDiary_ÇÕÆ÷', '" + war_name + "', '" + work_date + "', '" + worker + "'");

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
            var rst = Get_Json("B_WORK_LST_REMAIN 'G_WorkDiary_ÇÕÆ÷'," + id);		//	¾ÐÃâÅ×ÀÌºí¿¡ ÀúÀåµÈ µ¥ÀÌÅÍÁß ÁøÇàÁßÀÎ µ¥ÀÌÅÍ ¹ÝÈ¯
            if(rst[0].WorkID != ""){		//	ÁøÇàÁßÀÎ µ¥ÀÌÅÍ°¡ ÀÖÀ»°æ¿ì ½ÇÇà
                $("#WorkID").val(rst[0].WorkID);
                $("#Ã¢°í¸í").val(rst[0].Ã¢°í¸í);
                $(".input-field, .input-number, .input-readonly").each(function(){
                    if($(this).attr("type") == "text" || $(this).attr("type") == "date" || $(this).attr("type") == "textarea" || $(this).attr("type") == "hidden"){
                        var field = rst[0][this.id] + "";
                        field = ((field == 0 || field == "null") ? "" : field);
                        if(this.id == "ÀÛ¾÷ÀÏÀÚ"){
                            $("#" + this.id).val(field.substring(0, 10));       //  db¿¡ ÀúÀåµÈ ÀÛ¾÷ÀÏÀÚ¿¡ ½Ã°£°ª Á¦°Å
                        // }else if(this.id == "ÀÛ¾÷½ÃÀÛ½Ã°£"){
                        //     $("#" + this.id).val(field.substring(11, 16));       //  db¿¡ ÀúÀåµÈ ÀÛ¾÷½ÃÀÛ½Ã°£¿¡ ³¯ÀÚ°ª Á¦°Å
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
            $('.input-field, .input-number, .input-readonly').each(function(){
                if($(this).attr("type") == "text" || $(this).attr("type") == "date" || $(this).attr("type") == "hidden" || $(this).attr("type") == "textarea"){
                    t_val = $(this).val();
                }else if($(this).attr("type") == "checkbox"){
                    t_val = ($(this).is(":checked") == true ? 1 : 0);
                }else if($(this).attr("type") == "select-one"){
                    t_val = ($(this).val() == null ? 0 : $(this).val());
                };
                if(this.id.includes("¿Âµµ") || this.id.includes("Àå·Â") || this.id == "¿ÍÀÎµù¼Óµµ" || this.id == "RPM"){
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
            var insert = Get_Json("EXEC [AA_WORKDIARY_ÇÕÆ÷ANDÄÚÆÃ] '" + id + "', '" + WorkID + "'" + save_data + "");		//	save_data ¼±¾ð½Ã ¸¶Áö¸·¿¡ ' Æ÷ÇÔµÇ¾îÀÖ¾î ' ÀÖÀ¸¸é ¿À·ù¹ß»ý
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
    // Àç°íÈ®ÀÎ ÀÛ¾÷ Á¾·áÀü ÀÛµ¿        ÀÛ¾÷ ¼öÁ¤½Ã¿¡ ÀÛµ¿ÇÏ´Â°ÍÀ¸·Î ÀÎÁö
    // ------------------------------------------------------------------------
    function inven_check(){
        try{
            var gluName = $(".must_03_01");		//	±Û·çÇ°¸í ¹è¿­
            var gluColor = $(".must_03_02");		//	±Û·çÄÃ·¯ ¹è¿­
            var gluSize = $(".must_03_03");		//	±Û·ç»çÀÌÁî ¹è¿­
            var gluCount = $(".must_03_04");		//	±Û·ç¼ö·® ¹è¿­
            var oldGlu = $(".oldGlu");		//	±âÁ¸±Û·ç¼ö·® ¹è¿­
            for(i = 0; i < gluName.length; i++){
                if(isNaN(oldGlu[i].value) == false){
                    if(gluCount[i].value != "" || gluCount[i].value != 0){
                        var count = gluCount[i].value - oldGlu[i].value;
                        if(stock_chk(gluName[i].value, gluColor[i].value, gluSize[i].value, count) == false){
                            if(gluName[i].id == "±Û·çÇ°¸í"){
                                alert("ÀÌÇüÁö Àç°í ¼ö·®ÀÌ ºÎÁ·ÇÕ´Ï´Ù.\nÀç°í¼ö·® È®ÀÎ ÈÄ ÅõÀÔÇÏ¼¼¿ä.");
                                $("#" + gluCount[i].id + "").focus();
                                return false;
                            }else if(gluName[i].id == ("¿ø´ÜÇ°¸í" + i)){
                                alert("ÅõÀÔÇ° Àç°í¼ö·®ÀÌ ºÎÁ·ÇÕ´Ï´Ù.\nÀç°í¼ö·® È®ÀÎ ÈÄ ÅõÀÔÇÏ¼¼¿ä.");
                                $("#" + gluCount[i].id + "").focus();
                                return false;
                            };    //  ÀÌÇüÁöÀÎÁö ÅõÀÔÇ°ÀÎÁö
                        };
                    };
                };
            };
            return true;
        }catch(err){
            alert(err.message);
        };
    };    //  Àç°í°Ë»ç end

    // ------------------------------------------------------------------------
    //  Àç°í°Ë»ç ¾ÈÀÇ ÇÔ¼ö
    // ------------------------------------------------------------------------
    function stock_chk(item, color, size, cnt){
        try{
            var enabled = 0;
            var date = $("#ÀÛ¾÷ÀÏÀÚ").val();
            var wareID = defaultStocID;   //    5 : ¾ÐÃâÃ¢°í, 7 : ÇÕÆ÷Ã¢°í, 6 : ÄÚÆÃÃ¢°í
            var rst_item = Get_Json("SELECT * FROM [dbo].[Get_ITEMSIZE](1) WHERE ¾ÆÀÌÅÛÇ°¸í = '" + item + "' AND Ä®¶ó = '" + color + "' AND »çÀÌÁî = '" + size + "'");
            var itemID = rst_item[0].¾ÆÀÌÅÛID;
            var colorID = rst_item[0].Ä®¶óID;
            var sizeID = rst_item[0].»çÀÌÁîID;
            var rst_check = Get_Json("EXEC [H_Stock_NEW_CHUL_CHECK_RST] '" + date + "', '" + wareID + "', '" + itemID + "', '" + colorID + "', '" + sizeID + "', '" + cnt + "', '»ý»êÅõÀÔÀüÇ¥', 0");
            enabled = rst_check[0].ENABLED;
            return enabled;
        }catch(err){
            alert(err.message);
        };
    };    //  Àç°í°Ë»ç end

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
            var item = "";
            var color = "";
            var size = "";
            var Stoc = $("#Ã¢°í¸í").val();
            if(id == "Àåºñ±¸ºÐ"){		//	±âº» Ã¢°í¿¡ µû¶ó °Ë»ö¾î ´Þ¶óÁöµµ·Ï
                var gubun_text = Stoc == "ÇÕÆ÷Ã¢°í" ? "L%" : Stoc == "ÄÚÆÃÃ¢°í" ? "C%" : false;
                if(gubun_text == false){
                    dontFocus = 1;      // ÀÚµ¿¿Ï¼º È­»ìÇ¥ Æ®¸®°Å¸¸ ÀÛµ¿ÇÏµµ·Ï ÀÛ¾÷
                    alert("±âº»Ã¢°í¸¦ ÀçÈ®ÀÎ ÇØÁÖ¼¼¿ä.");
                    return false;
                }else{
                    t_sql = "EXEC AA_WORKDIARY_Search '" + gubun_text + "', 'Àåºñ±¸ºÐ', ''";
                };
            }else if(id == "³¯¾¾"){		//	³¯¾¾ÀÇ °æ¿ì ½ÇÇà sql¹® ÁöÁ¤
                t_sql = "EXEC AA_WORKDIARY_Search '', '³¯¾¾', ''";
            }else if(id.includes("Ä®¶ó")){		//	Ä®¶óid¿¡ ¸ÂÃç Ç°¸í id º¯°æ
                item = id == "Ä®¶ó" ? "Ç°¸í" : id == "±Û·çÄ®¶ó" ? "±Û·çÇ°¸í" : id == "¿ø´ÜÄ®¶ó1" ? "¿ø´ÜÇ°¸í1" : id == "¿ø´ÜÄ®¶ó2" ? "¿ø´ÜÇ°¸í2" : id == "¿ø´ÜÄ®¶ó3" ? "¿ø´ÜÇ°¸í3" 
                        : id == "¿ø´ÜÄ®¶ó4" ? "¿ø´ÜÇ°¸í4" : id == "¿ø´ÜÄ®¶ó5" ? "¿ø´ÜÇ°¸í5" : id == "¿ø´ÜÄ®¶ó6" ? "¿ø´ÜÇ°¸í6" : id == "¿ø´ÜÄ®¶ó7" ? "¿ø´ÜÇ°¸í7" : id == "¿ø´ÜÄ®¶ó8" ? "¿ø´ÜÇ°¸í8" 
                        : id == "¿ø´ÜÄ®¶ó9" ? "¿ø´ÜÇ°¸í9" : "¿ø´ÜÇ°¸í10";
                if($("#" + item).val() == ""){
                    dontFocus = 1;      // ÀÚµ¿¿Ï¼º È­»ìÇ¥ Æ®¸®°Å¸¸ ÀÛµ¿ÇÏµµ·Ï ÀÛ¾÷
                    alert("Ç°¸íÀ» ÀÔ·ÂÇØ ÁÖ¼¼¿ä.");
                    $("#" + item).focus();
                    return false;
                }else{
                    t_sql = "EXEC AA_WORKDIARY_Search '', 'Ä®¶ó', '" + $("#" + item).val() + "'";
                };
            }else if(id.includes("»çÀÌÁî")){		//	»çÀÌÁîid¿¡ ¸ÂÃç Ç°¸í id º¯°æ
                item = id == "»çÀÌÁî" ? "Ç°¸í" : id == "±Û·ç»çÀÌÁî" ? "±Û·çÇ°¸í" : id == "¿ø´Ü»çÀÌÁî1" ? "¿ø´ÜÇ°¸í1" : id == "¿ø´Ü»çÀÌÁî2" ? "¿ø´ÜÇ°¸í2" : id == "¿ø´Ü»çÀÌÁî3" ? "¿ø´ÜÇ°¸í3" 
                        : id == "¿ø´Ü»çÀÌÁî4" ? "¿ø´ÜÇ°¸í4" : id == "¿ø´Ü»çÀÌÁî5" ? "¿ø´ÜÇ°¸í5" : id == "¿ø´Ü»çÀÌÁî6" ? "¿ø´ÜÇ°¸í6" : id == "¿ø´Ü»çÀÌÁî7" ? "¿ø´ÜÇ°¸í7" : id == "¿ø´Ü»çÀÌÁî8" ? "¿ø´ÜÇ°¸í8" 
                        : id == "¿ø´Ü»çÀÌÁî9" ? "¿ø´ÜÇ°¸í9" : "¿ø´ÜÇ°¸í10";
                color = id == "»çÀÌÁî" ? "Ä®¶ó" : id == "±Û·ç»çÀÌÁî" ? "±Û·çÄ®¶ó" : id == "¿ø´Ü»çÀÌÁî1" ? "¿ø´ÜÄ®¶ó1" : id == "¿ø´Ü»çÀÌÁî2" ? "¿ø´ÜÄ®¶ó2" : id == "¿ø´Ü»çÀÌÁî3" ? "¿ø´ÜÄ®¶ó3"
                        : id == "¿ø´Ü»çÀÌÁî4" ? "¿ø´ÜÄ®¶ó4" : id == "¿ø´Ü»çÀÌÁî5" ? "¿ø´ÜÄ®¶ó5" : id == "¿ø´Ü»çÀÌÁî6" ? "¿ø´ÜÄ®¶ó6" : id == "¿ø´Ü»çÀÌÁî7" ? "¿ø´ÜÄ®¶ó7" : id == "¿ø´Ü»çÀÌÁî8" ? "¿ø´ÜÄ®¶ó8" 
                        : id == "¿ø´Ü»çÀÌÁî9" ? "¿ø´ÜÄ®¶ó9" : "¿ø´ÜÄ®¶ó10";
                if($("#" + item).val() == ""){
                    dontFocus = 1;      // ÀÚµ¿¿Ï¼º È­»ìÇ¥ Æ®¸®°Å¸¸ ÀÛµ¿ÇÏµµ·Ï ÀÛ¾÷
                    alert("Ç°¸íÀ» ÀÔ·ÂÇØ ÁÖ¼¼¿ä.");
                    $("#" + item).focus();
                    return false;
                }else if($("#" + color).val() == ""){
                    dontFocus = 1;      // ÀÚµ¿¿Ï¼º È­»ìÇ¥ Æ®¸®°Å¸¸ ÀÛµ¿ÇÏµµ·Ï ÀÛ¾÷
                    alert("»çÀÌÁî¸¦ ÀÔ·ÂÇØ ÁÖ¼¼¿ä.");
                    $("#" + color).focus();
                    return false;
                }else{
                    t_sql = "EXEC AA_WORKDIARY_Search '', '»çÀÌÁî', '" + $("#" + item).val() + "'";
                };
            }else if(id.includes("·ÎÆ®¹øÈ£")){		//	·ÎÆ®¹øÈ£ ¼ø¹ø¿¡ µû¶ó ¿¬°áÇÏ´Â Ç°¸í, Ä®¶ó, »çÀÌÁî º¯°æ
                item = id == "±Û·ç·ÎÆ®¹øÈ£" ? "±Û·çÇ°¸í" : id == "¿ø´Ü·ÎÆ®¹øÈ£1" ? "¿ø´ÜÇ°¸í1" : id == "¿ø´Ü·ÎÆ®¹øÈ£2" ? "¿ø´ÜÇ°¸í2" : id == "¿ø´Ü·ÎÆ®¹øÈ£3" ? "¿ø´ÜÇ°¸í3" 
                        : id == "¿ø´Ü·ÎÆ®¹øÈ£4" ? "¿ø´ÜÇ°¸í4" : id == "¿ø´Ü·ÎÆ®¹øÈ£5" ? "¿ø´ÜÇ°¸í5" : id == "¿ø´Ü·ÎÆ®¹øÈ£6" ? "¿ø´ÜÇ°¸í6" : id == "¿ø´Ü·ÎÆ®¹øÈ£7" ? "¿ø´ÜÇ°¸í7" 
                        : id == "¿ø´Ü·ÎÆ®¹øÈ£8" ? "¿ø´ÜÇ°¸í8" : id == "¿ø´Ü·ÎÆ®¹øÈ£9" ? "¿ø´ÜÇ°¸í9" : "¿ø´ÜÇ°¸í10";
                color = id == "±Û·ç·ÎÆ®¹øÈ£" ? "±Û·çÄ®¶ó" : id == "¿ø´Ü·ÎÆ®¹øÈ£1" ? "¿ø´ÜÄ®¶ó1" : id == "¿ø´Ü·ÎÆ®¹øÈ£2" ? "¿ø´ÜÄ®¶ó2" : id == "¿ø´Ü·ÎÆ®¹øÈ£3" ? "¿ø´ÜÄ®¶ó3" 
                        : id == "¿ø´Ü·ÎÆ®¹øÈ£4" ? "¿ø´ÜÄ®¶ó4" : id == "¿ø´Ü·ÎÆ®¹øÈ£5" ? "¿ø´ÜÄ®¶ó5" : id == "¿ø´Ü·ÎÆ®¹øÈ£6" ? "¿ø´ÜÄ®¶ó6" : id == "¿ø´Ü·ÎÆ®¹øÈ£7" ? "¿ø´ÜÄ®¶ó7" 
                        : id == "¿ø´Ü·ÎÆ®¹øÈ£8" ? "¿ø´ÜÄ®¶ó8" : id == "¿ø´Ü·ÎÆ®¹øÈ£9" ? "¿ø´ÜÄ®¶ó9" : "¿ø´ÜÄ®¶ó10";
                size = id == "±Û·ç·ÎÆ®¹øÈ£" ? "±Û·ç»çÀÌÁî" : id == "¿ø´Ü·ÎÆ®¹øÈ£1" ? "¿ø´Ü»çÀÌÁî1" : id == "¿ø´Ü·ÎÆ®¹øÈ£2" ? "¿ø´Ü»çÀÌÁî2" : id == "¿ø´Ü·ÎÆ®¹øÈ£3" ? "¿ø´Ü»çÀÌÁî3" 
                        : id == "¿ø´Ü·ÎÆ®¹øÈ£4" ? "¿ø´Ü»çÀÌÁî4" : id == "¿ø´Ü·ÎÆ®¹øÈ£5" ? "¿ø´Ü»çÀÌÁî5" : id == "¿ø´Ü·ÎÆ®¹øÈ£6" ? "¿ø´Ü»çÀÌÁî6" : id == "¿ø´Ü·ÎÆ®¹øÈ£7" ? "¿ø´Ü»çÀÌÁî7" 
                        : id == "¿ø´Ü·ÎÆ®¹øÈ£8" ? "¿ø´Ü»çÀÌÁî8" : id == "¿ø´Ü·ÎÆ®¹øÈ£9" ? "¿ø´Ü»çÀÌÁî9" : "¿ø´Ü»çÀÌÁî10";
                if($("#" + item).val() == "" || $("#" + color).val() == "" || $("#" + size).val() == ""){
                    dontFocus = 1;      // ÀÚµ¿¿Ï¼º È­»ìÇ¥ Æ®¸®°Å¸¸ ÀÛµ¿ÇÏµµ·Ï ÀÛ¾÷
                    alert("·ÎÆ®¹øÈ£¸¦ È®ÀÎÇÏ±â À§ÇØ\nÅõÀÔÇ° ÀÔ·Â Á¤º¸¸¦ ÀçÈ®ÀÎ ÇØÁÖ¼¼¿ä.");
                    var focus = $("#" + item).val() == "" ? item : $("#" + color).val() == "" ? color : size;
                    $("#" + focus).focus();
                    return false;
                }else{
                    t_sql = "EXEC [AA_WORKDIARY_LOTNO] '', '" + $("#ÀÛ¾÷ÀÚ").val() + "', '" + $("#" + item).val() + "', '" + $("#" + color).val() + "', '" + $("#" + size).val() + "', '" + Stoc + "'";
                };
            };
            var find_rst = "";		//	½ÇÇà½ÃÅ³ sql¹® ´ãÀ» º¯¼ö »ý¼º
            var find_data_array = new Array();		//	sqlÀÇ Á¤º¸ ¹ÝÈ¯ ¹ÞÀ» µ¥ÀÌÅÍ Array »ý¼º
            if(id.includes("Ç°¸í")){		//	Ç°¸íÀÇ °æ¿ì ÆäÀÌÁö ·Îµå½Ã ¹Ù·Î sql ½ÇÇàÇÏ¿© ´ã¾ÆµÎ¾î ÇÔ¼ö ½ÇÇà º¯¼ö·Î ¹Þ¾Æ¿Â°Í »ç¿ë
                find_rst = item_sql;
            }else if(id.includes("·ÎÆ®¹øÈ£")){
                //Get_Json_Before() // ÇÁ·Î±×·¡½º¹Ù ½ÇÇà
                $("#"+ id).css("background-color", "#eee");
                Get_Json_common_direct2(t_sql);     // Àü´Þ½Ã id°ª Àü´ÞÇÏÁö ¾ÊÀ½
                G_LotID = id;       // Àü´ÞÇÏÁö ¾ÊÀº id°ªÀ» À§ÇØ º¯¼ö ÁöÁ¤
                // °¡Á®¿À±â¿Ï·áÈÄ Get_Json_After2 ½ÇÇàµÊ
                return;
            }else{		//	±× ¿ÜÀÇ °æ¿ì sql¹® Get_Json()À¸·Î ½ÇÇà
                find_rst = Get_Json(t_sql);
            };
            find_data_array[id] = find_rst;
            if(id.includes("·ÎÆ®¹øÈ£")){
                if(find_rst[0]["FieldName"] == "" | find_rst[0]["FieldName"] == " "){        //  µ¥ÀÌÅÍ°¡ ¾ø´Â°æ¿ì move_next ¹ßµ¿½ÃÅ°Å°À§ÇÑ ´ÙÀ½À¸·Î ³Ñ¾î°¡±â »ðÀÔ
                    find_data_array.push("Á¶È¸ ³»¿ëÀÌ ¾ø½À´Ï´Ù. ´ÙÀ½À¸·Î ³Ñ¾î°¡±â");
                }else{		//	·ÎÆ®¹øÈ£ÀÇ °æ¿ì ÁöÁ¤ÇÑ º°Äª(AS(Alias))ÀÌ ´Ù¸£±â ¶§¹®¿¡ ´Ù¸£°Ô ÀÛ¼º
                    for(var i in find_rst){
                        find_data_array.push(find_rst[i]["FieldName"]);
                    };
                };
            }else{
                if(find_rst[0]["FND_DATA"] == "" | find_rst[0]["FND_DATA"] == " "){
                    find_data_array.push("Á¶È¸ ³»¿ëÀÌ ¾ø½À´Ï´Ù. ´ÙÀ½À¸·Î ³Ñ¾î°¡±â");
                }else{
                    for(var i in find_rst){
                        find_data_array.push(find_rst[i]["FND_DATA"]);
                    };
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
                    var t_this = this;
                    if(this.id == "»çÀÌÁî"){       //  »çÀÌÁî ÀÔ·Â½Ã ÀÌÀü ÀÔ·Â ³»¿ë ºÒ·¯¿À±â
                        auto_set($("#Ç°¸í").val(), $("#Ä®¶ó").val(), $(this).val(), 2);
                        return;
                    };
                    setTimeout(function(){
                        move_next(t_this);
                    }, 100);
                },
                focus : function(event, ui){    //  focus ½Ã ÀÌº¥Æ®    ÇÑ±Û°ú »ç¿ë½Ã ³ª¸ÓÁö°¡ »ç¶óÁö´Â ¹ö±×°¡ ÀÖ´Ù ? ¸®ÅÏÆÞ½º½Ã ¹«½ÃÇÑ´Ù°íÇÔ
                    return false;
                },
                change : function(event, ui){    //  change ½Ã ÀÌº¥Æ®
                    if(this.id.includes("Ç°¸í") == true){       //  Ç°¸í, Ä®¶ó, »çÀÌÁî Á¾·ù ÀÔ·Â½Ã ÀÔ·Â³»¿ë È®ÀÎ        select ¿¡¼­ ÀÛµ¿½Ã ¼±ÅÃÇÑ °ª¿¡¼­¸¸ ÀÛµ¿ÇÏ±â ¶§¹®¿¡ ÀÛ¼º³»¿ë È®ÀÎ À§ÇØ change ÀÛµ¿
                        if(autocom_valid("Ç°¸í", $(this).val(), "") == "0"){
                            dontFocus = 1;      // ÀÚµ¿¿Ï¼º È­»ìÇ¥ Æ®¸®°Å¸¸ ÀÛµ¿ÇÏµµ·Ï ÀÛ¾÷
                            $(this).val("");
                            $(this).focus();
                            return false;
                        };
                    };
                    if(this.id.includes("Ä®¶ó") == true){
                        item = id == "Ä®¶ó" ? "Ç°¸í" : id == "±Û·çÄ®¶ó" ? "±Û·çÇ°¸í" : id == "¿ø´ÜÄ®¶ó1" ? "¿ø´ÜÇ°¸í1" : id == "¿ø´ÜÄ®¶ó2" ? "¿ø´ÜÇ°¸í2" : id == "¿ø´ÜÄ®¶ó3" ? "¿ø´ÜÇ°¸í3" 
                                : id == "¿ø´ÜÄ®¶ó4" ? "¿ø´ÜÇ°¸í4" : id == "¿ø´ÜÄ®¶ó5" ? "¿ø´ÜÇ°¸í5" : id == "¿ø´ÜÄ®¶ó6" ? "¿ø´ÜÇ°¸í6" : id == "¿ø´ÜÄ®¶ó7" ? "¿ø´ÜÇ°¸í7" : id == "¿ø´ÜÄ®¶ó8" ? "¿ø´ÜÇ°¸í8" 
                                : id == "¿ø´ÜÄ®¶ó9" ? "¿ø´ÜÇ°¸í9" : "¿ø´ÜÇ°¸í10";
                        if(autocom_valid("Ä®¶ó", $(this).val(), $("#" + item).val()) == "0"){
                            dontFocus = 1;      // ÀÚµ¿¿Ï¼º È­»ìÇ¥ Æ®¸®°Å¸¸ ÀÛµ¿ÇÏµµ·Ï ÀÛ¾÷
                            $(this).val("");
                            $(this).focus();
                            return false;
                        };
                    };
                    if(this.id.includes("»çÀÌÁî") == true){
                        item = id == "»çÀÌÁî" ? "Ç°¸í" : id == "±Û·ç»çÀÌÁî" ? "±Û·çÇ°¸í" : id == "¿ø´Ü»çÀÌÁî1" ? "¿ø´ÜÇ°¸í1" : id == "¿ø´Ü»çÀÌÁî2" ? "¿ø´ÜÇ°¸í2" : id == "¿ø´Ü»çÀÌÁî3" ? "¿ø´ÜÇ°¸í3" 
                                : id == "¿ø´Ü»çÀÌÁî4" ? "¿ø´ÜÇ°¸í4" : id == "¿ø´Ü»çÀÌÁî5" ? "¿ø´ÜÇ°¸í5" : id == "¿ø´Ü»çÀÌÁî6" ? "¿ø´ÜÇ°¸í6" : id == "¿ø´Ü»çÀÌÁî7" ? "¿ø´ÜÇ°¸í7" : id == "¿ø´Ü»çÀÌÁî8" ? "¿ø´ÜÇ°¸í8" 
                                : id == "¿ø´Ü»çÀÌÁî9" ? "¿ø´ÜÇ°¸í9" : "¿ø´ÜÇ°¸í10";
                        if(autocom_valid("»çÀÌÁî", $(this).val(), $("#" + item).val()) == "0"){
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
    //  ÃÖ±ÙÀÔ·ÂÇÑ ÅõÀÔÀÚÀç, ±â°èÁ¤º¸ ÀÚµ¿ÀÔ·Â
    // ------------------------------------------------------------------------
    function auto_set(item, color, size, count){
        try{
            var rst = Get_Json("[B_WORK_Auto_MAT] 'G_WorkDiary_ÇÕÆ÷','"
                                    + item    + "','"
                                    + color    + "','"
                                    + size   + "'");
            if (rst[0].Ç°¸í == item && rst[0].Ä®¶ó == color && rst[0].»çÀÌÁî == size){
                if(confirm("ÀÌÀü »ý»êÇÑ ÅõÀÔÇ°À» ÀÚµ¿À¸·Î Ãß°¡ÇÏ½Ã°Ú½À´Ï±î ?") == true){
                    for(i = 0; i < count; i++){		//	.auto-mat°ú .machine-set À» °¡Áø °÷¿¡ ÀÔ·Â ½ÃÅ°±â À§ÇØ 2È¸ ½ÇÇà
                        var cl = (i == 0 ? '.auto-mat' : '.machine-set');
                        var classArray = $("" + cl + "");
                        for(n = 0; n < $("" + cl + "").length; n++){
                            var classId = classArray[n].id;
                            if(classArray[n].type == "text"){		//	Å¸ÀÔÀÌ ÀÏÄ¡ÇÏ´Â°æ¿ì ÀÔ·Â°ª ÀÛ¼ºÇÏµµ·Ï Ãß°¡ÀûÀÎ Å¸ÀÔÀÌ ÀÖÀ»°æ¿ì || À¸·Î Ãß°¡
                                var field = rst[0][classId] + "";
                                field = ((field == 0 || field == "null") ? "" : field);
                                $("#" + classId + "").val(field);
                            };
                        };
                    };
                    $("#»ý»ê·Ñ±æÀÌ1").focus();
                    return;
                }else {
                    $("#»ý»ê·Ñ±æÀÌ1").focus();
                    return;
                };
            };
            $("#»ý»ê·Ñ±æÀÌ1").focus();
        }catch(err){
            alert(err.message);
        };
    };    //  ÃÖ±ÙÀÔ·ÂÇÑ ÅõÀÔÀÚÀç, ±â°èÁ¤º¸ ÀÚµ¿ÀÔ·Â end

    // ------------------------------------------------------------------------
    // ÅõÀÔÇ° ±Û·ç ¹Ù²Ù±â, ¿©ºÎ Ã¼Å©
    // ------------------------------------------------------------------------
    function check_glu(count, id){
        if($("#" + id).is(":checked")){		// Ã¼Å© µÈ »óÅÂÀÎÁö
            $("#±Û·ç¿©ºÎ" + count).text("ÅõÀÔÇ°¸í" + count);		//	Ã¼Å© ¾ÈµÈ »óÅÂ ¸¸µé±â
            $("#" + id).prop("checked", false);
            if(count == ""){
                $("#±Û·çºñ°í").css("background-color", "#fff");
            }else{
                $("#¿ø´Üºñ°í" + count).css("background-color", "#fff");
            };
        }else{		//	Ã¼Å© µÈ »óÅÂ ¸¸µé±â
            $("#±Û·ç¿©ºÎ" + count).text("±Û·ç" + count);
            $("#" + id).prop("checked", true);
            if(count == ""){
                $("#±Û·çºñ°í").css("background-color", "#FFEAD5");
            }else{
                $("#¿ø´Üºñ°í" + count).css("background-color", "#FFEAD5");
            };
        };
    };      //  ÅõÀÔÇ° ±Û·ç ¹Ù²Ù±â, ¿©ºÎ Ã¼Å© end

    // ------------------------------------------------------------------------
    // ÅõÀÔÇ° ¹øÈ£ ¹Ù²Ù±â
    // ------------------------------------------------------------------------
    function changeDeisplay() {
        $("#ingredient_01").toggle();		//	º¸ÀÌ±â ¾Èº¸ÀÌ±â Ã³¸®
        $("#ingredient_02").toggle();
        if($("#changeInput").text() == "´ÙÀ½ÅõÀÔ"){		//	´©¸§¿¡ µû¶ó text º¯°æ
            $("#changeInput").text("ÀÌÀüÅõÀÔ");
        }else if($("#changeInput").text() == "ÀÌÀüÅõÀÔ"){
            $("#changeInput").text("´ÙÀ½ÅõÀÔ");
        };
    };    //  ÅõÀÔÇ° ¹øÈ£ ¹Ù²Ù±â end

    // ------------------------------------------------------------------------
    // ´ÙÀ½Ä­ ÀÌµ¿
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
    };    //  ´ÙÀ½Ä­ ÀÌµ¿ end

    // ------------------------------------------------------------------------
    //  auto_set_date °°Àº ³¯Â¥ ³¯¾¾ ¿Âµµ ¼ÂÆÃ
    // ------------------------------------------------------------------------
    function auto_set_date(date){
        try{
            var rst = Get_Json("[B_WORK_Auto_date] 1,'" + date + "'");		//	³¯Â¥¸¦ ÆÄ¶ó¹ÌÅÍ·Î Àü´Þ
            if (rst[0].³¯¾¾ != ""){		//	³¯¾¾ ÀÇ µ¥ÀÌÅÍ°¡ ÀÖÀ»°æ¿ì °ü·Ã µ¥ÀÌÅÍ °¡Á®¿À±â
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
    };    //    °°Àº ³¯Â¥ ³¯¾¾¿Âµµ ¼ÂÆÃ end

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
        var day2 = date.toISOString();      // ³¯ÀÚ°ª¸¸ ³²±â±â
        console.log(date)
        console.log(day)
        console.log(day2)
        return day;
    };    //  ¿À´Ã ³¯Â¥ end


</script>


<body>
  
    <div class="TopBtn">
        <div id="title_bar">
            <img id="title_bar_img" src ="../image/title/title2.png">
            <p id="t_header">ÀÛ¾÷ÀÏÁö</p>
        </div>

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
                    <td class="td_01" colspan="2;">
                        <input type="text" id="ÀÛ¾÷ÀÏÀÚ" class="input_tag input-field datepicker" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">ÀÛ¾÷½Ã°£</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="ÀÛ¾÷½Ã°£" class="input_tag input-field" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">Àåºñ</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="Àåºñ±¸ºÐ" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÀÛ¾÷ÀÚ</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="ÀÛ¾÷ÀÚ" class="input_tag input_tag_readonly_01 input_tag_end_01 input-field " tabindex="-1" readonly>
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">³¯¾¾</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="³¯¾¾" class="input_tag input-field set-date input-auto" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">¿Âµµ</label>
                    </th>
                    <td class="td_01 td_temp_01">
                        <input type="text" id="¿ÀÀü¿Âµµ" class="input_tag input_tag_temp_01 input-number set-date" autocomplete="off"><span>&#176;C</span>
                    </td>
                    <td class="td_01 td_temp_01">
                        <input type="text" id="¿ÀÈÄ¿Âµµ" class="input_tag input_tag_temp_01 input-number set-date" autocomplete="off"><span>&#176;C</span>
                    </td>

                    <th class="th_01">
                        <label class="label_tag">½Àµµ</label>
                    </th>
                    <td class="td_01 td_temp_01">
                        <input type="text" id="¿ÀÀü½Àµµ" class="input_tag input_tag_temp_01 input-number set-date" autocomplete="off"><span>%</span>
                    </td>
                    <td class="td_01 td_temp_01">
                        <input type="text" id="¿ÀÈÄ½Àµµ" class="input_tag input_tag_temp_01 input-number set-date" autocomplete="off"><span>%</span>
                    </td>

                    <th class="th_01">
                        <label class="label_tag">ºñ°í</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="ºñ°í" class="input_tag input_tag_end_01 input-field" autocomplete="off" spellcheck="false">
                    </td>
                </tr>
            </table>
        </div>

        <div class="item_insert">
            <table class="item">
                <tr>
                    <th class="th_01">
                        <label class="label_tag">»ý»êÇ°¸í</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="Ç°¸í" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">Ä®¶ó</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="Ä®¶ó" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">»çÀÌÁî</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="»çÀÌÁî" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="»ý»ê·ÎÆ®¹øÈ£" class="input_tag input_tag_readonly_01 input_tag_end_01 input-field " tabindex="-1" readonly>
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">»ý»ê±æÀÌ 1</label>
                    </th>
                    <td class="td_01 td_prod_01">
                        <input type="text" id="»ý»ê·Ñ±æÀÌ1" class="input_tag input_tag_prod_01 input-number auto_sum" autocomplete="off">
                    </td>
                    <td class="td_01 td_prod_02">
                        <input type="text" id="»ý»ê·Ñ¼ö·®1" class="input_tag input_tag_prod_02 input-number auto_sum" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">»ý»ê±æÀÌ 2</label>
                    </th>
                    <td class="td_01 td_prod_01">
                        <input type="text" id="»ý»ê·Ñ±æÀÌ2" class="input_tag input_tag_prod_01 input-number auto_sum" autocomplete="off">
                    </td>
                    <td class="td_01 td_prod_02">
                        <input type="text" id="»ý»ê·Ñ¼ö·®2" class="input_tag input_tag_prod_02_01 input-number auto_sum" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">»ý»ê±æÀÌ 3</label>
                    </th>
                    <td class="td_01 td_prod_01">
                        <input type="text" id="»ý»ê·Ñ±æÀÌ3" class="input_tag input_tag_prod_01 input-number auto_sum" autocomplete="off">
                    </td>
                    <td class="td_01 td_prod_02">
                        <input type="text" id="»ý»ê·Ñ¼ö·®3" class="input_tag input_tag_prod_02_01 input-number auto_sum" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">»ý»ê±æÀÌ 4</label>
                    </th>
                    <td class="td_01 td_prod_01">
                        <input type="text" id="»ý»ê·Ñ±æÀÌ4" class="input_tag input_tag_prod_01 input-number auto_sum" autocomplete="off">
                    </td>
                    <td class="td_01 td_prod_02">
                        <input type="text" id="»ý»ê·Ñ¼ö·®4" class="input_tag input_tag_prod_02_01 input_tag_end_04 input-number auto_sum" autocomplete="off">
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
                        <label class="label_tag">ÀÛ¾÷¼Óµµ</label>
                    </th>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;WIND&nbsp;</span><input type="text" id="¿ÍÀÎµù¼Óµµ" class="input_tag input_tag_info_ma_02 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;RPM&nbsp;&nbsp;</span><input type="text" id="RPM" class="input_tag input_tag_info_ma_02 input-number machine-set" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">¿ÏÁ¦Ç°µÎ²²</label>
                    </th>
                    <td class="td_01 td_info_pro_01">
                        <span class="span_02">&nbsp;&nbsp;ÁÂ&nbsp;</span><input type="text" id="¿ÏÁ¦Ç°ÈÄµµ_ÁÂ" class="input_tag input_tag_info_pro_01 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_pro_01">
                        <span class="span_02">&nbsp;Áß&nbsp;</span><input type="text" id="¿ÏÁ¦Ç°ÈÄµµ_Áß" class="input_tag input_tag_info_pro_01 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_pro_01">
                        <span class="span_02">¿ì&nbsp;&nbsp;</span><input type="text" id="¿ÏÁ¦Ç°ÈÄµµ_¿ì" class="input_tag input_tag_info_pro_01 input-number machine-set" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">»ý»ê¼ö·®</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="»ý»ê¼ö·®" class="input_tag input_tag_readonly_01 input_tag_end_01 input-number " tabindex="-1" readonly>
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
                        <label class="label_tag">Ã¨¹ö¿Âµµ 1</label>
                    </th>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;&nbsp;½ÇÁ¦&nbsp;&nbsp;</span><input type="text" id="Ã¨¹ö¿Âµµ_½ÇÁ¦1" class="input_tag input_tag_info_ma_02 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;¼ÂÆÃ&nbsp;&nbsp;</span><input type="text" id="Ã¨¹ö¿Âµµ_¼ÂÆÃ1" class="input_tag input_tag_info_ma_03 input-number machine-set" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">Ã¨¹ö¿Âµµ 2</label>
                    </th>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;&nbsp;½ÇÁ¦&nbsp;&nbsp;</span><input type="text" id="Ã¨¹ö¿Âµµ_½ÇÁ¦2" class="input_tag input_tag_info_ma_02 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;¼ÂÆÃ&nbsp;&nbsp;</span><input type="text" id="Ã¨¹ö¿Âµµ_¼ÂÆÃ2" class="input_tag input_tag_info_ma_03 input-number machine-set" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">Ã¨¹ö¿Âµµ 3</label>
                    </th>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;&nbsp;½ÇÁ¦&nbsp;&nbsp;</span><input type="text" id="Ã¨¹ö¿Âµµ_½ÇÁ¦3" class="input_tag input_tag_info_ma_02 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">¼ÂÆÃ</span><input type="text" id="Ã¨¹ö¿Âµµ_¼ÂÆÃ3" class="input_tag input_tag_info_ma_03 input_tag_end_03 input-number machine-set" autocomplete="off">
                    </td>
                </tr>

                <tr class="tr_hide">
                    <th class="th_01">
                        <label class="label_tag">Ã¨¹ö¿Âµµ 4</label>
                    </th>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;&nbsp;½ÇÁ¦&nbsp;&nbsp;</span><input type="text" id="Ã¨¹ö¿Âµµ_½ÇÁ¦4" class="input_tag input_tag_info_ma_02 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;¼ÂÆÃ&nbsp;&nbsp;</span><input type="text" id="Ã¨¹ö¿Âµµ_¼ÂÆÃ4" class="input_tag input_tag_info_ma_03 input-number machine-set" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">Ã¨¹ö¿Âµµ 5</label>
                    </th>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;&nbsp;½ÇÁ¦&nbsp;&nbsp;</span><input type="text" id="Ã¨¹ö¿Âµµ_½ÇÁ¦5" class="input_tag input_tag_info_ma_02 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;¼ÂÆÃ&nbsp;&nbsp;</span><input type="text" id="Ã¨¹ö¿Âµµ_¼ÂÆÃ5" class="input_tag input_tag_info_ma_03 input-number machine-set" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">Ã¨¹ö¿Âµµ 6</label>
                    </th>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;&nbsp;½ÇÁ¦&nbsp;&nbsp;</span><input type="text" id="Ã¨¹ö¿Âµµ_½ÇÁ¦6" class="input_tag input_tag_info_ma_02 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;¼ÂÆÃ&nbsp;&nbsp;</span><input type="text" id="Ã¨¹ö¿Âµµ_¼ÂÆÃ6" class="input_tag input_tag_info_ma_03 input-number machine-set" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">Ã¨¹ö¿Âµµ 7</label>
                    </th>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;&nbsp;½ÇÁ¦&nbsp;&nbsp;</span><input type="text" id="Ã¨¹ö¿Âµµ_½ÇÁ¦7" class="input_tag input_tag_info_ma_02 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">¼ÂÆÃ</span><input type="text" id="Ã¨¹ö¿Âµµ_¼ÂÆÃ7" class="input_tag input_tag_info_ma_03 input_tag_end_03 input-number machine-set" autocomplete="off">
                    </td>
                </tr>
            </table>
        </div>

        <div class="ingredient_insert">
            <table class="ingredient">
                <tr>
                    <th class="th_01">
                        <label id="±Û·ç¿©ºÎ" class="label_tag label_cursor" onclick="check_glu('', '±Û·ç')">
                            ÅõÀÔÇ°¸í
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="±Û·çÇ°¸í" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔÄ®¶ó</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="±Û·çÄ®¶ó" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔ»çÀÌÁî</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="±Û·ç»çÀÌÁî" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔ¼ö·®</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="±Û·çÅõÀÔ¼ö·®" class="input_tag input_tag_end_01 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">±âÁØµÎ²²</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="±Û·ç±âÁØµÎ²²" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">ÃøÁ¤µÎ²²</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="±Û·çÃøÁ¤µÎ²²" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">Àå·Â/ºñ°í</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="±Û·çÀå·Â" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="±Û·çºñ°í" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="±Û·ç·ÎÆ®¹øÈ£" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>
            </table>

            <table id="ingredient_01" class="ingredient_01">
                <tr>
                    <th class="th_01">
                        <label id="±Û·ç¿©ºÎ1" class="label_tag label_cursor" onclick="check_glu('1', '±Û·ç1')">
                            ÅõÀÔÇ°¸í 1
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÇ°¸í1" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔÄ®¶ó</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÄ®¶ó1" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔ»çÀÌÁî</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü»çÀÌÁî1" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔ¼ö·®</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;Ç¥Áö</span><input type="text" id="Ç¥Áö¼ö·®1" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;½Ç&nbsp;</span><input type="text" id="½Ç¼ö·®1" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">±âÁØµÎ²²</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü±âÁØµÎ²²1" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÃøÁ¤µÎ²²</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÃøÁ¤µÎ²²1" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">Àå·Â/ºñ°í</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="¿ø´ÜÀå·Â1" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="¿ø´Üºñ°í1" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü·ÎÆ®¹øÈ£1" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label id="±Û·ç¿©ºÎ2" class="label_tag label_cursor" onclick="check_glu('2', '±Û·ç2')">
                            ÅõÀÔÇ°¸í 2
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÇ°¸í2" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔÄ®¶ó</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÄ®¶ó2" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔ»çÀÌÁî</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü»çÀÌÁî2" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔ¼ö·®</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;Ç¥Áö</span><input type="text" id="Ç¥Áö¼ö·®2" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;½Ç&nbsp;</span><input type="text" id="½Ç¼ö·®2" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                
                    <th class="th_01">
                        <label class="label_tag">±âÁØµÎ²²</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü±âÁØµÎ²²2" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÃøÁ¤µÎ²²</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÃøÁ¤µÎ²²2" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">Àå·Â/ºñ°í</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="¿ø´ÜÀå·Â2" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="¿ø´Üºñ°í2" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü·ÎÆ®¹øÈ£2" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label id="±Û·ç¿©ºÎ3" class="label_tag label_cursor" onclick="check_glu('3', '±Û·ç3')">
                            ÅõÀÔÇ°¸í 3
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÇ°¸í3" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔÄ®¶ó</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÄ®¶ó3" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔ»çÀÌÁî</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü»çÀÌÁî3" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔ¼ö·®</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;Ç¥Áö</span><input type="text" id="Ç¥Áö¼ö·®3" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;½Ç&nbsp;</span><input type="text" id="½Ç¼ö·®3" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">±âÁØµÎ²²</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü±âÁØµÎ²²3" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÃøÁ¤µÎ²²</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÃøÁ¤µÎ²²3" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">Àå·Â/ºñ°í</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="¿ø´ÜÀå·Â3" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="¿ø´Üºñ°í3" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü·ÎÆ®¹øÈ£3" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label id="±Û·ç¿©ºÎ4" class="label_tag label_cursor" onclick="check_glu('4', '±Û·ç4')">
                            ÅõÀÔÇ°¸í 4
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÇ°¸í4" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔÄ®¶ó</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÄ®¶ó4" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔ»çÀÌÁî</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü»çÀÌÁî4" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔ¼ö·®</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;Ç¥Áö</span><input type="text" id="Ç¥Áö¼ö·®4" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;½Ç&nbsp;</span><input type="text" id="½Ç¼ö·®4" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">±âÁØµÎ²²</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü±âÁØµÎ²²4" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÃøÁ¤µÎ²²</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÃøÁ¤µÎ²²4" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">Àå·Â/ºñ°í</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="¿ø´ÜÀå·Â4" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="¿ø´Üºñ°í4" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü·ÎÆ®¹øÈ£4" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>

                </tr>

                <tr>
                    <th class="th_01">
                        <label id="±Û·ç¿©ºÎ5" class="label_tag label_cursor" onclick="check_glu('5', '±Û·ç5')">
                            ÅõÀÔÇ°¸í 5
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÇ°¸í5" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔÄ®¶ó</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÄ®¶ó5" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔ»çÀÌÁî</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü»çÀÌÁî5" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔ¼ö·®</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;Ç¥Áö</span><input type="text" id="Ç¥Áö¼ö·®5" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;½Ç&nbsp;</span><input type="text" id="½Ç¼ö·®5" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">±âÁØµÎ²²</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü±âÁØµÎ²²5" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÃøÁ¤µÎ²²</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÃøÁ¤µÎ²²5" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">Àå·Â/ºñ°í</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="¿ø´ÜÀå·Â5" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="¿ø´Üºñ°í5" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü·ÎÆ®¹øÈ£5" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>
            </table>

            <table id="ingredient_02" class="ingredient_02">
                <tr>
                    <th class="th_01">
                        <label id="±Û·ç¿©ºÎ6" class="label_tag label_cursor" onclick="check_glu('6', '±Û·ç6')">
                            ÅõÀÔÇ°¸í 6
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÇ°¸í6" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔÄ®¶ó</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÄ®¶ó6" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔ»çÀÌÁî</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü»çÀÌÁî6" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔ¼ö·®</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;Ç¥Áö</span><input type="text" id="Ç¥Áö¼ö·®6" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;½Ç&nbsp;</span><input type="text" id="½Ç¼ö·®6" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">±âÁØµÎ²²</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü±âÁØµÎ²²6" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÃøÁ¤µÎ²²</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÃøÁ¤µÎ²²6" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">Àå·Â/ºñ°í</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="¿ø´ÜÀå·Â6" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="¿ø´Üºñ°í6" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü·ÎÆ®¹øÈ£6" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>

                </tr>

                <tr>
                    <th class="th_01">
                        <label id="±Û·ç¿©ºÎ7" class="label_tag label_cursor" onclick="check_glu('7', '±Û·ç7')">
                            ÅõÀÔÇ°¸í 7
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÇ°¸í7" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔÄ®¶ó</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÄ®¶ó7" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔ»çÀÌÁî</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü»çÀÌÁî7" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔ¼ö·®</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;Ç¥Áö</span><input type="text" id="Ç¥Áö¼ö·®7" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;½Ç&nbsp;</span><input type="text" id="½Ç¼ö·®7" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">±âÁØµÎ²²</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü±âÁØµÎ²²7" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÃøÁ¤µÎ²²</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÃøÁ¤µÎ²²7" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">Àå·Â/ºñ°í</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="¿ø´ÜÀå·Â7" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="¿ø´Üºñ°í7" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü·ÎÆ®¹øÈ£7" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label id="±Û·ç¿©ºÎ8" class="label_tag label_cursor" onclick="check_glu('8', '±Û·ç8')">
                            ÅõÀÔÇ°¸í 8
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÇ°¸í8" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔÄ®¶ó</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÄ®¶ó8" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔ»çÀÌÁî</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü»çÀÌÁî8" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔ¼ö·®</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;Ç¥Áö</span><input type="text" id="Ç¥Áö¼ö·®8" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;½Ç&nbsp;</span><input type="text" id="½Ç¼ö·®8" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">±âÁØµÎ²²</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü±âÁØµÎ²²8" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÃøÁ¤µÎ²²</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÃøÁ¤µÎ²²8" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">Àå·Â/ºñ°í</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="¿ø´ÜÀå·Â8" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="¿ø´Üºñ°í8" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü·ÎÆ®¹øÈ£8" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label id="±Û·ç¿©ºÎ9" class="label_tag label_cursor" onclick="check_glu('9', '±Û·ç9')">
                            ÅõÀÔÇ°¸í 9
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÇ°¸í9" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔÄ®¶ó</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÄ®¶ó9" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔ»çÀÌÁî</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü»çÀÌÁî9" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔ¼ö·®</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;Ç¥Áö</span><input type="text" id="Ç¥Áö¼ö·®9" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;½Ç&nbsp;</span><input type="text" id="½Ç¼ö·®9" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">±âÁØµÎ²²</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü±âÁØµÎ²²9" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÃøÁ¤µÎ²²</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÃøÁ¤µÎ²²9" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">Àå·Â/ºñ°í</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="¿ø´ÜÀå·Â9" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="¿ø´Üºñ°í9" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü·ÎÆ®¹øÈ£9" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label id="±Û·ç¿©ºÎ10" class="label_tag label_cursor" onclick="check_glu('10', '±Û·ç10')">
                            ÅõÀÔÇ°¸í10
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÇ°¸í10" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔÄ®¶ó</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÄ®¶ó10" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔ»çÀÌÁî</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü»çÀÌÁî10" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÅõÀÔ¼ö·®</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;Ç¥Áö</span><input type="text" id="Ç¥Áö¼ö·®10" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;½Ç&nbsp;</span><input type="text" id="½Ç¼ö·®10" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">±âÁØµÎ²²</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü±âÁØµÎ²²10" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">ÃøÁ¤µÎ²²</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´ÜÃøÁ¤µÎ²²10" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">Àå·Â/ºñ°í</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="¿ø´ÜÀå·Â10" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="¿ø´Üºñ°í10" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="¿ø´Ü·ÎÆ®¹øÈ£10" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>
            </table>

            <table class="ingredient">
                <tr>
                    <th class="th_01 th_remark_01">
                        <label class="label_tag label_tag_2row">Æ¯ÀÌ»çÇ×</label>
                    </th>
                    <td class="td_01 td_remark_01">
                        <textarea type="text" id="Æ¯ÀÌ»çÇ×" class="input_tag textarea_tag input-field" autocomplete="off" spellcheck="false"></textarea>
                    </td>
                    
                    <td class="td_01 td_btn_01">
                        <button id="changeInput" class="btn_02 btn_td_01" onclick="changeDeisplay();">´ÙÀ½ÅõÀÔ</button>
                    </td>
                </tr>
            </table>
        </div>
    </div>

<!-- hidden -->
<input type='hidden' id='Ã¢°í¸í' class='input-field'>
<input type='hidden' id='ÀÛ¾÷½ÃÀÛ½Ã°£' class='input-field'>
<input type='hidden' id='ÀÛ¾÷Á¾·á½Ã°£' class='input-field'>
<input type='hidden' id='IP_Address' class='input-field'>
<input type='hidden' id='Item' value="">   
<input type='hidden' id='color' value="">   
<input type='hidden' id='size' value="">   
<input type='hidden' id='WorkID' value="">   
<input type='hidden' id='OLD±Û·çÅõÀÔ¼ö·®' value="0" class="oldGlu">
<input type='hidden' id='OLD½Ç¼ö·®1' value="0" class="oldGlu">
<input type='hidden' id='OLD½Ç¼ö·®2' value="0" class="oldGlu">
<input type='hidden' id='OLD½Ç¼ö·®3' value="0" class="oldGlu">
<input type='hidden' id='OLD½Ç¼ö·®4' value="0" class="oldGlu">
<input type='hidden' id='OLD½Ç¼ö·®5' value="0" class="oldGlu">
<input type='hidden' id='OLD½Ç¼ö·®6' value="0" class="oldGlu">
<input type='hidden' id='OLD½Ç¼ö·®7' value="0" class="oldGlu">
<input type='hidden' id='OLD½Ç¼ö·®8' value="0" class="oldGlu">
<input type='hidden' id='OLD½Ç¼ö·®9' value="0" class="oldGlu">
<input type='hidden' id='OLD½Ç¼ö·®10' value="0" class="oldGlu">
<input type='hidden' id='OLDÀÛ¾÷ÀÏÀÚ' value="0" class="oldGlu">

<input type="checkbox" id="±Û·ç" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="±Û·ç1" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="±Û·ç2" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="±Û·ç3" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="±Û·ç4" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="±Û·ç5" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="±Û·ç6" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="±Û·ç7" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="±Û·ç8" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="±Û·ç9" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="±Û·ç10" class="input-readonly" value="0" style="display:none;">


</body>
</HTML>