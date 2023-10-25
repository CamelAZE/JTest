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
' WorkDiary_AP.asp  KYJ

Dim junID , P_Lot_NO
junID = request("junID")
P_Lot_NO = request("P_Lot_NO")

%>

<head>
<meta charset="utf-8">
<title>�۾��������(����)</title>
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

    /* �� ���� ������ / ������ css �۾� */
    .TopBtn{ height: 100px; margin: 0px 0px 5px 0px; padding: 10px 0px 0px 0px; background-color: #dff0ed;  }
    .bottom{ width: 100%;  }

    .date_insert{ width: 100%; height: 80px; max-height: 95px; margin: 0px 0px 5px 0px;  }
    .date{ border-collapse: collapse; width: 100%; background-color: #FCEED6;  }
    .date label{ display: block; border: 1px solid #f0bd5e; background-color: #FCEED6;  }
    .date input{ border: 1px solid #f0bd5e; text-align: center;  }

    .item_insert{ width: 100%; height: 120px; max-height: 120px; margin: 0px 0px 5px 0px;  }
    .item{ border-collapse: collapse; width: 100%; background-color: #F8DCB3;  }
    .item label{ display: block; border: 1px solid #eea236; background-color: #F8DCB3;  }
    .item input{ border: 1px solid #eea236;  }

    .machine_insert{ width: 100%; height: 240px; max-height: 250px; margin: 0px 0px 5px 0px;  }
    .machine{ border-collapse: collapse; width: 100%; background-color: #BEDFDB;  }
    .machine label{ display: block; border: 1px solid #5e93c2; background-color: #BEDFDB;  }
    .machine input{ border: 1px solid #5e93c2; text-align: center;  }

    .ingredient_insert{ width: 100%; height: 300px; max-height: 300px; margin: 0px 0px 0px 0px;  }
    .ingredient{ border-collapse: collapse; width: 100%; background-color: #D9E8F8;  }
    .ingredient label{ display: block; border: 1px solid #5D8F89; background-color: #D9E8F8;  }
    .ingredient input{ border: 1px solid #5D8F89;  }
    .ingredient textarea{ border: 1px solid #5D8F89; background-color: #ffffff;  }
    .ingredient_kind{ border-collapse: collapse; width: 100%; background-color: #D9E8F8;  }
    .ingredient_kind label{ display: block; border: 1px solid #5D8F89; background-color: #D9E8F8;  }
    .ingredient_kind input{ border: 1px solid #5D8F89;  }

    .remark{ border-collapse: collapse; width: 100%; background-color: #E0F0FF;  }
    .remark label{ display: block; border: 1px solid #ACCEF2; background-color: #E0F0FF; width: 97%;  }
    .remark textarea{ border: 1px solid #ACCEF2;  }

    /* title */
    #title_bar{ float: left; width:22%; height:60px; margin: 5px 31.5% 0px 2%; vertical-align: auto; position: relative; background-size: 100%, 42px; background-position: center; background-repeat: no-repeat;  }
    #title_bar_img{ width: 100%; height: 100%;  }
    #t_header{ width: 100%; font-size: 18pt; font-weight: bold; font-family: Noto Sans KR; margin: 0px; color:white; text-align:center; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); letter-spacing: 2.5px;  }

    /* th �±� */
    .th_01{ box-sizing: border-box; width: 5%; height: 40px; font-size: 13pt; border-spacing: 0px;  }
    .th_press_01{ width: 6%;  }
    .th_press_02{ width: 3%;  }
    .th_cut_01{ width: 5%;  }

    /* td �±� */
    .td_01{ box-sizing: border-box; width: 15%; height: 40px; font-size: 13pt; border-spacing: 0px;  }
    .td_temp_01{ width: 7.5%;  }
    .td_prod_01{ width: 10%;  }
    .td_prod_02{ width: 5%;  }
    .td_machine_01{ width: 7.5%;  }
    .td_press_01{ width: 6%;  }
    .td_cut_01{ width: 8%;  }
    .td_Sremark_01{ width: 8%;  }
    .td_Lremark_01{ width: 73%; height: 80px;  }

    /* label */
    label{ border-radius: 3px; color: #000; height: 34px; max-height: 34px; line-height: 34px; text-align: center; vertical-align: middle; font-weight: bold; white-space: nowrap; margin: 0px;  }
    .label_tag_ingredient_01{ width: 100%; margin-top: 3px;  }
    .label_tag_remark{ width: 100%; margin-top: 3px;  }
    .label_tag_2row{ height: 74px; max-height: 74px; line-height: 74px;  }
    .label_press{ width: 94%;  }

    /* input �±� */
    input{ border-radius: 3px; background-color: #ffffff;  }
    input:focus{ border: 2px solid #f00; outline: none; }
    input:disabled{ color: #999;  }
    .input_tag{ width: 95%; height: 34px; max-height: 34px; line-height: 34px; vertical-align: middle; font-size: 13pt; border: 0; margin: 0px 1% 0px 2%;  }
    .input_tag_date{ width: 95%; height: 34px; max-height: 34px; margin: 0px 1% 0px 2%; text-align: center;  }
    .input-number{ text-align: center;  }
    .input_tag_temp_01{ width: 74%; margin: 0px 5% 0px 4%;  }
    .input_tag_prod_01{ width: 95%; margin: 0px 0px 0px 3%;  }
    .input_tag_prod_02{ width: 88%; margin: 0px 0px 0px 3%;  }
    .input_tag_machine_01{ width: 70%; margin: 0px 0px 0px 4%;  }
    .input_tag_machine_02{ width: 65%; margin: 0px 0px 0px 4%;  }
    .input_tag_press_01{ width: 87%; margin: 0px 1% 0px 4%;  }
    .input_tag_press_02{ width: 100%; margin: 0px 1% 0px 0px;  }
    .input_tag_cut_01{ width: 90%; margin: 0px 1% 0px 3%;  }
    .input_tag_ingredient_01{ width: 100%; height: 38px; max-height: 38px; margin: 0px 1% 0px 0px;  }
    .input_tag_ingredient_02{ width: 100%; height: 38px; max-height: 38px; margin: 0px 1% 0px 0px;  }
    .input_tag_Sremark_01{ width: 98.6%; margin: 0px 0% 0px 0.55%;  }
    .input_tag_readonly_01{ background-color: #eee; pointer-events: none;  }
    .input_tag_end_01{ width: 98%;  }
    .input_tag_end_02{ width: 96.5%;  }
    .input_tag_end_03{ width: 97%;  }

    /* textarea */
    .input_tag_Lremark_01{ width: 100%; height: 74px; max-height: 74px; line-height: 20px; font-size: 13pt; border-radius: 3px; margin: 0px 0.1% 0px 0px; padding: 0px; resize: none;  }
    textarea:focus{ border: 3px solid #f00; outline: none;  }
    textarea:disabled{ color: #ccc; background-color: #fff;  }

    /* span */
    span{ line-height: 34px; text-align: center; vertical-align: middle;  }

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

    //  URL���� �����ȣ, IP�ּ� �޾ƿ���
    var seSawonid = new URLSearchParams(window.location.search).get("seSawonid");
    var IP_Address = new URLSearchParams(window.location.search).get("IP_Address");

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
            // var WorkID = WorkID;
            $("#IP_Address").val(IP_Address);
            G_LotID = ""
            //    prk�� �۾� H_����������ǥ ���̺��� ����������ǥID   grid ���� �����ؼ� �������°�
            var prk = "<%=junID%>";

            if(seSawonid == ""){        //  �θ� â���� ���� ���������� Ȯ��
                alert("�α��� ���¸� �ٽ� Ȯ���� �ּ���.");
                self.close();
            }else if(prk != ""){        //  prk = grid ���� ������ ��ȣ �Ϸ�� �۾� �ҷ��������� Ȯ��
                //  �����ͺҷ�����
                init_disp(prk);     //  ��ȣ ���� ����

                //  ���� �۾�����, ������
                $("#OLD�۾�����").val($("#�۾�����").val());
                $("#�۾����").attr("disabled", true);
                $("#�۾�����").attr("disabled", true);
                $("#�۾�����").css("display","inline");     //  ���� �Ҽ��ֵ��� �۾�������ư ���̰�
                $("#�۾�����").attr("disabled", true);
                $("#�����Ʈ��ȣ").val("<%=P_Lot_NO%>");

            }else if(prk == ""){        //  �Ϸ���� ���� �۾��϶�
                //  ���� �۾�����, ������
                $("#�۾�����").css("display","none");
                $(".btn_01_2").css("margin", "30px 5.8% 10px 0px");
                $("#�۾�����").val(getDay());
                $("#�۾�����").attr("min", getDay());       //  �޷¿��� ���� ���� ���� �Ұ����ϵ���
                $("#�۾�����").attr("max", getDay());       //  �޷¿��� ���� ���� ���� �Ұ����ϵ���
                $("#�۾���").val(seSawonname);
                $("#â���").val("����â��");

                // ------------------------------------------------------------------------
                // autocomplete ǰ�� �˻� �۾��Ϸ� ������ �ҷ��ö� �ε������� �ΰ����� ������ ���Ǻ� ����
                // ------------------------------------------------------------------------
                // var item_json = Get_Json("EXEC AA_WORKDIARY_Search '', 'ǰ��', ''");
                // item_sql = item_json;

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
                        var delSawonName = $("#�۾���").val();
                        var delGubun = "1";         //  1 : ����, 2 : ����, 3 : ����, 4 : �д�, 5 : ���
                        var delWorkId = $("#WorkID").val();
                        var rst = Get_Json("EXEC RF_PROD_PDA_RF����_ERP_CLEAR '" + delSawonName   + "', '" + delGubun + "', '" + delWorkId + "'");
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

                // ------------------------------------------------------------------------
                // autocomplete ǰ�� �˻� �۾��Ϸ� ������ �ҷ��ö� �ε������� �ΰ����� ������ ���Ǻ� ����
                // ------------------------------------------------------------------------
                // var item_json = Get_Json("EXEC AA_WORKDIARY_Search '', 'ǰ��', ''");
                // item_sql = item_json;

            });   //  �۾����� ��ư end

            // ------------------------------------------------------------------------
            // input�� Ű �Է½� �̺�Ʈ ����(move_next)
            // ------------------------------------------------------------------------
            $("input").on("keydown", function(e){
                var key = e.charCode ? e.charCode : e.keyCode ? e.keyCode : 0;
                if(key == 13){      //  ���� Ű�ڵ尪 13
                    if($(this).hasClass("input-auto") == true){     //  autocomplete �۵��ϴ°����� ���۵��ϵ���
                        e.preventDefault();
                    }else{
                        move_next(this);
                    };
                };
            });   //  Ű �Է½� �̺�Ʈ end

            // ------------------------------------------------------------------------
            // autocomplete ǰ�� �˻� ������ �ε�� �ٷν���
            // ------------------------------------------------------------------------
            item_sql = "" // ������ ���ڵ�� ��������
            var item_json = Get_Json_common_direct("EXEC [AA_WORKDIARY_Search2] '', 'ǰ��', ''");
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
                    keyCode : 40         //  �Ʒ�����Ű Ű�ڵ� 40   �ڿ� �����ݷ� ���̸� ������
                });
                var t_this = this;		//	setTimeout���� this �� ����ϸ� this���� ���ϱ� ������ ������ this�� t_this�� ���
                setTimeout(function(){      //  �ٷ� ����� autoFocus ���׷� ���� ��Ŀ�� ����� setTimeout ������ ���� �����
                    $(t_this).trigger(e);
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
            // class input-number �׸� ���ڸ� �Է��ϵ��� ����
            // ------------------------------------------------------------------------
            $(".input-number").on("blur keyup", function(){
                // var regex = /[^0-9]/gi;    //  ���ڻ��� �Է� �ȵ� .���ȵ�
                var regex = /[��-��|��-��|��-�R|aA-zZ]/gi;     //  �ѱ� ��� ����
                $(this).val($(this).val().replace(regex, ""));      //  �� ���� regex�� ""�� �ٲ������
            });   //  ���ڸ� �Է� end

            // ------------------------------------------------------------------------
            // ������� �ڵ����
            // ------------------------------------------------------------------------
            $('.auto_sum').on("keyup", function(){
                var pro_count = 0;		//	�ڵ� ����� �� ���� ���� ����
                for(i = 1; i < 8; i++){     //  1~ 7���� �ݺ�
                    if($("#����ѱ���" + i).val() + "" != "" && $("#����Ѽ���" + i).val() + "" != ""){		//	�Է°� ���� Ȯ�� �Է°��� ������ ��� ����
                        pro_count = pro_count + parseInt($("#����ѱ���" + i).val()) * parseInt($("#����Ѽ���" + i).val());
                    };
                };
                $("#�������").val(pro_count);		//	���� �� ��������� ����
            });   //  ������� �ڵ���� end

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
    });   // document.ready end
    // ------------------------------------------------------------------------
    // ������ �˻����� �������� ����
    // ------------------------------------------------------------------------
    function Get_Json_After(temp_rst){
        //console.log("Get_Json_After")
        item_json = temp_rst
        //console.log(item_json)
        item_sql = item_json;
    }
    // ------------------------------------------------------------------------
    // ��Ʈ��ȣ �˻����� �������� ����
    // ------------------------------------------------------------------------
    function Get_Json_After2(temp_rst){
        var t_find_data_array = new Array();
        if(temp_rst.length <= 1 &&  !temp_rst[0].valueOf()==""){        //  �����Ͱ� ���°�� move_next �ߵ���ŰŰ���� �������� �Ѿ�� ����
            t_find_data_array.push("��ȸ ������ �����ϴ�. �������� �Ѿ��");
        }else {
            for(var i in temp_rst){
                t_find_data_array.push(temp_rst[i]["FieldName"]);
            };
        }
        $("#"+ G_LotID).css("background-color", "#ffffff")
        autocomplete_dbc(t_find_data_array, G_LotID);
        // ��Ʈ��ȣ�� ��� �߰��� return �ؼ� ���� ����Ǳ� ������ Ʈ���� ���ۼ�
        var e = $.Event("keydown", {        // autocomplete �Ϸ�� �˻����� Ȯ�� �ǵ��� �Ʒ�����Ű Ʈ���� �����
            keyCode : 40         //  �Ʒ�����Ű Ű�ڵ� 40   �ڿ� �����ݷ� ���̸� ������
        });
        setTimeout(function(){      //  �ٷ� ����� autoFocus ���׷� ���� ��Ŀ�� ����� setTimeout ������ ���� �����
            $("#" + G_LotID).trigger(e);        // �Ʒ� ����Ű Ʈ���� �۵�
        }, 100);
    }
    
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
                $(".input-field, .input-number").each(function(){
                    $(this).attr("disabled", true);      //  �б� �������� �ҷ�����
                    if($(this).attr("type") == "text" || $(this).attr("type") == "date" || $(this).attr("type") == "textarea" || $(this).attr("type") == "hidden"){		// ������ ������ input�׸� �Է�
                        var field = rst[0][this.id] + "";
                        field = ((field == 0 || field == "null") ? "" : field);
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
                $(".input-field, .input-number").each(function(){
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
    // �˻��� �Է� �ڵ��ϼ� sql
    // ------------------------------------------------------------------------
    function data_find(id, item_sql){
        try{
            var item = "";
            var t_sql = "";
            var item = "";
            var color = "";
            var size = "";
            if(id == "��񱸺�"){		//	��񱸺� �� ��� �˻���� E% �� ���� ������ �ٸ� ������������ sp�ȿ��� �������� �ʵ��� Ȱ��
                t_sql = "EXEC AA_WORKDIARY_Search 'E%', '" + id + "', ''";
            }else if(id == "����"){		//	������ ��� ���� sql�� ����
                t_sql = "EXEC AA_WORKDIARY_Search '', '" + id + "', ''";
            }else if(id == "Į��" || id == "�۷�Į��" || id == "����Į��1" || id == "����Į��2" || id == "����Į��3" || id == "����Į��4"){		//	Į��id�� ���� ǰ�� id ����
                item = id == "Į��" ? "ǰ��" : id == "�۷�Į��" ? "�۷�ǰ��" : id == "����Į��1" ? "����ǰ��1" : id == "����Į��2" ? "����ǰ��2" : id == "����Į��3" ? "����ǰ��3" : "����ǰ��4";
                if($("#" + item).val() == ""){
                    dontFocus = 1;      // �ڵ��ϼ� ȭ��ǥ Ʈ���Ÿ� �۵��ϵ��� �۾�
                    alert("ǰ���� �Է��� �ּ���.");
                    $("#" + item).focus();
                    return false;
                }else{
                    t_sql = "EXEC AA_WORKDIARY_Search '', 'Į��', '" + $("#" + item).val() + "'";
                };
            }else if(id == "������" || id == "�۷������" || id == "���ܻ�����1" || id == "���ܻ�����2" || id == "���ܻ�����3" || id == "���ܻ�����4"){		//	������id�� ���� ǰ�� id ����
                item = id == "������" ? "ǰ��" : id == "�۷������" ? "�۷�ǰ��" : id == "���ܻ�����1" ? "����ǰ��1" : id == "���ܻ�����2" ? "����ǰ��2" : id == "���ܻ�����3" ? "����ǰ��3" : "����ǰ��4";
                color = id == "������" ? "Į��" : id == "�۷������" ? "�۷�Į��" : id == "���ܻ�����1" ? "����Į��1" : id == "���ܻ�����2" ? "����Į��2" : id == "���ܻ�����3" ? "����Į��3" : "����Į��4";
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
            }else if(id == "�۷��Ʈ��ȣ" || id == "���ܷ�Ʈ��ȣ1" || id == "���ܷ�Ʈ��ȣ2" || id == "���ܷ�Ʈ��ȣ3" || id == "���ܷ�Ʈ��ȣ4"){		//	��Ʈ��ȣ ������ ���� �����ϴ� ǰ��, Į��, ������ ����
                item = id == "�۷��Ʈ��ȣ" ? "�۷�ǰ��" : id == "���ܷ�Ʈ��ȣ1" ? "����ǰ��1" : id == "���ܷ�Ʈ��ȣ2" ? "����ǰ��2" : id == "���ܷ�Ʈ��ȣ3" ? "����ǰ��3" : "����ǰ��4";
                color = id == "�۷��Ʈ��ȣ" ? "�۷�Į��" : id == "���ܷ�Ʈ��ȣ1" ? "����Į��1" : id == "���ܷ�Ʈ��ȣ2" ? "����Į��2" : id == "���ܷ�Ʈ��ȣ3" ? "����Į��3" : "����Į��4";
                size = id == "�۷��Ʈ��ȣ" ? "�۷������" : id == "���ܷ�Ʈ��ȣ1" ? "���ܻ�����1" : id == "���ܷ�Ʈ��ȣ2" ? "���ܻ�����2" : id == "���ܷ�Ʈ��ȣ3" ? "���ܻ�����3" : "���ܻ�����4";
                if($("#" + item).val() == "" || $("#" + color).val() == "" || $("#" + size).val() == ""){
                    dontFocus = 1;      // �ڵ��ϼ� ȭ��ǥ Ʈ���Ÿ� �۵��ϵ��� �۾�
                    alert("��Ʈ��ȣ�� Ȯ���ϱ� ����\n������ �Ǵ� ����ǰ �Է� ������ ��Ȯ�� ���ּ���.");
                    var focus = $("#" + item).val() == "" ? item : $("#" + color).val() == "" ? color : size;
                    $("#" + focus).focus();
                    return false;
                }else{
                    t_sql = "EXEC [AA_WORKDIARY_LOTNO] '', '" + $("#�۾���").val() + "', '" + $("#" + item).val() + "', '" + $("#" + color).val() + "', '" + $("#" + size).val() + "', '����â��'";
                };
            };
            var find_rst = "";		//	�����ų sql�� ���� ���� ����
            var find_data_array = new Array();		//	sql�� ���� ��ȯ ���� ������ Array ����
            if(id == "ǰ��" || id == "�۷�ǰ��" || id == "����ǰ��1" || id == "����ǰ��2" || id == "����ǰ��3" || id == "����ǰ��4"){
                find_rst = item_sql;		//	ǰ���� ��� ������ �ε�� �ٷ� sql �����Ͽ� ��Ƶξ� �Լ� ���� ������ �޾ƿ°� ���
            }else if(id == "�۷��Ʈ��ȣ" || id == "���ܷ�Ʈ��ȣ1" || id == "���ܷ�Ʈ��ȣ2" || id == "���ܷ�Ʈ��ȣ3" || id == "���ܷ�Ʈ��ȣ4"){
                //Get_Json_Before() // ���α׷����� ����
                $("#"+ id).css("background-color", "#eee")
                Get_Json_common_direct2(t_sql)
                G_LotID = id
                // ��������Ϸ��� Get_Json_After2 �����
                return;
            }else{		//	�� ���� ��� sql�� Get_Json()���� ����
                find_rst = Get_Json(t_sql);
            };
            find_data_array[id] = find_rst;
            if(id == "�۷��Ʈ��ȣ" || id == "���ܷ�Ʈ��ȣ1" || id == "���ܷ�Ʈ��ȣ2" || id == "���ܷ�Ʈ��ȣ3" || id == "���ܷ�Ʈ��ȣ4"){
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
        };
    };    //  data_find end

    // ------------------------------------------------------------------------
    // �ڵ��ϼ� ��ü ����
    // ------------------------------------------------------------------------
    function autocomplete_dbc(find_data_array, id){
        try {
            $("#" + id + "").autocomplete({    // autocomplete ����
                source : find_data_array,    //  �ڵ��ϼ��� ���� �ڷ�
                select : function(event, ui){   //  �ڷ� ���ý� �̺�Ʈ      $(this).val()�� �̹� �Էµ� ���� �ۼ��Ͽ� �۵��ϰԵ� �����ϱ� ���� ���� ���޵� / ui.item.value�� �ۼ��� ������ ������ �Ķ��Ÿ ����
                    $("#" + id + "").val(ui.item.value);
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
                    if(this.id.includes("ǰ��") == true){       //  ǰ�� Į�� ������ ���� �Է½� �Է³��� Ȯ��        select ���� �۵��� ������ �������� �۵��ϱ� ������ �ۼ����� Ȯ�� ���� change �۵�
                        if(autocom_valid("ǰ��", $(this).val(), "") == "0"){
                            dontFocus = 1;      // �ڵ��ϼ� ȭ��ǥ Ʈ���Ÿ� �۵��ϵ��� �۾�
                            $(this).val("");
                            $(this).focus();
                            return false;
                        };
                    };
                    if(this.id.includes("Į��") == true){
                        item = id == "Į��" ? "ǰ��" : id == "�۷�Į��" ? "�۷�ǰ��" : id == "����Į��1" ? "����ǰ��1" : id == "����Į��2" ? "����ǰ��2" : id == "����Į��3" ? "����ǰ��3" : "����ǰ��4";
                        if(autocom_valid("Į��", $(this).val(), $("#" + item).val()) == "0"){
                            dontFocus = 1;      // �ڵ��ϼ� ȭ��ǥ Ʈ���Ÿ� �۵��ϵ��� �۾�
                            $(this).val("");
                            $(this).focus();
                            return false;
                        };
                    };
                    if(this.id.includes("������") == true){
                        item = id == "������" ? "ǰ��" : id == "�۷������" ? "�۷�ǰ��" : id == "���ܻ�����1" ? "����ǰ��1" : id == "���ܻ�����2" ? "����ǰ��2" : id == "���ܻ�����3" ? "����ǰ��3" : "����ǰ��4";
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
                // maxShowItems : 5,    // �ִ� �����ִ� ������ ��
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
            $("#ǰ��").focus();
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
    };    //  move_next end

    // ------------------------------------------------------------------------
    // �ʼ� �Է� ��� Ȯ��    0 ���� kind ������ �տ���(�۾�����) 1 �� kind ������ �ڿ�����(�۾�����)   SP���� Ȯ���ϴ°����� �����Ͽ� �̻��
    // ------------------------------------------------------------------------
    function val_check(kind){
        try{
            var className = $(".must_01");
            for(i = 0; i < className.length; i++){
                if(className[i].value == ""){
                    alert($("label[for='" + className[i].id + "']").text() + "��(��) �ʼ� �Է� �׸��Դϴ�.");
                    $("#" + className[i].id + "").focus();
                return false;
                };
            };    //  �۾����۽� (���, ����ǰ��, ����Į��, ���������) �Է¿��� end
            if(kind > 0){
                var className = $(".must_02");
                for(i = 0; i < className.length; i++){
                    if(className[i].value == "" || className[i].value == 0){
                        if(className[i].id == "�������"){
                            alert("���������(��) �ʼ� �Է� �׸��Դϴ�.");
                            $("#����ѱ���1").focus();
                            return false;
                        };
                        alert($("label[for='" + className[i].id + "']").text() + "��(��) �ʼ� �Է� �׸��Դϴ�.");
                        $("#" + className[i].id + "").focus();
                        return false;
                    };
                };    //  �۾������ (�������, ��������, ������Į��, ������������, ����������, ����ǰ��, ����Į��, ���Ի�����, ���Լ���) �Է¿��� end
                inven_check();
            };    //  ����� ����ǰ���� Ȯ�� (kind = 1 �� ���) end
            return true;
        }catch(err){
            alert(err.message);
        };
    };    //  �ʼ��Է� ��� Ȯ�� end

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
            var wareID = 5;   //    5 : ����â��, 7 : ����â��, 6 : ����â��
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
    //  �ֱ��Է��� ��������, ������� �ڵ��Է�
    // ------------------------------------------------------------------------
    function auto_set(item, color, size, count){
        try{
            var rst = Get_Json("[B_WORK_Auto_MAT] 'G_WorkDiary_����','"
                                    + item    + "','"
                                    + color    + "','"
                                    + size   + "'");
            if(rst[0].ǰ�� == item && rst[0].Į�� == color && rst[0].������ == size){
                if(confirm("���� ������ ����ǰ�� �ڵ����� �߰��Ͻðڽ��ϱ� ?") == true){
                    for(i = 0; i < count; i++){		//	.auto-mat�� .machine-set �� ���� ���� �Է� ��Ű�� ���� 2ȸ ����
                        cl = (i == 0 ? '.auto-mat' : '.machine-set');
                        var classArray = $("" + cl + "");
                        for(n = 0; n < $("" + cl + "").length; n++){
                            var classId = classArray[n].id;
                            if(classArray[n].type == "text"){		//	Ÿ���� ��ġ�ϴ°�� �Է°� �ۼ��ϵ��� �߰����� Ÿ���� ������� || ���� �߰�
                                var field = rst[0][classId] + "";
                                field = (field == 0 || field == "null") ? "" : field;
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
    //  ����
    // ------------------------------------------------------------------------
    function save(){
        try{
            var id = seSawonid;
            var WorkID = $("#WorkID").val();
            var t_val = "";
            var save_data = "";
            $('.input-field, .input-number').each(function(){
                if($(this).attr("type") == "text" || $(this).attr("type") == "date" || $(this).attr("type") == "hidden" || $(this).attr("type") == "textarea"){
                    t_val = $(this).val();
                }else if($(this).attr("type") == "checkbox"){       //  ��� �Ǵ� �׸� ��� �� ���� ���
                    t_val = ($(this).is(":checked") == true ? 1 : 0);
                }else if($(this).attr("type") == "select-one"){
                    t_val = ($(this).val() == null ? 0 : $(this).val());
                };
                // if(isNaN(t_val) == false){
                //     save_data += ", " + t_val;
                // }else if(isNaN(t_val) == true){
                //     save_data += ", " + 0;
                // }else{
                //     save_data += ", " + t_val + "'";
                // };
                if(this.id.includes("�µ�") || this.id.includes("HEAD")){       // �����µ�, ���Ŀµ�, HEAD�з�, HEAD���� �Ҽ��� ���� ���ؼ� '' �Ȱ��ΰ� ������
                    if(t_val == "" || t_val == " "){        // �Է°� ���°� �����
                        save_data += ", " + 0;
                    }else{
                        var chk_num = Get_Json("SELECT ISNUMERIC(" + t_val + ") AS TF");        // �������� Ȯ���ϱ�
                        if(chk_num[0].TF == 1){     // �����ΰ��
                            save_data += ", " + t_val;
                        }else{      // �ƴѰ��
                            save_data += ", " + 0;
                        };
                    };
                }else{
                    save_data += ", '" + t_val + "'";
                };
            });
            // var oldGlu_array = $(".oldGlu");   //  ���üũ sp���� ������ ��� �õ� �۷� ���� ������
            // for(i = 0; i < oldGlu_array.length; i++){
            //   t_val = oldGlu_array[i].value;
            //   save_data += ", '" + t_val + "'";
            // };
            console.log("EXEC [AA_WORKDIARY_����] '" + id + "', '" + WorkID + "'" + save_data);
            var insert = Get_Json("EXEC [AA_WORKDIARY_����] '" + id + "', '" + WorkID + "'" + save_data + "");		//	save_data ����� �������� ' ���ԵǾ��־� ' ������ �����߻�
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
    //  auto_set_date ���� ��¥ ���� �µ� ����
    // ------------------------------------------------------------------------
    function auto_set_date(date){
        try{
            var rst = Get_Json("[B_WORK_Auto_date] 1,'" + date + "'");		//	��¥�� �Ķ���ͷ� ����
            if (rst[0].���� != ""){		//	���� �� �����Ͱ� ������� ���� ������ ��������
                $(".set-date").each(function(){
                    if($(this).attr("type") == "text"){
                        var field = rst[0][this.id] + "";
                        field = (field == 0 || field == "null") ? "" : field;
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
        var hours = ("0" + date.getHours()).slice(-2);
        var minutes = ("0" + date.getMinutes()).slice(-2);
        var timeString = hours + ":" + minutes;
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
        console.log(date)
        return day;
    };    //  ���� ��¥ end

</script>


</head>

<body>
  
    <div class="TopBtn">
        <div id="title_bar">
            <img id="title_bar_img" src ="../image/title/title2.png">
            <p id="t_header">�����۾�����</p>
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
                        <label class="label_tag" for="�۾�����">�۾�����</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�۾�����" class="input_tag input_tag_date input-field input_date must_01 datepicker" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">�۾��ð�</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�۾��ð�" class="input_tag input-field" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag" for="��񱸺�">���</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="��񱸺�" class="input_tag input-field input-auto input-auto_a must_01" autocomplete="off">
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
                        <input type="text" id="����" class="input_tag input-field input-auto input-auto_a set-date" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">�µ�</label>
                    </th>
                    <td class="td_01 td_temp_01">
                        <input type="text" id="�����µ�" class="input_tag input_tag_temp_01 input-number set-date" step="0.1" autocomplete="off"><span>&#176;C</span>
                    </td>
                    <td class="td_01 td_temp_01">
                        <input type="text" id="���Ŀµ�" class="input_tag input_tag_temp_01 input-number set-date" step="0.1" autocomplete="off"><span>&#176;C</span>
                    </td>

                    <th class="th_01">
                        <label class="label_tag">����</label>
                    </th>
                    <td class="td_01 td_temp_01">
                        <input type="text" id="��������" class="input_tag input_tag_temp_01 input-number set-date" step="0.1" autocomplete="off"><span>%</span>
                    </td>
                    <td class="td_01 td_temp_01">
                        <input type="text" id="���Ľ���" class="input_tag input_tag_temp_01 input-number set-date" step="0.1" autocomplete="off"><span>%</span>
                    </td>

                    <th class="th_01">
                        <label class="label_tag" for="���">���</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="���" class="input_tag input_tag_end_01 input-field" autocomplete="off">
                    </td>
                </tr>
            </table>
        </div>

        <div class="item_insert">
            <table class="item">
                <tr>
                    <th class="th_01">
                        <label class="label_tag" for="ǰ��">����ǰ��</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="ǰ��" class="input_tag input-field input-auto input-auto_a must_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag" for="Į��">Į��</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="Į��" class="input_tag input-field input-auto input-auto_b must_01" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag" for="������">������</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="������" class="input_tag input-field input-auto input-auto_b must_01" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�����Ʈ��ȣ" class="input_tag input_tag_readonly_01 input_tag_end_01 input-field" tabindex="-1" readonly>
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
                        <input type="text" id="����Ѽ���2" class="input_tag input_tag_prod_02 input-number auto_sum" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">������� 3</label>
                    </th>
                    <td class="td_01 td_prod_01">
                        <input type="text" id="����ѱ���3" class="input_tag input_tag_prod_01 input-number auto_sum" autocomplete="off">
                    </td>
                    <td class="td_01 td_prod_02">
                        <input type="text" id="����Ѽ���3" class="input_tag input_tag_prod_02 input-number auto_sum" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">������� 4</label>
                    </th>
                    <td class="td_01 td_prod_01">
                        <input type="text" id="����ѱ���4" class="input_tag input_tag_prod_01 input-number auto_sum" autocomplete="off">
                    </td>
                    <td class="td_01 td_prod_02">
                        <input type="text" id="����Ѽ���4" class="input_tag input_tag_prod_02 input_tag_end_01 input-number auto_sum" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">������� 5</label>
                    </th>
                    <td class="td_01 td_prod_01">
                        <input type="text" id="����ѱ���5" class="input_tag input_tag_prod_01 input-number auto_sum" autocomplete="off">
                    </td>
                    <td class="td_01 td_prod_02">
                        <input type="text" id="����Ѽ���5" class="input_tag input_tag_prod_02 input-number auto_sum" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">������� 6</label>
                    </th>
                    <td class="td_01 td_prod_01">
                        <input type="text" id="����ѱ���6" class="input_tag input_tag_prod_01 input-number auto_sum" autocomplete="off">
                    </td>
                    <td class="td_01 td_prod_02">
                        <input type="text" id="����Ѽ���6" class="input_tag input_tag_prod_02 input-number auto_sum" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">������� 7</label>
                    </th>
                    <td class="td_01 td_prod_01">
                        <input type="text" id="����ѱ���7" class="input_tag input_tag_prod_01 input-number auto_sum" autocomplete="off">
                    </td>
                    <td class="td_01 td_prod_02">
                        <input type="text" id="����Ѽ���7" class="input_tag input_tag_prod_02 input-number auto_sum" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag" for="�������">�������</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�������" class="input_tag input_tag_readonly_01 input_tag_end_01 input-number must_02" tabindex="-1" readonly>
                    </td>
                </tr>
            </table>
        </div>

        <div class="machine_insert">
            <table class="machine">
                <tr>
                    <th class="th_01">
                        <label class="label_tag">S/RPM</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="S_RPM" class="input_tag input-number" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag">L/SPEED</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="LINE_SPEED" class="input_tag input-number" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">UN_W �ټ�</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="UNWINDER_TEN" class="input_tag input-field" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">RE_W �ټ�</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="REWINDER_TEN" class="input_tag input_tag_end_01 input-field" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">����(&#176;C)</label>
                    </th>
                    <td class="td_01 td_machine_01">
                        <span>&nbsp;1��&nbsp;</span><input type="text" id="HEATER1" class="input_tag input_tag_machine_01 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_machine_01">
                        <span>&nbsp;2��&nbsp;</span><input type="text" id="HEATER2" class="input_tag input_tag_machine_01 input-number machine-set" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">�µ�</label>
                    </th>
                    <td class="td_01 td_machine_01">
                        <span>&nbsp;����&nbsp;</span><input type="text" id="�����µ�" class="input_tag input_tag_machine_02 input-number machine-set" autocomplete="off">
                    </td>
                    <td class="td_01 td_machine_01">
                        <span>&nbsp;����&nbsp;</span><input type="text" id="����" class="input_tag input_tag_machine_02 input-number machine-set" autocomplete="off">
                    </td>


                    <th class="th_01">
                        <label class="label_tag">�Լ���(%)</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�Լ���" class="input_tag input-number" autocomplete="off">
                    </td>

                    <th class="th_01">
                        <label class="label_tag">�õ�����(&#176;C)</label>
                    </th>
                    <td class="td_01" colspan="2;">
                        <input type="text" id="�õ������µ�" class="input_tag input_tag_end_01 input-number" autocomplete="off">
                    </td>
                </tr>
            </table>

            <table class="machine">
                <tr>
                    <th class="th_01 th_press_01" rowspan="2">
                        <label class="label_tag label_tag_2row">��������</label>
                    </th>
                    <th class="th_01 th_press_02">
                        <label class="label_tag">CY1</label>
                    </th>
                    <td class="td_01 td_press_01">
                        <input type="text" id="CY1" class="input_tag input_tag_press_01 input-number machine-set" autocomplete="off">
                    </td>
                    <th class="th_01 th_press_02">
                        <label class="label_tag">CY2</label>
                    </th>
                    <td class="td_01 td_press_01">
                        <input type="text" id="CY2" class="input_tag input_tag_press_01 input-number machine-set" autocomplete="off">
                    </td>
                    <th class="th_01 th_press_02">
                        <label class="label_tag">CY3</label>
                    </th>
                    <td class="td_01 td_press_01">
                        <input type="text" id="CY3" class="input_tag input_tag_press_01 input-number machine-set" autocomplete="off">
                    </td>
                    <th class="th_01 th_press_02">
                        <label class="label_tag">CY4</label>
                    </th>
                    <td class="td_01 td_press_01">
                        <input type="text" id="CY4" class="input_tag input_tag_press_01 input-number machine-set" autocomplete="off">
                    </td>
                    <th class="th_01 th_press_02">
                        <label class="label_tag">CY5</label>
                    </th>
                    <td class="td_01 td_press_01">
                        <input type="text" id="CY5" class="input_tag input_tag_press_01 input-number machine-set" autocomplete="off">
                    </td>
                    <th class="th_01 th_press_02">
                        <label class="label_tag">HD1</label>
                    </th>
                    <td class="td_01 td_press_01">
                        <input type="text" id="HEAD1" class="input_tag input_tag_press_01 input-number machine-set" autocomplete="off">
                    </td>
                    <th class="th_01 th_press_02">
                        <label class="label_tag">HD2</label>
                    </th>
                    <td class="td_01 td_press_01">
                        <input type="text" id="HEAD2" class="input_tag input_tag_press_01 input-number machine-set" autocomplete="off">
                    </td>
                    <th class="th_01 th_press_02">
                        <label class="label_tag">�з�</label>
                    </th>
                    <td class="td_01 td_press_01">
                        <input type="text" id="HEAD�з�" class="input_tag input_tag_press_01 input-number machine-set" autocomplete="off">
                    </td>
                    <th class="th_01 th_press_02">
                        <label class="label_tag">����</label>
                    </th>
                    <td class="td_01 td_press_01">
                        <input type="text" id="HEAD����" class="input_tag input_tag_press_01 input-number machine-set" autocomplete="off">
                    </td>
                    <th class="th_01 th_press_02">
                        <label class="label_tag">S/C</label>
                    </th>
                    <td class="td_01 td_press_01">
                        <input type="text" id="S_C" class="input_tag input_tag_press_01 input_tag_end_02 input-number machine-set" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01 th_press_02">
                        <label class="label_tag">DI1</label>
                    </th>
                    <td class="td_01 td_press_01">
                        <input type="text" id="DIES1" class="input_tag input_tag_press_01 input-number machine-set" autocomplete="off">
                    </td>
                    <th class="th_01 th_press_02">
                        <label class="label_tag">DI2</label>
                    </th>
                    <td class="td_01 td_press_01">
                        <input type="text" id="DIES2" class="input_tag input_tag_press_01 input-number machine-set" autocomplete="off">
                    </td>
                    <th class="th_01 th_press_02">
                        <label class="label_tag">DI3</label>
                    </th>
                    <td class="td_01 td_press_01">
                        <input type="text" id="DIES3" class="input_tag input_tag_press_01 input-number machine-set" autocomplete="off">
                    </td>
                    <th class="th_01 th_press_02">
                        <label class="label_tag">DI4</label>
                    </th>
                    <td class="td_01 td_press_01">
                        <input type="text" id="DIES4" class="input_tag input_tag_press_01 input-number machine-set" autocomplete="off">
                    </td>
                    <th class="th_01 th_press_02">
                        <label class="label_tag">DI5</label>
                    </th>
                    <td class="td_01 td_press_01">
                        <input type="text" id="DIES5" class="input_tag input_tag_press_01 input-number machine-set" autocomplete="off">
                    </td>
                    <th class="th_01 th_press_02">
                        <label class="label_tag">DI6</label>
                    </th>
                    <td class="td_01 td_press_01">
                        <input type="text" id="DIES6" class="input_tag input_tag_press_01 input-number machine-set" autocomplete="off">
                    </td>
                    <th class="th_01 th_press_02">
                        <label class="label_tag">DI7</label>
                    </th>
                    <td class="td_01 td_press_01">
                        <input type="text" id="DIES7" class="input_tag input_tag_press_01 input-number machine-set" autocomplete="off">
                    </td>
                    <th class="th_01 th_press_02" colspan="2;">
                        <label class="label_tag label_press">DIE GAP(mm)</label>
                    </th>
                    <td class="td_01 td_press_01" colspan="4;">
                        <input type="text" id="DIE_GAP" class="input_tag input_tag_press_02 input-number machine-set" autocomplete="off">
                    </td>
                </tr>
            </table>

            <table class="machine">
                <tr>
                    <th class="th_01 th_cut_01">
                        <label class="label_tag">������ cm(1)</label>
                    </th>
                    <td class="td_01 td_cut_01">
                        <input type="text" id="������CM1" class="input_tag input_tag_cut_01 input-number machine-set" autocomplete="off">
                    </td>
                        
                    <th class="th_01 th_cut_01">
                        <label class="label_tag">������ cm(7)</label>
                    </th>
                    <td class="td_01 td_cut_01">
                        <input type="text" id="������CM7" class="input_tag input_tag_cut_01 input-number machine-set" autocomplete="off">
                    </td>
                    
                    <th class="th_01 th_cut_01">
                        <label class="label_tag">���ú� ���� kg(1)</label>
                    </th>
                    <td class="td_01 td_cut_01">
                        <input type="text" id="���úι���KG1" class="input_tag input_tag_cut_01 input-number machine-set" autocomplete="off">
                    </td>
                    
                    <th class="th_01 th_cut_01">
                        <label class="label_tag">���ú� ���� kg(7)</label>
                    </th>
                    <td class="td_01 td_cut_01">
                        <input type="text" id="���úι���KG7" class="input_tag input_tag_cut_01 input-number machine-set" autocomplete="off">
                    </td>
                    
                    <th class="th_01 th_cut_01">
                        <label class="label_tag">���� �� ���� (m)</label>
                    </th>
                    <td class="td_01 td_cut_01">
                        <input type="text" id="�����ѱ���M" class="input_tag input_tag_cut_01 input-number machine-set" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01 th_cut_01">
                        <label class="label_tag">�о�� �߷� (m)</label>
                    </th>
                    <td class="td_01 td_cut_01">
                        <input type="text" id="�о���߷�" class="input_tag input_tag_cut_01 input-number machine-set" autocomplete="off">
                    </td>
                        
                    <th class="th_01 th_cut_01">
                        <label class="label_tag">���Ǽ��� ���� (m)</label>
                    </th>
                    <td class="td_01 td_cut_01">
                        <input type="text" id="���Ǽ��ñ���" class="input_tag input_tag_cut_01 input-number machine-set" autocomplete="off">
                    </td>
                    
                    <th class="th_01 th_cut_01">
                        <label class="label_tag">���� �߷� (kg)</label>
                    </th>
                    <td class="td_01 td_cut_01">
                        <input type="text" id="���Ǽ����߷�" class="input_tag input_tag_cut_01 input-number machine-set" autocomplete="off">
                    </td>

                    <th class="th_01 th_cut_01">
                        <label class="label_tag">���� �� (mm)</label>
                    </th>
                    <td class="td_01 td_cut_01">
                        <input type="text" id="���Ǽ�����" class="input_tag input_tag_cut_01 input-number machine-set" autocomplete="off">
                    </td>

                    <th class="th_01 th_cut_01">
                        <label class="label_tag">���������� LOSS (m)</label>
                    </th>
                    <td class="td_01 td_cut_01">
                        <input type="text" id="����������LOSS" class="input_tag input_tag_cut_01 input-number machine-set" autocomplete="off">
                    </td>
                    
                    <th class="th_01 th_cut_01" colspan="2;">
                        <label class="label_tag">��Ÿ Loss</label>
                    </th>
                    <td class="td_01 td_cut_01" colspan="2;">
                        <input type="text" id="��ŸLOSS" class="input_tag input_tag_cut_01 input_tag_end_03 input-number machine-set" autocomplete="off">
                    </td>
                </tr>
            </table>
        </div>

        <div class="ingredient_insert">
            <table class="ingredient">
                <tr>
                    <th class="th_01">
                        <label class="label_tag" for="�۷�ǰ��">��������</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�۷�ǰ��" class="input_tag input-field auto-mat input-auto input-auto_a must_02 must_03_01" autocomplete="off">
                    </td>
                        
                    <th class="th_01">
                        <label class="label_tag" for="�۷�Į��">Į��</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�۷�Į��" class="input_tag input-field auto-mat input-auto input-auto_b must_02 must_03_02" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag" for="�۷������">������</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�۷������" class="input_tag input-field auto-mat input-auto input-auto_b must_02 must_03_03" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag" for="�۷����Լ���">���Լ���</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�۷����Լ���" class="input_tag input_tag_end_01 input-number must_02 must_03_04" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <th class="th_01">
                        <label class="label_tag">���</label>
                    </th>
                    <td class="td_01 td_Sremark_01" colspan="5;">
                        <input type="text" id="�۷���" class="input_tag input_tag_Sremark_01 input-field auto-mat" autocomplete="off">
                    </td>
                    
                    <th class="th_01">
                        <label class="label_tag">LOT NO</label>
                    </th>
                    <td class="td_01">
                        <input type="text" id="�۷��Ʈ��ȣ" class="input_tag input_tag_end_01 input-field input-auto input-auto_b" autocomplete="off">
                    </td>
                </tr>
            </table>

            <table class="ingredient_kind">
                <tr>
                    <th class="th_01">
                        <label class="label_tag label_tag_ingredient_01" for="����ǰ��1">����ǰ��</label>
                    </th>

                    <th class="th_01">
                        <label class="label_tag label_tag_ingredient_01" for="����Į��1">Į��</label>
                    </th>

                    <th class="th_01">
                        <label class="label_tag label_tag_ingredient_01" for="���ܻ�����1">������</label>
                    </th>

                    <th class="th_01">
                        <label class="label_tag label_tag_ingredient_01" for="�Ǽ���1">���Լ���</label>
                    </th>

                    <th class="th_01">
                        <label class="label_tag label_tag_ingredient_01">LOT NO</label>
                    </th>

                    <th class="th_01">
                        <label class="label_tag label_tag_remark">���</label>
                    </th>
                </tr>

                <tr>
                    <td class="td_01 td_cut_01">
                        <input type="text" id="����ǰ��1" class="input_tag input_tag_ingredient_01 input-field auto-mat input-auto input-auto_a must_02 must_03_01" autocomplete="off">
                    </td>

                    <td class="td_01 td_cut_01">
                        <input type="text" id="����Į��1" class="input_tag input_tag_ingredient_01 input-field auto-mat input-auto input-auto_b must_02 must_03_02" autocomplete="off">
                    </td>

                    <td class="td_01 td_cut_01">
                        <input type="text" id="���ܻ�����1" class="input_tag input_tag_ingredient_01 input-field auto-mat input-auto input-auto_b must_02 must_03_03" autocomplete="off">
                    </td>

                    <td class="td_01 td_cut_01">
                        <input type="text" id="�Ǽ���1" class="input_tag input_tag_ingredient_01 input-number must_02 must_03_04" autocomplete="off">
                    </td>

                    <td class="td_01 td_cut_01">
                        <input type="text" id="���ܷ�Ʈ��ȣ1" class="input_tag input_tag_ingredient_01 input-field input-auto input-auto_b" autocomplete="off">
                    </td>

                    <td class="td_01 td_cut_01">
                        <input type="text" id="���ܺ��1" class="input_tag input_tag_ingredient_02 input-field auto-mat" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <td class="td_01 td_cut_01">
                        <input type="text" id="����ǰ��2" class="input_tag input_tag_ingredient_01 input-field auto-mat input-auto input-auto_a must_03_01" autocomplete="off">
                    </td>

                    <td class="td_01 td_cut_01">
                        <input type="text" id="����Į��2" class="input_tag input_tag_ingredient_01 input-field auto-mat input-auto input-auto_b must_03_02" autocomplete="off">
                    </td>

                    <td class="td_01 td_cut_01">
                        <input type="text" id="���ܻ�����2" class="input_tag input_tag_ingredient_01 input-field auto-mat input-auto input-auto_b must_03_03" autocomplete="off">
                    </td>

                    <td class="td_01 td_cut_01">
                        <input type="text" id="�Ǽ���2" class="input_tag input_tag_ingredient_01 input-number must_03_04" autocomplete="off">
                    </td>

                    <td class="td_01 td_cut_01">
                        <input type="text" id="���ܷ�Ʈ��ȣ2" class="input_tag input_tag_ingredient_01 input-field input-auto input-auto_b" autocomplete="off">
                    </td>

                    <td class="td_01 td_cut_01">
                        <input type="text" id="���ܺ��2" class="input_tag input_tag_ingredient_02 input-field auto-mat" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <td class="td_01 td_cut_01">
                        <input type="text" id="����ǰ��3" class="input_tag input_tag_ingredient_01 input-field auto-mat input-auto input-auto_a must_03_01" autocomplete="off">
                    </td>

                    <td class="td_01 td_cut_01">
                        <input type="text" id="����Į��3" class="input_tag input_tag_ingredient_01 input-field auto-mat input-auto input-auto_b must_03_02" autocomplete="off">
                    </td>

                    <td class="td_01 td_cut_01">
                        <input type="text" id="���ܻ�����3" class="input_tag input_tag_ingredient_01 input-field auto-mat input-auto input-auto_b must_03_03" autocomplete="off">
                    </td>

                    <td class="td_01 td_cut_01">
                        <input type="text" id="�Ǽ���3" class="input_tag input_tag_ingredient_01 input-number must_03_04" autocomplete="off">
                    </td>

                    <td class="td_01 td_cut_01">
                        <input type="text" id="���ܷ�Ʈ��ȣ3" class="input_tag input_tag_ingredient_01 input-field input-auto input-auto_b" autocomplete="off">
                    </td>

                    <td class="td_01 td_cut_01">
                        <input type="text" id="���ܺ��3" class="input_tag input_tag_ingredient_02 input-field auto-mat" autocomplete="off">
                    </td>
                </tr>

                <tr>
                    <td class="td_01 td_cut_01">
                        <input type="text" id="����ǰ��4" class="input_tag input_tag_ingredient_01 input-field auto-mat input-auto input-auto_a must_03_01" autocomplete="off">
                    </td>

                    <td class="td_01 td_cut_01">
                        <input type="text" id="����Į��4" class="input_tag input_tag_ingredient_01 input-field auto-mat input-auto input-auto_b must_03_02" autocomplete="off">
                    </td>

                    <td class="td_01 td_cut_01">
                        <input type="text" id="���ܻ�����4" class="input_tag input_tag_ingredient_01 input-field auto-mat input-auto input-auto_b must_03_03" autocomplete="off">
                    </td>

                    <td class="td_01 td_cut_01">
                        <input type="text" id="�Ǽ���4" class="input_tag input_tag_ingredient_01 input-number must_03_04" autocomplete="off">
                    </td>

                    <td class="td_01 td_cut_01">
                        <input type="text" id="���ܷ�Ʈ��ȣ4" class="input_tag input_tag_ingredient_01 input-field input-auto input-auto_b" autocomplete="off">
                    </td>

                    <td class="td_01 td_cut_01">
                        <input type="text" id="���ܺ��4" class="input_tag input_tag_ingredient_02 input-field auto-mat" autocomplete="off">
                    </td>
                </tr>
            </table>

            <table class="remark">
                <tr>
                    <th class="th_01 ">
                        <label class="label_tag label_tag_2row">Ư�̻���</label>
                    </th>
                    <td class="td_01 td_Lremark_01">
                        <textarea id="Ư�̻���" type="textarea" class="input_tag input_tag_Lremark_01 input-field" autocomplete="off" spellcheck="false"></textarea>
                    </td>
                </tr>
            </table>
        </div>
    </div>

<!-- hidden -->
<input type="hidden" id="â���" class="input-field" >
<input type="hidden" id="�۾����۽ð�" class="input-field">
<input type="hidden" id="�۾�����ð�" class="input-field">
<input type="hidden" id="IP_Address" class="input-field">
<input type="hidden" id="Item" value="">
<input type="hidden" id="color" value="">
<input type="hidden" id="size" value="">
<input type="hidden" id="WorkID" value="">

<input type="hidden" id="OLD�۷����Լ���" value="0" class="oldGlu">
<input type="hidden" id="OLD�Ǽ���1" value="0" class="oldGlu">
<input type="hidden" id="OLD�Ǽ���2" value="0" class="oldGlu">
<input type="hidden" id="OLD�Ǽ���3" value="0" class="oldGlu">
<input type="hidden" id="OLD�Ǽ���4" value="0" class="oldGlu">
<input type="hidden" id="OLD�۾�����" value="0">

<!-- ���α׷��� ��� -->

<div class="modal fade" id="progress_Modal" tabindex="-1" style="width:100%;" data-bs-keyboard="false" aria-labelledby="progressModalLabel" data-backdrop="static" aria-hidden="true" >
	<div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" id="modal-header">
                <h5 class="modal-title" id="progressModalLabel" style="font-size: 16px;font-weight: 900;">��ȸ���Դϴ�. ��ø� ��ٷ��ּ���.</h5>
            </div>
            <div class="modal-body">
                <div id="progress_div" class="progress">
                    <div  id="progress" class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:40%">
                    
                    </div>
                </div>
            </div>
            <div class="modal-footer" id="modal-footer">

            </div>
        </div>
	</div>
</div>

</body>
</HTML>
