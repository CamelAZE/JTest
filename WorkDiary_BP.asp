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
' WorkDiary_BP.asp  KYJ

Dim junID , P_Lot_NO
junID = request("junID")
P_Lot_NO = request("P_Lot_NO")

%>

<head>
<meta charset="utf-8">
<title>�۾��������(�д�)</title>
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

    /* �� ���� ������ / ������ css �۾� */
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

    /* �Ƿڼ� ��ȸ */
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

    /* ��ȸ ���Ľ� ������ */
    .ui-icon { zoom: 200%; margin-top: 1px; position: absolute; display: none; background-image: url("../IncJquery/images/ui-icons_ffffff_256x240.png");  }
    
    /* title */
    #title_bar{ float: left; width:22%; height:60px; margin: 5px 9% 0px 2%; vertical-align: auto; position: relative; background-size: 100%, 42px; background-position: center; background-repeat: no-repeat;  }
    #title_bar_img{ width: 100%; height: 100%;  }
    #t_header{ width: 100%; font-size: 18pt; font-weight: bold; font-family: Noto Sans KR; margin: 0px; color:white; text-align:center; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); letter-spacing: 2.5px;  }

    /* tr �±� */
    .tr_disable_01{ display: table-row;  }
    .tr_disable_01 label{ background-color: #E6E4DA;  }

    /* th �±� */
    .th_01{ box-sizing: border-box; width: 7.5%; height: 40px; font-size: 13pt; border-spacing: 0px; text-align: center;  }
    .th_table_01{ box-sizing: border-box; text-align: center;  }
    .th_search_01{ box-sizing: border-box; width: 22%; height: 40px; font-size: 13pt; border-spacing: 0px; text-align: center;  }

    /* td �±� */
    .td_01{ box-sizing: border-box; width: 17.5%; height: 40px; font-size: 13pt; border-spacing: 0px;  }
    .td_search_01{ box-sizing: border-box; width: 48%; height: 40px; font-size: 13pt; border-spacing: 0px;  }
    .td_insertCount_01{ width: 8.75%;  }
    .td_insertCount_02{ width: 8.75%;  }
    .td_length_01{ width: 12.5%;  }
    .td_length_02{ width: 5%;  }

    /* label */
    label{ display: block; border-radius: 3px; color: #000000; height: 34px; max-height: 34px; line-height: 34px; text-align: center; vertical-align: middle; font-weight: bold; white-space: nowrap; margin: 0px;  }
    .label_tag_2row{ height: 74px; max-height: 74px; line-height: 74px;  }

    /* input �±� */
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
    
    /* �д� ����/���� ������ */
    #insertTable tr:nth-child(n+6) { display: none;  }

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

    //  â�� ��ȣ�� â���̸� ��������
    var get_defaultStocName = Get_Json("SELECT â��� AS defaultStocName FROM C_â�� WHERE â��ID =" + defaultStocID);
    var defaultStocName = get_defaultStocName[0].defaultStocName;

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

            //  �۾� ����� �۾����� ȣ��� ����ϴ� ��ȣ
            var prk = "<%=junID%>";

            if(seSawonid == ""){        //  �θ� â���� ���� ���������� Ȯ��
                alert("�α��� ���¸� �ٽ� Ȯ���� �ּ���.");
                self.close();
            }else if(prk != ""){
                //  �����ͺҷ�����
                init_disp(prk);     //  ��ȣ ���� ����

                //  ���� ������
                $("#�۾����").attr("disabled", true);
                $("#�۾�����").attr("disabled", true);
                $("#�۾�����").css("display","inline");     //  ���� �Ҽ��ֵ��� �۾����� ��ư ���̰�
                $("#�۾�����").attr("disabled", true);
                $("#�����۷�Ʈ��ȣ").val("<%=P_Lot_NO%>");
                $(".btn_02_2").css("margin", "10px 2% 10px 0px");
                setTag();
            }else if(prk == ""){
                //  ���� ������
                $("#�۾�����").css("display","none");
                $(".btn_01_2").css("margin", "30px 4% 10px 0px");
                $("#�۾�����").val(getDay());
                $("#�۾�����").attr("min", getDay());       //  �޷¿��� ���� ���� ���� �Ұ����ϵ���
                $("#�۾�����").attr("max", getDay());       //  �޷¿��� ���� ���� ���� �Ұ����ϵ���
                var date = new Date();
                // date.setDate(date.getDate() - 7);       //  7���� ��¥ ���
                // var oneWeekAgo = date.toISOString().substring(0, 10);       //  ��� �� ��¥ YYYY-MM-DD ������ ��ȯ ������ �ȴ�� �ٷ� val() �ص� ����
                var oneWeekAgo = get_add_date_yyyymmdd('dd', -7);       // 7�� �� ��¥ ���
                $("#��ȸ����").val(oneWeekAgo);
                $("#�۾���").val(seSawonname);
                $("#â���").val(defaultStocName);

                //  �̿Ϸ� ������ Ȯ��
                var work_id = work_check($("#â���").val(), $("#�۾�����").val(), $("#�۾���").val());     //  â���, �۾�����, �۾��� �Ķ��Ÿ�� ����

                //  �̿Ϸ� �����Ϳ� ���� �����߻��� Ȥ�� ���� �������� �غ�
                if(work_id != ""){      //  �̿Ϸ� �����Ͱ� �������� �۾��������
                    remain_disp(work_id);       //  �������� workid �Ķ��Ÿ�� ����
                    prk = 1;        //  ���� ��Ŀ�� �������� �ʵ��� prk 1�� ���� prk ã�ư��� ���� �˼�����
                    $("#�۾�����").attr("disabled", true);
                    //  ���������۾��� �߰��� tr�±� ������� �߰��ϵ���
                    setTag();
                    //  PAD�� ������ ������ ��� ���� �Ұ����ϵ��� ó��
                    var PDA_rst = Get_Json("EXEC RF_PDA_CRE_WORKDIARY_CHECK 1, '�д�', '" + work_id + "'");
                    PDA_rst_length = PDA_rst.length
                    if(PDA_rst[0].RF�д�����ID == "" || PDA_rst[0].RF�д�����ID == " "){
                        PDA_rst_length = 0;
                    }else{
                        $("#t_header").text($("#t_header").text() + "(PDA�۾�)");
                        $("#���Էѱ���, #���ԷѼ���, #�����۷�Ʈ��ȣ,#���Էѱ���2, #���ԷѼ���2, #�����۷�Ʈ��ȣ2, #���Էѱ���3, #���ԷѼ���3, #�����۷�Ʈ��ȣ3").prop("readonly", true);
                        $("#���Էѱ���, #���ԷѼ���, #�����۷�Ʈ��ȣ,#���Էѱ���2, #���ԷѼ���2, #�����۷�Ʈ��ȣ2, #���Էѱ���3, #���ԷѼ���3, #�����۷�Ʈ��ȣ3").addClass("input_tag_readonly_01");
                        $("#â���, #�дܱ�, #ǰ��, #Į��, #������").prop("readonly", true);
                        $("#â���, #�дܱ�, #ǰ��, #Į��, #������").addClass("input_tag_readonly_01");
                        PDA_rst_length = 1;     //  autocomplete �۵� �ȵǰ�
                    };
                }else{      //  �̿Ϸ� ������ �������� �۾������غ�
                    $("#�۾�����").attr("disabled", true);
                };
            };    //  �ʱ� ������ ���� end

            // ------------------------------------------------------------------------
            // �۾����� ��ư Ŭ��
            // ------------------------------------------------------------------------
            $("#�۾�����").on("click", function(){
                if(save() == true){
                    $("#�۾�����").attr("disabled", true);
                    $("#�۾�����").attr("disabled", false);
                    $("#�ҷ�����1").val("01:����");
                };
            });   //  �۾����� ��ư end

            // ------------------------------------------------------------------------
            // �۾���� ��ư Ŭ��
            // ------------------------------------------------------------------------
            $("#�۾����").on("click", function(){
                if(confirm("���� ����Ͻðڽ��ϱ� ?") == true){
                    if($("#�۾����۽ð�").val() == ""){
                        alert("�۾��� ���۵Ǿ����� �ٽ� Ȯ�����ּ���.");
                    }else{
                        var wareHouse = $("#â���").val();
                        var delSawonName = $("#�۾���").val();
                        var delGubun = 4;         //  1 : ����, 2 : ����, 3 : ����, 4 : �д�, 5 : ���
                        var delWorkId = $("#WorkID").val();
                        var rst = Get_Json("EXEC RF_BUN_PDA_RF�д�����_ERP_CLEAR '" + delSawonName   + "', '" + delGubun + "', '" + delWorkId + "'");
                        alert(rst[0].MSG);
                        location.reload();
                    };
                };
            });   //  �۾���� ��ư end

            // ------------------------------------------------------------------------
            // �۾����� ��ư Ŭ��
            // ------------------------------------------------------------------------
            $("#�۾�����").on("click", function(){
                if(save() == true){
                    alert("����Ǿ����ϴ�.");
                    opener.main_bind();
                    self.close();
                    };
            });   //  �۾����� ��ư end

            // ------------------------------------------------------------------------
            // �۾����� ��ư Ŭ��
            // ------------------------------------------------------------------------
            $("#�۾�����").on("click", function(){
                $(".input-field, .input-number").attr("disabled", false);
                $("#�۾�����").attr("disabled", false);
                $("#�۾�����").attr("disabled", true);
                //  PAD�� ������ ������ ��� ���� �Ұ����ϵ��� ó��
                var PDA_rst = Get_Json("EXEC RF_PDA_CRE_WORKDIARY_CHECK 1, '�д�', '" + work_id + "'");
                PDA_rst_length = PDA_rst.length
                if(PDA_rst[0].RF�д�����ID == "" || PDA_rst[0].RF�д�����ID == " "){
                    PDA_rst_length = 0;
                }else{
                    $("#t_header").text($("#t_header").text() + "(PDA�۾�)");
                    $("#���Էѱ���, #���ԷѼ���, #�����۷�Ʈ��ȣ,#���Էѱ���2, #���ԷѼ���2, #�����۷�Ʈ��ȣ2, #���Էѱ���3, #���ԷѼ���3, #�����۷�Ʈ��ȣ3").pro("readonly", true);
                    $("#���Էѱ���, #���ԷѼ���, #�����۷�Ʈ��ȣ,#���Էѱ���2, #���ԷѼ���2, #�����۷�Ʈ��ȣ2, #���Էѱ���3, #���ԷѼ���3, #�����۷�Ʈ��ȣ3").addClass("input_tag_readonly_01");
                    $("#â���, #�дܱ�, #ǰ��, #Į��, #������").pro("readonly", true);
                    $("#â���, #�дܱ�, #ǰ��, #Į��, #������").addClass("input_tag_readonly_01");
                    PDA_rst_length = 1;     //  autocomplete �۵� �ȵǰ�
                };
                //  ���������۾��� �߰��� tr�±� ������� �߰��ϵ���
                setTag();

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
                var e = $.Event("keydown", {
                    keyCode : 40         //  �Ʒ�����Ű Ű�ڵ� 40
                });
                var t_this = this;
                setTimeout(function(){      //  �ٷ� ����� autoFocus ���׷� ���� ��Ŀ�� ����� setTimeout ������ ���� �����
                    $(t_this).trigger(e);
                }, 100);
                if(this.id == "â���" || this.id == "�дܱ�"){     // ������Ŀ�� ����� �̰� �߰���
                    return;
                }else{
                    $(this).trigger(e);
                };
            });   //  �Ʒ�����Ű Ʈ���� end
            
            $("#â���, #�дܱ�").on("focus", function(){      // �̰��ؾ� �Է°��� ������� �˻��� â�� �����ִµ� �׷��� autoFocus�� ���峲...
                $(this).autocomplete("search", "");             // �׷��� autoFocus ����� Ʈ���ŷ� autoFocus ��� �߰� �ۼ���
            });
            
            // ------------------------------------------------------------------------
            // ��ȸ
            // ------------------------------------------------------------------------
            $("#��ȸ����").on("change", function(){
				if(jFuncDateValid(this) == true){
					SUPPLY_DISP();
				}else{
					$("#��ȸ����").val(oneWeekAgo);
					return false;
				};
            });     //  ��ȸ end
            
            // ------------------------------------------------------------------------
            // ��ȸ ���� ����
            // ------------------------------------------------------------------------
            $("#forList_body").on("click", "tr", function(){
                //  ������ �����Ͽ����� �̸� �����ϴ� V ����� ���� ������ �־ ������
                $("#table_forList tbody tr").each(function(){
                    if(checkEven($(this).index() + 1) == true){     //  index�� ���缭 Ȧ���� ¦���� ����
                        $("td", this).css("background", "#eee");
                        // $("td", this).css("color", "#000");
                    }else{
                        $("td", this).css("background", "#fff");
                        // $("td", this).css("color", "#000");
                    };
                });
                var chk = $("td:eq(4)", this).text();
                if(chk == "" || chk === "��"){       //  ��ȸ ���� ��ܿ� �ڵ� �ۼ�
                    $("#ǰ��").val($("td:eq(6)", this).text());
                    $("#Į��").val($("td:eq(7)", this).text());
                    $("#������").val($("td:eq(8)", this).text());
                    $("#���Էѱ���").val($("td:eq(9)", this).text());
                    $("#���ԷѼ���").val(1);
                    sum();
                    $("#�����۷�Ʈ��ȣ").val($("td:eq(10)", this).text());
                    $("#�԰���ǥID").val($("td:eq(12)", this).text());
                    $("td", this).css("background-color", "#DBD6E8");
                };
            });     //  ��ȸ ���� ���� end
            
            // ------------------------------------------------------------------------
            // ��ȸ ���� ��� Ŭ������ ����
            // ------------------------------------------------------------------------
            $("#table_forList").on("click", "th", function(){
                var regex = /[^��-��|��-��|��-�R|aA-zZ]/gi;     //  �ѱ� ��� �Է�
                var sort_kind = $(this).text().replace(regex, "");      //  �׳� $(this).text() �� ����� �ٸ� ���ڰ� �־� replace�� �ѱ۸� �����
                console.log(sort_kind);
                if(sort_kind == "����"){
                    return;
                };
                $("#supply_header > th span").each(function(){      //  this�� �ƴѰ�� display none�� ������ �����
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
            // �����Ѽ��� �ڵ���� �Լ�����
            // ------------------------------------------------------------------------
            $(".auto_sum_01").on("change", function(){
                sum();
            });     //  �����Ѽ��� �ڵ���� �Լ����� end

            // ------------------------------------------------------------------------
            // �д��Ѽ��� �ڵ����
            // ------------------------------------------------------------------------
            $(".auto_sum_02").on("change", function(){
                var sum = 0;
                for(i = 1; i < 11; i++){
                    $("#�дܼ���" + i).val(parseInt($("#�дܷѱ���" + i).val() == "" ? 0 : $("#�дܷѱ���" + i).val()) * parseInt($("#�дܷѼ���" + i).val() == "" ? 0 : $("#�дܷѼ���" + i).val()));
                    sum += parseInt($("#�дܼ���" + i).val());
                };
                $("#�д��Ѽ���").val(sum);
            });     //  �д��Ѽ��� �ڵ����

            // ------------------------------------------------------------------------	
            // ���۽� ��Ŀ��
            // ------------------------------------------------------------------------	
            if(prk + "" == ""){     //  �ҷ��� �۾��� �������� ����Ǵ°��̳� ��������
                $("#â���").focus();
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
            var rst = Get_Json("B_WORK_LST_BUN 'G_WorkDiary_�д�', " + id);
            if(rst[0].WorkID == "" || rst[0].WorkID == " " || rst[0].WorkID == null){
                alert("�۾������� ��ϵ��� �ʾҽ��ϴ�.");
                self.close();
            }else{
                $("#WorkID").val(rst[0].WorkID);
                $("#â���").val(rst[0].â���);
                $(".input-field, .input-number").each(function(){
                    $(this).attr("disabled", true);      //  �б� �������� �ҷ�����
                    if($(this).attr("type") == "text" || $(this).attr("type") == "date" || $(this).attr("type") == "textarea" || $(this).attr("type") == "hidden"){
                        var field = rst[0][this.id] + "";
                        field = ((field == 0 || field == "null") ? "" : field);
                        if(this.id == "�۾�����"){
                            $("#" + this.id).val(field.substring(0, 10));       //  db�� ����� �۾����ڿ� �ð��� ����
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
    };    // �б����� ������ end

    // ------------------------------------------------------------------------
    //  ���� �̿Ϸ� �۾����� ��ȣ ȣ��
    // ------------------------------------------------------------------------
    function work_check(war_name ,work_date, worker){
        try{
            var rst = Get_Json("B_WORK_CHECK 'G_WorkDiary_�д�', '" + war_name + "', '" + work_date + "', '" + worker + "'");

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
            var rst = Get_Json("B_WORK_LST_REMAIN 'G_WorkDiary_�д�'," + id);
            if(rst[0].WorkID != ""){
                $("#WorkID").val(rst[0].WorkID);
                $("#â���").val(rst[0].â���);
                $(".input-field, .input-number").each(function(){
                    if($(this).attr("type") == "text" || $(this).attr("type") == "date" || $(this).attr("type") == "textarea" || $(this).attr("type") == "hidden"){
                        var field = rst[0][this.id] + "";
                        field = ((field == 0 || field == "null") ? "" : field);
                        if(this.id == "�۾�����"){
                            $("#" + this.id).val(field.substring(0, 10));       //  db�� ����� �۾����ڿ� �ð��� ����
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
            // console.log("EXEC [AA_WORKDIARY_�д�] '" + id + "', '" + WorkID + "'" + save_data)
            var insert = Get_Json("EXEC [AA_WORKDIARY_�д�] '" + id + "', '" + WorkID + "'" + save_data);
            if(insert[0].VALID == 0){
                dontFocus = 1;      // �ڵ��ϼ� ȭ��ǥ Ʈ���Ÿ� �۵��ϵ��� �۾�
                alert(insert[0].MSG);
                $("#" + insert[0].RETURN_INPUT).focus();
                return false;
            }else if(insert[0].VALID == 1){
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
            var gubun = "";
            if(id == "â���" || id == "�дܱ�" || id.includes("�дܱ���")){
				gubun = id == "â���" ? "â���" : id == "�дܱ�" ? "�дܱ�" : "�дܱ���"
                t_sql = "EXEC AA_WORKDIARY_Search '', '" + gubun + "', ''";
            }else if(id == "Į��"){
                if($("#ǰ��").val() == ""){
                    dontFocus = 1;      // �ڵ��ϼ� ȭ��ǥ Ʈ���Ÿ� �۵��ϵ��� �۾�
                    alert("ǰ���� �Է��� �ּ���.");
                    $("#ǰ��").focus();
                    return false;
                }else{
                    t_sql = "EXEC AA_WORKDIARY_Search '', 'Į��', '" + $("#ǰ��").val() + "'";
                };
            }else if(id == "������"){
                if($("#ǰ��").val() == ""){
                    dontFocus = 1;      // �ڵ��ϼ� ȭ��ǥ Ʈ���Ÿ� �۵��ϵ��� �۾�
                    alert("ǰ���� �Է��� �ּ���.");
                    $("#ǰ��").focus();
                    return false;
                }else{
                    t_sql = "EXEC AA_WORKDIARY_Search '', '������', '" + $("#ǰ��").val() + "'";
                };
            }else if(id.includes("��Ʈ��ȣ")){
                if($("#ǰ��").val() == "" || $("#Į��").val() == "" || $("#������").val() == ""){
                    dontFocus = 1;      // �ڵ��ϼ� ȭ��ǥ Ʈ���Ÿ� �۵��ϵ��� �۾�
                    alert("����ǰ �Է� ������ ��Ȯ�� ���ּ���.");
                    var focus = $("#ǰ��").val() == "" ? "Į��" : $("#����Į��").val() == "" ? "������" : size;
                    $("#" + focus).focus();
                    return false;
                }else{
                    t_sql = "EXEC [AA_WORKDIARY_LOTNO] '', '" + $("#�۾���").val() + "', '" + $("#ǰ��").val() + "', '" + $("#Į��").val() + "', '" + $("#������").val() + "', '" + $("#â���").val() + "'";
                };
            };
            var find_rst = "";
            var find_data_array = new Array();
            if(id == "ǰ��"){
                find_rst = item_sql;
            }else if(id.includes("��Ʈ��ȣ")){
                //Get_Json_Before() // ���α׷����� ����
                $("#"+ id).css("background-color", "#eee");
                Get_Json_common_direct2(t_sql);
                G_LotID = id;
                // ��������Ϸ��� Get_Json_After2 �����
                return;
            }else{
                find_rst = Get_Json(t_sql);
            };

            find_data_array[id] = find_rst;
            if(find_rst[0]["FND_DATA"] == "" | find_rst[0]["FND_DATA"] == " "){
                find_data_array.push("��ȸ ������ �����ϴ�. �������� �Ѿ��");
                // return false;        // return ���� ����ó���� �ع����� �ڵ��ϼ��� �ƿ� �۵����� ����
            }else{
                for(var i in find_rst){
                    find_data_array.push(find_rst[i]["FND_DATA"]);
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
                    if(this.id == "â���"){
                        SUPPLY_DISP();
                    };
                    var t_this = this;
                    setTimeout(function(){
                        move_next(t_this);
                    }, 100);
                },
                focus : function(event, ui){    //  focus �� �̺�Ʈ    �ѱ۰� ���� �������� ������� ���װ� �ִ� ? �����޽��� �����Ѵٰ���
                    return false;
                },
                change : function(event, ui){    //  change �� �̺�Ʈ
                    if(this.id == "ǰ��"){       //  ǰ��, Į��, ������ ���� �Է½� �Է³��� Ȯ��
                        if(autocom_valid("ǰ��", $(this).val(), "") == "0"){
                            dontFocus = 1;      // �ڵ��ϼ� ȭ��ǥ Ʈ���Ÿ� �۵��ϵ��� �۾�
                            $(this).val("");
                            $(this).focus();
                            return false;
                        };
                    };
                    if(this.id == "Į��"){
                        if(autocom_valid("Į��", $(this).val(), $("#ǰ��").val()) == "0"){
                            dontFocus = 1;      // �ڵ��ϼ� ȭ��ǥ Ʈ���Ÿ� �۵��ϵ��� �۾�
                            $(this).val("");
                            $(this).focus();
                            return false;
                        };
                    };
                    if(this.id == "������"){
                        if(autocom_valid("������", $(this).val(), $("#ǰ��").val()) == "0"){
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
    // �Ƿڼ� ��ȸ
    // ------------------------------------------------------------------------
    function SUPPLY_DISP(sortName, sortOrder) {
        try{
            sortName = sortName == null ? "" : sortName == undefined ? "" : sortName;		//	sortName�� �Է°� �ִ��� Ȯ��
            sortOrder = sortOrder == null ? "" : sortOrder == undefined ? "" : sortOrder;		//	sortOrder�� �Է°� �ִ��� Ȯ��
            var rst = Get_Json("EXEC B_WORK_PROD_LST 1, '" + $("#â���").val() + "', '" + $("#��ȸ����").val() + "', '" + sortName + "', '" + sortOrder + "'");
            var appendHTML = "";
            if(rst[0].�������� == "" || rst[0].�������� == " " || rst[0].�������� == null){       //  ��ȸ ������ ���� ���
                appendHTML += "<tr><td>��ȸ ������ �����ϴ�</td></tr>";
            }else{
                if(rst.length > 10){
                    for(i = 0; i < rst.length; i++){
                        appendHTML += '<tr><td style="width: 8%">' + rst[i].�������� + '</td><td style="width: 8%">' + rst[i].�ڸ����� + '</td><td style="width: 7%">' + rst[i].â��� + '</td><td style="width: 7%">' + rst[i].�����
                                + '</td><td class="select" style="width: 2%">' + rst[i].�дܻ�� + '</td><td style="width: 7%">' + rst[i].��񱸺�
                                + '</td><td style="width: 13%">'+ rst[i].ǰ�� + '</td><td style="width: 13%">' + rst[i].Į�� + '</td><td style="width: 8%">' + rst[i].������ + '</td><td class="number" style="width: 5%">' + rst[i].����
                                + '</td><td style="width: 10%">' + rst[i].��Ʈ��ȣ + '</td><td style="width: 11.1%">' + rst[i].������ + '</td><td style="display:none">' + rst[i].�԰���ǥID + '</td></tr>';
                    };
                }else{
                    for(i = 0; i < rst.length; i++){
                        appendHTML += '<tr><td style="width: 8%">' + rst[i].�������� + '</td><td style="width: 8%">' + rst[i].�ڸ����� + '</td><td style="width: 7%">' + rst[i].â��� + '</td><td style="width: 7%">' + rst[i].�����
                                + '</td><td class="select" style="width: 2%">' + rst[i].�дܻ�� + '</td><td style="width: 7%">' + rst[i].��񱸺�
                                + '</td><td style="width: 13%">'+ rst[i].ǰ�� + '</td><td style="width: 13%">' + rst[i].Į�� + '</td><td style="width: 8%">' + rst[i].������ + '</td><td class="number" style="width: 5%">' + rst[i].����
                                + '</td><td style="width: 10%">' + rst[i].��Ʈ��ȣ + '</td><td style="width: 12%">' + rst[i].������ + '</td><td style="display:none">' + rst[i].�԰���ǥID + '</td></tr>';
                    };
                };
            };
            $("#forList_body").empty();
            $("#forList_body").append(appendHTML);
        }catch(err){
            alert(err.message);
        };
    };      //  �Ƿڼ� ��ȸ end

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
    // �д� ���� / ���� �׸� �ø���
    // ------------------------------------------------------------------------
    function showTrTag(){
        try{
            var int = parseInt($("#countAdd").val());       //  ���° ������ �����ϱ� ���� ���簪 start 6
            var top = parseInt($("#topInt").val());       //  top ��ġ ����� ���簪 start 450
            var divHeight = parseInt($("#divHeight").val());        //  ���̺� div height ���簪
            var tbodyHeight = parseInt($("#tbodyHeight").val());        //  ���̺� tbody height ���簪
            if(int < 11){
                if (int > 5){        //  int ��° tr �±� display �Ӽ� ����
                    $("#insertTable tr:nth-child(" + int + ")").css("display", "table-row");
                    $("#addInput").text("+" + (int + 1));
                    $(".btn_add").css("top", (top + 40) + "px");
                };
            }else{
                return;
            };
            if(int > 7){        //  ���̺� �þ����� ��ü ��ũ�� ����°� �����ϱ� ���� ��ü���� ũ�� ����
                $(".div_forList").css("height", (divHeight - 40) + "px");
                $(".forList_body").css("height", (tbodyHeight - 40) + "px");
                $("#divHeight").val(parseInt($("#divHeight").val()) - 40);     //  ���簪 ���� - 40 ó��
                $("#tbodyHeight").val(parseInt($("#tbodyHeight").val()) - 40);     //  ���簪 ���� - 40 ó��
            };
            if(int == 10){      //  10 ��°�ϰ�� ��ư �Ⱥ��̰�
                $("#addInput").hide();
                return;
            };
            $("#countAdd").val(parseInt($("#countAdd").val()) + 1);     //  ���簪 ���� + 1 ó��
            $("#topInt").val(parseInt($("#topInt").val()) + 40);     //  ���簪 ���� + 40 ó��
        }catch(err){
            alert(err.message);
        };
    };      //  �д� ���� / ���� �׸� �ø��� end

    // ------------------------------------------------------------------------
    // �д� ���� / ���� �׸� ����Ʈ ������ �ٷ� �ø���
    // ------------------------------------------------------------------------
    function setTag(){
        for(i = 6; i < 11; i++){
            if($("#�дܷѱ���" + i).val().length > 0){
                showTrTag();
            }else{
                return false;
            };
        };
    };
    

    // ------------------------------------------------------------------------
    // �����Ѽ��� �Լ�
    // ------------------------------------------------------------------------
    function sum(){
        var roll_length = $("#���Էѱ���").val() == "" ? 0 : $("#���Էѱ���").val();
        var roll_cnt = $("#���ԷѼ���").val() == "" ? 0 : $("#���ԷѼ���").val();
        var roll_length2 = $("#���Էѱ���2").val() == "" ? 0 : $("#���Էѱ���2").val();
        var roll_cnt2 = $("#���ԷѼ���2").val() == "" ? 0 : $("#���ԷѼ���2").val();
        var roll_length3 = $("#���Էѱ���3").val() == "" ? 0 : $("#���Էѱ���3").val();
        var roll_cnt3 = $("#���ԷѼ���3").val() == "" ? 0 : $("#���ԷѼ���3").val();
        $("#�����Ѽ���").val(parseInt(roll_length) * parseInt(roll_cnt) + parseInt(roll_length2) * parseInt(roll_cnt2) + parseInt(roll_length3) * parseInt(roll_cnt3));
    };      //  �����Ѽ��� �Լ� end

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

    // ------------------------------------------------------------------------
    // Ȧ¦ �����ϱ�
    // ------------------------------------------------------------------------
    function checkEven(num){        //  Ȧ���� ������ false ¦���� ������ true
        return (num % 2 == 0);
    };      //  Ȧ¦ �����ϱ� end



</script>

</head>

<body>
  
    <div class="TopBtn">
        <div id="title_bar">
            <img id="title_bar_img" src ="../image/title/title2.png">
            <p id="t_header">�д��۾�����</p>
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
                    <td class="td_01">
                        <input type="text" id="�۾�����" class="input_tag input-field datepicker" max="9999-12-31" min="1970-01-01" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">â���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="â���" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">�дܱ�</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܱ�" class="input_tag input-field input-auto" autocomplete="off">
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

        <div class="item_insert">
            <table class="item">
                <tr>
                    <th class="th_01">
                        <label class="label_tag">ǰ��</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="ǰ��" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">Į��</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="Į��" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">������</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="������" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="���Ժ��" class="input_tag input_tag_end_01 input-field" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">���Ա���/����</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="���Էѱ���" class="input_tag input_tag_insertCount_01 auto_sum_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="���ԷѼ���" class="input_tag input_tag_insertCount_02 auto_sum_01 input-number" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">��Ʈ��ȣ</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�����۷�Ʈ��ȣ" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">�����Ѽ���</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�����Ѽ���" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">�д��Ѽ���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�д��Ѽ���" class="input_tag input_tag_readonly_01 input_tag_end_01 input-number" tabindex="-1" readonly>
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">���Ա���/����</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="���Էѱ���2" class="input_tag input_tag_insertCount_01 auto_sum_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="���ԷѼ���2" class="input_tag input_tag_insertCount_02 auto_sum_01 input-number" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">��Ʈ��ȣ</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�����۷�Ʈ��ȣ2" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">���Ա���/����</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="���Էѱ���3" class="input_tag input_tag_insertCount_01 auto_sum_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="���ԷѼ���3" class="input_tag input_tag_insertCount_02 auto_sum_01 input-number" autocomplete="off">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">��Ʈ��ȣ</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�����۷�Ʈ��ȣ3" class="input_tag input_tag_end_01 input-field input-auto" autocomplete="off">
                    </td>
                </tr>
            </table>
        </div>

        <div class="machine_insert">
            <table id="insertTable" class="machine">
                <tr id="tr_div_01">
                    <th class="th_01">
                        <label class="label_tag">�дܱ���/����</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="�дܷѱ���1" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="�дܷѼ���1" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">�дܼ���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܼ���1" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">�дܱ���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܱ���1" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܺ��1" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
                
                <tr id="tr_div_2">
                    <th class="th_01">
                        <label class="label_tag">�дܱ���/����</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="�дܷѱ���2" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="�дܷѼ���2" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">�дܼ���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܼ���2" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">�дܱ���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܱ���2" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܺ��2" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
                
                <tr id="tr_div_3">
                    <th class="th_01">
                        <label class="label_tag">�дܱ���/����</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="�дܷѱ���3" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="�дܷѼ���3" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">�дܼ���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܼ���3" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">�дܱ���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܱ���3" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܺ��3" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
                
                <tr id="tr_div_4">
                    <th class="th_01">
                        <label class="label_tag">�дܱ���/����</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="�дܷѱ���4" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="�дܷѼ���4" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">�дܼ���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܼ���4" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">�дܱ���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܱ���4" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܺ��4" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
                
                <tr id="tr_div_5">
                    <th class="th_01">
                        <label class="label_tag">�дܱ���/����</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="�дܷѱ���5" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="�дܷѼ���5" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">�дܼ���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܼ���5" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">�дܱ���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܱ���5" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܺ��5" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
                
                <tr id="tr_div_6">
                    <th class="th_01">
                        <label class="label_tag">�дܱ���/����</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="�дܷѱ���6" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="�дܷѼ���6" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">�дܼ���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܼ���6" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">�дܱ���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܱ���6" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܺ��6" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
                
                <tr id="tr_div_7">
                    <th class="th_01">
                        <label class="label_tag">�дܱ���/����</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="�дܷѱ���7" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="�дܷѼ���7" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">�дܼ���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܼ���7" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">�дܱ���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܱ���7" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܺ��7" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
                
                <tr id="tr_div_8">
                    <th class="th_01">
                        <label class="label_tag">�дܱ���/����</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="�дܷѱ���8" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="�дܷѼ���8" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">�дܼ���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܼ���8" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">�дܱ���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܱ���8" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܺ��8" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
                
                <tr id="tr_div_9">
                    <th class="th_01">
                        <label class="label_tag">�дܱ���/����</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="�дܷѱ���9" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="�дܷѼ���9" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">�дܼ���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܼ���9" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">�дܱ���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܱ���9" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܺ��9" class="input_tag input_tag_end_01 input-field">
                    </td>
                </tr>
                
                <tr id="tr_div_10">
                    <th class="th_01">
                        <label class="label_tag">�дܱ���/����</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="�дܷѱ���10" class="input_tag input_tag_insertCount_01 auto_sum_02 input-number">
                    </td>
                    <td class="td_01 td_insertCount_02">
                        <input type="text" id="�дܷѼ���10" class="input_tag input_tag_insertCount_02 auto_sum_02 input-number">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">�дܼ���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܼ���10" class="input_tag input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                    <th class="th_01">
                        <label class="label_tag">�дܱ���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܱ���10" class="input_tag input-field input-auto">
                    </td>
                    <th class="th_01">
                        <label class="label_tag">���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�дܺ��10" class="input_tag input_tag_end_01 input-field">
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
                            ��������<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 8%">
                            �ڸ�����<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 7%">
                            â���<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 7%">
                            �����<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 2%">
                            &nbsp;<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 7%">
                            ��񱸺�<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 13%">
                            ǰ��<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 13%">
                            Į��<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 8%">
                            ������<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 5%">
                            ����<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 10%">
                            ��Ʈ��ȣ<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_table_01" style="width: 12%">
                            ������<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                    </tr>
                </thead>
                
                <tbody id="forList_body" class="forList_body">
                </tbody>
            </table>
        </div>
    </div>

          
<!-- hidden -->
<input type="hidden" id="�۾����۽ð�" class="input-field">
<input type="hidden" id="�۾�����ð�" class="input-field">
<input type="hidden" id="�۾��ð�" class="input-field">

<input type="hidden" id="�԰���ǥID" class="input-field">
<input type="hidden" id="IP_Address" class="input-field">
<input type="hidden" id="WorkID" value="">

<input type="hidden" id="countAdd" value="6">
<input type="hidden" id="topInt" value="450">
<input type="hidden" id="divHeight" value="350">
<input type="hidden" id="tbodyHeight" value="300">

</body>
</HTML>