 <!-- METADATA TYPE="typelib" FILE="C:\Program Files\Common Files\SYSTEM\ADO\msado15.dll" -->
<%
'============================================================================================
'			���ڵ�� ��ü����
'============================================================================================
Function funcRs(conn,sql)
	set funcRs	= Server.CreateObject("ADODB.RecordSet")
	set funcRs	= conn.execute(sql)
End Function

'-----------------------------------------------------------------------------------
'			Ŀ�ؼ� ��ü �ݰ� ������
'-----------------------------------------------------------------------------------
Function CONN_CLOSE(cnnDB)	
	If Not cnnDB Is Nothing Then
		If cnnDB.State = "0x00000001" Then 'adStateOpen��� = 0x00000001'
			cnnDB.Close
		end if
	End If
	set cnnDB = nothing
End Function
'--------------------------------------------------------------------------------------
'			�Է��� URL�� �����̷���
'--------------------------------------------------------------------------------------
Function funcGoUrl(url)	
	response.write ("<META HTTP-EQUIV='refresh' Content='0; url=" & url & "'>")
End Function

'------------------------------------------------------------------------------------
'			 �޼��� â ���� �̵�(Ȯ��)
'-----------------------------------------------------------------------------------
Function funcUrlGo(msg,url,opt)
	dim strGo
	select case opt
		case "historyBack"
			strGo = "history.back();"
		case "None"
			strGo = ""
		case "ParentsGo"
			strGo = "parent.location.href = '" & url & "' ;"
		case "ThisGo"
			strGo = "location.href = '" & url & "' ;"
		case "OpenerGo"
			strGo = "opener.location.href = '" & url & "' ;"
		case "CloseOpenerGo"
			strGo = "self.close();opener.location.href = '" & url & "' ;"
		case "ThisGoReload"
			strGo = "parent.document.frames['cmain'].document.location.href='" & url & "';  "
		case "Reload"
			strGo = "parent.location.reload();"
		case "Close"
			strGo = "self.close();"
	end Select

	If msg = "" Then
		response.write ("<SCRIPT LANGUAGE='JavaScript'>" & strGo & "</SCRIPT>")
	Else		
		response.write ("<SCRIPT LANGUAGE='JavaScript'>alert('" & msg & "');" & strGo & "</SCRIPT>")
	End If
	
End Function
'--------------------------------------------------------------------------------------
'			���ؼǰ�ü�� ����
'--------------------------------------------------------------------------------------
Function funcCnnExec(conn,sql)

	funcCnnExec	= conn.Execute(sql)
End Function
'--------------------------------------------------------------------------------------
'			���ڵ�� ��ü�ݰ� ������
'--------------------------------------------------------------------------------------
Function funcRs_close(rs)
	if isobject(rs) then
		rs.close
		set	rs	= nothing
	end if
End Function
' --------------------------------------------------------------------
'	ADO Command ��ü ���
' --------------------------------------------------------------------
Function funcCmd(commandText,cnnDB)
	dim Cmd
	set Cmd = Server.CreateObject("ADODB.Command")
	with Cmd
		.activeConnection = cnnDB
		.commandType = adCmdStoredProc
		.commandText = commandText
	end with
	set funcCmd = Cmd
End Function

' Command�� Paramter�� �����Ҷ� ���
function funcParameter(gName,gType,gDirection,gSize,gValue)
	Dim param
	Set param = Server.CreateObject("ADODB.Parameter")
	with param
		.name = gName
		.type = gType
		.direction = gDirection
		.size = gSize
		.value = gValue
	end with
	set funcParameter = param
	set param = nothing
end function
'--------------------------------------------------------------------------------------
'		�ش�⵵�� ���� �޾� ���� ������ ��¥�� �����ϴ� �Լ�
'--------------------------------------------------------------------------------------
Function funcSetLastDay(gYear,gMonth)
	dim dayCount
	'�迭�� 0���� �����Ѵ�. dayCount(1)�� 2������ ����Ų��.
	dayCount = Array(31,28,31,30,31,30,31,31,30,31,30,31)
	if ((gYear mod 4 = 0) and not (gYear mod 100 = 0)) or (gYear mod 400 = 0) then
		dayCount(1) = 29
	end if
	funcSetLastDay = dayCount(cint(gMonth)-1)
End Function
'--------------------------------------------------------------------------------------
'
'					����� ���� ��¥����
'		�����Լ�: func_make2Length(str)
'
'--------------------------------------------------------------------------------------

Function funcCustomDate(tmpDate,cMode)
	dim tmpYear,tmpMonth,tmpDay,tmpHH,tmpMM,tmpSS
	tmpYear = year(tmpDate)
	tmpMonth= month(tmpDate)
	tmpDay = day(tmpDate)
	tmpHH = hour(tmpDate)
	tmpMM = minute(tmpDate)
	tmpSS = second(tmpDate)

	select case cMode
		case "dateDash"
			funcCustomDate = tmpYear & "-" & func_make2Length(tmpMonth) & "-" & func_make2Length(tmpDay)
		case "dateSlash"
			funcCustomDate = tmpYear & "/" & func_make2Length(tmpMonth) & "/" & func_make2Length(tmpDay)
		case "dateYMD"
			funcCustomDate = tmpYear & "�� " & tmpMonth & "�� " & tmpDay & "�� "
		case "timeColon"
			funcCustomDate = " "& func_make2Length(tmpHH) & ":" & func_make2Length(tmpMM) & ":" & func_make2Length(tmpSS) 
		case "timePipe"
			funcCustomDate = " "& func_make2Length(tmpHH) & "|" & func_make2Length(tmpMM) & "|" & func_make2Length(tmpSS) 
		case else
			funcCustomDate = tmpDate
	end select
