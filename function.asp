 <!-- METADATA TYPE="typelib" FILE="C:\Program Files\Common Files\SYSTEM\ADO\msado15.dll" -->
<%
'============================================================================================
'			레코드셋 객체생성
'============================================================================================
Function funcRs(conn,sql)
	set funcRs	= Server.CreateObject("ADODB.RecordSet")
	set funcRs	= conn.execute(sql)
End Function

'-----------------------------------------------------------------------------------
'			커넥션 객체 닫고 없에기
'-----------------------------------------------------------------------------------
Function CONN_CLOSE(cnnDB)	
	If Not cnnDB Is Nothing Then
		If cnnDB.State = "0x00000001" Then 'adStateOpen상수 = 0x00000001'
			cnnDB.Close
		end if
	End If
	set cnnDB = nothing
End Function
'--------------------------------------------------------------------------------------
'			입력한 URL로 리다이렉션
'--------------------------------------------------------------------------------------
Function funcGoUrl(url)	
	response.write ("<META HTTP-EQUIV='refresh' Content='0; url=" & url & "'>")
End Function

'------------------------------------------------------------------------------------
'			 메세지 창 띄우고 이동(확장)
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
'			컨넥션객체로 실행
'--------------------------------------------------------------------------------------
Function funcCnnExec(conn,sql)

	funcCnnExec	= conn.Execute(sql)
End Function
'--------------------------------------------------------------------------------------
'			레코드셋 객체닫고 없에기
'--------------------------------------------------------------------------------------
Function funcRs_close(rs)
	if isobject(rs) then
		rs.close
		set	rs	= nothing
	end if
End Function
' --------------------------------------------------------------------
'	ADO Command 객체 사용
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

' Command의 Paramter를 설정할때 사용
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
'		해당년도와 월을 받아 월의 마지막 날짜를 리턴하는 함수
'--------------------------------------------------------------------------------------
Function funcSetLastDay(gYear,gMonth)
	dim dayCount
	'배열이 0부터 시작한다. dayCount(1)이 2월달을 가리킨다.
	dayCount = Array(31,28,31,30,31,30,31,31,30,31,30,31)
	if ((gYear mod 4 = 0) and not (gYear mod 100 = 0)) or (gYear mod 400 = 0) then
		dayCount(1) = 29
	end if
	funcSetLastDay = dayCount(cint(gMonth)-1)
End Function
'--------------------------------------------------------------------------------------
'
'					사용자 정의 날짜포멧
'		관련함수: func_make2Length(str)
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
			funcCustomDate = tmpYear & "년 " & tmpMonth & "월 " & tmpDay & "일 "
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
'		 한자리 숫자를 2자리로 바꾸어 준다.
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
'		일반숫자를 1000단위 구분해서 뿌려줌
'
'--------------------------------------------------------------------------------------
Function funcReplaceZero(str,mode)
	Dim retuStr
'	null 값이면 바로 리턴
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
'				<select> 박스 출력하는 함수 #2 (DB의 자원을 가지고옴)
'
'----------------------------------------------------------------------------------------------

Function funcSelect_DB(sltName,sltValue,rs,feld1,feld2,sltTitle,evnt)
	dim tmpSelect
	dim tmpFileName
	dim tmpValue
	dim optTitle

	'//	타이틀값이 있을때만 타이블을 넣어준다.
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
'					문자열 Replace
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
'	공통적으로 들어가는 인자값 받음
'-----------------------------------------------------------------------------
'	인자값 true/false로 지정
sub	funcRequest(fb,tb,fs,ts,fj,tj,dMode,fa,ta,kv,fp,tp,s1,s2,fd,fc)
	Dim arryDate
	Dim hRs
	Dim brndRs, brndSept
	'--------------------------------------------------------
	'	Form값 받는부분[공통] 및 기본값 세팅하는 부분
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
	'	날짜세팅하는 함수 콜
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
	'	자료생성시 가는 url주소 구함
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
	'	SELECTBOX 들어갈 데이터[브랜드]
	if p1 then
		strSql = "exec CT_BRAND " 
		Set rs(1) = g_Conn.Execute(strSql)
	end If
	'--------------------------------------------------------
	'	SELECTBOX 들어갈 데이터[매장]
		if p2 then
		strSql = "exec CT_AIG " 
		Set rs(2) = g_Conn.Execute(strSql)
	end if
	'--------------------------------------------------------
	'	SELECTBOX 들어갈 데이터[씨즌부터]
	if p3 then
		strSql = "exec CT_SEAN"
		Set rs(3) = g_Conn.Execute(strSql)
	end if
	'--------------------------------------------------------
	'	SELECTBOX 들어갈 데이터[씨즌까지]
	if p4 then
		strSql = "exec CT_SEAN"
		Set rs(4) = g_Conn.Execute(strSql)

	end if
	'--------------------------------------------------------
	'	SELECTBOX 들어갈 데이터[제품구분 부터]
	if p5 then
	strSql = "exec CT_JUE"
		Set rs(5) = g_Conn.Execute(strSql)
	end if

	'--------------------------------------------------------
	'	SELECTBOX 들어갈 데이터[제품구분 까지]
	if p6 then
	strSql = "exec CT_JUE"
		Set rs(6) = g_Conn.Execute(strSql)
	end if
	'--------------------------------------------------------
	'	SELECTBOX 들어갈 데이터[DN]
	if p7 then		
		strSql = "exec CT_GET_DN "
		Set rs(7) = g_Conn.Execute(strSql)
	end If
