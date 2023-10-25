<!--#include virtual="N_MAIN/global.asp" -->
<!DOCTYPE html>
<html>
<%
call vFunChkSession(2)	'����üũ �� �ߺ������üũ     �Լ���ġ: /INCLUDE/function.asp
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
<title>�۾��������(����AND����)</title>
<!-- ���ι��� ���� -->
<script src="../../N_Main/jQuery/jquery-1.12.4.min.js"></script>
<script src="../../N_Main/jQuery/jquery-ui.js"></script>
<script type="text/javascript" src="../erp_func/common_func.js?230103a"></script>
<script type="text/javascript" src="../../N_CSS/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="../../N_CSS/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="../../IncJquery/jquery-ui.min.css">
<!-- datepicker -->

<link rel="stylesheet" type="text/css" href="../../N_CSS/datepicker2.css" />

<style>
    /* ��ü ���� */
    html, body { width: 99.5%; margin: 5px 5px 5px 5px;  }

    /* ��ư */
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

    /* �� ���� ������ / ������ css �۾� */
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

    /* tr �±� */
    .tr_hide{ display: none;  }

    /* th �±� */
    .th_01{ box-sizing: border-box; width: 5%; height: 40px; font-size: 13pt; border-spacing: 0px;  }
    .th_remark_01{ width: 10%;  }

    /* td �±� */
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

    /* input �±� */
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

    //  autocomplete ��ġ�� �ʵ��� �ϴ� ���� ����       / �۾�����, ����� ��Ŀ���� ���� �ڵ��ϼ��� ȭ��ǥ Ʈ���Ű� ���� �۵��Ǿ� ��Ŀ�� ��ġ ���� �ذ��
    let dontFocus = 0;

    $(document).ready(function(){
        try{
            // ------------------------------------------------------------------------
            // �ʱ� ������ ����
            // ------------------------------------------------------------------------
            window.focus();
            $("#IP_Address").val(IP_Address);
            // ��Ʈ��ȣ �˻��� ����� ���� ���� ����
            G_LotID = "";

            //    prk�� �۾� H_����������ǥ ���̺��� ����������ǥID   grid ���� �����ؼ� �������°�
            var prk = "<%=junID%>";

            if(seSawonid == ""){        //  �θ� â���� ���� ���������� Ȯ��
                alert("�α��� ���¸� �ٽ� Ȯ���� �ּ���.");
                self.close();
            }else if(prk != ""){        //  prk = grid ���� ������ ��ȣ �Ϸ�� �۾� �ҷ��������� Ȯ��
                //  �����ͺҷ�����
                init_disp(prk);     //  ��ȣ ���� ����

                //  ���� ������
                $("#OLD�۾�����").val($("#�۾�����").val());
                $("#�۾����").attr("disabled", true);
                $("#�۾�����").attr("disabled", true);
                $("#�۾�����").css("display","inline");     //  ���� �Ҽ��ֵ��� �۾����� ��ư ���̰�
                $("#�۾�����").attr("disabled", true);
                $("#�����Ʈ��ȣ").val("<%=P_Lot_NO%>");

            }else if(prk == ""){        //  �Ϸ���� ���� �۾��϶�
                //  ���� ������
                $("#�۾�����").css("display","none");
                $(".btn_01_2").css("margin", "30px 5.8% 10px 0px");     //  �۾� ���� ��ư�� �Ⱥ��̱⶧���� �׿� ���缭 ��ġ ����
                $("#�۾�����").val(getDay());       //  ���÷� �ۼ�
                $("#�۾�����").attr("min", getDay());       //  �޷¿��� ���� ���� ���� �Ұ����ϵ���
                $("#�۾�����").attr("max", getDay());       //  �޷¿��� ���� ���� ���� �Ұ����ϵ���
                $("#�۾���").val(seSawonname);

                //  â�� ����
                if(defaultStocID == 7){     //  �⺻â�� ��ȣ�� ���� â���� �۾����� �̸� ����
                    $("#â���").val("����â��");
                    $("#t_header").text("�����۾�����");
                }else if(defaultStocID == 6){
                    $("#â���").val("����â��");
                    $("#t_header").text("�����۾�����");
                };

                //  �̿Ϸ� ������ Ȯ��
                var work_id = work_check($("#â���").val(), $("#�۾�����").val(), $("#�۾���").val());     //  â���, �۾�����, �۾��� �Ķ��Ÿ�� ����

                //  �̿Ϸ� �����Ϳ� ���� �����߻��� Ȥ�� ���� �������� �غ�
                if(work_id != ""){      //  �̿Ϸ� �����Ͱ� �������� �۾��������
                    remain_disp(work_id);       //  �������� workid �Ķ��Ÿ�� ����
                    prk = 1;        //  ���� ��Ŀ�� �������� �ʵ��� prk 1�� ���� prk ã�ư��� ���� �˼�����
                    $("#�۾�����").attr("disabled", true);
                }else{      //  �̿Ϸ� ������ �������� �۾������غ�
                    $("#�۾�����").attr("disabled", true);
                    auto_set_date($("#�۾�����").val());        //  �������� �µ�, ���� �� ������ ������� �ҷ�����
                };
            };    //  �ʱ� ������ ���� end

            // ------------------------------------------------------------------------
            // �۾����� ��ư Ŭ��
            // ------------------------------------------------------------------------
            $("#�۾�����").on("click", function(){
                if(save() == true){		//  �۾� ���� �� ��ư ����
                    $("#�۾�����").attr("disabled", true);
                    $("#�۾�����").attr("disabled", false);
                };
            });   //  �۾����� ��ư end

            // ------------------------------------------------------------------------
            // �۾����� ��ư Ŭ��
            // ------------------------------------------------------------------------
            $("#�۾�����").on("click", function(){
                if(inven_check() == true){		//	������ �Է°� Ȯ��
                    if(save() == true){
                        alert("����Ǿ����ϴ�.");
                        opener.main_bind();
                        self.close();
                    };
                };
            });   //  �۾����� ��ư end

            // ------------------------------------------------------------------------
            // �۾���� ��ư Ŭ��
            // ------------------------------------------------------------------------
            $("#�۾����").on("click", function(){
                if(confirm("���� ����Ͻðڽ��ϱ� ?") == true){
                    if($("#�۾����۽ð�").val() == ""){     //  �۾����۽ð� ������ �۾� ���� Ȯ��
                        alert("�۾��� ���۵Ǿ����� �ٽ� Ȯ�����ּ���.");
                    }else{
                        var wareHouse = $("#â���").val();
                        var delSawonName = $("#�۾���").val();
                        var delGubun = wareHouse == "����â��" ? "2" : wareHouse == "����â��" ? "3" : "false";         //  1 : ����, 2 : ����, 3 : ����, 4 : �д�, 5 : ���
                        var delWorkId = $("#WorkID").val();
                        if(delGubun == "false"){
                            alert("���� â�� ��Ȯ�� ���ּ���.");
                            return false;
                        };
                        var rst = Get_Json("EXEC RF_PROD_PDA_RF����_ERP_CLEAR '" + delSawonName + "', '" + delGubun + "', '" + delWorkId + "'");
                        alert(rst[0].MSG);
                        location.reload();
                    };
                };
            });   //  �۾���� ��ư end

            // ------------------------------------------------------------------------
            // �۾����� ��ư Ŭ��
            // ------------------------------------------------------------------------
            $("#�۾�����").on("click", function(){		//	�Է� �׸� �����Ҽ� �ֵ��� ����
                $(".input-field, .input-number").attr("disabled", false);
                $("#�۾�����").attr("disabled", false);
                $("#�۾�����").attr("disabled", true);

            });   //  �۾����� ��ư end

            // ------------------------------------------------------------------------
            // ������� �ڵ����
            // ------------------------------------------------------------------------
            $('.auto_sum').on("keyup", function(){
                var pro_count = 0;		//	�ڵ� ����� �� ���� ���� ����
                for(i = 1; i < 5; i++){     //  1~ 4���� �ݺ�
                    if($("#����ѱ���" + i).val() + "" != "" && $("#����Ѽ���" + i).val() + "" != ""){		//	�Է°� ���� Ȯ�� �Է°��� ������ ��� ����
                        pro_count = pro_count + parseInt($("#����ѱ���" + i).val()) * parseInt($("#����Ѽ���" + i).val());
                    };
                };
                $("#�������").val(pro_count);		//	���� �� ��������� ����
            });   //  ������� �ڵ���� end

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
            // class input-number �׸� ���ڸ� �Է��ϵ��� ����
            // ------------------------------------------------------------------------
            $(".input-number").on("blur keyup", function(){
                // var regex = /[^0-9]/gi;    //  ���ڻ��� �Է� �ȵ� .���ȵ�
                var regex = /[��-��|��-��|��-�R|aA-zZ]/gi;     //  �ѱ� ��� ����
                $(this).val($(this).val().replace(regex, ""));
            });   //  ���ڸ� �Է� end

            // ------------------------------------------------------------------------
            // autocomplete ǰ�� �˻� ������ �ε�� �ٷν���
            // ------------------------------------------------------------------------
            item_sql = "";      // ������ ���ڵ�� ��������
            var item_json = Get_Json_common_direct("EXEC [AA_WORKDIARY_Search2] '', 'ǰ��', ''");       // json ����ȯ �Ͽ� �������� ǰ�� ���� �˻� sql
            // �Ϸ��� Get_Json_After �Լ��� ����ǰ� �׶� item_sql �� ������ ��

            // ------------------------------------------------------------------------
            // input-auto ��Ŀ���� ���� �Ʒ�����Ű Ʈ���� �۵����� �˻� ��� ��ġ�� / autocomplete ����
            // ------------------------------------------------------------------------
            $(".input-auto").on("focus", function(){
                if(dontFocus == 0){
                    data_find(this.id, item_sql);       //  �ڵ��ϼ� ����
                }else{
                    dontFocus = 0;
                    return;
                };
                var e = $.Event("keydown", {        // autocomplete �Ϸ�� �˻����� Ȯ�� �ǵ��� �Ʒ�����Ű Ʈ���� �����
                    keyCode : 40         //  �Ʒ�����Ű Ű�ڵ� 40   �ڿ� �����ݷ� ���̸� ������
                });
                var t_this = this;		//	setTimeout���� this �� ����ϸ� this���� ���ϱ� ������ ������ this�� t_this�� ���
                setTimeout(function(){      //  �ٷ� ����� autoFocus ���׷� ���� ��Ŀ�� ����� setTimeout ������ ���� �����
                    $(t_this).trigger(e);        // �Ʒ� ����Ű Ʈ���� �۵�
                }, 100);
                if(this.id == "����" || this.id == "��񱸺�"){     // ������Ŀ�� ����� �̰� �߰���
                    return;
                }else{
                    $(this).trigger(e);
                };
            });   //  �Ʒ�����Ű Ʈ���� end

            $("#����, #��񱸺�").on("focus", function(){      // �̰��ؾ� �Է°��� ������� �˻��� â�� �����ִµ� �׷��� autoFocus�� ���峲...
                $(this).autocomplete("search", "");             // �׷��� autoFocus ����� Ʈ���ŷ� autoFocus ��� �߰� �ۼ���
            });

            // ------------------------------------------------------------------------	
            // ���Լ��� old ����                                                                                    ���� ������ ��� ?
            // ------------------------------------------------------------------------	
            $(".must_03_04").focusin(function(){
                var className = $(".must_03_04");
                var className_old = $(".oldGlu");
                if((prk > 1) && $("#OLD�۾�����").val() == $("#�۾�����").val()){
                    for(i = 1; i < className.length; i++){
                        if($("#" + className_old[i].id + "").val() == "0"){
                            $("#" + className_old[i].id + "").val($("#" + className[i].id + "").val());
                        };
                    };
                };
            });   //  ���Լ��� old ���� end

            // ------------------------------------------------------------------------
            // #Heating 2 ���� ���̱� �� Ŭ����
            // ------------------------------------------------------------------------
            $("#Heating").on("click", function(){
                $(".tr_hide").toggle();     //  ���̰� �Ⱥ��̰� �ϴ� Method
                // if($(".tr_hide").css("display") == "none"){      //  display ���¸� Ȯ���ϰ� display ���¸� ����
                //     $(".tr_hide").slideDown("slow");       //  slideDown / slideUp ������ jquery ���� �ٲ�� �� /jquery/3.6.4/jquery.min.js
                //     $(".tr_hide").css("display", "table");
                // }else{
                //     $(".tr_hide").css("display", "none");
                //     $(".tr_hide").slideUp("slow");
                // };
            });   //  ���� ���̱� end

            // ------------------------------------------------------------------------
            // #Heating 2 ���� ���̱�2 input ��Ŀ����
            // ------------------------------------------------------------------------
            $("#Heating_SV, #Heating_PV").on("focus", function(){       //  toggle ���� ȭ���� ������������ ������� ������ css Method�� ���̰Ը� ó��
                if($(".tr_hide").css("display") == "none"){     //  display ���¸� Ȯ���ϰ� display ���¸� ����
                    $(".tr_hide").css("display", "table");
                };
            });   //  ���� ���̱� end

            // ------------------------------------------------------------------------	
            // ���۽� ��Ŀ��
            // ------------------------------------------------------------------------	
            if(prk + "" == ""){     //  �ҷ��� �۾��� �������� ����Ǵ°��̳� ��������
                $("#��񱸺�").focus();
            };    //  ���۽� ��Ŀ�� end

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
					$(this).val(getDay());
					$(this).focus();
					return;
				};
			});		// �Է°� Ȯ��



        }catch(err){
            alert(err.message);
        };    //  catch end
    });     //  document.reaty end



    // ------------------------------------------------------------------------
    // �б����� ������ �ҷ�����
    // ------------------------------------------------------------------------
    function init_disp(id){
        try{
            var rst = Get_Json("B_WORK_LST 'G_WorkDiary_����', " + id);		//	������ ���������� sql ����
            if(rst[0].WorkID == "" || rst[0].WorkID == " " || rst[0].WorkID == null){
                alert("�۾������� ��ϵ��� �ʾҽ��ϴ�.");
                self.close();
            }else{
                $("#WorkID").val(rst[0].WorkID);
                $("#â���").val(rst[0].â���);
                if($("#â���").val() == "����â��"){
                    $("#t_header").text("�����۾�����");
                }else if($("#����â��")){
                    $("#t_header").text("�����۾�����");
                };
                $(".input-field, .input-number, .input-readonly").each(function(){
                    $(this).attr("disabled", true);      //  �б� �������� �ҷ�����
                    if($(this).attr("type") == "text" || $(this).attr("type") == "date" || $(this).attr("type") == "textarea" || $(this).attr("type") == "hidden"){		// ������ ������ input�׸� �Է�
                        var field = rst[0][this.id] + "";
                        field = (field == 0 || field == "null") ? "" : field;
                        if(this.id == "�۾�����"){		//	�۾������� ��� ������ �Ϻ� ����
                            $("#" + this.id).val(field.substring(0, 10));       //  db�� ����� �۾����ڿ� �ð��� ����
                        // }else if(this.id == "�۾����۽ð�"){
                        //     $("#" + this.id).val(field.substring(11, 16));      //  db�� ����� �۾����۽ð��� ���ڰ� ����
                        // }else if(this.id == "�۾�����ð�"){     //  ���ڰ� ������ ������ �������� �״�� ��������
                        //     $("#" + this.id).val(field.substring(11, 16));      //  db�� ����� �۾�����ð��� ���ڰ� ����
                        }else{
                            $("#" + this.id).val(field);
                        };
                    }else if($(this).attr("type") == "checkbox"){		//	üũ�ڽ��� ��� üũ ���·� �Է�
                        $("input:checkbox[id='" + this.id + "']").prop("checked", rst[0][this.id]);        //  �۷� ���� Ȯ��
                    };
                });
                if($("#�۷�").is(":checked")){      //  �۷� ���� Ȯ���� ���� ����
                    $("#�۷翩��").text("�۷�");
                    $("#�۷���").css("background-color", "#FFEAD5");    
                };
                for(i = 1; i < 11; i++){        //  �߰� �۷� ���� Ȯ���� ���� ����
                    if($("#�۷�" + i).is(":checked")){
                        $("#�۷翩��" + i).text("�۷�" + i);
                        $("#���ܺ��" + i).css("background-color", "#FFEAD5");    
                    };
                };
            };
        }catch(err){
            alert(err.message);
            self.close();
        };
    };    // �б����� ������ end

    // ------------------------------------------------------------------------
    //  ���� �̿Ϸ� �۾����� ��ȣ ȣ��
    // ------------------------------------------------------------------------
    function work_check(war_name ,work_date, worker){
        try{
            var rst = Get_Json("B_WORK_CHECK 'G_WorkDiary_����', '" + war_name + "', '" + work_date + "', '" + worker + "'");

            if(rst[0].WORKID != " "){       //  WORKID �� �ִ��� ������ Ȯ��
                var valid = rst[0].WORKID + "";
            }else{
                valid = "";
            };
            return valid;
        }catch(err){
            alert(err.message);
        };
    };    //  ���� �̿Ϸ� �۾����� ��ȣ end

    // ------------------------------------------------------------------------
    // �̿Ϸ� �۾����� �ҷ�����
    // ------------------------------------------------------------------------
    function remain_disp(id){
        try{
            var rst = Get_Json("B_WORK_LST_REMAIN 'G_WorkDiary_����'," + id);		//	�������̺� ����� �������� �������� ������ ��ȯ
            if(rst[0].WorkID != ""){		//	�������� �����Ͱ� ������� ����
                $("#WorkID").val(rst[0].WorkID);
                $("#â���").val(rst[0].â���);
                $(".input-field, .input-number, .input-readonly").each(function(){
                    if($(this).attr("type") == "text" || $(this).attr("type") == "date" || $(this).attr("type") == "textarea" || $(this).attr("type") == "hidden"){
                        var field = rst[0][this.id] + "";
                        field = ((field == 0 || field == "null") ? "" : field);
                        if(this.id == "�۾�����"){
                            $("#" + this.id).val(field.substring(0, 10));       //  db�� ����� �۾����ڿ� �ð��� ����
                        // }else if(this.id == "�۾����۽ð�"){
                        //     $("#" + this.id).val(field.substring(11, 16));       //  db�� ����� �۾����۽ð��� ���ڰ� ����
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
    };    // �̿Ϸ� �۾����� �ҷ����� end

    // ------------------------------------------------------------------------
    //  ����
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
                if(this.id.includes("�µ�") || this.id.includes("���") || this.id == "���ε��ӵ�" || this.id == "RPM"){
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
            var insert = Get_Json("EXEC [AA_WORKDIARY_����AND����] '" + id + "', '" + WorkID + "'" + save_data + "");		//	save_data ����� �������� ' ���ԵǾ��־� ' ������ �����߻�
            if(insert[0].VALID == 0){		//	sql ����� validation ����������� �޼����� ��Ŀ���� ��������
                dontFocus = 1;      // �ڵ��ϼ� ȭ��ǥ Ʈ���Ÿ� �۵��ϵ��� �۾�
                alert(insert[0].MSG);
                $("#" + insert[0].RETURN_INPUT).focus();
                return false;
            }else if(insert[0].VALID == 1){		//	���� ������ ������ ��ȯ
                $("#�۾����۽ð�").val(insert[0].�۾����۽ð�);
                $("#�۾�����ð�").val(insert[0].�۾�����ð�);
                $("#�۾��ð�").val(insert[0].�۾��ð�);
                $("#WorkID").val(insert[0].WorkID);
                return true;
            };
        }catch(err){
            alert(err.message);
        };
    };    //  save end

    // ------------------------------------------------------------------------
    // ���Ȯ�� �۾� ������ �۵�        �۾� �����ÿ� �۵��ϴ°����� ����
    // ------------------------------------------------------------------------
    function inven_check(){
        try{
            var gluName = $(".must_03_01");		//	�۷�ǰ�� �迭
            var gluColor = $(".must_03_02");		//	�۷��÷� �迭
            var gluSize = $(".must_03_03");		//	�۷������ �迭
            var gluCount = $(".must_03_04");		//	�۷���� �迭
            var oldGlu = $(".oldGlu");		//	�����۷���� �迭
            for(i = 0; i < gluName.length; i++){
                if(isNaN(oldGlu[i].value) == false){
                    if(gluCount[i].value != "" || gluCount[i].value != 0){
                        var count = gluCount[i].value - oldGlu[i].value;
                        if(stock_chk(gluName[i].value, gluColor[i].value, gluSize[i].value, count) == false){
                            if(gluName[i].id == "�۷�ǰ��"){
                                alert("������ ��� ������ �����մϴ�.\n������ Ȯ�� �� �����ϼ���.");
                                $("#" + gluCount[i].id + "").focus();
                                return false;
                            }else if(gluName[i].id == ("����ǰ��" + i)){
                                alert("����ǰ �������� �����մϴ�.\n������ Ȯ�� �� �����ϼ���.");
                                $("#" + gluCount[i].id + "").focus();
                                return false;
                            };    //  ���������� ����ǰ����
                        };
                    };
                };
            };
            return true;
        }catch(err){
            alert(err.message);
        };
    };    //  ���˻� end

    // ------------------------------------------------------------------------
    //  ���˻� ���� �Լ�
    // ------------------------------------------------------------------------
    function stock_chk(item, color, size, cnt){
        try{
            var enabled = 0;
            var date = $("#�۾�����").val();
            var wareID = defaultStocID;   //    5 : ����â��, 7 : ����â��, 6 : ����â��
            var rst_item = Get_Json("SELECT * FROM [dbo].[Get_ITEMSIZE](1) WHERE ������ǰ�� = '" + item + "' AND Į�� = '" + color + "' AND ������ = '" + size + "'");
            var itemID = rst_item[0].������ID;
            var colorID = rst_item[0].Į��ID;
            var sizeID = rst_item[0].������ID;
            var rst_check = Get_Json("EXEC [H_Stock_NEW_CHUL_CHECK_RST] '" + date + "', '" + wareID + "', '" + itemID + "', '" + colorID + "', '" + sizeID + "', '" + cnt + "', '����������ǥ', 0");
            enabled = rst_check[0].ENABLED;
            return enabled;
        }catch(err){
            alert(err.message);
        };
    };    //  ���˻� end

    // ------------------------------------------------------------------------
    // ǰ�� autocomplete �������� �� ����       // common_func.js �� Get_Json_Done() ���� �۵���
    // ------------------------------------------------------------------------
    function Get_Json_After(temp_rst){
        // console.log("Get_Json_After");
        item_json = temp_rst;
        // console.log(item_json);
        item_sql = item_json;
    };      // ǰ�� �������� �� ���� end
    
    // ------------------------------------------------------------------------
    // ��Ʈ��ȣ �˻����� �������� ����          // common_func.js �� Get_Json_Done2() ���� �۵���
    // ------------------------------------------------------------------------
    function Get_Json_After2(temp_rst){
        var t_find_data_array = new Array();
        if(temp_rst.length <= 1 && !temp_rst[0].valueOf() == "" ){        //  �����Ͱ� ���°�� move_next �ߵ���ŰŰ���� �������� �Ѿ�� ����
            t_find_data_array.push("��ȸ ������ �����ϴ�. �������� �Ѿ��");
        }else{
            for(var i in temp_rst){
                t_find_data_array.push(temp_rst[i]["FieldName"]);
            };
        };
        $("#"+ G_LotID).css("background-color", "#ffffff");
        autocomplete_dbc(t_find_data_array, G_LotID);
        // ��Ʈ��ȣ�� ��� �߰��� return �ؼ� ���� ����Ǳ� ������ Ʈ���� ���ۼ�
        var e = $.Event("keydown", {        // autocomplete �Ϸ�� �˻����� Ȯ�� �ǵ��� �Ʒ�����Ű Ʈ���� �����
            keyCode : 40         //  �Ʒ�����Ű Ű�ڵ� 40   �ڿ� �����ݷ� ���̸� ������
        });
        setTimeout(function(){      //  �ٷ� ����� autoFocus ���׷� ���� ��Ŀ�� ����� setTimeout ������ ���� �����
            $("#" + G_LotID).trigger(e);        // �Ʒ� ����Ű Ʈ���� �۵�
        }, 100);
    };

    // ------------------------------------------------------------------------
    // �˻��� �Է� �ڵ��ϼ� sql
    // ------------------------------------------------------------------------
    function data_find(id, item_sql){
        try{
            var item = "";
            var t_sql = "";
            var item = "";
            var color = "";
            var size = "";
            var Stoc = $("#â���").val();
            if(id == "��񱸺�"){		//	�⺻ â�� ���� �˻��� �޶�������
                var gubun_text = Stoc == "����â��" ? "L%" : Stoc == "����â��" ? "C%" : false;
                if(gubun_text == false){
                    dontFocus = 1;      // �ڵ��ϼ� ȭ��ǥ Ʈ���Ÿ� �۵��ϵ��� �۾�
                    alert("�⺻â�� ��Ȯ�� ���ּ���.");
                    return false;
                }else{
                    t_sql = "EXEC AA_WORKDIARY_Search '" + gubun_text + "', '��񱸺�', ''";
                };
            }else if(id == "����"){		//	������ ��� ���� sql�� ����
                t_sql = "EXEC AA_WORKDIARY_Search '', '����', ''";
            }else if(id.includes("Į��")){		//	Į��id�� ���� ǰ�� id ����
                item = id == "Į��" ? "ǰ��" : id == "�۷�Į��" ? "�۷�ǰ��" : id == "����Į��1" ? "����ǰ��1" : id == "����Į��2" ? "����ǰ��2" : id == "����Į��3" ? "����ǰ��3" 
                        : id == "����Į��4" ? "����ǰ��4" : id == "����Į��5" ? "����ǰ��5" : id == "����Į��6" ? "����ǰ��6" : id == "����Į��7" ? "����ǰ��7" : id == "����Į��8" ? "����ǰ��8" 
                        : id == "����Į��9" ? "����ǰ��9" : "����ǰ��10";
                if($("#" + item).val() == ""){
                    dontFocus = 1;      // �ڵ��ϼ� ȭ��ǥ Ʈ���Ÿ� �۵��ϵ��� �۾�
                    alert("ǰ���� �Է��� �ּ���.");
                    $("#" + item).focus();
                    return false;
                }else{
                    t_sql = "EXEC AA_WORKDIARY_Search '', 'Į��', '" + $("#" + item).val() + "'";
                };
            }else if(id.includes("������")){		//	������id�� ���� ǰ�� id ����
                item = id == "������" ? "ǰ��" : id == "�۷������" ? "�۷�ǰ��" : id == "���ܻ�����1" ? "����ǰ��1" : id == "���ܻ�����2" ? "����ǰ��2" : id == "���ܻ�����3" ? "����ǰ��3" 
                        : id == "���ܻ�����4" ? "����ǰ��4" : id == "���ܻ�����5" ? "����ǰ��5" : id == "���ܻ�����6" ? "����ǰ��6" : id == "���ܻ�����7" ? "����ǰ��7" : id == "���ܻ�����8" ? "����ǰ��8" 
                        : id == "���ܻ�����9" ? "����ǰ��9" : "����ǰ��10";
                color = id == "������" ? "Į��" : id == "�۷������" ? "�۷�Į��" : id == "���ܻ�����1" ? "����Į��1" : id == "���ܻ�����2" ? "����Į��2" : id == "���ܻ�����3" ? "����Į��3"
                        : id == "���ܻ�����4" ? "����Į��4" : id == "���ܻ�����5" ? "����Į��5" : id == "���ܻ�����6" ? "����Į��6" : id == "���ܻ�����7" ? "����Į��7" : id == "���ܻ�����8" ? "����Į��8" 
                        : id == "���ܻ�����9" ? "����Į��9" : "����Į��10";
                if($("#" + item).val() == ""){
                    dontFocus = 1;      // �ڵ��ϼ� ȭ��ǥ Ʈ���Ÿ� �۵��ϵ��� �۾�
                    alert("ǰ���� �Է��� �ּ���.");
                    $("#" + item).focus();
                    return false;
                }else if($("#" + color).val() == ""){
                    dontFocus = 1;      // �ڵ��ϼ� ȭ��ǥ Ʈ���Ÿ� �۵��ϵ��� �۾�
                    alert("����� �Է��� �ּ���.");
                    $("#" + color).focus();
                    return false;
                }else{
                    t_sql = "EXEC AA_WORKDIARY_Search '', '������', '" + $("#" + item).val() + "'";
                };
            }else if(id.includes("��Ʈ��ȣ")){		//	��Ʈ��ȣ ������ ���� �����ϴ� ǰ��, Į��, ������ ����
                item = id == "�۷��Ʈ��ȣ" ? "�۷�ǰ��" : id == "���ܷ�Ʈ��ȣ1" ? "����ǰ��1" : id == "���ܷ�Ʈ��ȣ2" ? "����ǰ��2" : id == "���ܷ�Ʈ��ȣ3" ? "����ǰ��3" 
                        : id == "���ܷ�Ʈ��ȣ4" ? "����ǰ��4" : id == "���ܷ�Ʈ��ȣ5" ? "����ǰ��5" : id == "���ܷ�Ʈ��ȣ6" ? "����ǰ��6" : id == "���ܷ�Ʈ��ȣ7" ? "����ǰ��7" 
                        : id == "���ܷ�Ʈ��ȣ8" ? "����ǰ��8" : id == "���ܷ�Ʈ��ȣ9" ? "����ǰ��9" : "����ǰ��10";
                color = id == "�۷��Ʈ��ȣ" ? "�۷�Į��" : id == "���ܷ�Ʈ��ȣ1" ? "����Į��1" : id == "���ܷ�Ʈ��ȣ2" ? "����Į��2" : id == "���ܷ�Ʈ��ȣ3" ? "����Į��3" 
                        : id == "���ܷ�Ʈ��ȣ4" ? "����Į��4" : id == "���ܷ�Ʈ��ȣ5" ? "����Į��5" : id == "���ܷ�Ʈ��ȣ6" ? "����Į��6" : id == "���ܷ�Ʈ��ȣ7" ? "����Į��7" 
                        : id == "���ܷ�Ʈ��ȣ8" ? "����Į��8" : id == "���ܷ�Ʈ��ȣ9" ? "����Į��9" : "����Į��10";
                size = id == "�۷��Ʈ��ȣ" ? "�۷������" : id == "���ܷ�Ʈ��ȣ1" ? "���ܻ�����1" : id == "���ܷ�Ʈ��ȣ2" ? "���ܻ�����2" : id == "���ܷ�Ʈ��ȣ3" ? "���ܻ�����3" 
                        : id == "���ܷ�Ʈ��ȣ4" ? "���ܻ�����4" : id == "���ܷ�Ʈ��ȣ5" ? "���ܻ�����5" : id == "���ܷ�Ʈ��ȣ6" ? "���ܻ�����6" : id == "���ܷ�Ʈ��ȣ7" ? "���ܻ�����7" 
                        : id == "���ܷ�Ʈ��ȣ8" ? "���ܻ�����8" : id == "���ܷ�Ʈ��ȣ9" ? "���ܻ�����9" : "���ܻ�����10";
                if($("#" + item).val() == "" || $("#" + color).val() == "" || $("#" + size).val() == ""){
                    dontFocus = 1;      // �ڵ��ϼ� ȭ��ǥ Ʈ���Ÿ� �۵��ϵ��� �۾�
                    alert("��Ʈ��ȣ�� Ȯ���ϱ� ����\n����ǰ �Է� ������ ��Ȯ�� ���ּ���.");
                    var focus = $("#" + item).val() == "" ? item : $("#" + color).val() == "" ? color : size;
                    $("#" + focus).focus();
                    return false;
                }else{
                    t_sql = "EXEC [AA_WORKDIARY_LOTNO] '', '" + $("#�۾���").val() + "', '" + $("#" + item).val() + "', '" + $("#" + color).val() + "', '" + $("#" + size).val() + "', '" + Stoc + "'";
                };
            };
            var find_rst = "";		//	�����ų sql�� ���� ���� ����
            var find_data_array = new Array();		//	sql�� ���� ��ȯ ���� ������ Array ����
            if(id.includes("ǰ��")){		//	ǰ���� ��� ������ �ε�� �ٷ� sql �����Ͽ� ��Ƶξ� �Լ� ���� ������ �޾ƿ°� ���
                find_rst = item_sql;
            }else if(id.includes("��Ʈ��ȣ")){
                //Get_Json_Before() // ���α׷����� ����
                $("#"+ id).css("background-color", "#eee");
                Get_Json_common_direct2(t_sql);     // ���޽� id�� �������� ����
                G_LotID = id;       // �������� ���� id���� ���� ���� ����
                // ��������Ϸ��� Get_Json_After2 �����
                return;
            }else{		//	�� ���� ��� sql�� Get_Json()���� ����
                find_rst = Get_Json(t_sql);
            };
            find_data_array[id] = find_rst;
            if(id.includes("��Ʈ��ȣ")){
                if(find_rst[0]["FieldName"] == "" | find_rst[0]["FieldName"] == " "){        //  �����Ͱ� ���°�� move_next �ߵ���ŰŰ���� �������� �Ѿ�� ����
                    find_data_array.push("��ȸ ������ �����ϴ�. �������� �Ѿ��");
                }else{		//	��Ʈ��ȣ�� ��� ������ ��Ī(AS(Alias))�� �ٸ��� ������ �ٸ��� �ۼ�
                    for(var i in find_rst){
                        find_data_array.push(find_rst[i]["FieldName"]);
                    };
                };
            }else{
                if(find_rst[0]["FND_DATA"] == "" | find_rst[0]["FND_DATA"] == " "){
                    find_data_array.push("��ȸ ������ �����ϴ�. �������� �Ѿ��");
                }else{
                    for(var i in find_rst){
                        find_data_array.push(find_rst[i]["FND_DATA"]);
                    };
                };
            };
            autocomplete_dbc(find_data_array, id);
        }catch(err){
            alert(err.message);
            $("#ǰ��").focus();
        };
    };    //  data_find end

    // ------------------------------------------------------------------------
    // �ڵ��ϼ� ��ü ����
    // ------------------------------------------------------------------------
    function autocomplete_dbc(find_data_array, id){
        try {
            $("#" + id).autocomplete({    // autocomplete ����
                source : find_data_array,    //  �ڵ��ϼ��� ���� �ڷ�
                select : function(event, ui){   //  �ڷ� ���ý� �̺�Ʈ      $(this).val()�� �̹� �Էµ� ���� �ۼ��Ͽ� �۵��ϰԵ� �����ϱ� ���� ���� ���޵� / ui.item.value�� �ۼ��� ������ ������ �Ķ��Ÿ ����
                    $("#" + id).val(ui.item.value);
                    var t_this = this;
                    if(this.id == "������"){       //  ������ �Է½� ���� �Է� ���� �ҷ�����
                        auto_set($("#ǰ��").val(), $("#Į��").val(), $(this).val(), 2);
                        return;
                    };
                    setTimeout(function(){
                        move_next(t_this);
                    }, 100);
                },
                focus : function(event, ui){    //  focus �� �̺�Ʈ    �ѱ۰� ���� �������� ������� ���װ� �ִ� ? �����޽��� �����Ѵٰ���
                    return false;
                },
                change : function(event, ui){    //  change �� �̺�Ʈ
                    if(this.id.includes("ǰ��") == true){       //  ǰ��, Į��, ������ ���� �Է½� �Է³��� Ȯ��        select ���� �۵��� ������ �������� �۵��ϱ� ������ �ۼ����� Ȯ�� ���� change �۵�
                        if(autocom_valid("ǰ��", $(this).val(), "") == "0"){
                            dontFocus = 1;      // �ڵ��ϼ� ȭ��ǥ Ʈ���Ÿ� �۵��ϵ��� �۾�
                            $(this).val("");
                            $(this).focus();
                            return false;
                        };
                    };
                    if(this.id.includes("Į��") == true){
                        item = id == "Į��" ? "ǰ��" : id == "�۷�Į��" ? "�۷�ǰ��" : id == "����Į��1" ? "����ǰ��1" : id == "����Į��2" ? "����ǰ��2" : id == "����Į��3" ? "����ǰ��3" 
                                : id == "����Į��4" ? "����ǰ��4" : id == "����Į��5" ? "����ǰ��5" : id == "����Į��6" ? "����ǰ��6" : id == "����Į��7" ? "����ǰ��7" : id == "����Į��8" ? "����ǰ��8" 
                                : id == "����Į��9" ? "����ǰ��9" : "����ǰ��10";
                        if(autocom_valid("Į��", $(this).val(), $("#" + item).val()) == "0"){
                            dontFocus = 1;      // �ڵ��ϼ� ȭ��ǥ Ʈ���Ÿ� �۵��ϵ��� �۾�
                            $(this).val("");
                            $(this).focus();
                            return false;
                        };
                    };
                    if(this.id.includes("������") == true){
                        item = id == "������" ? "ǰ��" : id == "�۷������" ? "�۷�ǰ��" : id == "���ܻ�����1" ? "����ǰ��1" : id == "���ܻ�����2" ? "����ǰ��2" : id == "���ܻ�����3" ? "����ǰ��3" 
                                : id == "���ܻ�����4" ? "����ǰ��4" : id == "���ܻ�����5" ? "����ǰ��5" : id == "���ܻ�����6" ? "����ǰ��6" : id == "���ܻ�����7" ? "����ǰ��7" : id == "���ܻ�����8" ? "����ǰ��8" 
                                : id == "���ܻ�����9" ? "����ǰ��9" : "����ǰ��10";
                        if(autocom_valid("������", $(this).val(), $("#" + item).val()) == "0"){
                            dontFocus = 1;      // �ڵ��ϼ� ȭ��ǥ Ʈ���Ÿ� �۵��ϵ��� �۾�
                            $(this).val("");
                            $(this).focus();
                            return false;
                        };
                    };
                    if($(this).val().includes("��������")){       //  move_next �ߵ��� �Է°� ����
                        $(this).val("");
                    };
                },
                minLength : 0,    //  �ּ� ���� ��
                // autoFocus : true,   //  true�� ���� �� ù ��° �׸� �ڵ� ��Ŀ��
                classes : {   //  ���� ��ҿ� �߰� �� Ŭ���� ����
                    'ui-autocomplete' : 'highlight'
                },
                delay : 100,    //  �۵� �����ð�
                disable : false,    //  true �� �ڵ��ϼ� ��� ����
                position : {    //  ��ġ
                    my : 'left top',
                    at : 'left bottom',
                    collision : "flip"      //  ȭ�� ��򰡿� �浹�� �浹���� �ʴ� �������� ��ġ��
                }
            }).focus(function(){
                // $(this).autocomplete("search", $(this).val());    //  focus�� �ٷ� �˻�â�� ON   Ʈ���ŷ� �Ʒ�����Ű �����°� �߰� ���� ������ autoFocus �� ���װɷ��� ��Ŀ�� �����
            });

        }catch(err){
            alert(err.message);
        };
    };    //  autocomplete_dbc end

    // ------------------------------------------------------------------------
    // �ڵ��ϼ� valid check
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
    };    //  �ڵ��ϼ� valid check end

    // ------------------------------------------------------------------------
    //  �ֱ��Է��� ��������, ������� �ڵ��Է�
    // ------------------------------------------------------------------------
    function auto_set(item, color, size, count){
        try{
            var rst = Get_Json("[B_WORK_Auto_MAT] 'G_WorkDiary_����','"
                                    + item    + "','"
                                    + color    + "','"
                                    + size   + "'");
            if (rst[0].ǰ�� == item && rst[0].Į�� == color && rst[0].������ == size){
                if(confirm("���� ������ ����ǰ�� �ڵ����� �߰��Ͻðڽ��ϱ� ?") == true){
                    for(i = 0; i < count; i++){		//	.auto-mat�� .machine-set �� ���� ���� �Է� ��Ű�� ���� 2ȸ ����
                        var cl = (i == 0 ? '.auto-mat' : '.machine-set');
                        var classArray = $("" + cl + "");
                        for(n = 0; n < $("" + cl + "").length; n++){
                            var classId = classArray[n].id;
                            if(classArray[n].type == "text"){		//	Ÿ���� ��ġ�ϴ°�� �Է°� �ۼ��ϵ��� �߰����� Ÿ���� ������� || ���� �߰�
                                var field = rst[0][classId] + "";
                                field = ((field == 0 || field == "null") ? "" : field);
                                $("#" + classId + "").val(field);
                            };
                        };
                    };
                    $("#����ѱ���1").focus();
                    return;
                }else {
                    $("#����ѱ���1").focus();
                    return;
                };
            };
            $("#����ѱ���1").focus();
        }catch(err){
            alert(err.message);
        };
    };    //  �ֱ��Է��� ��������, ������� �ڵ��Է� end

    // ------------------------------------------------------------------------
    // ����ǰ �۷� �ٲٱ�, ���� üũ
    // ------------------------------------------------------------------------
    function check_glu(count, id){
        if($("#" + id).is(":checked")){		// üũ �� ��������
            $("#�۷翩��" + count).text("����ǰ��" + count);		//	üũ �ȵ� ���� �����
            $("#" + id).prop("checked", false);
            if(count == ""){
                $("#�۷���").css("background-color", "#fff");
            }else{
                $("#���ܺ��" + count).css("background-color", "#fff");
            };
        }else{		//	üũ �� ���� �����
            $("#�۷翩��" + count).text("�۷�" + count);
            $("#" + id).prop("checked", true);
            if(count == ""){
                $("#�۷���").css("background-color", "#FFEAD5");
            }else{
                $("#���ܺ��" + count).css("background-color", "#FFEAD5");
            };
        };
    };      //  ����ǰ �۷� �ٲٱ�, ���� üũ end

    // ------------------------------------------------------------------------
    // ����ǰ ��ȣ �ٲٱ�
    // ------------------------------------------------------------------------
    function changeDeisplay() {
        $("#ingredient_01").toggle();		//	���̱� �Ⱥ��̱� ó��
        $("#ingredient_02").toggle();
        if($("#changeInput").text() == "��������"){		//	������ ���� text ����
            $("#changeInput").text("��������");
        }else if($("#changeInput").text() == "��������"){
            $("#changeInput").text("��������");
        };
    };    //  ����ǰ ��ȣ �ٲٱ� end

    // ------------------------------------------------------------------------
    // ����ĭ �̵�
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
    };    //  ����ĭ �̵� end

    // ------------------------------------------------------------------------
    //  auto_set_date ���� ��¥ ���� �µ� ����
    // ------------------------------------------------------------------------
    function auto_set_date(date){
        try{
            var rst = Get_Json("[B_WORK_Auto_date] 1,'" + date + "'");		//	��¥�� �Ķ���ͷ� ����
            if (rst[0].���� != ""){		//	���� �� �����Ͱ� ������� ���� ������ ��������
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
    };    //    ���� ��¥ �����µ� ���� end

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
        var day2 = date.toISOString();      // ���ڰ��� �����
        console.log(date)
        console.log(day)
        console.log(day2)
        return day;
    };    //  ���� ��¥ end


</script>


<body>
  
    <div class="TopBtn">
        <div id="title_bar">
            <img id="title_bar_img" src ="../image/title/title2.png">
            <p id="t_header">�۾�����</p>
        </div>

        <button id="���ΰ�ħ" class="btn btn_01" onclick="location.reload();">
            <svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" fill="currentColor" class="bi bi-arrow-clockwise" viewBox="0 0 14 14">
                <path fill-rule="evenodd" d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2v1z"/>
                <path d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466z"/>
            </svg>
            <i class="bi bi-arrow-clockwise"></i>
            ���ΰ�ħ
        </button>

        <button id="�۾����" class="btn btn_01 btn_01_2">
            �۾����
        </button>
        
        <button id="�۾�����" class="btn btn_02 btn_02_1">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-fill" viewBox="0 0 16 16">
                <path d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708l-3-3zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207l6.5-6.5zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.499.499 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11l.178-.178z"/>
            </svg>
            <i class="bi bi-pencil-fill"></i>
            �۾�����
        </button>

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
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�۾�����" class="input_tag input-field datepicker" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">�۾��ð�</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�۾��ð�" class="input_tag input-field" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">���</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="��񱸺�" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">�۾���</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�۾���" class="input_tag input_tag_readonly_01 input_tag_end_01 input-field " tabindex="-1" readonly>
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">����</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="����" class="input_tag input-field set-date input-auto" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">�µ�</label>
                    </th>
                    <td class="td_01 td_temp_01">
                        <input type="text" id="�����µ�" class="input_tag input_tag_temp_01 input-number set-date" autocomplete="off"><span>&#176;C</span>
                    </td>
                    <td class="td_01 td_temp_01">
                        <input type="text" id="���Ŀµ�" class="input_tag input_tag_temp_01 input-number set-date" autocomplete="off"><span>&#176;C</span>
                    </td>

                    <th class="th_01">
                        <label class="label_tag">����</label>
                    </th>
                    <td class="td_01 td_temp_01">
                        <input type="text" id="��������" class="input_tag input_tag_temp_01 input-number set-date" autocomplete="off"><span>%</span>
                    </td>
                    <td class="td_01 td_temp_01">
                        <input type="text" id="���Ľ���" class="input_tag input_tag_temp_01 input-number set-date" autocomplete="off"><span>%</span>
                    </td>

                    <th class="th_01">
                        <label class="label_tag">���</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���" class="input_tag input_tag_end_01 input-field" autocomplete="off" spellcheck="false">
                    </td>
                </tr>
            </table>
        </div>

        <div class="item_insert">
            <table class="item">
                <tr>
                    <th class="th_01">
                        <label class="label_tag">����ǰ��</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="ǰ��" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">Į��</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="Į��" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">������</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="������" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�����Ʈ��ȣ" class="input_tag input_tag_readonly_01 input_tag_end_01 input-field " tabindex="-1" readonly>
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">������� 1</label>
                    </th>
                    <td class="td_01 td_prod_01">
                        <input type="text" id="����ѱ���1" class="input_tag input_tag_prod_01 input-number auto_sum" autocomplete="off">
                    </td>
                    <td class="td_01 td_prod_02">
                        <input type="text" id="����Ѽ���1" class="input_tag input_tag_prod_02 input-number auto_sum" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">������� 2</label>
                    </th>
                    <td class="td_01 td_prod_01">
                        <input type="text" id="����ѱ���2" class="input_tag input_tag_prod_01 input-number auto_sum" autocomplete="off">
                    </td>
                    <td class="td_01 td_prod_02">
                        <input type="text" id="����Ѽ���2" class="input_tag input_tag_prod_02_01 input-number auto_sum" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">������� 3</label>
                    </th>
                    <td class="td_01 td_prod_01">
                        <input type="text" id="����ѱ���3" class="input_tag input_tag_prod_01 input-number auto_sum" autocomplete="off">
                    </td>
                    <td class="td_01 td_prod_02">
                        <input type="text" id="����Ѽ���3" class="input_tag input_tag_prod_02_01 input-number auto_sum" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">������� 4</label>
                    </th>
                    <td class="td_01 td_prod_01">
                        <input type="text" id="����ѱ���4" class="input_tag input_tag_prod_01 input-number auto_sum" autocomplete="off">
                    </td>
                    <td class="td_01 td_prod_02">
                        <input type="text" id="����Ѽ���4" class="input_tag input_tag_prod_02_01 input_tag_end_04 input-number auto_sum" autocomplete="off">
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
                        <label class="label_tag">�۾��ӵ�</label>
                    </th>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;WIND&nbsp;</span><input type="text" id="���ε��ӵ�" class="input_tag input_tag_info_ma_02 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;RPM&nbsp;&nbsp;</span><input type="text" id="RPM" class="input_tag input_tag_info_ma_02 input-number machine-set" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">����ǰ�β�</label>
                    </th>
                    <td class="td_01 td_info_pro_01">
                        <span class="span_02">&nbsp;&nbsp;��&nbsp;</span><input type="text" id="����ǰ�ĵ�_��" class="input_tag input_tag_info_pro_01 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_pro_01">
                        <span class="span_02">&nbsp;��&nbsp;</span><input type="text" id="����ǰ�ĵ�_��" class="input_tag input_tag_info_pro_01 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_pro_01">
                        <span class="span_02">��&nbsp;&nbsp;</span><input type="text" id="����ǰ�ĵ�_��" class="input_tag input_tag_info_pro_01 input-number machine-set" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">�������</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�������" class="input_tag input_tag_readonly_01 input_tag_end_01 input-number " tabindex="-1" readonly>
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
                        <label class="label_tag">è���µ� 1</label>
                    </th>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;&nbsp;����&nbsp;&nbsp;</span><input type="text" id="è���µ�_����1" class="input_tag input_tag_info_ma_02 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;����&nbsp;&nbsp;</span><input type="text" id="è���µ�_����1" class="input_tag input_tag_info_ma_03 input-number machine-set" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">è���µ� 2</label>
                    </th>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;&nbsp;����&nbsp;&nbsp;</span><input type="text" id="è���µ�_����2" class="input_tag input_tag_info_ma_02 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;����&nbsp;&nbsp;</span><input type="text" id="è���µ�_����2" class="input_tag input_tag_info_ma_03 input-number machine-set" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">è���µ� 3</label>
                    </th>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;&nbsp;����&nbsp;&nbsp;</span><input type="text" id="è���µ�_����3" class="input_tag input_tag_info_ma_02 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">����</span><input type="text" id="è���µ�_����3" class="input_tag input_tag_info_ma_03 input_tag_end_03 input-number machine-set" autocomplete="off">
                    </td>
                </tr>

                <tr class="tr_hide">
                    <th class="th_01">
                        <label class="label_tag">è���µ� 4</label>
                    </th>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;&nbsp;����&nbsp;&nbsp;</span><input type="text" id="è���µ�_����4" class="input_tag input_tag_info_ma_02 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;����&nbsp;&nbsp;</span><input type="text" id="è���µ�_����4" class="input_tag input_tag_info_ma_03 input-number machine-set" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">è���µ� 5</label>
                    </th>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;&nbsp;����&nbsp;&nbsp;</span><input type="text" id="è���µ�_����5" class="input_tag input_tag_info_ma_02 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;����&nbsp;&nbsp;</span><input type="text" id="è���µ�_����5" class="input_tag input_tag_info_ma_03 input-number machine-set" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">è���µ� 6</label>
                    </th>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;&nbsp;����&nbsp;&nbsp;</span><input type="text" id="è���µ�_����6" class="input_tag input_tag_info_ma_02 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;����&nbsp;&nbsp;</span><input type="text" id="è���µ�_����6" class="input_tag input_tag_info_ma_03 input-number machine-set" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">è���µ� 7</label>
                    </th>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">&nbsp;&nbsp;����&nbsp;&nbsp;</span><input type="text" id="è���µ�_����7" class="input_tag input_tag_info_ma_02 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_info_ma_01">
                        <span class="span_02">����</span><input type="text" id="è���µ�_����7" class="input_tag input_tag_info_ma_03 input_tag_end_03 input-number machine-set" autocomplete="off">
                    </td>
                </tr>
            </table>
        </div>

        <div class="ingredient_insert">
            <table class="ingredient">
                <tr>
                    <th class="th_01">
                        <label id="�۷翩��" class="label_tag label_cursor" onclick="check_glu('', '�۷�')">
                            ����ǰ��
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�۷�ǰ��" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">����Į��</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�۷�Į��" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">���Ի�����</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�۷������" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">���Լ���</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�۷����Լ���" class="input_tag input_tag_end_01 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">���صβ�</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�۷���صβ�" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">�����β�</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�۷������β�" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">���/���</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="�۷����" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="�۷���" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�۷��Ʈ��ȣ" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>
            </table>

            <table id="ingredient_01" class="ingredient_01">
                <tr>
                    <th class="th_01">
                        <label id="�۷翩��1" class="label_tag label_cursor" onclick="check_glu('1', '�۷�1')">
                            ����ǰ�� 1
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="����ǰ��1" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">����Į��</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="����Į��1" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">���Ի�����</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܻ�����1" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">���Լ���</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;ǥ��</span><input type="text" id="ǥ������1" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;��&nbsp;</span><input type="text" id="�Ǽ���1" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">���صβ�</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܱ��صβ�1" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">�����β�</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���������β�1" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">���/���</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="�������1" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="���ܺ��1" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܷ�Ʈ��ȣ1" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label id="�۷翩��2" class="label_tag label_cursor" onclick="check_glu('2', '�۷�2')">
                            ����ǰ�� 2
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="����ǰ��2" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">����Į��</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="����Į��2" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">���Ի�����</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܻ�����2" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">���Լ���</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;ǥ��</span><input type="text" id="ǥ������2" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;��&nbsp;</span><input type="text" id="�Ǽ���2" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                
                    <th class="th_01">
                        <label class="label_tag">���صβ�</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܱ��صβ�2" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">�����β�</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���������β�2" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">���/���</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="�������2" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="���ܺ��2" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܷ�Ʈ��ȣ2" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label id="�۷翩��3" class="label_tag label_cursor" onclick="check_glu('3', '�۷�3')">
                            ����ǰ�� 3
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="����ǰ��3" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">����Į��</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="����Į��3" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">���Ի�����</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܻ�����3" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">���Լ���</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;ǥ��</span><input type="text" id="ǥ������3" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;��&nbsp;</span><input type="text" id="�Ǽ���3" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">���صβ�</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܱ��صβ�3" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">�����β�</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���������β�3" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">���/���</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="�������3" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="���ܺ��3" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܷ�Ʈ��ȣ3" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label id="�۷翩��4" class="label_tag label_cursor" onclick="check_glu('4', '�۷�4')">
                            ����ǰ�� 4
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="����ǰ��4" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">����Į��</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="����Į��4" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">���Ի�����</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܻ�����4" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">���Լ���</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;ǥ��</span><input type="text" id="ǥ������4" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;��&nbsp;</span><input type="text" id="�Ǽ���4" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">���صβ�</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܱ��صβ�4" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">�����β�</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���������β�4" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">���/���</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="�������4" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="���ܺ��4" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܷ�Ʈ��ȣ4" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>

                </tr>

                <tr>
                    <th class="th_01">
                        <label id="�۷翩��5" class="label_tag label_cursor" onclick="check_glu('5', '�۷�5')">
                            ����ǰ�� 5
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="����ǰ��5" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">����Į��</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="����Į��5" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">���Ի�����</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܻ�����5" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">���Լ���</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;ǥ��</span><input type="text" id="ǥ������5" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;��&nbsp;</span><input type="text" id="�Ǽ���5" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">���صβ�</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܱ��صβ�5" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">�����β�</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���������β�5" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">���/���</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="�������5" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="���ܺ��5" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܷ�Ʈ��ȣ5" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>
            </table>

            <table id="ingredient_02" class="ingredient_02">
                <tr>
                    <th class="th_01">
                        <label id="�۷翩��6" class="label_tag label_cursor" onclick="check_glu('6', '�۷�6')">
                            ����ǰ�� 6
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="����ǰ��6" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">����Į��</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="����Į��6" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">���Ի�����</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܻ�����6" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">���Լ���</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;ǥ��</span><input type="text" id="ǥ������6" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;��&nbsp;</span><input type="text" id="�Ǽ���6" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">���صβ�</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܱ��صβ�6" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">�����β�</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���������β�6" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">���/���</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="�������6" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="���ܺ��6" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܷ�Ʈ��ȣ6" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>

                </tr>

                <tr>
                    <th class="th_01">
                        <label id="�۷翩��7" class="label_tag label_cursor" onclick="check_glu('7', '�۷�7')">
                            ����ǰ�� 7
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="����ǰ��7" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">����Į��</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="����Į��7" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">���Ի�����</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܻ�����7" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">���Լ���</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;ǥ��</span><input type="text" id="ǥ������7" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;��&nbsp;</span><input type="text" id="�Ǽ���7" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">���صβ�</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܱ��صβ�7" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">�����β�</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���������β�7" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">���/���</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="�������7" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="���ܺ��7" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܷ�Ʈ��ȣ7" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label id="�۷翩��8" class="label_tag label_cursor" onclick="check_glu('8', '�۷�8')">
                            ����ǰ�� 8
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="����ǰ��8" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">����Į��</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="����Į��8" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">���Ի�����</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܻ�����8" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">���Լ���</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;ǥ��</span><input type="text" id="ǥ������8" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;��&nbsp;</span><input type="text" id="�Ǽ���8" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">���صβ�</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܱ��صβ�8" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">�����β�</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���������β�8" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">���/���</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="�������8" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="���ܺ��8" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܷ�Ʈ��ȣ8" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label id="�۷翩��9" class="label_tag label_cursor" onclick="check_glu('9', '�۷�9')">
                            ����ǰ�� 9
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="����ǰ��9" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">����Į��</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="����Į��9" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">���Ի�����</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܻ�����9" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">���Լ���</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;ǥ��</span><input type="text" id="ǥ������9" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;��&nbsp;</span><input type="text" id="�Ǽ���9" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">���صβ�</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܱ��صβ�9" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">�����β�</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���������β�9" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">���/���</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="�������9" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="���ܺ��9" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܷ�Ʈ��ȣ9" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label id="�۷翩��10" class="label_tag label_cursor" onclick="check_glu('10', '�۷�10')">
                            ����ǰ��10
                        </label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="����ǰ��10" class="input_tag input-field auto-mat input-auto must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">����Į��</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="����Į��10" class="input_tag input-field auto-mat input-auto must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">���Ի�����</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܻ�����10" class="input_tag input-field auto-mat input-auto must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">���Լ���</label>
                    </th>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;ǥ��</span><input type="text" id="ǥ������10" class="input_tag input_tag_count_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_count_01">
                        <span class="span_03">&nbsp;��&nbsp;</span><input type="text" id="�Ǽ���10" class="input_tag input_tag_count_01 input_tag_end_02 input-number must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">���صβ�</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܱ��صβ�10" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">�����β�</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���������β�10" class="input_tag input-number auto-mat" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">���/���</label>
                    </th>
                    <td class="td_01 td_pro_remark_01">
                        <input type="text" id="�������10" class="input_tag input_tag_pro_remark_01 input-number auto-mat" autocomplete="off">
                    </td>
                    <td class="td_01 td_pro_remark_02">
                        <input type="text" id="���ܺ��10" class="input_tag input_tag_pro_remark_02 input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܷ�Ʈ��ȣ10" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>
            </table>

            <table class="ingredient">
                <tr>
                    <th class="th_01 th_remark_01">
                        <label class="label_tag label_tag_2row">Ư�̻���</label>
                    </th>
                    <td class="td_01 td_remark_01">
                        <textarea type="text" id="Ư�̻���" class="input_tag textarea_tag input-field" autocomplete="off" spellcheck="false"></textarea>
                    </td>
                    
                    <td class="td_01 td_btn_01">
                        <button id="changeInput" class="btn_02 btn_td_01" onclick="changeDeisplay();">��������</button>
                    </td>
                </tr>
            </table>
        </div>
    </div>

<!-- hidden -->
<input type='hidden' id='â���' class='input-field'>
<input type='hidden' id='�۾����۽ð�' class='input-field'>
<input type='hidden' id='�۾�����ð�' class='input-field'>
<input type='hidden' id='IP_Address' class='input-field'>
<input type='hidden' id='Item' value="">   
<input type='hidden' id='color' value="">   
<input type='hidden' id='size' value="">   
<input type='hidden' id='WorkID' value="">   
<input type='hidden' id='OLD�۷����Լ���' value="0" class="oldGlu">
<input type='hidden' id='OLD�Ǽ���1' value="0" class="oldGlu">
<input type='hidden' id='OLD�Ǽ���2' value="0" class="oldGlu">
<input type='hidden' id='OLD�Ǽ���3' value="0" class="oldGlu">
<input type='hidden' id='OLD�Ǽ���4' value="0" class="oldGlu">
<input type='hidden' id='OLD�Ǽ���5' value="0" class="oldGlu">
<input type='hidden' id='OLD�Ǽ���6' value="0" class="oldGlu">
<input type='hidden' id='OLD�Ǽ���7' value="0" class="oldGlu">
<input type='hidden' id='OLD�Ǽ���8' value="0" class="oldGlu">
<input type='hidden' id='OLD�Ǽ���9' value="0" class="oldGlu">
<input type='hidden' id='OLD�Ǽ���10' value="0" class="oldGlu">
<input type='hidden' id='OLD�۾�����' value="0" class="oldGlu">

<input type="checkbox" id="�۷�" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="�۷�1" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="�۷�2" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="�۷�3" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="�۷�4" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="�۷�5" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="�۷�6" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="�۷�7" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="�۷�8" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="�۷�9" class="input-readonly" value="0" style="display:none;">
<input type="checkbox" id="�۷�10" class="input-readonly" value="0" style="display:none;">


</body>
</HTML>