End Function
'--------------------------------------------------------------------------------------
'
'		 ���ڸ� ���ڸ� 2�ڸ��� �ٲپ� �ش�.
'
'--------------------------------------------------------------------------------------
function func_make2Length(str)
	if len(str) < 2 then
		str = "0" & str
	end if
	func_make2Length = str
end function

'--------------------------------------------------------------------------------------
'
'		�Ϲݼ��ڸ� 1000���� �����ؼ� �ѷ���
'
'--------------------------------------------------------------------------------------
Function funcReplaceZero(str,mode)
	Dim retuStr
'	null ���̸� �ٷ� ����
	if isnull(str) or isempty(str) then	
		str = "0"
'		exit function
	end if	


	if str = "0" or str="" or str=" " then 
		retuStr = "&nbsp;"
	else 
		select case mode
			case 0
				retuStr = formatnumber(str,0)
			case 1
				retuStr = round(str,1) & "%"
			case 2
				retuStr = round(str,1)
			case 3
				retuStr = round(str)
			case else
				retuStr = str
		end select
	end if 
	funcReplaceZero = retuStr
End Function

'----------------------------------------------------------------------------------------------
'
'				<select> �ڽ� ����ϴ� �Լ� #2 (DB�� �ڿ��� �������)
'
'----------------------------------------------------------------------------------------------

Function funcSelect_DB(sltName,sltValue,rs,feld1,feld2,sltTitle,evnt)
	dim tmpSelect
	dim tmpFileName
	dim tmpValue
	dim optTitle

	'//	Ÿ��Ʋ���� �������� Ÿ�̺��� �־��ش�.
	if sltTitle = "" or isnull(sltTitle)then
	else
		optTitle = " <option value='0'>" & sltTitle & "</option>"
	end if

	tmpSelect = ""
	tmpSelect = tmpSelect & "<select name='" & sltName & "'" & evnt & ">"
	tmpSelect = tmpSelect & optTitle
	do until rs.eof
		tmpValue = rs(feld1)		
		tmpFileName=rs(feld2)		
		if sltValue = tmpValue Then
			tmpSelect = tmpSelect & "	<option value='" & tmpValue & "' selected>" & tmpFileName & "</option>"
		else
			tmpSelect = tmpSelect & "	<option value='" & tmpValue & "'>" & tmpFileName & "</option>"
		end if

		rs.movenext
	loop
	tmpSelect = tmpSelect & "</select>"
	funcSelect_DB = tmpSelect
End Function


'------------------------------------------------------------------------------------------------------
'
'					���ڿ� Replace
'
'------------------------------------------------------------------------------------------------------
	Function funcConvert(str,mode)

		Dim strtemp : strtemp = str
		If IsNull(strtemp) Then
			strtemp = " "
		End If 
		select case mode
			case "ReplaceDB"
				strtemp = replace(strtemp, "'","''")
			case "Display"
				strtemp = replace(strtemp, "<BR>", chr(13)&chr(10))
				strtemp = replace(strtemp, "''", "'")
			case "Display02"
				strtemp = replace(strtemp, chr(13), "<br>")
				strtemp = replace(strtemp, "''", "'")	
			case else			

		end select	
	
		funcConvert = strtemp
	End Function



'----------------------------------------------------------------------------
'	���������� ���� ���ڰ� ����
'-----------------------------------------------------------------------------
'	���ڰ� true/false�� ����
sub	funcRequest(fb,tb,fs,ts,fj,tj,dMode,fa,ta,kv,fp,tp,s1,s2,fd,fc)
	Dim arryDate
	Dim hRs
	Dim brndRs, brndSept
	'--------------------------------------------------------
	'	Form�� �޴ºκ�[����] �� �⺻�� �����ϴ� �κ�
	chk		= request("chk")
	if fb then	
		F_brnd	= request("F_brnd") 
		if isEmpty(F_brnd) then F_brnd = 1 end if
	end if
	if tb then	
		T_brnd	= request("T_brnd") 
		if isEmpty(T_brnd) then T_brnd = 1 end if
	end if

	'----------------------------
	'	��¥�����ϴ� �Լ� ��
	if dMode <> 0 then
		arryDate = funcSetDate(dMode)
		F_dat = request("F_dat")
		T_dat = request("T_dat")
		if isempty(F_dat) then	F_dat	= arryDate(0)	end if
		if isempty(T_dat) then	T_dat	= arryDate(1)	end if
	end if

	if fa then	F_aig	= request("F_aig") end if
	if ta then	T_aig	= request("T_aig") end if
	if kv then	
		K_view	= request("K_view") 
		if isempty(K_view) then	K_view = 1	end if
				
	end if
	if fp then	F_pj	= request("F_pj") end if
	if tp then	T_pj	= request("T_pj") end if

	if s1 then	
		K_slt1	= request("K_slt1") 		
		if isEmpty(K_slt1) then	K_slt1 = 0	else K_slt1 = 1 end if
	end if
	if s2 then	
		K_slt2	= request("K_slt2") 
		if isEmpty(K_slt2) then	K_slt2 = 0	else K_slt2 = 1 end if
	end if		
	if fd then
		F_dn	= request("F_dn")
	end if
	if fc then
		F_col	= request("F_col")
	end if
	
	'----------------------------------------------------
	'	�ڷ������ ���� url�ּ� ����
	strPostBackUrl = request.ServerVariables("PATH_INFO")		
	strPageName = mid(strPostBackUrl,instrrev(strPostBackUrl,"/")+1)
	strFormName = mid(strPageName,1,instr(strPageName,".")-1)
	strPageName = strFormName & "_RDS.ASP"
end Sub