end sub



'---------------------------------------------------------------
'	셀렉트박스 레코드소스 확장판
'	f1~f2 = 레코드소스 선택하는 셀렉트박스값
'	v1~v4 = 스로트어드 프로시저에 사용되는 인자값
'	r1~r2 = 배열로 선언된 레코드소스 선택
sub funcSelectSource_ex(f1,f2,v1,v2,v3,v4,r1,r2)

	dim strSql
	'--------------------------------------------------------
	select case f1
		case 5	 
			strSql = "exec CT_warehousedivision"
			F_ipue = request("F_ipue")
		case 6
			'v1:날짜 v2:매장
			strSql = "exec  CT_GET_CID '" & v1 & "','" & v2 & "'"
		case 7		
			'v1:디자인번호문자
			strSql = "exec CT_GET_COL '" & v1 & "'"
		case 8
			'v1:디자인번호숫자
			strSql = "exec CT_GET_COLOR '" & v1 & "'"
		case 9
			'v1:날짜 v2:날짜 v3:매장 v4:매장			
			strSql = "exec CT_SALOJ '" & v1 & "','" & v2 & "','" & v3 & "','" & v4 & "'"
		case 10
			'v1:TOP 다음에들어갈 숫자값
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
'	기본 날짜값 지정
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
		case 1	'1주일간 자료			
			arryRetu(0) = dateadd("d",-7,tmpDate)
			arryRetu(1) = tmpDate
		case 2	'달 1일부터 말일까지
			arryRetu(0) = tmpYear & "-" & func_make2Length(tmpMonth) & "-" & "01"
			arryRetu(1) = tmpYear & "-" & func_make2Length(tmpMonth) & "-" & funcSetLastDay(tmpYear,tmpMonth)
		case 3	'현재월-1부터 현재까지
			arryRetu(0) = dateadd("m",-1,tmpDate)
			arryRetu(1) = tmpDate
		case 4	'달 1일부터 현재까지
			arryRetu(0) = tmpYear & "-" & func_make2Length(tmpMonth) & "-" & "01"
			arryRetu(1) = tmpDate
		case 5	'현재부터 현재까지
			arryRetu(0) = tmpDate
			arryRetu(1) = tmpDate		
		case 6	'1월1일부터 12월31일까지
			arryRetu(0) = tmpYear & "-" & "01" & "-" & "01"
			arryRetu(1) = tmpYear & "-" & "12" & "-" & "31"
		case 7	'현재날짜까지
			arryRetu(0) = ""
			arryRetu(1) = tmpDate
		case 8	'씨즌의 첫입고일
	'		arryRetu(0) = ""
	'		arryRetu(1) = tmpDate
		case 9	'어제부터 오늘까지
			arryRetu(0) = dateadd("d",-1,tmpDate)
			arryRetu(1) = tmpDate
		case 10	'현재날자로부터 12개월전 월별단위판매현황
			arryRetu(0) = ""
			If Len(tmpMonth) = 1 Then 
				arryRetu(1) = tmpYear - 1 & "-0" & tmpMonth + 1
			Else 
				arryRetu(1) = tmpYear - 1 & "-" & tmpMonth + 1
			End If 
		Case 11 '현재날자부터 24주전 주간단위판매현황
			arryRetu(0) = ""
			arryRetu(1) = DateAdd("d",-168,tmpDate)
		Case 12	'현재날자로부터 한달(30일기준)
			arryRetu(0) = DateAdd("d",-30,tmpDate)
			arryRetu(1) = tmpDate
		case 13	'년 1일부터 말일까지
			arryRetu(0) = tmpYear & "-01-01"
			arryRetu(1) = tmpDate
		case 14	'2일전부터 오늘까지
			arryRetu(0) = dateadd("d",-2,tmpDate)
			arryRetu(1) = tmpDate
		Case 15	'매장이월재고 
			arryRetu(0) = DateAdd("d",-1,DateAdd("m",0,tmpYear & "-" & tmpMonth & "-01" ))
			arryRetu(1) = tmpYear & "-" & tmpMonth & "-01"
		Case 16	'일자기간별판매현황 
			arryRetu(0) = DateAdd("d",-83,tmpDate)
			arryRetu(1) = tmpDate
		Case 17	'일자기간별판매현황 
			arryRetu(0) = DateAdd("m",-1,(tmpYear & "-" & func_make2Length(tmpMonth) & "-" & "01"))
			arryRetu(1) = DateAdd("d",-1,(tmpYear & "-" & func_make2Length(tmpMonth) & "-" & "01"))
		Case 18	'이전달 1일부터 이전달 말일까지
			arryRetu(0) = DateAdd("m",-1,(tmpYear & "-" & func_make2Length(tmpMonth) & "-" & "01"))
			arryRetu(1) = tmpYear & "-" & func_make2Length(tmpMonth-1) & "-" & funcSetLastDay(tmpYear,tmpMonth-1)
		Case 19	'1월1일부터 현재날까지
			arryRetu(0) = tmpYear & "-" & "01" & "-" & "01"
			arryRetu(1) = tmpDate

		case 20	'전달 1일부터 말일까지
			arryRetu(0) = DateAdd("m",-1,(tmpYear & "-" & func_make2Length(tmpMonth) & "-" & "01"))
			arryRetu(1) = tmpYear & "-" & func_make2Length(tmpMonth) & "-" & funcSetLastDay(tmpYear,tmpMonth)

		
		case else
			arryRetu(0) = tmpDate
			arryRetu(1) = tmpDate			
	end select

	funcSetDate = arryRetu
