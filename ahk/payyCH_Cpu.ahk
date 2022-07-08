#include, Gdip.ahk
CPULoad() { ; By SKAN, CD:22-Apr-2014 / MD:05-May-2014. Thanks to ejor, Codeproject: http://goo.gl/epYnkO
Static PIT, PKT, PUT                           ; http://ahkscript.org/boards/viewtopic.php?p=17166#p17166
  IfEqual, PIT,, Return 0, DllCall( "GetSystemTimes", "Int64P",PIT, "Int64P",PKT, "Int64P",PUT )

  DllCall( "GetSystemTimes", "Int64P",CIT, "Int64P",CKT, "Int64P",CUT )
, IdleTime := PIT - CIT,    KernelTime := PKT - CKT,    UserTime := PUT - CUT
, SystemTime := KernelTime + UserTime 

Return ( ( SystemTime - IdleTime ) * 100 ) // SystemTime,    PIT := CIT,    PKT := CKT,    PUT := CUT 
}

GetProcessMemoryUsage(ProcessID)
{
	static PMC_EX, size := NumPut(VarSetCapacity(PMC_EX, 8 + A_PtrSize * 9, 0), PMC_EX, "uint")

	if (hProcess := DllCall("OpenProcess", "uint", 0x1000, "int", 0, "uint", ProcessID)) {
		if !(DllCall("GetProcessMemoryInfo", "ptr", hProcess, "ptr", &PMC_EX, "uint", size))
			if !(DllCall("psapi\GetProcessMemoryInfo", "ptr", hProcess, "ptr", &PMC_EX, "uint", size))
				return (ErrorLevel := 2) & 0, DllCall("CloseHandle", "ptr", hProcess)
		DllCall("CloseHandle", "ptr", hProcess)
		return Round(NumGet(PMC_EX, 8 + A_PtrSize * 8, "uptr") / 1024**2, 2)
	}
	return (ErrorLevel := 1) & 0
}

Screenshot(outfile)
{
  pToken := Gdip_Startup()
  screen=0|0|%A_ScreenWidth%|%A_ScreenHeight%
  pBitmap := Gdip_BitmapFromScreen(screen)
  Gdip_SaveBitmapToFile(pBitmap, outfile, 100)
  Gdip_DisposeImage(pBitmap)
  Gdip_Shutdown(pToken)
}

Loop {
  cpu_load := CPULoad()
  Tooltip %cpu_load%
  Sleep, 5000 ;1000*60*3
  path_image := "screen.png"
  Screenshot(path_image)
  file := FileOpen("payy_cpu.txt", "w")
  if !IsObject(file)
  {
      MsgBox Can't open "%FileName%" for writing.
      return
  }
  Date = %A_DDDD% %A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec%
  Process, Exist, % "Asakin.exe"
  MemoryAsakin := % GetProcessMemoryUsage(ErrorLevel) " MB" 
  Process, Exist, % "RDCMan.exe"
  MemoryRDCMan := % GetProcessMemoryUsage(ErrorLevel) " MB"
  Percent := "%"
  Text = %Date% `nCPU_USAGE --> %cpu_load%%Percent%`nASAKIN_RAM_USAGE --> %MemoryAsakin%`nRDCMan_RAM_USAGE --> %MemoryRDCMan%
  file.Write(Text)
  file.Close()
  if (cpu_load >= 90){
	Runwait, taskkill /im Asakin.exe /f
	ExitApp
  }
}