Sub	funcGetFormName()
	Dim strPostBackUrl, strPageName, sql, rs, TString 
	strPostBackUrl = request.ServerVariables("PATH_INFO")		
	strPageName = mid(strPostBackUrl,instrrev(strPostBackUrl,"/")+1)
	strFormName = mid(strPageName,1,instr(strPageName,".")-1)
	
	sql = "SELECT IDX,WUSERNAME,LBL_OPT1, LBL_OPT2, LBL_OPT3, LBL_OPT4, ISNULL(DateTermType,'14') AS DateTermType, defaultCount FROM B_workname WHERE FILENAME = '" & strFormName & "' AND UseCHK = 0"     
	set rs = g_Conn.Execute(sql)

    if rs.eof then
        GLOBALSET(40) = ""
    else
        GLOBALSET(40) = rs("WUSERNAME")
        
        If Not (rs("LBL_OPT1") = "" or IsEmpty(rs("LBL_OPT1")) or IsNull(rs("LBL_OPT1"))) Then
            TString = rs("LBL_OPT1")
        End If
        If Not (rs("LBL_OPT2") = "" or IsEmpty(rs("LBL_OPT2")) or IsNull(rs("LBL_OPT2"))) Then
            TString = TString & "|" & rs("LBL_OPT2")
        End If
        If Not (rs("LBL_OPT3") = "" or IsEmpty(rs("LBL_OPT3")) or IsNull(rs("LBL_OPT3"))) Then
            TString = TString & "|" & rs("LBL_OPT3")
        End If
        If Not (rs("LBL_OPT4") = "" or IsEmpty(rs("LBL_OPT4")) or IsNull(rs("LBL_OPT4"))) Then
            TString = TString & "|" & rs("LBL_OPT4")
        End If            
        GLOBALSET(41) = TString
        GLOBALSET(42) = rs("DateTermType")
        GLOBALSET(43) = rs("IDX")
        GLOBALSET(44) = rs("defaultCount")
    End If

    sql = "EXEC [H_GLOBPERMIT_Workname] " & GLOBALSET(7) & ",'" & GLOBALSET(43) & "'"    
    set rs = g_Conn.Execute(sql)    
    if rs.eof then
        GLOBALSET(45) = 0
    Else                                     
        GLOBALSET(45) = rs("UPermit")
    End If

    call funcRs_close(rs)
    call CONN_CLOSE(g_Conn)
End Sub

sub funcSelectSource(p1,p2,p3,p4,p5,p6,p7,p8)
	dim strSql
	'--------------------------------------------------------
	'	SELECTBOX �� ������[�귣��]
	if p1 then
		strSql = "exec CT_BRAND " 
		Set rs(1) = g_Conn.Execute(strSql)
	end If
	'--------------------------------------------------------
	'	SELECTBOX �� ������[����]
		if p2 then
		strSql = "exec CT_AIG " 
		Set rs(2) = g_Conn.Execute(strSql)
	end if
	'--------------------------------------------------------
	'	SELECTBOX �� ������[�������]
	if p3 then
		strSql = "exec CT_SEAN"
		Set rs(3) = g_Conn.Execute(strSql)
	end if
	'--------------------------------------------------------
	'	SELECTBOX �� ������[�������]
	if p4 then
		strSql = "exec CT_SEAN"
		Set rs(4) = g_Conn.Execute(strSql)

	end if
	'--------------------------------------------------------
	'	SELECTBOX �� ������[��ǰ���� ����]
	if p5 then
	strSql = "exec CT_JUE"
		Set rs(5) = g_Conn.Execute(strSql)
	end if

	'--------------------------------------------------------
	'	SELECTBOX �� ������[��ǰ���� ����]
	if p6 then
	strSql = "exec CT_JUE"
		Set rs(6) = g_Conn.Execute(strSql)
	end if
	'--------------------------------------------------------
	'	SELECTBOX �� ������[DN]
	if p7 then		
		strSql = "exec CT_GET_DN "
		Set rs(7) = g_Conn.Execute(strSql)
	end If
end sub



'---------------------------------------------------------------
'	����Ʈ�ڽ� ���ڵ�ҽ� Ȯ����
'	f1~f2 = ���ڵ�ҽ� �����ϴ� ����Ʈ�ڽ���
'	v1~v4 = ����Ʈ��� ���ν����� ���Ǵ� ���ڰ�
'	r1~r2 = �迭�� ����� ���ڵ�ҽ� ����
sub funcSelectSource_ex(f1,f2,v1,v2,v3,v4,r1,r2)

	dim strSql
	'--------------------------------------------------------
	select case f1
		case 5	 
			strSql = "exec CT_warehousedivision"
			F_ipue = request("F_ipue")
		case 6
			'v1:��¥ v2:����
			strSql = "exec  CT_GET_CID '" & v1 & "','" & v2 & "'"
		case 7		
			'v1:�����ι�ȣ����
			strSql = "exec CT_GET_COL '" & v1 & "'"
		case 8
			'v1:�����ι�ȣ����
			strSql = "exec CT_GET_COLOR '" & v1 & "'"
		case 9
			'v1:��¥ v2:��¥ v3:���� v4:����			
			strSql = "exec CT_SALOJ '" & v1 & "','" & v2 & "','" & v3 & "','" & v4 & "'"
		case 10
			'v1:TOP �������� ���ڰ�
			strSql = "exec CT_SALDT '" & v1 & "'"
		case 14
			strSql = " exec CT_YYYYMM "	
			F_yyyymm = request("F_yyyymm")					
		case 100
			strSql = " exec CT_YEAR "		
			F_year = request("F_year")
		case 101
			strSql = " exec CT_dissection "		
			F_sue = request("F_sue")
		case else
			strSql = ""			
	end select

	if strSql <> "" then
		Set rs(r1) = g_Conn.Execute(strSql)
	end if

	select case f2
		case 5		
			strSql = "exec CT_warehousedivision"
			T_ipue = request("T_ipue")
		case 6
			strSql = "exec NSacountnumber "	
		case 100
			strSql = "exec CT_YEAR "		
			T_year = request("F_year")
		case 101
			strSql = " exec CT_dissection "		
			T_sue = request("T_sue")
		case else
			strSql = ""	
	end select

	if strSql <> "" then
		Set rs(r2) = g_Conn.Execute(strSql)
	end if