end function
			
'----------------------------------------------------------------------------------------------------------
'	기본 배경색 지정
'----------------------------------------------------------------------------------------------------------
Sub setColor(Tit_BGC,Gub_BGC)
	TITLE_BGCOL = Tit_BGC
	GUBUN_BGCOL = Gub_BGC   
End Sub

'-----------------------------------------------
'	종류별 최대값과 최소값을 리턴해주는 변수
'-----------------------------------------------	
function setMinMax(opt)		
	dim setArray
	select case opt
		case 1	'매장쿼리
			setArray = outPutProc("CT_GET_AIGID","r_min","r_max")
			F_aig = setArray(1)
			T_aig = setArray(2)
		case 2	'입고구분
			setArray = outPutProc("CT_GET_IPUE","r_min","r_max")
			F_ipue = setArray(1)
			T_ipue = setArray(2)					
		case else
	end select
end function

'-----------------------------------------------
'	OUTPUT변수가 선언된 프로시저 실행
'-----------------------------------------------	
function outPutProc(commandText,op1,op2)
	dim cmd	
	dim returnArray(2)
	'-------------------------------------------------------------------------
	'	Parameter DataTypeEnum 상수
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
	'	Direction 속성
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

	returnArray(1)	= cmd.parameters(op1).value		'최소값
	returnArray(2)	= cmd.parameters(op2).value		'최대값
	outPutProc = returnArray
	set cmd = nothing
end function

