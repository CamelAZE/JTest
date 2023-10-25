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
' WorkDiary_JP.asp  KYJ

Dim junID , P_Lot_NO
junID = request("junID")
P_Lot_NO = request("P_Lot_NO")

%>

<head>
<meta charset="utf-8">
<title>�۾��������(���)</title>
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
    /* �ҷ���Ʈ �ݱ� */
    .btn_td_01{ width: 100%; height: 36px; line-height: 34px; vertical-align: middle; border: 1px solid #195E9B; border-radius: 3px; background-color: #337ab7; color: #fff; font-weight: bold; font-size: 16px; margin: 0px;  }

    /* �� ���� ������ / ������ css �۾� */
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

    /* �����Ƿڼ� ��ȸ */
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
    
    /* ��ȸ ���Ľ� ������ */
    .ui-icon { zoom: 200%; margin-top: 1px; position: absolute; display: none; background-image: url("../IncJquery/images/ui-icons_ffffff_256x240.png");  }

    /* title */
    #title_bar{ float: left; width:22%; height:60px; margin: 5px 2% 0px 2%; vertical-align: auto; position: relative; background-size: 100%, 42px; background-position: center; background-repeat: no-repeat;  }
    #title_bar_img{ width: 100%; height: 100%;  }
    #t_header{ width: 100%; font-size: 18pt; font-weight: bold; font-family: Noto Sans KR; margin: 0px; color:white; text-align:center; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); letter-spacing: 2.5px;  }

    /* tr �±� */
    .tr_hide{ display: none; border-collapse: collapse; width: 100%; background-color: #E0F0FF;  }
    .tr_hide label{ display: block; border: 1px solid #ACCEF2; background-color: #E0F0FF; width: 100%;  }

    /* th �±� */
    .th_01{ box-sizing: border-box; width: 7.5%; height: 40px; font-size: 13pt; border-spacing: 0px; text-align: center;  }

    /* td �±� */
    .td_01{ box-sizing: border-box; width: 17.5%; height: 40px; font-size: 13pt; border-spacing: 0px;  }
    .td_search_01{ width: 1%;  }
    .td_insertCount_01{ width: 5%;  }
    .td_insertCount_02{ width: 12.5%;  }
    .td_length_01{ width: 12.5%;  }
    .td_length_02{ width: 5%;  }

    /* label */
    label{ display: block; border-radius: 3px; color: #000; height: 34px; max-height: 34px; line-height: 34px; text-align: center; vertical-align: middle; font-weight: bold; white-space: nowrap; margin: 0px;  }

    /* input �±� */
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
            var PDA_rst_length = 0;
            var size_add_cnt = 1;

            if(seSawonid == ""){        //  �θ� â���� ���� ���������� Ȯ��
                alert("�α��� ���¸� �ٽ� Ȯ���� �ּ���.");
                self.close();

            }else if(prk != ""){
                //  �����ͺҷ�����
                init_disp(prk);     //  ��ȣ ���� ����

                //  ���� ������
                $("#OLD�۾�����").val($("#�۾�����").val());
                $("#�۾����").attr("disabled", true);
                $("#�۾�����").attr("disabled", true);
                $("#�۾�����").css("display","inline");     //  ���� �Ҽ��ֵ��� �۾����� ��ư ���̰�
                $("#�۾�����").attr("disabled", true);
                $("#�����۷�Ʈ��ȣ").val("<%=P_Lot_NO%>");
                $(".btn_01_2").css("margin", "30px 1.8% 10px 0px");
                $(".btn_02_2").css("margin", "10px 2% 10px 0px");
                
            }else{
                //  ���� ������
                $("#�۾�����").css("display", "none");      //  ���� �Ҽ��ֵ��� �۾����� ��ư ���̰�
                $("#�߻�����").val(dateString);
                $("#�߻�����").attr("min", getDay());       //  �޷¿��� ���� ���� ���� �Ұ����ϵ���
                $("#�߻�����").attr("max", getDay());       //  �޷¿��� ���� ���� ���� �Ұ����ϵ���
                $("#�����").val(seSawonname);
                $("#â���").val(defaultStocName);
                $("#���LOT").val($("#�߻�����").val().replace(/-/gi, "").substring(2));
                // var date = new Date();
                // date.setDate(date.getDate() - 7);       //  7���� ��¥ ���
                // var oneWeekAgo = date.toISOString().substring(0, 10);       //  ��� �� ��¥ YYYY-MM-DD ������ ��ȯ ������ �ȴ�� �ٷ� val() �ص� ����
                var searchFirstDate = get_add_date_yyyymmdd('mm', -3);      // 3�� ������ ����
                $("#��ȸ���ں���").val(searchFirstDate);
                $("#��ȸ���ڱ���").val(dateString);

                //  �̿Ϸ� ������ Ȯ��
                var work_id = work_check($("#â���").val(), $("#�߻�����").val(), $("#�����").val());     //  â���, �߻�����, ����� �Ķ��Ÿ�� ����

                //  �̿Ϸ� �����Ϳ� ���� �����߻��� Ȥ�� ���� �������� �غ�
                if(work_id != ""){      //  �̿Ϸ� �����Ͱ� �������� �۾��������
                    remain_disp(work_id);       //  �������� workid �Ķ��Ÿ�� ����
                    var prk = 1;        //  ���� ��Ŀ�� �������� �ʵ��� prk 1�� ���� prk ã�ư��� ���� �˼�����
                    $("#�۾�����").attr("disabled", true);

                    //  PAD�� ������ ������ ��� ���� �Ұ����ϵ��� ó��
                    var PDA_rst = Get_Json("EXEC RF_PDA_CRE_WORKDIARY_CHECK 1, '���', '" + work_id + "'");
                    PDA_rst_length = PDA_rst.length
                    if(PDA_rst[0].RF�������ID == "" || PDA_rst[0].RF�������ID == " "){
                        PDA_rst_length = 0;
                    }else{
                        $("#t_header").text($("#t_header").text() + "(PDA�۾�)");
                        $("#â���, #���ó��, #��ܱ�, #����ǰ��, #����Į��, #���Ի�����, #ǰ��, #Į��, #���ԷѼ���").prop("readonly", true);
                        $("#â���, #���ó��, #��ܱ�, #����ǰ��, #����Į��, #���Ի�����, #ǰ��, #Į��, #���ԷѼ���").addClass("input_tag_readonly_01");
                //	$("#���Էѱ���,#���ԷѼ���,#�����۷�Ʈ��ȣ").attr("class","input-readonly").prop("readonly",true)   //  ���� ����
                        PDA_rst_length = 1;     //  autocomplete �۵� �ȵǰ�
                    };
                }else{
                    $("#�۾�����").attr("disabled", true);
                };
                $("#�ҷ�����1").val("01:����");
                $("#OutID").val("");
            };    //  �ʱ� ������ ���� end

            // ------------------------------------------------------------------------
            // �۾����� ��ư Ŭ��
            // ------------------------------------------------------------------------
            $("#�۾�����").on("click", function(){
                if(save("G_Workdiary") == true){        //  �۾� ���� �� ��ư ����
                    $("#�۾�����").attr("disabled", true);
                    $("#�۾�����").attr("disabled", false);
                    $("#�ҷ�����1").val("01:����");
                };
            });   //  �۾����� ��ư end

            // ------------------------------------------------------------------------
            // �۾����� ��ư Ŭ��
            // ------------------------------------------------------------------------
            $("#�۾�����").on("click", function(){
                // if(stock_chk($("#����ǰ��").val(), $("#����Į��").val(), $("#���Ի�����").val(), $("#���Լ���").val() - $("#OLD���Լ���").val()) == false){      // �۾����� ������ �����Ұ�� OLD���Լ��� �� �ʿ� �׷��� �ʱ⶧���� ����
                if(stock_chk($("#����ǰ��").val(), $("#����Į��").val(), $("#���Ի�����").val(), $("#���Լ���").val()) == false){
                    alert("����ǰ �������� �����մϴ�.\n������ Ȯ�� �� �����ϼ���.");
                    $("#���ԷѼ���").focus();
                    return false;
                }else{
                    if($("#sizeAdd").val() == 1){       //  ������ �߰� ��Ȳ�� ��
                        if(save("G_WorkDiary_Sub") != true){
                            return false;
                        };
                    }else{
                        if(save("G_WorkDiary") != true){		//	�⺻ ����
                            return false;
                        };
                    };
                };
                
                // $(opener.location).attr("href", "javascript:searchOnDblclickHandler();");        //  ���� ������ �ִ� ���   �˻����� ����Ŭ���� �˻����������� �����ε� ��� ����Ǿ�����(IncJs/GlobEventHandler.js)

                alert("����Ǿ����ϴ�.");
                if(confirm("�ٸ� ����� �߰��� ����Ͻðڽ��ϱ� ?") == true){
                    $("#sizeAdd").val(1);
                    $("#�۾�����").val("disabled", true);
                    $("#�۾�����").val("disabled", false);
                    if(size_add_cnt == 1){      //  ù��° ������ �߰��Ͻ� ���� Workid ����
                        $("#workid_ori").val($("#WorkID").val());
                    };
                    size_add_cnt = size_add_cnt + 1;
                    // ������ �Ϻ� ���� ���� / ���Լ����� �ߺ� üũ �Ǵ� ���� �ִٰ���
                    $(".input-field, .input-number").not("#�߻�����, #���ó��, #��ܱ�, #ǰ��, #Į��, #����ǰ��, #����Į��, #���Ի�����, #�ʸ�LOT, #����LOT, #���LOT, #�ѱ���, #����, #���").each(function(){
                        if($(this).attr("type") == "text" || $(this).attr("type") == "date"){
                            $(this).val("");
                        }; 
                    });
                    $("#�۾����۽ð�").val($("#�۾�����ð�").val());
                    $("#forList_body").empty();
                    $("#�ҷ�����1").val("01:����");
                }else{
                    opener.main_bind();
                    self.close();
                };
            });   //  �۾����� ��ư end

            // ------------------------------------------------------------------------
            // �۾���� ��ư Ŭ��
            // ------------------------------------------------------------------------
            $("#�۾����").on("click", function(){
                if(confirm("���� ����Ͻðڽ��ϱ� ?") == true){
                    if($("#�۾����۽ð�").val() == ""){     //  �۾����۽ð� ������ �۾� ���� ���� Ȯ��
                        alert("�۾��� ���۵Ǿ����� �ٽ� Ȯ�����ּ���.");
                    }else{
                        var wareHouse = $("#â���").val();
                        var delSawonName = $("#�����").val();
                        var delGubun = 5;         //  1 : ����, 2 : ����, 3 : ����, 4 : �д�, 5 : ���
                        var delWorkId = $("#WorkID").val();
                        var rst = Get_Json("EXEC RF_JAE_PDA_RF�������_ERP_CLEAR '" + delSawonName   + "', '" + delGubun + "', '" + delWorkId + "'");
                        alert(rst[0].MSG);
                        location.reload();
                    };
                };
            });   //  �۾���� ��ư end

            // ------------------------------------------------------------------------
            // �۾����� ��ư Ŭ��
            // ------------------------------------------------------------------------
            $("#�۾�����").on("click", function(){
                $(".input-field, .input-number").attr("disabled", false);
                $("#�۾�����").attr("disabled", false);
                $("#�۾�����").attr("disabled", true);

            });   //  �۾����� ��ư Ŭ�� end

            // ------------------------------------------------------------------------
            // class input-number �׸� ���ڸ� �Է��ϵ��� ����
            // ------------------------------------------------------------------------
            $(".input-number").on("blur keyup keydown", function(){
                // var regex = /[^0-9]/gi;    //  ���ڻ��� �Է� �ȵ� .���ȵ�
                var regex = /[��-��|��-��|��-�R|aA-zZ]/gi;     //  �ѱ� ��� ����
                $(this).val($(this).val().replace(regex, ""));
            });   //  ���ڸ� �Է� end

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
            // autocomplete ǰ�� �˻� ������ �ε�� �ٷν���
            // ------------------------------------------------------------------------
            item_sql = "";      // ������ ���ڵ�� ��������
            var item_json = Get_Json_common_direct("EXEC [AA_WORKDIARY_Search2] '', 'ǰ��', ''");       // json ����ȯ �Ͽ� �������� ǰ�� ���� �˻� sql
            // �Ϸ��� Get_Json_After �Լ��� ����ǰ� �׶� item_sql �� ������ ��

            // ------------------------------------------------------------------------
            // input-auto ��Ŀ���� ���� �Ʒ�����Ű Ʈ���� �۵����� �˻� ��� ��ġ�� / autocomplete ����
            // ------------------------------------------------------------------------
            $(".input-auto").on("focus", function(){
                //if(PDA_rst_length == 0){		//	PDA�� �ҷ��� ��� ������� �ʵ��� 0�ΰ�쿡 ����		//	PDA �������� �ҷ��ð�� PDA_rst_length = 1 �� ������
                    if(dontFocus == 0){
                    data_find(this.id, item_sql);       //  �ڵ��ϼ� ����
                    }else{
                        dontFocus = 0;
                        return;
                    };
                    var e = $.Event("keydown", {
                        keyCode : 40         //  �Ʒ�����Ű Ű�ڵ� 40
                    });
                    var t_this = this;		//	setTimeout���� this �� ����ϸ� this���� ���ϱ� ������ ������ this�� t_this�� ���
                    setTimeout(function(){      //  �ٷ� ����� autoFocus ���׷� ���� ��Ŀ�� ����� setTimeout ������ ���� �����
                        $(t_this).trigger(e);
                    }, 100);
                    if(this.id == "���ó��" || this.id == "��ܱ�"){     // ������Ŀ�� ����� �̰� �߰���
                        return;
                    }else{
                        $(this).trigger(e);
                    };
                // };
            });   //  �Ʒ�����Ű Ʈ���� end
            
            $("#���ó��, #��ܱ�").on("focus", function(){      // �̰��ؾ� �Է°��� ������� �˻��� â�� �����ִµ� �׷��� autoFocus�� ���峲...
                $(this).autocomplete("search", "");             // �׷��� autoFocus ����� Ʈ���ŷ� autoFocus ��� �߰� �ۼ���
            });
            
            // ------------------------------------------------------------------------
            // �����Ƿ��� ��ȸ
            // ------------------------------------------------------------------------
            $("#��ȸ���ں���, #��ȸ���ڱ���").on("change", function(){
				if(jFuncDateValid(this) == true){
                    SUPPLY_DISP($("#ǰ��").val(), $("#Į��").val(), $("#������").val());
				}else if(this.id == "��ȸ���ں���"){
                    $("#��ȸ���ں���").val(get_add_date_yyyymmdd('mm', -3));
					return false;
				}else if(this.id == "��ȸ���ڱ���"){
                    $("#��ȸ���ڱ���").val(dateString);
					return false;
                };
            });     //  �����Ƿ��� ��ȸ end

            // ------------------------------------------------------------------------
            // �����Ƿ� ���� üũǥ��, ��׶��� ������
            // ------------------------------------------------------------------------
            $("#forList_body").on("click", "td", function(){
                var rowIndex = $(this).parent().parent().children().index($(this).parent()) + 1;        //  ���̺� ��ü���� 0��°�� ����̱� ������ 1��° index�� �ֱ����� +1
                var cnt = parseInt($("#table_forList tr:eq(" + rowIndex + ") td:eq(7)").text());
                var chk = $("#table_forList tr:eq(" + rowIndex + ") td:eq(8)");     //  .text()�� ������ �� ���� �Ϸ��� chk �������� .text()�� ���� ������ �Ұ����ؼ� .text()�� ���� ���
                var OutID = $("#table_forList tr:eq(" + rowIndex + ") td:eq(9)").text();
                var work_cnt = $("#�۾�����").val() == "" ? 0 : parseInt($("#�۾�����").val());
                if(chk.text() == "?"){     //  �̹� üũǥ�ð� �ִ� ��� �������� ������
                    chk.text("");
                    $("#�۾�����").val(work_cnt - cnt);
                    $("#OutID").val("");
                    if(checkEven(rowIndex)){        //  Ȧ����° ������ ¦����° ������ Ȯ���ϰ� ���� ����
                        $("#table_forList tr:eq(" + rowIndex + ")").css("background-color", "#eee");
                    }else{
                        $("#table_forList tr:eq(" + rowIndex + ")").css("background-color", "#fff");
                    };
                }else{      //  üũǥ��
                    chk.text("?");
                    $("#�۾�����").val(work_cnt + cnt);
                    $("#OutID").val(OutID);
                    $("#table_forList tr:eq(" + rowIndex + ")").css("background-color", "#DBD6E8");
                };
            });     //  �����Ƿ� ���� end
            
            // ------------------------------------------------------------------------
            // �����Ƿ� ��� Ŭ������ ����
            // ------------------------------------------------------------------------
            $("#table_forList").on("click", "th", function(){
                var regex = /[^��-��|��-��|��-�R|aA-zZ]/gi;     //  �ѱ� ��� �Է�
                var sort_kind = $(this).text().replace(regex, "");      //  $(this).text() �� ����� �ٸ� ���ڰ� �־� replace�� �ѱ۸� �����
                if(sort_kind == "����"){
                    return;
                };
                $("#supply_header > th span").each(function(){      //  this�� �ƴѰ�� display none�� ������ �����
                    if($(this).parent().text().replace(regex, "") != sort_kind){
                        $(this).css("display", "none");
                    };
                });
                if($(this).children().css("display") == "none"){		//	���� ������ �Ǿ� ���� ������ ������ ������ �Ǻ�
                    $(this).children().css("display", "inline").attr("class", "ui-icon ui-icon-triangle-1-n");
                    SUPPLY_DISP($("#ǰ��").val(), $("#Į��").val(), $("#������").val(), sort_kind, "ASC");
                }else{
                    if($(this).children().hasClass("ui-icon-triangle-1-n") == true){		//	Ŭ���� ������ �������� ��� �Ǻ��� ���� ���� ����
                        $(this).children().attr("class", "ui-icon ui-icon-triangle-1-s");
                        SUPPLY_DISP($("#ǰ��").val(), $("#Į��").val(), $("#������").val(), sort_kind, "DESC");
                    }else{
                        $(this).children().attr("class", "ui-icon ui-icon-triangle-1-n");
                        SUPPLY_DISP($("#ǰ��").val(), $("#Į��").val(), $("#������").val(), sort_kind, "ASC");
                    };
                };
            });     //  �����Ƿ� ��� Ŭ������ ���� end

            // ------------------------------------------------------------------------
            // �������, �ҷ����� �ڵ����
            // ------------------------------------------------------------------------
            $('.auto_sum').on("change", function roll_sum(){
                if($("#�ѱ���").val() == "" || $("#�ѱ���").val() == "0"){      //  �ѱ��� �Է� üũ
                    alert("�ѱ��̴� �ʼ� �Է� �׸��Դϴ�.");
                    $("#�ѱ���").focus();
                    return false;
                };
                var roll_good = 0;      //  ��������� ���� ����
                var roll_bad = 0;       //  �ҷ������� ���� ����
                for(i = 1; i < 9; i++){     //  1~ 8���� �ݺ�
                    if($("#�Ѽ���" + i).val() + "" != ""){      //  �Ѽ��� �Է� üũ
                        if($("#�ҷ�����" + i).val() == ""){     //  �Ѽ����� �Է��ߴµ� �ҷ������� �Է����� �������
                            alert("�ҷ������� ���� �Է��� �ּ���.");
                            $("#�Ѽ���" + i).val("");		//	�Ѽ����� �ۼ��Ǿ������� �ҷ������� ���� ���Ǳ� ������ �Ѽ��� ����
                            $("#�ҷ�����" + i).focus();
                        }else{      //  �Է°� ���
                            roll_good = roll_good + ($("#�ҷ�����" + i).val() == "01:����" ? parseInt($("#�Ѽ���" + i).val()) : 0);     //  ������ ��� �� ���� ���
                            roll_bad = roll_bad + ($("#�ҷ�����" + i).val() != "01:����" ? parseInt($("#�Ѽ���" + i).val()) : 0);       //  ������ �ƴ� ��� �� ���� ���
                        };
                    };
                };
                $("#�������").val(parseInt($("#�ѱ���").val()) * roll_good);       //  ������� ��ü ��� �� ����
                $("#�ҷ�����").val(parseInt($("#�ѱ���").val()) * roll_bad);        //  �ҷ����� ��ü ��� �� ����
            });   //  ���� �ڵ���� end

            // ------------------------------------------------------------------------
            // ���Լ��� �ڵ����
            // ------------------------------------------------------------------------
            $("#���ԷѼ���, #�ѱ���").on("change", function(){
                if($("#�ѱ���").val() == "" || $("#�ѱ���").val() == "0"){      //	�ѱ��� �Է� üũ
                    alert("�ѱ��̴� �ʼ� �Է� �׸��Դϴ�.");
                    $("#�ѱ���").focus();
                    $("#���Լ���").val("");
                    return false;
                };
                if($("#���ԷѼ���").val() != "" && $("#���ԷѼ���").val() != "0"){		//	���ԷѼ��� �Է� üũ
                    $("#���Լ���").val(parseInt($("#�ѱ���").val()) * parseInt($("#���ԷѼ���").val()));		//	���Լ��� �ڵ� ���
                }else{
                    $("#���ԷѼ���").val(0);
                };
            });     //  ���Լ��� �ڵ���� end

            // ------------------------------------------------------------------------
            // ���Լ��� OLD ����
            // ------------------------------------------------------------------------
            $("#���Լ���").focusin(function(){
                if((prk > 1) && ($("#OLD�۾�����").val() == $("#�۾�����").val())){
                    if($("#���Լ���").val() == "0"){
                        $("#OLD���Լ���").val($("#���Լ���").val());
                    };
                };
            });

            // ------------------------------------------------------------------------	
            // ���۽� ��Ŀ��
            // ------------------------------------------------------------------------	
            if(prk + "" == ""){     //  �ҷ��� �۾��� �������� ����Ǵ°��̳� ��������
                $("#���ó��").focus();
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
            var rst = Get_Json("B_WORK_LST_BUN 'G_WorkDiary', " + id);
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
                        if(this.id == "�߻�����"){
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
    // ���� �̿Ϸ� �۾����� ��ȣ ȣ��
    // ------------------------------------------------------------------------
    function work_check(war_name ,work_date, worker){
        try{
            var rst = Get_Json("B_WORK_CHECK 'G_WorkDiary', '" + war_name + "', '" + work_date + "', '" + worker + "'");

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
            var rst = Get_Json("B_WORK_LST_REMAIN 'G_WorkDiary'," + id);		//	����۾� �������ΰ� �ִ��� üũ ������ �߰���ƾ�� Ȯ������ ���� ���۹�ư ��ü�� ������ ����
            if(rst[0].WorkID != ""){
                $("#WorkID").val(rst[0].WorkID);
                $("#â���").val(rst[0].â���);
                $(".input-field, .input-number, .input-readonly").each(function(){
                    if($(this).attr("type") == "text" || $(this).attr("type") == "date" || $(this).attr("type") == "textarea" || $(this).attr("type") == "hidden"){
                        var field = rst[0][this.id] + "";
                        field = ((field == 0 || field == "null") ? "" : field);
                        if(this.id == "�߻�����"){
                            $("#" + this.id).val(field.substring(0, 10));       //  db�� ����� �߻����ڿ� �ð��� ����
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
    //  ��� üũ
    // ------------------------------------------------------------------------
    function stock_chk(item, color, size, cnt){
        if(item == "" || color == "" || size == "" || cnt == "" || size.includes("����") == true){
            return true;
        };
        var enabled;
        var date = $("#�߻�����").val();
        var wareID = $("#â���").val() == "���â��" ? 8 : $("#â���").val() == "��ǰâ��" ? 14 : 7;
        //  GET_ITEMZIZE ��ü�� ���� ID 3���� �����ð��̱� ������ select ���� ���� �۵�
        // var rst_item = Get_Json("SELECT * FROM [dbo].[Get_ITEMSIZE](1) WHERE ������ǰ�� = '" + item + "' AND Į�� = '" + color + "' AND ������ = '" + size + "'");
        // console.log("SELECT * FROM [dbo].[Get_ITEMSIZE](1) WHERE ������ǰ�� = '" + item + "' AND Į�� = '" + color + "' AND ������ = '" + size + "'");
        // var itemID = rst_item[0].������ID;
        // var colorID = rst_item[0].Į��ID;
        // var sizeID = rst_item[0].������ID;
        var rst_itemid = Get_Json("SELECT ������ID FROM H_������ WHERE ������ǰ�� = '" + item + "'");
        var rst_colorid = Get_Json("SELECT detailid FROM C_Į�� WHERE detailname = '" + color + "'");
        var rst_sizeid = Get_Json("SELECT detailid FROM C_������ WHERE detailname = '" + size + "'");
        var itemID = rst_itemid[0].������ID;
        var colorID = rst_colorid[0].detailid;
        var sizeID = rst_sizeid[0].detailid;
        var rst = Get_Json("EXEC [H_Stock_NEW_CHUL_CHECK_RST] '" + date + "', '" + wareID + "', '" + itemID + "', '" + colorID + "', '" + sizeID + "', '" + cnt + "', '���������ǥ', 0");
        console.log("EXEC [H_Stock_NEW_CHUL_CHECK_RST] '" + date + "', '" + wareID + "', '" + itemID + "', '" + colorID + "', '" + sizeID + "', '" + cnt + "', '���������ǥ', 0");
        enabled = rst[0].ENABLED;       // ��� ���¿� ���� ��밡���Ͻ� 1 �Ұ����Ͻ� 0 �� ��ȯ��
        return enabled;
    };

    // ------------------------------------------------------------------------
    //  ����
    // ------------------------------------------------------------------------
    function save(table){
        try{
            var id = seSawonid;
            var WorkID = $("#WorkID").val();
            var t_val = "";
            var save_data = "";
            $('.input-field, .input-number, .input-readonly').each(function(){		//	���� ����� input �׸� üũ
                if($(this).attr("type") == "text" || $(this).attr("type") == "date" || $(this).attr("type") == "hidden" || $(this).attr("type") == "textarea"){
                    t_val = $(this).val();
                }else if($(this).attr("type") == "checkbox"){
                    t_val = $(this).is(":checked") == true ? 1 : 0;
                }else if($(this).attr("type") == "select-one"){
                    t_val = $(this).val() == null ? 0 : $(this).val();
                };
                save_data += ", '" + t_val + "'";		//	üũ�ϸ� �Է°� ������ ���
            });
            var insert = Get_Json("EXEC [AA_WORKDIARY_���] '" + id + "', '" + WorkID + "'" + save_data + ", '" + table + "'");		//	���� sp ����
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
            var color = "";
            var size = "";
            var t_sql = "";
            var Stoc = $("#â���").val();
            var gubun = "";
            if(id == "���ó��" || id == "��ܱ�" || id.includes("�ҷ�����")){		//	���ó��, ��ܱ�, �ҷ����� �� ��� ���� sql�� ����
                gubun = id == "���ó��" ? "���ó��" : id == "��ܱ�" ? "��ܱ�" : "�ҷ�����";
                t_sql = "EXEC AA_WORKDIARY_Search '', '" + gubun + "', ''";
            }else if(id == "Į��" || id == "����Į��"){		//	Į��, ����Į�� �� ��� ���� sql�� ����
                item = id == "Į��" ? "ǰ��" : "����ǰ��";
                if($("#" + item).val() == ""){
                    dontFocus = 1;      // �ڵ��ϼ� ȭ��ǥ Ʈ���Ÿ� �۵��ϵ��� �۾�
                    alert(item + "�� �Է��� �ּ���.");
                    $("#" + item).focus();
                    return false;
                }else{
                    t_sql = "EXEC AA_WORKDIARY_Search '', 'Į��', '" + $("#" + item).val() + "'";
                };
            }else if(id == "������" || id == "���Ի�����" || id == "���ܻ�����"){		//	������, ���Ի�����, ���ܻ����� �� ��� ���� sql�� ����
                item = id == "������" ? "ǰ��" : "����ǰ��";		//	������, ���Ի����� �� ���� ������ ǰ�� ����
                color = id == "������" ? "Į��" : "����Į��";
                if(($("#" + item).val() == "" || $("#" + color).val() == "") && id != "���ܻ�����"){		//	���� �Է� ��� Ȯ�� ���ܻ������� ��� ǰ��� ���� ���� ������ ����
                    dontFocus = 1;      // �ڵ��ϼ� ȭ��ǥ Ʈ���Ÿ� �۵��ϵ��� �۾�
                    var focus = $("#" + item).val() == "" ? item : color;
                    alert(focus + "�� �Է��� �ּ���.");
                    $("#" + focus).focus();
                    return false;
                }else{
                    if(id == "������"){
                        t_sql = "EXEC AA_WORKDIARY_Search '', '���', '" + $("#" + item).val() + "'";
                    }else if(id == "���Ի�����"){
                        t_sql = "EXEC AA_WORKDIARY_Search '', '����', '" + $("#" + item).val() + "'";
                    }else if(id == "���ܻ�����"){
                        t_sql = "EXEC AA_WORKDIARY_Search '', '����', ''";
                    };
                };
            }else if(id == "����LOT"){		//	����LOT �� ��� ���� sql�� ����
                if($("#����ǰ��").val() == "" || $("#����Į��").val() == "" || $("#���Ի�����").val() == ""){		//	���� �Է� ��� Ȯ��
                    // dontFocus = 1;      // �ڵ��ϼ� ȭ��ǥ Ʈ���Ÿ� �۵��ϵ��� �۾�
                    // alert("����ǰ �Է� ������ ��Ȯ�� ���ּ���.");
                    // var focus = $("#����ǰ��").val() == "" ? "����ǰ��" : $("#����Į��").val() == "" ? "����Į��" : "���Ի�����";
                    // $("#" + focus).focus();
                    return false;
                }else{
                    t_sql = "EXEC [AA_WORKDIARY_LOTNO] '', '" + $("#�����").val() + "', '" + $("#����ǰ��").val() + "', '" + $("#����Į��").val() + "', '" + $("#���Ի�����").val() + "', '" + Stoc + "'";
                };
            };
            console.log(t_sql)
            var find_rst = "";		//	�����ų sql�� ���� ���� ����
            var find_data_array = new Array();		//	sql�� ���� ��ȯ ���� ������ Array ����
            var find_unit_array = new Array();		//	ǰ���� ���� ��ȯ ���� ������ Array ����
            var find_roll_array = new Array();		//	ǰ���� ���� ��ȯ ���� ������ Array ����
            if(id.includes("ǰ��")){		//	ǰ���� ��� ������ �ε�� �ٷ� sql �����Ͽ� ��Ƶξ� �Լ� ���� ������ �޾ƿ°� ���
                find_rst = item_sql;
            }else if(id == "����LOT"){
                //Get_Json_Before() // ���α׷����� ����
                $("#"+ id).css("background-color", "#eee");
                Get_Json_common_direct2(t_sql);
                G_LotID = id;
                // ��������Ϸ��� Get_Json_After2 �����
                return;
            }else{		//	�� ���� ��� sql�� Get_Json()���� ����
                find_rst = Get_Json(t_sql);
            };
            find_data_array[id] = find_rst;
            if(id == "�۾�����"){		//	�۾������� ��� ���� ������ �ۼ�
                find_data_array = ["�����Ƿ�", "�������", "�������"];
            }else if(id == "ǰ��" || id == "����ǰ��"){
                if(find_rst[0]["FND_DATA"] ==  ""){        //  �����Ͱ� ���°�� move_next �ߵ���ŰŰ���� �������� �Ѿ�� ����
                    find_data_array.push("��ȸ ������ �����ϴ�. �������� �Ѿ��");
                }else{
                    for(var i in find_rst){     //  ǰ���� ��� �� ���̿� �������� ��ȸ�ؼ� �������� ������ �迭�� key �� value �� ���� ������Ŵ
                        find_data_array.push({label : find_rst[i]["FND_DATA"], value : find_rst[i]["FND_DATA"], unit : find_rst[i]["unitName"], roll : find_rst[i]["rollName"]});
                    };
                };
            }else if(id == "����LOT"){
                if(find_rst[0]["FieldName"] == "" || find_rst[0]["FieldName"] == " "){
                    find_data_array.push("��ȸ ������ �����ϴ�. �������� �Ѿ��");
                }else{
                    for(var i in find_rst){		//	����LOT�� ��� ������ ��Ī(AS(Alias))�� �ٸ��� ������ �ٸ��� �ۼ�
                        find_data_array.push(find_rst[i]["FieldName"]);
                    };
                };
            }else{
                if(find_rst[0]["FND_DATA"] == "" || find_rst[0]["FND_DATA"] == " "){
                    find_data_array.push("��ȸ ������ �����ϴ�. �������� �Ѿ��");
                }else{
                    for(var i in find_rst){		//	�ܿ� ��쿡 ��� ���� ��Ī(AS(Alias))�� ����Ͽ��⿡ �˸°� ������ ���
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
    // �ڵ��ϼ� ��ü ����
    // ------------------------------------------------------------------------
    function autocomplete_dbc(find_data_array, id){
        try {
            $("#" + id).autocomplete({    // autocomplete ����
                source : find_data_array,    //  �ڵ��ϼ��� ���� �ڷ�
                select : function(event, ui){   //  �ڷ� ���ý� �̺�Ʈ      $(this).val()�� �̹� �Էµ� ���� �ۼ��Ͽ� �۵��ϰԵ� �����ϱ� ���� ���� ���޵� / ui.item.value�� �ۼ��� ������ ������ �Ķ��Ÿ ����
                    $("#" + id).val(ui.item.value);
                    if(this.id == "���ó��"){
                        var date = new Date();
                        if(ui.item.value == "��ܶ���"){        //  ��ܶ����� ��� ����
                            $("#â���").val("���â��");
                            $("#search_title").html("�����Ƿ���");
                            // date.setDate(date.getDate() - 7);       //  7���� ��¥ ���
                            // var oneWeekAgo = date.toISOString().substring(0, 10);       //  ��� �� ��¥ YYYY-MM-DD ������ ��ȯ ������ �ȴ�� �ٷ� val()�� ��Ƶ� ����
                            //  toISOString() ���� �⺻���� ���� ǥ�ؽ÷� �ٲ� ��갪�� �޶��� > get_add_date_yyyymmdd ���
                            var searchFirstDate = get_add_date_yyyymmdd('mm', -3);      // 3���� ���� ����
                            $("#��ȸ���ں���").val(searchFirstDate);
                            $("#��ȸ���ڱ���").val(dateString);
                            $("#���LOT").val($("#�߻�����").val().replace(/-/gi, "").substring(2));
                            $("#����LOT").val("");
                        }else if(ui.item.value == "��������"){      //  ���������� ��� ����
                            $("#â���").val("��ǰâ��");
                            $("#��ܱ�").val("���� ������ 2��");
                            $("#search_title").html("����Ƿ���");
                            // date.setDate(date.getDate() + 2);       //  2���� ��¥ ���
                            // var twoDaysLater = date.toISOString().substring(0, 10);     // ��� �� ��¥ YYYY-MM-DD ������ ��ȯ ������ �ȴ�� �ٷ� val()�� ��Ƶ� ����
                            var twoDaysLater = get_add_date_yyyymmdd('dd', +2);      // 2�� �� ��¥ ���
                            $("#��ȸ���ں���").val(dateString);
                            $("#��ȸ���ڱ���").val(twoDaysLater);
                            $("#����LOT").val($("#�߻�����").val().replace(/-/gi, "").substring(2));
                            $("#���LOT").val("");
                            $("#ǰ��").focus();     //  ���������� ��� ��ܱ⵵ �ۼ��� ���ֱ� ������ ǰ������ ��Ŀ�� �̵��ϰ� move_next �ߵ����� �ʵ��� return false; ���� Ż��
                            return false;       //  �ۼ� ���ϸ� move_next �ߵ����� Į�� ���� ���� ��
                        }else{		//	���������� ��� ����
                            $("#â���").val("����â��");
                        };
                    };
                    if(this.id == "ǰ��" || this.id == "����ǰ��"){     //  ǰ�� �Է½� �ѱ���, ����, ����ǰ�� ���� ��ü �Է�
                        $("#�ѱ���").val(ui.item.roll);
                        $("#����").val(ui.item.unit);
                        if(id == "ǰ��"){		//	ǰ�� �Է½� ����ǰ�� �Է�
                            $("#����ǰ��").val(ui.item.value);
                        };
                    };
                    if(this.id == "Į��" || this.id == "����Į��"){		//	Į�� �Է½� ����Į�� �Է�
                        $("#����Į��").val(ui.item.value);
                    };
                    if(this.id == "������"){		//	������ �Է½� �Ƿڼ� ��ȸ
                        SUPPLY_DISP($("#ǰ��").val(), $("#Į��").val(), ui.item.value);
                    };
                    var t_this = this;		//	setTimeout���� this �� ����ϸ� this���� ���ϱ� ������ ������ this�� t_this�� ���
                    setTimeout(function(){		//	setTimeout�� ���� ������ ���� ������ ���� ������� �������� ����
                        move_next(t_this);		//	���� �Է� �׸����� �̵� ����
                    }, 100);
                },
                focus : function(event, ui){    //  focus �� �̺�Ʈ    �ѱ۰� ���� �������� ������� ���װ� �ִ� ? �����޽��� �����Ѵٰ���
                    return false;
                },
                change : function(event, ui){    //  change �� �̺�Ʈ
                    if(id == "ǰ��" || id == "����ǰ��"){       //  ǰ��, ����ǰ�� �Է½� �Է°� Ȯ��
                        if(autocom_valid("ǰ��", $(this).val(), "") == "0"){
                            dontFocus = 1;      // �ڵ��ϼ� ȭ��ǥ Ʈ���Ÿ� �۵��ϵ��� �۾�
                            $(this).val("");
                            $(this).focus();
                            if(id == "ǰ��"){
                                $("#����ǰ��").val("");
                            };
                            return false;
                        };
                    };
                    if(id == "Į��" || id == "����Į��"){		//	Į��, ����Į�� �Է½� �Է°� Ȯ��
                        item = id == "Į��" ? "ǰ��" : "����ǰ��";
                        if(autocom_valid("Į��", $(this).val(), $("#" + item).val()) == "0"){
                            dontFocus = 1;      // �ڵ��ϼ� ȭ��ǥ Ʈ���Ÿ� �۵��ϵ��� �۾�
                            $(this).val("");
                            $(this).focus();
                            if(id == "Į��"){
                                $("#����Į��").val("");
                            };
                            return false;
                        };
                    };
                    if(this.id == "������" || this.id == "���Ի�����"){		//	������, ���Ի����� �Է½� �Է°� Ȯ��
                        item = id == "������" ? "ǰ��" : "����ǰ��";
                        var t_this = this;
                        setTimeout(function(){
                            if(autocom_valid("������", $(t_this).val(), $("#" + item).val()) == "0"){
                                if($(t_this).val() != ""){
                                    if($(t_this).val().includes("����")){
                                        // ������ ���Ե� ��� �����尡 ��ġ���� �ʾƵ� �Ѿ���� ��Ż�� ó���� ������� ?
                                        // ���� SP���� ��Ż�� �� Ȯ�� ���� ���Ի����� ��˻� �Ͽ� ��ġ�ϴ��� Ȯ�� ���� �ۼ���
                                    }else{
                                        dontFocus = 1;      // �ڵ��ϼ� ȭ��ǥ Ʈ���Ÿ� �۵��ϵ��� �۾�
                                        alert("�Է°��� �ùٸ��� �ʽ��ϴ�.");
                                        $(t_this).val("");
                                        $(t_this).focus();
                                        return false;
                                    };
                                };
                            };
                        }, 200);
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
                // if(this.id == "���ó" || this.id == "��ܱ�"){
                //     $(this).autocomplete("search", "");    //  focus�� �ٷ� �˻�â�� ON   Ʈ���ŷ� �Ʒ�����Ű �����°� �߰� ���� ������ autoFocus �� ���װɷ��� ��Ŀ�� �����
                // }else{
                //     $(this).autocomplete("search", $(this).val());    //  focus�� �ٷ� �˻�â�� ON   Ʈ���ŷ� �Ʒ�����Ű �����°� �߰� ���� ������ autoFocus �� ���װɷ��� ��Ŀ�� �����
                // };
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
    // �����Ƿڼ� ��ȸ
    // ------------------------------------------------------------------------
    function SUPPLY_DISP(item, color, size, sortName, sortOrder){
        try{
            if(color == "" || size == ""){
                return false;
            };
            sortName = sortName == null ? "" : sortName == undefined ? "" : sortName;		//	sortName�� �Է°� �ִ��� Ȯ��
            sortOrder = sortOrder == null ? "" : sortOrder == undefined ? "" : sortOrder;		//	sortOrder�� �Է°� �ִ��� Ȯ��
            var rst = Get_Json("B_WORK_SUPPLY_LST 1, '" + item + "', '" + color + "', '" + size + "', '" + $("#��ȸ���ں���").val() + "', '" + $("#��ȸ���ڱ���").val() + "', '"
                                                        + ($("#���ó��").val() == "��ܶ���" ? 1 : 2) + "', '"
                                                        + sortName + "', '" + sortOrder + "'");
            console.log("B_WORK_SUPPLY_LST 1, '" + item + "', '" + color + "', '" + size + "', '" + $("#��ȸ���ں���").val() + "', '" + $("#��ȸ���ڱ���").val() + "', '"
                                                        + ($("#���ó��").val() == "��ܶ���" ? 1 : 2) + "', '"
                                                        + sortName + "', '" + sortOrder + "'");
            var appendHTML = "";
            if(rst[0].����Ƿ��� == "" || rst[0].����Ƿ��� == " " || rst[0].����Ƿ��� == null){       //  ��ȸ ������ ���� ���
                appendHTML += "<tr><td>��ȸ ������ �����ϴ�</td></tr>";
            }else{
                if(rst.length > 10){
                    for(i = 0; i < rst.length; i++){
                        appendHTML += '<tr><td style="width: 9%;">' + rst[i].�����Ƿ��� + '</td><td style="width: 9%;">' + rst[i].����Ƿ��� + '</td><td style="width: 11%;">' + rst[i].�����Ƿڹ�ȣ
                            + '</td><td style="width: 19%;">' + rst[i].�ŷ�ó�� + '</td><td style="width: 13%;">' + rst[i].ǰ�� + '</td><td style="width: 15%;">' + rst[i].���޼���
                            + '</td><td style="width: 10%;">' + rst[i].��ܼ��� + '</td><td style="width: 8%;" class="number">' + rst[i].�ܿ�����
                            + '</td><td class="select" style="width: 5.1%;"></td><td style="display:none">' + rst[i].OUTID + '</td></tr>';
                    };
                }else{
                    for(i = 0; i < rst.length; i++){
                        appendHTML += '<tr><td style="width: 9%;">' + rst[i].�����Ƿ��� + '</td><td style="width: 9%;">' + rst[i].����Ƿ��� + '</td><td style="width: 11%;">' + rst[i].�����Ƿڹ�ȣ
                            + '</td><td style="width: 19%;">' + rst[i].�ŷ�ó�� + '</td><td style="width: 13%;">' + rst[i].ǰ�� + '</td><td style="width: 15%;">' + rst[i].���޼���
                            + '</td><td style="width: 10%;">' + rst[i].��ܼ��� + '</td><td style="width: 8%;" class="number">' + rst[i].�ܿ�����
                            + '</td><td class="select" style="width: 6%;"></td><td style="display:none">' + rst[i].OUTID + '</td></tr>';
                    };
                };
            };
            $("#forList_body").empty();
            $("#forList_body").append(appendHTML);
        }catch(err){
            alert(err.message);
        };
    };      //  �����Ƿڼ� ��ȸ end

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
    // �ҷ���Ʈ ����        onfocus �� �۵�		���� �ݱ� �۵� ������ �޶� �ϳ��� ��ġ�� ���峲
    // ------------------------------------------------------------------------
    function openLine(num){
        $(".tr_hide_0" + num).css("display", "table-row");
    };      //  �ҷ���Ʈ ���� end

    // ------------------------------------------------------------------------
    // �ҷ���Ʈ �ݱ�        onclick �� �۵�
    // ------------------------------------------------------------------------
    function closeLine(num){
        $(".tr_hide_0" + num).css("display", "none");
    };      //  �ҷ���Ʈ �ݱ� end

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
    function checkEven(num){        //  Ȧ���� ������ 0(false) ¦���� ������ 1(true)
        return (num % 2 == 0);
    };      //  Ȧ¦ �����ϱ� end

</script>


</head>

<body>
  
    <div class="TopBtn">
        <div id="title_bar">
            <img id="title_bar_img" src ="../image/title/title2.png">
            <p id="t_header">����۾�����</p>
        </div>

        <table class="searchDate">
            <tr>
                <th class="th_01">
                    <label id="search_title" class="label_tag">�����Ƿ���</label>
                </th>
                <td class="td_01">
                    <input type="text" id="��ȸ���ں���" class="input_tag input_tag_date datepicker" max="9999-12-31" min="1970-01-01" autocomplete="off">
                </td>
                <td class="td_01 td_search_01">
                    <label class="label_tag">����</label>
                </td>
                <td class="td_01">
                    <input type="text" id="��ȸ���ڱ���" class="input_tag input_tag_date datepicker" max="9999-12-31" min="1970-01-01" autocomplete="off">
                </td>
                <td class="td_01 td_search_01">
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
                        <input type="text" id="�߻�����" class="input_tag input_tag_date input-field datepicker input_tag_readonly_01"  tabindex="-1" readonly autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">���ó��</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="���ó��" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">��ܱ�</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="��ܱ�" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">�����</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�����" class="input_tag input_tag_readonly_01 input_tag_end_01 input-field" tabindex="-1" readonly>
                    </td>
                </tr>
            </table>
        </div>

        <div class="item_insert">
            <table class="item">
                <tr>
                    <th class="th_01">
                        <label class="label_tag">���ǰ��</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="ǰ��" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">���Į��</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="Į��" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">��ܻ�����</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="������" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">�۾���������</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�۾�����" class="input_tag input_tag_end_01 input-number" autocomplete="off">
                    </td>
                </tr>
            </table>
        </div>

        <div class="machine_insert">
            <table class="machine">
                <tr>
                    <th class="th_01">
                        <label class="label_tag">����ǰ��</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="����ǰ��" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">����Į��</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="����Į��" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">���Ի�����</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="���Ի�����" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">���Լ���</label>
                    </th>
                    <td class="td_01 td_insertCount_01">
                        <input type="text" id="���ԷѼ���" class="input_tag input_tag_insertCount_01 input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_insertCount_02" colspan="2;">
                        <input type="text" id="���Լ���" class="input_tag input_tag_insertCount_02 input_tag_readonly_01 input-number" tabindex="-1" readonly autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">�ʸ� LOT</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�ʸ�LOT" class="input_tag input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">���� LOT</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="����LOT" class="input_tag input-field input-auto" autocomplete="off">
                    </td>


                    <th class="th_01">
                        <label class="label_tag">��� LOT</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="���LOT" class="input_tag input-field" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">�ѱ���</label>
                    </th>
                    <td class="td_01 td_length_01" colspan="2;">
                        <input type="text" id="�ѱ���" class="input_tag input_tag_length_01 auto_sum input-number" autocomplete="off">
                    </td>
                    <td class="td_01 td_length_02">
                        <input type="text" id="����" class="input_tag input_tag_length_02 input_tag_end_02 input-field" autocomplete="off">
                    </td>
                </tr>
            </table>
        </div>

        <div class="ingredient_insert">
            <table class="ingredient">
                <tr>
                    <th class="th_01">
                        <label class="label_tag">�ҷ�����</label>
                    </th>
                    <td class="td_01 td_length_01">
                        <input type="text" id="�ҷ�����1" class="input_tag input_tag_length_01 input-field input-auto" onfocus="openLine(1);" autocomplete="off">
                    </td>
                    <td class="td_01 td_length_02">
                        <input type="text" id="�Ѽ���1" class="input_tag input_tag_length_02 auto_sum input-number" onfocus="openLine(1);" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">�ҷ�����</label>
                    </th>
                    <td class="td_01 td_length_01">
                        <input type="text" id="�ҷ�����2" class="input_tag input_tag_length_01 input-field input-auto" onfocus="openLine(1);" autocomplete="off">
                    </td>
                    <td class="td_01 td_length_02">
                        <input type="text" id="�Ѽ���2" class="input_tag input_tag_length_02 auto_sum input-number" onfocus="openLine(1);" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">�ҷ�����</label>
                    </th>
                    <td class="td_01 td_length_01">
                        <input type="text" id="�ҷ�����3" class="input_tag input_tag_length_01 input-field input-auto" onfocus="openLine(1);" autocomplete="off">
                    </td>
                    <td class="td_01 td_length_02">
                        <input type="text" id="�Ѽ���3" class="input_tag input_tag_length_02 auto_sum input-number" onfocus="openLine(1);" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">�������</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�������" class="input_tag input_tag_end_01 input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                </tr>

                <tr class="tr_hide tr_hide_01">
                    <th class="th_01">
                        <label class="label_tag">�ҷ� LOT</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�ҷ���Ʈ1" class="input_tag input-field" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">�ҷ� LOT</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�ҷ���Ʈ2" class="input_tag input-field" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">�ҷ� LOT</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�ҷ���Ʈ3" class="input_tag input-field" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <button class="btn_01 btn_td_01" onclick="closeLine(1);">�ݱ�</button>
                    </th>
                    <td class="td_01">
                        <span> </span>
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">�ҷ�����</label>
                    </th>
                    <td class="td_01 td_length_01">
                        <input type="text" id="�ҷ�����4" class="input_tag input_tag_length_01 input-field input-auto" onfocus="openLine(2);" autocomplete="off">
                    </td>
                    <td class="td_01 td_length_02">
                        <input type="text" id="�Ѽ���4" class="input_tag input_tag_length_02 auto_sum input-number" onfocus="openLine(2);" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">�ҷ�����</label>
                    </th>
                    <td class="td_01 td_length_01">
                        <input type="text" id="�ҷ�����5" class="input_tag input_tag_length_01 input-field input-auto" onfocus="openLine(2);" autocomplete="off">
                    </td>
                    <td class="td_01 td_length_02">
                        <input type="text" id="�Ѽ���5" class="input_tag input_tag_length_02 auto_sum input-number" onfocus="openLine(2);" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">�ҷ�����</label>
                    </th>
                    <td class="td_01 td_length_01">
                        <input type="text" id="�ҷ�����6" class="input_tag input_tag_length_01 input-field input-auto" onfocus="openLine(2);" autocomplete="off">
                    </td>
                    <td class="td_01 td_length_02">
                        <input type="text" id="�Ѽ���6" class="input_tag input_tag_length_02 auto_sum input-number" onfocus="openLine(2);" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">�ҷ�����</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�ҷ�����" class="input_tag input_tag_end_01 input_tag_readonly_01 input-number" tabindex="-1" readonly>
                    </td>
                </tr>

                <tr class="tr_hide tr_hide_02">
                    <th class="th_01">
                        <label class="label_tag">�ҷ� LOT</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�ҷ���Ʈ4" class="input_tag input-field" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">�ҷ� LOT</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�ҷ���Ʈ5" class="input_tag input-field" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">�ҷ� LOT</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�ҷ���Ʈ6" class="input_tag input-field" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <button class="btn_01 btn_td_01" onclick="closeLine(2);">�ݱ�</button>
                    </th>
                    <td class="td_01">
                        <span> </span>
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">�ҷ�����</label>
                    </th>
                    <td class="td_01 td_length_01">
                        <input type="text" id="�ҷ�����7" class="input_tag input_tag_length_01 input-field input-auto" onfocus="openLine(3);" autocomplete="off">
                    </td>
                    <td class="td_01 td_length_02">
                        <input type="text" id="�Ѽ���7" class="input_tag input_tag_length_02 auto_sum input-number" onfocus="openLine(3);" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">�ҷ�����</label>
                    </th>
                    <td class="td_01 td_length_01">
                        <input type="text" id="�ҷ�����8" class="input_tag input_tag_length_01 input-field input-auto" onfocus="openLine(3);" autocomplete="off">
                    </td>
                    <td class="td_01 td_length_02">
                        <input type="text" id="�Ѽ���8" class="input_tag input_tag_length_02 auto_sum input-number" onfocus="openLine(3);" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">���ܻ�����</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���ܻ�����" class="input_tag input-field input-auto" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">�ĵ�</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�ĵ�" class="input_tag input_tag_end_01 input-number" autocomplete="off">
                    </td>
                </tr>

                <tr class="tr_hide tr_hide_03">
                    <th class="th_01">
                        <label class="label_tag">�ҷ� LOT</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�ҷ���Ʈ7" class="input_tag input-field" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">�ҷ� LOT</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�ҷ���Ʈ8" class="input_tag input-field" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <button class="btn_01 btn_td_01" onclick="closeLine(3);">�ݱ�</button>
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
                        <label class="label_tag">�۾�����</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�۾�����" class="input_tag input-field input-auto" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">���</label>
                    </th>
                    <td class="td_01" colspan="7;">
                        <input type="text" id="���" class="input_tag input_remark_01 input-field" autocomplete="off">
                    </td>
                </tr>
            </table>
        </div>

        <div class="div_forList">
            <table id="table_forList" class="table_forList">
                <thead id="forList_header" class="forList_header">
                    <tr id="supply_header">
                        <th class="th_01" style="width: 9%">
                            �����Ƿ���<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_01" style="width: 9%">
                            ����Ƿ���<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_01" style="width: 11%">
                            �����Ƿڹ�ȣ<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_01" style="width: 19%">
                            �ŷ�ó��<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_01" style="width: 13%">
                            ǰ��<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_01" style="width: 15%">
                            ���޼���<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_01" style="width: 10%">
                            ��ܼ���<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_01" style="width: 8%">
                            �ܿ�����<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                        <th class="th_01" style="width: 6%">
                            ����<span class="ui-icon ui-icon-triangle-1-n">
                        </th>
                    </tr>
                </thead>

                <tbody id="forList_body" class="forList_body">
                </tbody>
            </table>
        </div>
    </div>

          
<!-- hidden -->
<input type="hidden" id="â���" class="input-field">
<input type="hidden" id="�۾����۽ð�" class="input-field">
<input type="hidden" id="�۾�����ð�" class="input-field">
<input type="hidden" id="�۾��ð�" class="input-field">
<input type="hidden" id="OutID" class="input-field">

<input type="hidden" id="IP_Address" class="input-field">
<input type="hidden" id="WorkID" value="">
<input type="hidden" id="Item" value="">
<input type="hidden" id="color" value="">
<input type="hidden" id="size" value="">
<input type="hidden" id="sizeOpt" value="">
<input type="hidden" id="OLD���Լ���" value="0">
<input type="hidden" id="OLD�۾�����" value="0">
<input type="hidden" id="sizeAdd" value="0">
<input type="hidden" id="workid_ori" value="0">

</body>
</HTML>