end sub

'--------------------------------------
'	�⺻ ��¥�� ����
'--------------------------------------
function funcSetDate(dMode)

	dim tmpYear,tmpMonth,tmpDay,tmpHH,tmpMM,tmpSS
	dim arryRetu(1)	
	dim tmpDate
	Dim tmpDateEx

	tmpDate = date
	tmpYear = year(tmpDate)
	tmpMonth= month(tmpDate)
	tmpDay = day(tmpDate)
	tmpHH = hour(tmpDate)
	tmpMM = minute(tmpDate)
	tmpSS = second(tmpDate)

	select case dMode		
		case 1	'1���ϰ� �ڷ�			
			arryRetu(0) = dateadd("d",-7,tmpDate)
			arryRetu(1) = tmpDate
		case 2	'�� 1�Ϻ��� ���ϱ���
			arryRetu(0) = tmpYear & "-" & func_make2Length(tmpMonth) & "-" & "01"
			arryRetu(1) = tmpYear & "-" & func_make2Length(tmpMonth) & "-" & funcSetLastDay(tmpYear,tmpMonth)
		case 3	'�����-1���� �������
			arryRetu(0) = dateadd("m",-1,tmpDate)
			arryRetu(1) = tmpDate
		case 4	'�� 1�Ϻ��� �������
			arryRetu(0) = tmpYear & "-" & func_make2Length(tmpMonth) & "-" & "01"
			arryRetu(1) = tmpDate
		case 5	'������� �������
			arryRetu(0) = tmpDate
			arryRetu(1) = tmpDate		
		case 6	'1��1�Ϻ��� 12��31�ϱ���
			arryRetu(0) = tmpYear & "-" & "01" & "-" & "01"
			arryRetu(1) = tmpYear & "-" & "12" & "-" & "31"
		case 7	'���糯¥����
			arryRetu(0) = ""
			arryRetu(1) = tmpDate
		case 8	'������ ù�԰���
	'		arryRetu(0) = ""
	'		arryRetu(1) = tmpDate
		case 9	'�������� ���ñ���
			arryRetu(0) = dateadd("d",-1,tmpDate)
			arryRetu(1) = tmpDate
		case 10	'���糯�ڷκ��� 12������ ���������Ǹ���Ȳ
			arryRetu(0) = ""
			If Len(tmpMonth) = 1 Then 
				arryRetu(1) = tmpYear - 1 & "-0" & tmpMonth + 1
			Else 
				arryRetu(1) = tmpYear - 1 & "-" & tmpMonth + 1
			End If 
		Case 11 '���糯�ں��� 24���� �ְ������Ǹ���Ȳ
			arryRetu(0) = ""
			arryRetu(1) = DateAdd("d",-168,tmpDate)
		Case 12	'���糯�ڷκ��� �Ѵ�(30�ϱ���)
			arryRetu(0) = DateAdd("d",-30,tmpDate)
			arryRetu(1) = tmpDate
		case 13	'�� 1�Ϻ��� ���ϱ���
			arryRetu(0) = tmpYear & "-01-01"
			arryRetu(1) = tmpDate
		case 14	'2�������� ���ñ���
			arryRetu(0) = dateadd("d",-2,tmpDate)
			arryRetu(1) = tmpDate
		Case 15	'�����̿���� 
			arryRetu(0) = DateAdd("d",-1,DateAdd("m",0,tmpYear & "-" & tmpMonth & "-01" ))
			arryRetu(1) = tmpYear & "-" & tmpMonth & "-01"
		Case 16	'���ڱⰣ���Ǹ���Ȳ 
			arryRetu(0) = DateAdd("d",-83,tmpDate)
			arryRetu(1) = tmpDate
		Case 17	'���ڱⰣ���Ǹ���Ȳ 
			arryRetu(0) = DateAdd("m",-1,(tmpYear & "-" & func_make2Length(tmpMonth) & "-" & "01"))
			arryRetu(1) = DateAdd("d",-1,(tmpYear & "-" & func_make2Length(tmpMonth) & "-" & "01"))
		Case 18	'������ 1�Ϻ��� ������ ���ϱ���
			arryRetu(0) = DateAdd("m",-1,(tmpYear & "-" & func_make2Length(tmpMonth) & "-" & "01"))
			arryRetu(1) = tmpYear & "-" & func_make2Length(tmpMonth-1) & "-" & funcSetLastDay(tmpYear,tmpMonth-1)
		Case 19	'1��1�Ϻ��� ���糯����
			arryRetu(0) = tmpYear & "-" & "01" & "-" & "01"
			arryRetu(1) = tmpDate

		case 20	'���� 1�Ϻ��� ���ϱ���
			arryRetu(0) = DateAdd("m",-1,(tmpYear & "-" & func_make2Length(tmpMonth) & "-" & "01"))
			arryRetu(1) = tmpYear & "-" & func_make2Length(tmpMonth) & "-" & funcSetLastDay(tmpYear,tmpMonth)

		
		case else
			arryRetu(0) = tmpDate
			arryRetu(1) = tmpDate			
	end select

	funcSetDate = arryRetu
end function
			
'----------------------------------------------------------------------------------------------------------
'	�⺻ ���� ����
'----------------------------------------------------------------------------------------------------------
Sub setColor(Tit_BGC,Gub_BGC)
	TITLE_BGCOL = Tit_BGC
	GUBUN_BGCOL = Gub_BGC   