'-----------------------------------------------
'	SESSION체크
'-----------------------------------------------	
Function CHK_SESSION()	' 세션 상태를 체크
	dim sub_sql, sub_Rs, sub_sid
	Dim tmpUrl

	if isEmpty(GLOBALSET(1)) or GLOBALSET(1) = "" then GLOBALSET(1) = session("seSawonid") end if
	if isEmpty(GLOBALSET(2)) or GLOBALSET(2) = "" then GLOBALSET(2) = session("seSawonname") end if
	if isEmpty(GLOBALSET(4)) or GLOBALSET(4) = "" then GLOBALSET(4) = session("seItemno") end if	
    if isEmpty(GLOBALSET(5)) or GLOBALSET(5) = "" then GLOBALSET(5) = session("seUnitpriceView") end if	
    if isEmpty(GLOBALSET(7)) or GLOBALSET(7) = "" then GLOBALSET(7) = session("sePerm_ID") end if	

	If session("seSawonid") & "" = "" or session("seSawonname") & "" = "" Then			' 로그인 세션이 만료가 되었으면		
		If Request.cookies("tmpIdCookie") & "" = ""  then
			sub_sql = "exec Usp_CT_nowconnectlogdelete '" & session("seSawonid") & "','" & Session.SessionID & "'"
			g_Conn.execute(sub_sql)				' 세션아이디 레코드를 삭제
			session.contents.removeall		
			session.abandon						' 관련 세션 모두 삭제		
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
		session.abandon							' 관련 세션 모두 삭제
		'Call funcGoUrl("../default.htm")		
        ''' 로그인화면으로 가는거 막음. 2021-04-08
		''' response.write "<script type='text/javascript'> parent.parent.frames[0].location='/default.htm' </script>"			
		'------------------------------------------------------------------------------
		call CONN_CLOSE(g_Conn)

		'------------------------------------------------------
		'--// 다시 로그인하도록 팝업
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
'   중복사용자체크
'-----------------------------------------------------------------------
Function DuplicationUserCheck(pageType)
    Dim chkRS        
    If pageType = 0 Then     '0: 웹사용자            
        Set chkRS = g_Conn.execute("SELECT SawonName as CNT FROM G_Sawon WHERE sessionID = '" & session.SessionID & "'")        
        If ChkRs.eof Then   '세션아이디가 없으면 중복로그인으로 간주함
            session.contents.removeall
	        session.abandon			
            '''response.Write  "<script type='text/javascript'>alert('유효 접속시간이 초과하여 접속을 종료 합니다\n\n!!! 재로그인 하세요 !!!');parent.parent.frames[0].location='/default.htm'</script>"       
			
			'------------------------------------------------------
			'--// 다시 로그인하도록 팝업
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



Function CHK_SESSION_10()	' 세션 상태를 체크
	dim sub_sql, sub_Rs, sub_sid
	Dim tmpUrl

	if isEmpty(GLOBALSET(1)) or GLOBALSET(1) = "" then GLOBALSET(1) = session("seSawonid") end if
	if isEmpty(GLOBALSET(2)) or GLOBALSET(2) = "" then GLOBALSET(2) = session("seSawonname") end if
	if isEmpty(GLOBALSET(4)) or GLOBALSET(4) = "" then GLOBALSET(4) = session("seItemno") end if	

	If isEmpty(session("seSawonid")) Then			' 로그인 세션이 만료가 되었으면					
			session.contents.removeall		
			session.abandon						' 관련 세션 모두 삭제		
			'Call funcGoUrl("../default.htm")					
            response.write "<script type='text/javascript'> parent.parent.frames[0].location='/default.htm' </script>"
			call CONN_CLOSE(g_Conn)
			response.end
	End if
End Function




'-----------------------------------------------
'	SESSION체크
'-----------------------------------------------	
Function vFunChkSession(mode)	
	Call CHK_SESSION()

    '중복사용자체크
    Call DuplicationUserCheck(0)
    'Call CHK_SESSION_10()
End Function


'------------------------------------------------
'	메뉴작성
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
	'	기본값세팅
	intI = 1
	intJ = 1
	if not rs.eof then tmpIdx = rs("업무그룹IDX") end if

	do until rs.eof 				
		if tmpIdx <> rs("업무그룹IDX") then
			intI = intI + 1
			intJ = 1
		end if			

		arryMenu(intI,intJ) = rs("업무그룹")
		arryMenuItem(intI, intJ) = rs("업무명")
		arryFile(intI, intJ) = rs("파일명")

		intJ = intJ + 1

		tmpIdx = rs("업무그룹IDX")
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
'셀렉트 박스 생성
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
'셀렉트 박스 생성 #2 출고의뢰대비출고현황

function searchslt_Cg(gRs,slt,sltname) 
	dim	intValue,intValue2
	Dim strText,strText2
	dim tmpSelect
	dim intDoIdx
	
	tmpSelect = tmpSelect & "<select name='" & sltname & "' >"	
	tmpSelect = tmpSelect & " <option value=0 selected>--전체선택--</option>"
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
'	제 목: crReport Object 제거함수
'	날 자: 2007.04.05	
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
'			ABC UploadComponent 기본셋팅
'--------------------------------------------------------------------------------------
Function funcDefaultSetUpload(gUpload)
	Server.ScriptTimeout = 1000
	gUpload.AbsolutePath = True
	gUpload.Overwrite = False
	gUpload.MaxUploadSize = 84886080
End Function	

'-----------------------------------------------------------
'	업로드 파일길이 체크
'-----------------------------------------------------------
Function funUploadFile_LenChk(gFile)
	if gFile.FileExists then
		if clng(gFile.Length) >= clng(81 * 1024 * 1024) then
'			call CONN_CLOSE()
'			set gFile = nothing
'			set UploadForm = nothing
'			call ALERT_AND_GO("첨부가능한 최대 크기를 초과 하였습니다. \n\n최대 첨부 크기는 80M 바이트 입니다.",-1)
			response.write "첨부가능한 최대 크기를 초과 하였습니다. \n\n최대 첨부 크기는 80M 바이트 입니다"
			response.end
		end if 
	End If 
End Function 


Function UNIQUE_FILENAME(file_name, path)	 	' 파일명이 중복 되는지 확인하고 중복일 경우 ()에 첨자를 붙인 중복되지 않는 파일명을 리턴한다

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
'	업로드 파일정보 업로드
'-----------------------------------------------------------
Function funcUploadFile_Save(gFile,folderPath)

	Dim save_filename
	if gFile.FileExists then			
		save_filename = UNIQUE_FILENAME(gFile.SafeFileName, folderPath)
		gFile.Save server.mappath(folderPath) & "\" & save_filename	'파일 업로드
	End If 
	funcUploadFile_Save = save_filename

End Function 

'-----------------------------------------------------------
'	업로드된 파일과 중복체크
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
'	업로드 파일정보 삭제
'-----------------------------------------------------------
Function funcUploadFile_Del(folderPath,gFilename)
	Dim strFullPath
	Dim fs

	strFullPath = server.mappath(folderPath) & "\" & gFilename	'삭제할 파일의 전체경로

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
'Jalfile 파일 다운로드
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
		response.write "<script>alert('올바른 파일형식이 아닙니다.');self.close()</script>"
		response.End 
	End If 
End Function 

Function randomleft()
    Dim headstr, bottomstr, bottomstrzero, hint, serialCode, bint 
    headstr   = "0123" '앞자리에 사용될 랜덤 숫자
    bottomstr = "0123456789" '뒷자리에 사용될 랜덤 숫자
    bottomstrzero = "123456789" '뒷자리에 사용될 랜덤 숫자 

    Randomize '랜덤 초기화   	

    hint = Int((4 - 1 + 1) * Rnd + 1)  ' 4은 str의 문자갯수
	serialCode = Mid(headstr,hint,1)
	
	If serialCode = 3 Then 
        serialCode = serialCode + "0"
	ElseIf serialCode = 0 Then 
		bint = Int((9 - 1 + 1) * Rnd + 1)  ' 10은 str의 문자갯수
		serialCode = serialCode + Mid(bottomstrzero,bint,1)
	Else 
		bint = Int((10 - 1 + 1) * Rnd + 1)  ' 10은 str의 문자갯수
		serialCode = serialCode + Mid(bottomstr,bint,1)
	End If  
   randomleft = serialCode
 End Function


 Function randomright()
    Dim headstr, bottomstr, bottomstrzero, hint, serialCode, bint 

	headstr   = "3210" '앞자리에 사용될 랜덤 숫자
    bottomstr = "9876543210" '뒷자리에 사용될 랜덤 숫자
    bottomstrzero = "987654321" '뒷자리에 사용될 랜덤 숫자 

    Randomize '랜덤 초기화
   	
	hint = Int((4 - 1 + 1) * Rnd + 1)  ' 4은 str의 문자갯수
	serialCode = Mid(headstr,hint,1)
	
	If serialCode = 3 Then 
		serialCode = serialCode + "0"
	ElseIf serialCode = 0 Then 
		bint = Int((9 - 1 + 1) * Rnd + 1)  ' 10은 str의 문자갯수
		serialCode = serialCode + Mid(bottomstrzero,bint,1)
	Else 
		bint = Int((10 - 1 + 1) * Rnd + 1)  ' 10은 str의 문자갯수
		serialCode = serialCode + Mid(bottomstr,bint,1)
	End If  
   randomright = serialCode
 End Function
%>

<SCRIPT LANGUAGE=JavaScript>
	//------------------------
	//-- 재로그인 팝업
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