End Sub

'-----------------------------------------------
'	������ �ִ밪�� �ּҰ��� �������ִ� ����
'-----------------------------------------------	
function setMinMax(opt)		
	dim setArray
	select case opt
		case 1	'��������
			setArray = outPutProc("CT_GET_AIGID","r_min","r_max")
			F_aig = setArray(1)
			T_aig = setArray(2)
		case 2	'�԰���
			setArray = outPutProc("CT_GET_IPUE","r_min","r_max")
			F_ipue = setArray(1)
			T_ipue = setArray(2)					
		case else
	end select
end function

'-----------------------------------------------
'	OUTPUT������ ����� ���ν��� ����
'-----------------------------------------------	
function outPutProc(commandText,op1,op2)
	dim cmd	
	dim returnArray(2)
	'-------------------------------------------------------------------------
	'	Parameter DataTypeEnum ���
	'-------------------------------
	'	char			: adChar
	'	varchar			: adVarChar
	'	datetime		: adDBTimeStamp
	'	smalldatetime	: adDBTimeStamp
	'	float			: adSingle
	'	real			: adSingle
	'	int				: adInteger
	'	smallint		: adSmallInt
	'	tinyint			: adUnsignedTinyint
	'-------------------------------
	'	Direction �Ӽ�
	'-------------------------------
	'	adParamUnknown		: 0
	'	adParamInput		: 1
	'	adParamOutput		: 2
	'	adParamInputOutput	: 3
	'	adParamReturnValue	: 4

	set cmd = funcCmd(commandText,g_Conn)
	with cmd
		.parameters.append funcParameter(op1,adInteger,adParamOutput,4,0)
		.parameters.append funcParameter(op2,adInteger,adParamOutput,4,-1)
		.execute,,adExecuteNoRecords
	end with

	returnArray(1)	= cmd.parameters(op1).value		'�ּҰ�
	returnArray(2)	= cmd.parameters(op2).value		'�ִ밪
	outPutProc = returnArray
	set cmd = nothing
end function

'-----------------------------------------------
'	SESSIONüũ
'-----------------------------------------------	
Function CHK_SESSION()	' ���� ���¸� üũ
	dim sub_sql, sub_Rs, sub_sid
	Dim tmpUrl

	if isEmpty(GLOBALSET(1)) or GLOBALSET(1) = "" then GLOBALSET(1) = session("seSawonid") end if
	if isEmpty(GLOBALSET(2)) or GLOBALSET(2) = "" then GLOBALSET(2) = session("seSawonname") end if
	if isEmpty(GLOBALSET(4)) or GLOBALSET(4) = "" then GLOBALSET(4) = session("seItemno") end if	
    if isEmpty(GLOBALSET(5)) or GLOBALSET(5) = "" then GLOBALSET(5) = session("seUnitpriceView") end if	
    if isEmpty(GLOBALSET(7)) or GLOBALSET(7) = "" then GLOBALSET(7) = session("sePerm_ID") end if	

	If session("seSawonid") & "" = "" or session("seSawonname") & "" = "" Then			' �α��� ������ ���ᰡ �Ǿ�����		
		If Request.cookies("tmpIdCookie") & "" = ""  then
			sub_sql = "exec Usp_CT_nowconnectlogdelete '" & session("seSawonid") & "','" & Session.SessionID & "'"
			g_Conn.execute(sub_sql)				' ���Ǿ��̵� ���ڵ带 ����
			session.contents.removeall		
			session.abandon						' ���� ���� ��� ����		
			'Call funcGoUrl("../default.htm")					
            response.write "<script type='text/javascript'> parent.parent.frames[0].location='/default.htm' </script>"
			call CONN_CLOSE(g_Conn)
			response.end
		Else
			session("seSawonid") = Request.cookies("cokseSawonid")
			session("seSawonname") = Request.cookies("cokseSawonname")
			session("seItemno") = Request.cookies("cokseItemno")
            session("seUnitpriceView") = Request.cookies("cokseUnitpriceView")
            session("sePerm_ID") = Request.cookies("coksePerm_ID")

			GLOBALSET(1) = Request.cookies("cokseSawonid")
			GLOBALSET(2) = Request.cookies("cokseSawonname")
			GLOBALSET(4) = Request.cookies("cokseItemno")
            GLOBALSET(5) = Request.cookies("cokseUnitpriceView")
            GLOBALSET(7) = Request.cookies("coksePerm_ID")
		End if
	End if

	sub_sql = "exec Usp_CT_nowconnectlog '" & session("seItemno") & "','" & session("seSawonid") & "'"
	set sub_Rs = g_Conn.execute(sub_sql)

	if sub_Rs.eof then						
		session.contents.removeall
		session.abandon							' ���� ���� ��� ����
		'Call funcGoUrl("../default.htm")		
        ''' �α���ȭ������ ���°� ����. 2021-04-08
		''' response.write "<script type='text/javascript'> parent.parent.frames[0].location='/default.htm' </script>"			
		'------------------------------------------------------------------------------
		call CONN_CLOSE(g_Conn)

		'------------------------------------------------------
		'--// �ٽ� �α����ϵ��� �˾�
		'------------------------------------------------------
		dim strScript

		strScript = ""
		strScript = strScript & "<SCRIPT LANGUAGE=JavaScript>"
		strScript = strScript & " fnOpenPopup(580,300);"
		strScript = strScript & "</SCRIPT>"
		'------------------------------------------------------

		response.end
	end if
End Function

'-----------------------------------------------------------------------
'   �ߺ������üũ
'-----------------------------------------------------------------------
Function DuplicationUserCheck(pageType)
    Dim chkRS        
    If pageType = 0 Then     '0: �������            
        Set chkRS = g_Conn.execute("SELECT SawonName as CNT FROM G_Sawon WHERE sessionID = '" & session.SessionID & "'")        
        If ChkRs.eof Then   '���Ǿ��̵� ������ �ߺ��α������� ������
            session.contents.removeall
	        session.abandon			
            '''response.Write  "<script type='text/javascript'>alert('��ȿ ���ӽð��� �ʰ��Ͽ� ������ ���� �մϴ�\n\n!!! ��α��� �ϼ��� !!!');parent.parent.frames[0].location='/default.htm'</script>"       
			
			'------------------------------------------------------
			'--// �ٽ� �α����ϵ��� �˾�
			'------------------------------------------------------
			dim strScript

			strScript = ""
			strScript = strScript & "<SCRIPT LANGUAGE=JavaScript>"
			strScript = strScript & " fnOpenPopup(580,300);"
			strScript = strScript & "</SCRIPT>"

			response.Write strScript
			response.end
			'------------------------------------------------------
        End If                
    End If    
    chkRS.close
    Set chkRS = nothing
End Function 



Function CHK_SESSION_10()	' ���� ���¸� üũ
	dim sub_sql, sub_Rs, sub_sid
	Dim tmpUrl

	if isEmpty(GLOBALSET(1)) or GLOBALSET(1) = "" then GLOBALSET(1) = session("seSawonid") end if
	if isEmpty(GLOBALSET(2)) or GLOBALSET(2) = "" then GLOBALSET(2) = session("seSawonname") end if
	if isEmpty(GLOBALSET(4)) or GLOBALSET(4) = "" then GLOBALSET(4) = session("seItemno") end if	

	If isEmpty(session("seSawonid")) Then			' �α��� ������ ���ᰡ �Ǿ�����					
			session.contents.removeall		
			session.abandon						' ���� ���� ��� ����		
			'Call funcGoUrl("../default.htm")					
            response.write "<script type='text/javascript'> parent.parent.frames[0].location='/default.htm' </script>"
			call CONN_CLOSE(g_Conn)
			response.end
	End if
End Function




'-----------------------------------------------
'	SESSIONüũ
'-----------------------------------------------	
Function vFunChkSession(mode)	
	Call CHK_SESSION()

    '�ߺ������üũ
    Call DuplicationUserCheck(0)
    'Call CHK_SESSION_10()
End Function


'------------------------------------------------
'	�޴��ۼ�
'------------------------------------------------
Function funcMenu(sid,opt)
	dim sql
	dim rs
	dim arryMenu(11,50)
	dim arryMenuItem(11,50)
	dim arryFile(11,50)
	dim intI, intJ
	dim tmpIdx
	dim strReturn
	
	sql = "Execute CT_usermenu " & sid
	set rs = g_Conn.execute(sql)

	'----------------------------------------
	'	�⺻������
	intI = 1
	intJ = 1
	if not rs.eof then tmpIdx = rs("�����׷�IDX") end if

	do until rs.eof 				
		if tmpIdx <> rs("�����׷�IDX") then
			intI = intI + 1
			intJ = 1
		end if			

		arryMenu(intI,intJ) = rs("�����׷�")
		arryMenuItem(intI, intJ) = rs("������")
		arryFile(intI, intJ) = rs("���ϸ�")

		intJ = intJ + 1

		tmpIdx = rs("�����׷�IDX")
		rs.movenext		
	loop

	select case opt
		case 1
			strReturn = arryMenu
		case 2
			strReturn = arryMenuItem
		case 3
			strReturn = arryFile
	end select

	funcMenu = strReturn
End Function


Function passtrans(passchar)
	Dim P1, P2, P3, P4, p5, p6
	   P1 = ""
	   P2 = ""
	   P3 = ""
	   P4 = ""
	   p5 = ""
	   p6 = ""
	   If passchar = "" Then
		  passtrans = ""
	   Else
		  P1 = Chr(Mid(passchar, 1, 3) + 1)
		  If Len(passchar) > 3 Then
			 P2 = Chr(Mid(passchar, 4, 3) + 2)
		  End If
		  If Len(passchar) > 6 Then
			 P3 = Chr(Mid(passchar, 7, 3) + 3)
		  End If
		  If Len(passchar) > 9 Then
			 P4 = Chr(Mid(passchar, 10, 3) + 4)
		  End If
		  If Len(passchar) > 12 Then
			 p5 = Chr(Mid(passchar, 13, 3) + 5)
		  End If
		  If Len(passchar) > 15 Then
			 p6 = Chr(Mid(passchar, 16, 3) + 6)
		  End If
		  passtrans = P1 & P2 & P3 & P4 & p5 & p6
	   End If
End Function

Function passconv(passchar)

	Dim P1, P2, P3, P4, p5, p6
	   P1 = ""
	   P2 = ""
	   P3 = ""
	   P4 = ""
	   p5 = ""
	   p6 = ""
	   If passchar = "" Then
		  passconv = ""
	   Else
		  P1 = convnull(Right(str(Asc(Mid(passchar, 1, 1)) - 1), 3))
		  If Len(passchar) > 1 Then
			 P2 = convnull(Right(str(Asc(Mid(passchar, 2, 1)) - 2), 3))
		  End If
		  If Len(passchar) > 2 Then
			 P3 = convnull(Right(str(Asc(Mid(passchar, 3, 1)) - 3), 3))
		  End If
		  If Len(passchar) > 3 Then
			 P4 = convnull(Right(str(Asc(Mid(passchar, 4, 1)) - 4), 3))
		  End If
		  If Len(passchar) > 4 Then
			 p5 = convnull(Right(str(Asc(Mid(passchar, 5, 1)) - 5), 3))
		  End If
		  If Len(passchar) > 5 Then
			 p6 = convnull(Right(str(Asc(Mid(passchar, 6, 1)) - 6), 3))
		  End If
		  passconv = P1 & P2 & P3 & P4 & p5 & p6
	   End If
End Function
'-------------------------------------------
'����Ʈ �ڽ� ����
'-------------------------------------------
function searchslt(gRs,slt,sltname) 
	dim	intValue,intValue2
	Dim strText,strText2
	dim tmpSelect
	dim intDoIdx

	tmpSelect = tmpSelect & "<select name='" & sltname & "' style=width:158;>"	
	do while not  gRs.eof

		intValue = gRs(0)
		strText = gRs(1)				
	if slt = intValue then
		tmpSelect = tmpSelect & " <option value='" & intValue & "' selected>" & strText & "</option>"
	else
		tmpSelect = tmpSelect & " <option value='" & intValue & "' >" & strText & "</option>"
	end if
		gRs.movenext
		loop
	
	tmpSelect = tmpSelect & "</select>"		
	gRs.close		
	searchslt = tmpSelect
		
end Function

'-------------------------------------------
'����Ʈ �ڽ� ���� #2 ����Ƿڴ�������Ȳ

function searchslt_Cg(gRs,slt,sltname) 
	dim	intValue,intValue2
	Dim strText,strText2
	dim tmpSelect
	dim intDoIdx
	
	tmpSelect = tmpSelect & "<select name='" & sltname & "' >"	
	tmpSelect = tmpSelect & " <option value=0 selected>--��ü����--</option>"
	do while not  gRs.eof

		intValue = gRs(0)
		strText = gRs(1)				
	if slt = intValue Then
		tmpSelect = tmpSelect & " <option value='" & intValue & "' selected >" & strText & "</option>"
	else
		tmpSelect = tmpSelect & " <option value='" & intValue & "' >" & strText & "</option>"
	end if
		gRs.movenext
		loop
	
	tmpSelect = tmpSelect & "</select>"		
	gRs.close		
	searchslt_Cg = tmpSelect
		
end Function

	
Function funRdoChecker(gVal,opt)
	
	Dim strRetu

	If IsEmpty(gVal) Or IsNull(gVal) Or gVal="" Then	
		gVal = 1
	End If
	
	If CInt(gVal) = opt Then
		strRetu = "checked"
	End If
	
	funRdoChecker = strRetu
End Function 	


'--------------------------------------------------------
'	�� ��: crReport Object �����Լ�
'	�� ��: 2007.04.05	
'--------------------------------------------------------
Function DestroyObjects(ByRef ObjectToDestroy)
  If isobject(ObjectToDestroy) then
    set ObjectToDestroy = nothing
    DestroyObjects = true
  Else
    DestroyObjects = false
  End if
End Function


'--------------------------------------------------------------------------------------
'			ABC UploadComponent �⺻����
'--------------------------------------------------------------------------------------
Function funcDefaultSetUpload(gUpload)
	Server.ScriptTimeout = 1000
	gUpload.AbsolutePath = True
	gUpload.Overwrite = False
	gUpload.MaxUploadSize = 84886080
End Function	

'-----------------------------------------------------------
'	���ε� ���ϱ��� üũ
'-----------------------------------------------------------
Function funUploadFile_LenChk(gFile)
	if gFile.FileExists then
		if clng(gFile.Length) >= clng(81 * 1024 * 1024) then
'			call CONN_CLOSE()
'			set gFile = nothing
'			set UploadForm = nothing
'			call ALERT_AND_GO("÷�ΰ����� �ִ� ũ�⸦ �ʰ� �Ͽ����ϴ�. \n\n�ִ� ÷�� ũ��� 80M ����Ʈ �Դϴ�.",-1)
			response.write "÷�ΰ����� �ִ� ũ�⸦ �ʰ� �Ͽ����ϴ�. \n\n�ִ� ÷�� ũ��� 80M ����Ʈ �Դϴ�"
			response.end
		end if 
	End If 
End Function 


Function UNIQUE_FILENAME(file_name, path)	 	' ���ϸ��� �ߺ� �Ǵ��� Ȯ���ϰ� �ߺ��� ��� ()�� ÷�ڸ� ���� �ߺ����� �ʴ� ���ϸ��� �����Ѵ�

	dim fso, real_path, up_file, sub_idx, filename, tmp_filename, ext, array_filename, sub_key

	up_file = ""
	sub_idx = 1

	if file_name = "" then
		FILE_UPLOAD = up_file
		exit function
	end if

	if path = "" then
		path = "./"
	end if

	set fso = server.createobject("scripting.filesystemobject")
	real_path = server.mappath(path)

	array_filename = split(file_name, ".")
	ext = array_filename(ubound(array_filename))
	filename = left(file_name, len(file_name) - (len(ext)+1))
	up_file = filename & "." & ext

	do while fso.fileexists(real_path & "\" & up_file)
		up_file = filename & "(" & sub_idx & ")." & ext
		sub_idx = sub_idx + 1
	loop

	UNIQUE_FILENAME = up_file

End Function

'-----------------------------------------------------------
'	���ε� �������� ���ε�
'-----------------------------------------------------------
Function funcUploadFile_Save(gFile,folderPath)

	Dim save_filename
	if gFile.FileExists then			
		save_filename = UNIQUE_FILENAME(gFile.SafeFileName, folderPath)
		gFile.Save server.mappath(folderPath) & "\" & save_filename	'���� ���ε�
	End If 
	funcUploadFile_Save = save_filename

End Function 

'-----------------------------------------------------------
'	���ε�� ���ϰ� �ߺ�üũ
'-----------------------------------------------------------
Function uploadedFileDuplicate_chk(folderPath,fileName)
	
	Dim FSO
	Dim returnFlag

	Set FSO = server.CreateObject("Scripting.filesystemobject")

	If FSO.FileExists(folderPath & "\" & fileName) Then
		returnFlag = False		
	Else  
		returnFlag = True 	
	End If 

	uploadedFileDuplicate_chk = returnFlag	
End Function 

'-----------------------------------------------------------
'	���ε� �������� ����
'-----------------------------------------------------------
Function funcUploadFile_Del(folderPath,gFilename)
	Dim strFullPath
	Dim fs

	strFullPath = server.mappath(folderPath) & "\" & gFilename	'������ ������ ��ü���

	Set fs = Server.CreateObject("Scripting.FileSystemObject")

	if fs.FileExists(strFullPath) Then 			
		fs.DeleteFile(strFullPath) 
	End if		
	Set fs = Nothing		
End Function 

Sub Get_Image_Size(ByVal m_filename, ByRef m_X, ByRef m_Y)
	Dim m_imgObj
	set m_imgObj = Server.CreateObject ("ImgSize.Check")
    m_imgObj.FileName = m_filename

	if m_imgObj.Error<>"" Then
		m_X=490
		m_Y=470
	Else
		m_X=m_imgObj.Width
		m_Y=m_imgObj.Height
	End If 
	
	Set m_imgObj = Nothing
End Sub

Sub ImgResize(folderPath,fileName,gWidth,gHeight,gWidthS,gHeightS)
	Dim Image
	Set Image = Server.CreateObject("Nanumi.ImagePlus")
	Image.OpenImageFile folderPath & "\" & fileName
	Image.ImageFormat = "JPG" 
	Image.OverWrite = True
	Image.ChangeSize gWidth,gHeight
	Image.SaveFile folderPath & "\" & fileName
	Image.ChangeSize gWidthS,gHeightS
	Image.SaveFile folderPath & "\s-" & fileName

	Image.Dispose
	Set Image = Nothing
End sub

Sub Download_File(ByVal m_path, ByVal m_filename)
'Jalfile ���� �ٿ�ε�
	Dim objFile
	Set objFile= Server.CreateObject("JALFile.File")
	objFile.strPath= m_path 		'max length 260 characters
	objFile.nChunkSize= 1024 	'max value 256*1024
	Response.ContentType= "application/unknown"
	Response.AddHeader "Content-Disposition","attatchment; filename="&m_filename
	objFile.BinaryWrite
	Set objFile = Nothing
End Sub

Function funcMimeTypeChk(fileNameEx)
	Dim mimeType 
	mimeType = fileNameEx.MIMEType
	If mimeType = "image/pjpeg" Or mimeType = "image/gif" Or mimeType = "image/bmp" Then
		funcMimeTypeChk = mimeType
	Else
		response.write "<script>alert('�ùٸ� ���������� �ƴմϴ�.');self.close()</script>"
		response.End 
	End If 
End Function 

Function randomleft()
    Dim headstr, bottomstr, bottomstrzero, hint, serialCode, bint 
    headstr   = "0123" '���ڸ��� ���� ���� ����
    bottomstr = "0123456789" '���ڸ��� ���� ���� ����
    bottomstrzero = "123456789" '���ڸ��� ���� ���� ���� 

    Randomize '���� �ʱ�ȭ   	

    hint = Int((4 - 1 + 1) * Rnd + 1)  ' 4�� str�� ���ڰ���
	serialCode = Mid(headstr,hint,1)
	
	If serialCode = 3 Then 
        serialCode = serialCode + "0"
	ElseIf serialCode = 0 Then 
		bint = Int((9 - 1 + 1) * Rnd + 1)  ' 10�� str�� ���ڰ���
		serialCode = serialCode + Mid(bottomstrzero,bint,1)
	Else 
		bint = Int((10 - 1 + 1) * Rnd + 1)  ' 10�� str�� ���ڰ���
		serialCode = serialCode + Mid(bottomstr,bint,1)
	End If  
   randomleft = serialCode
 End Function


 Function randomright()
    Dim headstr, bottomstr, bottomstrzero, hint, serialCode, bint 

	headstr   = "3210" '���ڸ��� ���� ���� ����
    bottomstr = "9876543210" '���ڸ��� ���� ���� ����
    bottomstrzero = "987654321" '���ڸ��� ���� ���� ���� 

    Randomize '���� �ʱ�ȭ
   	
	hint = Int((4 - 1 + 1) * Rnd + 1)  ' 4�� str�� ���ڰ���
	serialCode = Mid(headstr,hint,1)
	
	If serialCode = 3 Then 
		serialCode = serialCode + "0"
	ElseIf serialCode = 0 Then 
		bint = Int((9 - 1 + 1) * Rnd + 1)  ' 10�� str�� ���ڰ���
		serialCode = serialCode + Mid(bottomstrzero,bint,1)
	Else 
		bint = Int((10 - 1 + 1) * Rnd + 1)  ' 10�� str�� ���ڰ���
		serialCode = serialCode + Mid(bottomstr,bint,1)
	End If  
   randomright = serialCode
 End Function
%>

<SCRIPT LANGUAGE=JavaScript>
	//------------------------
	//-- ��α��� �˾�
	//------------------------
	function fnOpenPopup(w, h){
		var s = 0;		
		var winl = (screen.width - w) / 2;
		var wint = (screen.height - h) / 2;
		winprops = 'height='+h+',width='+w+',top='+wint+',left='+winl+',scrollbars='+s
		win = window.open('/user_login_frmEx_Popup.asp', 'LoginPopup', winprops)
		if (parseInt(navigator.appVersion) >= 4) { win.window.focus(); }
	}

//-->
</script>