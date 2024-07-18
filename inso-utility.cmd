@echo off
::Auto-elevation en droits d'admin .
    >nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
    ) ELSE (
    >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
    )

        if '%errorlevel%' NEQ '0' (
            ::echo Demande des droits d'Administrateur .
            goto UACPrompt
        ) else ( goto gotAdmin )


        :UACPrompt
            echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
            set params= %cmdline%
            echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

            "%temp%\getadmin.vbs"
            del "%temp%\getadmin.vbs"
            exit /B

        :gotAdmin
            pushd "%CD%"
            CD /D "%~dp0"
::Fin de l'auto-elevation
@echo off
: request admin permission
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
cd "%~dp0"

:: checking if the build number is higher than 19045 to see if it's 11 and less than 10240 for any os before 10
:winver
for /f "tokens=4-6 delims=.] " %%i in ('ver') do set VERSION=%%i%%j%%k
if %version% GTR 10020348 (set osver=Windows 11 - Partly Supported) else (set osver=Windows 10 - Supported)
if %version% LSS 10010240 goto not_supported

cls
chcp 65001
mode con cols=130 lines=50
title                                                                                    Script d'optmisation automatique du système
@echo off
set w=[97m
set p=[95m
set b=[96m
set g=[92m
set z=[91m
set i=[94m
set j=[93m

echo.
echo.                                                 %j%VERSION: 1.3 - By inso.vs™
echo.                                      %g%Optimize Windows for a better gaming Experience.%w%
echo.
echo.//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
echo. %b%
echo.     ██╗       ██╗██╗███╗  ██╗██████╗  █████╗ ██╗       ██╗ ██████╗       ██╗   ██╗████████╗██╗██╗     ██╗████████╗██╗   ██╗
echo.     ██║  ██╗  ██║██║████╗ ██║██╔══██╗██╔══██╗██║  ██   ██║██╔════╝       ██║   ██║╚══██╔══╝██║██║     ██║╚══██╔══╝╚██╗ ██╔╝ 
echo.     ╚██╗████╗██╔╝██║██╔██╗██║██║  ██║██║  ██║╚██╗████╗██╔╝╚█████╗        ██║   ██║   ██║   ██║██║     ██║   ██║    ╚████╔╝  
echo.      ████╔═████║ ██║██║╚████║██║  ██║██║  ██║ ████╔═████║  ╚═══██╗       ██║   ██║   ██║   ██║██║     ██║   ██║     ╚██╔╝
echo.      ╚██╔╝ ╚██╔╝ ██║██║ ║███║██████╔╝╚█████╔╝ ╚██╔╝ ╚██╔╝ ██████╔╝       ╚██████╔╝   ██║   ██║███████╗██║   ██║      ██║
echo.       ╚═╝   ╚═╝  ╚═╝╚═╝ ╚══╝╚══════╝  ╚════╝   ╚═╝   ╚═╝  ╚═════╝         ╚═════╝    ╚═╝   ╚═╝╚══════╝╚═╝   ╚═╝      ╚═╝
echo.%w%
echo.//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
echo.
echo                                                        %g%Welcome %username%.
echo                                              %g%Current OS: %osver%
echo.
echo.
echo.    %z%          Script d'optimisation et configuration Optimale de la machine pour une utilisation Gaming/Streaming.  
echo.
echo. 
echo.
echo.    %w%                                          vous souhaitez en savoir plus ? 
echo.                     Rejoignez le Discord, et faites un Ticket je serais là pour répondres a vos questions.  
echo.
echo.
echo.
echo.              (lien de mon Discord a la fin du script sur ma page "guns.lol" ou ici: https://discord.gg/fayeECjdtb)  
echo.                     Le script est totalement GRATUIT, si quelqun te l'as vendu, c'est que tu t'es fait scam. 
echo.           Rejoignez moi sur le Discord ou sur GitHub, d'autres optimisations, Tweaks, et astuces sont ouverts a tous.  
echo.
echo.
echo.
echo.
echo.
echo. %b%appuyez (3 fois) sur une touche pour %g%demarrer%b% le script.....
timeout 500
timeout 60
timeout 30
echo.
echo.                               %b%"═══════════════════════════════════════════════════════"
echo.                               %g%                   Press for continue....
echo.                               %b%"═══════════════════════════════════════════════════════"
pause > nul
cls

prompt patientez......

cls
echo %g% -  Cleaning Useless Device Data..
chcp 437 > nul
@echo off
POWERSHELL "$Devices = Get-PnpDevice | ? Status -eq Unknown;foreach ($Device in $Devices) { &\"pnputil\" /remove-device $Device.InstanceId }"

cls
echo %g% - Setting CSRSS to Realtime (for -input lag Mouse and Keyboard)
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "4" /f 
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csrss.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "3" /f 
timeout /t 1 /nobreak > NUL  

echo %g% - Enabling 1:1 Pixel Mouse Movements
Reg.exe add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseSensitivity" /t REG_SZ /d "10" /f
timeout /t 0.5 /nobreak > NUL 

echo %g% - Reducing Keyboard Repeat Delay
Reg.exe add "HKEY_CURRENT_USER\Control Panel\Keyboard" /v "KeyboardDelay" /t REG_SZ /d "0" /f
timeout /t 1 /nobreak > NUL 

echo %b% - Increasing Keyboard Repeat Rate
Reg.exe add "HKEY_CURRENT_USER\Control Panel\Keyboard" /v "KeyboardSpeed" /t REG_SZ /d "31" /f
timeout /t 0.5 /nobreak > NUL 
:clear

echo %b% - Optimize kb/mouse latency
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d "17" /f
Reg.exe add "HKEY_CURRENT_USER\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d "17" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /h "a" /f
Reg.exe add "HKEY_CURRENT_USER\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /h "a" /f
timeout /t 0.5 /nobreak > NUL

echo %b% - Disabling Filter Keys
Reg.exe add "HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_SZ /d "0" /f
timeout /t 1 /nobreak > NUL 

echo %b% - Disabling Mouse Keys
Reg.exe add "HKEY_CURRENT_USER\Control Panel\Accessibility\MouseKeys" /v "Flags" /t REG_SZ /d "0" /f

echo %b% - Disabling Mouse Acceleration
Reg.exe add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f
timeout /t 1 /nobreak > NUL 

echo %b% - Disabling Prefetch and superfetch
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL 

cls
title                                                                                            Optmimisation du systeme en cours.......

echo %p% - Optimize global Regedit Settings..
timeout 1.5
@echo on
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "ClearPageFileAtShutdown" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "NonPagedPoolQuota" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "NonPagedPoolSize" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PagedPoolQuota" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PagedPoolSize" /t REG_DWORD /d "192" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SecondLevelDataCache" /t REG_DWORD /d "1024" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SessionPoolSize" /t REG_DWORD /d "192" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SessionViewSize" /t REG_DWORD /d "192" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "SystemPages" /t REG_DWORD /d "4294967295" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PhysicalAddressExtension" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettings" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "IoPageLockLimit" /t REG_DWORD /d "16710656" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PoolUsageMaximum" /t REG_DWORD /d "96" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Ndu" /v "Start" /t REG_DWORD /d "4" /f 
Reg.exe add "HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response" /v "BounceTime" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response" /v "DelayBeforeAcceptance" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response" /v "Last BounceKey Setting" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response" /v "Last Valid Delay" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response" /v "Last Valid Repeat" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_SZ /d "1" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BackgroundAppGlobalToggle" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_SZ /d "2" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_IrisRecommendations" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v "ScoobeSystemSettingEnabled" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.Suggested" /v "Enabled" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_SZ /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "CortanaConsent" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\EdgeUI" /v "DisableMFUTracking" /t REG_SZ /d "1" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "HasAccepted" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_SZ /d "1" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_SZ /d "1" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\KernelModeCodeIntegrity" /v "Enabled" /t REG_SZ /d "0" /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer" /v "Start" /t REG_DWORD /d "4" /f
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation" /v "Start" /t REG_DWORD /d "4" /f
reg.exe add "HKEY_CURRENT_USER\System\GameConfigStore\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d "1" /f
reg.exe add "HKEY_CURRENT_USER\System\GameConfigStore\System\GameConfigStore" /v "GameDVR_DSEBehavior" /t REG_DWORD /d "2" /f
reg.exe add "HKEY_CURRENT_USER\System\GameConfigStore\System\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d "0" /f 
reg.exe add "HKEY_CURRENT_USER\System\GameConfigStore\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f 
reg.exe add "HKEY_CURRENT_USER\System\GameConfigStore\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d "2" /f
reg.exe add "HKEY_CURRENT_USER\System\GameConfigStore\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d "2" /f 
reg.exe add "HKEY_CURRENT_USER\System\GameConfigStore\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d "1" /f 
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f 
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d "0" /f 
reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" /v "value" /t REG_DWORD /d "0" /f 
reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter" /v "ActivationType" /t REG_DWORD /d "0" /f 
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d 00000001 /f
@echo off

CLS
echo %g% - Online Games Tweak..
reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RemoteComputer\NameSpace\{D6277990-4C6A-11CF-8D87-00AA0060F5BF}]
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSMQ\Parameters" /v "TCPNoDelay" /t REG_DWORD /d "1" /f 
reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RemoteComputer\NameSpace\{D6277990-4C6A-11CF-8D87-00AA0060F5BF}]
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSMQ\Parameters" /v "TcpNoDelay" /t REG_DWORD /d "1" /f 
cls

echo %g% - delete auto start AMD Logging..
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\amdlog" /v "Start" /t REG_DWORD /d "4" /f

echo %g% - Enabling MSI Mode..
for /f %%g in ('wmic path win32_videocontroller get PNPDeviceID ^| findstr /L "VEN_"') do (
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f  
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d "0" /f 
)
timeout /t 1 /nobreak > NUL 

powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Printing-Foundation-Features -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Printing-Foundation-InternetPrinting-Client -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Printing-Foundation-LPDPrintService -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Printing-Foundation-LPRPortMonitor -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-RemoteDesktopConnection -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName HypervisorPlatform -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Tools-All -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Management-PowerShell -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Hypervisor -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Services -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Management-Clients -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Windows-Defender-ApplicationGuard -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Printing-XPSServices-Features -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName WorkFolders-Client -NoRestart"

cls
echo Disable Preemption
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisablePreemption" /t REG_DWORD /d "1" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableCudaContextPreemption" /t REG_DWORD /d "1" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "EnableCEPreemption" /t REG_DWORD /d "0" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisablePreemptionOnS3S4" /t REG_DWORD /d "1" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "ComputePreemption" /t REG_DWORD /d "0" /f 
timeout /t 1 /nobreak > NUL 

echo %j% -  Enabling MSI Mode..
for /f %%g in ('wmic path win32_videocontroller get PNPDeviceID ^| findstr /L "VEN_"') do (
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f  
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d "0" /f 
timeout /t 1 /nobreak > NUL 

echo %j% - Disabling Display Refresh Rate Override..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "3D_Refresh_Rate_Override_DEF" /t REG_DWORD /d "0" /f 
timeout /t 1 /nobreak > NUL  

echo %j% - Disabling Anti Aliasing..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "AAF_NA" /t REG_DWORD /d "0" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "AntiAlias_NA" /t REG_SZ /d "0" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "ASTT_NA" /t REG_SZ /d "0" /f 
timeout /t 1 /nobreak > NUL 

echo %j% - Disabling Subscriptions..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "AllowSubscription" /t REG_DWORD /d "0" /f 
timeout /t 1 /nobreak > NUL 

echo %j% - Disabling Radeon Overlay..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "AllowRSOverlay" /t REG_SZ /d "false" /f  
timeout /t 1 /nobreak > NUL 

echo %j% - Disabling timer coalescing..
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL 

echo %j% - Disabling fast startup..
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL  

echo %j% - Disabling Skins..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "AllowSkins" /t REG_SZ /d "false" /f  
timeout /t 1 /nobreak > NUL 

echo %j% - Disabling hibernation..
reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabled" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL 

echo %j% - Disabling SnapShot..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "AllowSnapshot" /t REG_DWORD /d "0" /f 
timeout /t 1 /nobreak > NUL

echo %j% - Disabling Automatic Color Depth Reduction..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "AutoColorDepthReduction_NA" /t REG_DWORD /d "0" /f 
timeout /t 1 /nobreak > NUL

echo %p% - Disabling Power Gating..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableSAMUPowerGating" /t REG_DWORD /d "1" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableUVDPowerGatingDynamic" /t REG_DWORD /d "1" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableVCEPowerGating" /t REG_DWORD /d "1" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisablePowerGating" /t REG_DWORD /d "1" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "DisableDrmdmaPowerGating" /t REG_DWORD /d "1" /f 
 
echo %p% - Disabling Clock Gating..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableVceSwClockGating" /t REG_DWORD /d "1" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableUvdClockGating" /t REG_DWORD /d "1" /f 

echo %p% - Disabling Active State Power Management..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableAspmL0s" /t REG_DWORD /d "0" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableAspmL1" /t REG_DWORD /d "0" /f 

echo %p% - Disabling Ultra Low Power States..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableUlps" /t REG_DWORD /d "0" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "EnableUlps_NA" /t REG_SZ /d "0" /f 

echo %p% - Enabling De-Lag..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_DeLagEnabled" /t REG_DWORD /d "1" /f 
timeout /t 1 /nobreak > NUL 

echo %p% - Disabling Frame Rate Target..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "KMD_FRTEnabled" /t REG_DWORD /d "0" /f 

echo %b% - Disabling GPU Memory Clock Sleep State..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PP_SclkDeepSleepDisable" /t REG_DWORD /d "1" /f 
timeout /t 1 /nobreak > NUL 

echo %b% - Disabling Thermal Throttling..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PP_ThermalAutoThrottlingEnable" /t REG_DWORD /d "0" /f 

echo %w% - Disabling GPU Power Down..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "PP_GPUPowerDownEnabled" /t REG_DWORD /d "1" /f 

echo %w% - Disabling AMD Logging..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\amdlog" /v "Start" /t REG_DWORD /d "4" /f 
timeout /t 1 /nobreak > NUL

cls

echo %g% - Disabling Windows settings synchronization..
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" /v "SyncPolicy" /t REG_DWORD /d "5" /f 
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSync" /t REG_DWORD /d "2" /f 
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSyncUserOverride" /t REG_DWORD /d "1" /f 
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSyncOnPaidNetwork" /t REG_DWORD /d "1" /f

echo %i% - Disabling SmartScreen..
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f 
reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f 
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL

echo %b% - Disabling mouse acceleration..
reg.exe add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseSensitivity" /t REG_SZ /d "10" /f 
reg.exe add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f 
reg.exe add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f 
reg.exe add "HKEY_CURRENT_USER\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f  
timeout /t 1 /nobreak > NUL

)

cls
echo %b% - Disabling USB PowerSavings..
for /f %%i in ('wmic path Win32_USBController get PNPDeviceID^| findstr /l "PCI\VEN_"') do (
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters" /v "AllowIdleIrpInD3" /t REG_DWORD /d "0" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters" /v "D3ColdSupported" /t REG_DWORD /d "0" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters" /v "DeviceSelectiveSuspended" /t REG_DWORD /d "0" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters" /v "EnableSelectiveSuspend" /t REG_DWORD /d "0" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters" /v "EnhancedPowerManagementEnabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters" /v "SelectiveSuspendEnabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\%%i\Device Parameters" /v "SelectiveSuspendOn" /t REG_DWORD /d "0" /f 
)
timeout /t 1 /nobreak > NUL 

echo %b% - Thread Priority..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\usbxhci\Parameters" /v "ThreadPriority" /t REG_DWORD /d "31" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v "ThreadPriority" /t REG_DWORD /d "31" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters" /v "ThreadPriority" /t REG_DWORD /d "31" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NDIS\Parameters" /v "ThreadPriority" /t REG_DWORD /d "31" /f
timeout /t 1 /nobreak > NUL

echo %b% - Disabling USB Selective Suspend..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USB" /v "DisableSelectiveSuspend" /t REG_DWORD /d "1" /f 
timeout /t 1 /nobreak > NUL 

echo %b% - Enabing MSI mode on usb..
for /f %%i in ('wmic path Win32_USBController get PNPDeviceID') do set "str=%%i" & (
echo.DEL USB Device Priority %b%
Reg.exe add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /f
echo.Enable MSI Mode on USB %b%
Reg.exe add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f
)

echo %b% - USB Msi Priority..
for /f %%i in ('wmic path Win32_IDEController get PNPDeviceID 2^>nul') do set "str=%%i" & if "!str:PCI\VEN_=!" neq "!str!" (
echo %w%- DEL Sata controllers Device Priority %b%
Reg.exe add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Enum\%%i\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /f

echo %b% - Disabling Energy Logging + Power Telemetry..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "DisableTaggedEnergyLogging" /t REG_DWORD /d "1" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "TelemetryMaxApplication" /t REG_DWORD /d "0" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "TelemetryMaxTagPerApplication" /t REG_DWORD /d "0" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\2a737441-1930-4402-8d77-b2bebba308a3\d4e98f31-5ffe-4ce1-be31-1b38b384c009\DefaultPowerSchemeValues\381b4222-f694-41f0-9685-ff5bb260df2e" /v "ACSettingIndex" /t REG_DWORD /d "0" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\2a737441-1930-4402-8d77-b2bebba308a3\d4e98f31-5ffe-4ce1-be31-1b38b384c009\DefaultPowerSchemeValues\381b4222-f694-41f0-9685-ff5bb260df2e" /v "DCSettingIndex" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\2a737441-1930-4402-8d77-b2bebba308a3\d4e98f31-5ffe-4ce1-be31-1b38b384c009\DefaultPowerSchemeValues\8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c" /v "ACSettingIndex" /t REG_DWORD /d "0" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb\DefaultPowerSchemeValues\381b4222-f694-41f0-9685-ff5bb260df2e" /v "ACSettingIndex" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb\DefaultPowerSchemeValues\381b4222-f694-41f0-9685-ff5bb260df2e" /v "ADCSettingIndex" /t REG_DWORD /d "0" /f  
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb\DefaultPowerSchemeValues\8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c" /v "ACSettingIndex" /t REG_DWORD /d "0" /f 

timeout /t 1 /nobreak > NUL 

cls
echo %b%- Disable Idle Power Managment..
for /f "tokens=*" %%i in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum" /s /f "StorPort"^| findstr "StorPort"') do Reg.exe add "%%i" /v "EnableIdlePowerManagement" /t REG_DWORD /d "0" /f
    for %%i in (EnableHIPM EnableDIPM EnableHDDParking) do for /f %%a in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services" /s /f "%%i" ^| findstr "HKEY"') do Reg.exe add "%%a" /v "%%i" /t REG_DWORD /d "0" /f 
    )

echo %b%- Disable Link State Power Managment..
FOR /F "eol=E" %%a in ('REG QUERY "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services" /s "EnableHIPM"^| FINDSTR /V "EnableHIPM"') DO (
Reg.exe add "%%a" /v "EnableHIPM" /t REG_DWORD /d "0" /f  > nul 
Reg.exe add "%%a" /v "EnableDIPM" /t REG_DWORD /d "0" /f > nul 
FOR /F "tokens=*" %%z IN ("%%a") DO (
SET STR=%%z
SET STR=!STR:HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\=!
) > nul  
)

CLS
	
echo %b% - Disabling GPU Energy Driver..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d "4" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\GpuEnergyDr" /v "Start" /t REG_DWORD /d "4" /f 
timeout /t 1 /nobreak > NUL 
CLS

echo %g% - Hardware Accelerated GPU Scheduling..
reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d "2" /f
timeout /t 1 /nobreak > NUL

echo %g% - Disabling CoalescingTimerInterval..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\ModernSleep" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v "PlatformAoAcOverride" /t REG_DWORD /d "0" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v "EnergyEstimationEnabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v "EventProcessorEnabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v "CsEnabled" /t REG_DWORD /d "0" /f 
timeout /t 1 /nobreak > NUL 

echo %g% - Disabling Power Throttling..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "1" /f 
timeout /t 1 /nobreak > NUL 

cls
echo %z% - Deleting useless power plans..
timeout /t 1 /nobreak > NUL 
powercfg -delete 381b4222-f694-41f0-9685-ff5bb260df2e
powercfg -delete 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
powercfg -delete 94e50ae8-2cda-4d3b-9ac2-18ab7dd8ac01
powercfg -delete a1841308-3541-4fab-bc81-f71556f20b4a

echo %z% - Disable Nagiles algorithm (enable tcpnodelay)..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TcpAckFrequency" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TCPNoDelay" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TcpDelAckTicks" /t REG_DWORD /d "0" /f

echo %z% - Disabling Fast Startup..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d "0" /f 
timeout /t 1 /nobreak > NUL 

echo %z% - Disabling Hibernation..
powercfg /h off
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabled" /t REG_DWORD /d "0" /f 
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v "SleepReliabilityDetailedDiagnostics" /t REG_DWORD /d "0" /f 
timeout /t 1 /nobreak > NUL 

echo %z% - Disabling Sleep Study..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "SleepStudyDisabled" /t REG_DWORD /d "1" /f 
timeout /t 1 /nobreak > NUL 

echo %z% - Disable Dynamic Tick..
bcdedit /set disabledynamictick yes >nul 2>&1
timeout /t 1 /nobreak > NUL 

echo %p% - Disable High Precision Event Timer (HPET)..
bcdedit /deletevalue useplatformclock  >nul 2>&1
timeout /t 1 /nobreak > NUL
chcp 65001
@echo off         
title                                                                                                               By inso.vs 
cls 

echo. %g% Created By
echo.
echo %j%██╗███╗  ██  ██████╗  █████╗    
echo %j%██║████╗ ██ ██╔════╝ ██╔══██╗      
echo %j%██║██╔██╗██ ╚█████╗  ██║  ██║    
echo %j%██║██║╚████  ╚═══██╗ ██║  ██║     
echo %j%██║██║ ║███ ██████╔╝ ╚█████╔╝ ██  vs
echo %j%╚═╝╚═╝ ╚══╝ ╚═════╝   ╚════╝       
echo.
echo %g%!! si tu as payez pour ce script sache que tu t'es fait %z%SCAM..
echo. %b%"═══════════════════════════════════════════════════════"
echo. %w%             Press any key to continue.....
echo. %b%"═══════════════════════════════════════════════════════"
pause > nul
cls

echo %p% - Disable Synthetic Timers..
bcdedit /set useplatformtick yes  >nul 2>&1
timeout /t 1 /nobreak > NUL 

echo %p% - MMCSS Priority For Low Latency..
timeout /t 2 /nobreak > NUL 
@echo on
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Affinity" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Background Only" /t REG_SZ /d "False" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "BackgroundPriority" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Clock Rate" /t REG_DWORD /d "10000" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "GPU Priority" /t REG_DWORD /d "8" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Priority" /t REG_DWORD /d "2" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Scheduling Category" /t REG_SZ /d "Medium" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "SFIO Priority" /t REG_SZ /d "High" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Latency Sensitive" /t REG_SZ /d "True" /f
timeout /t 1 /nobreak > nul 
@echo off
cls

echo %p% - MMCSS Priority For Games..
timeout /t 2 /nobreak > NUL 
@echo on
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "BackgroundPriority" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d "10000" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d "8" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "2" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Latency Sensitive" /t REG_SZ /d "True" /f
timeout /t 1 /nobreak > nul 
@echo off
cls

echo %p% - Setting Win32Priority..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "38" /f 

echo %p% - Disabling VirtualizationBasedSecurity..
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d "0" /f 

echo %p% - Disabling HVCIMATRequired..
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "HVCIMATRequired" /t REG_DWORD /d "0" /f 

echo %j% - Disabling Sehop..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "KernelSEHOPEnabled" /t REG_DWORD /d "0" /f  

echo %j% - Disabling CFG..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "EnableCfg" /t REG_DWORD /d "0" /f 

echo %j% - Disabling Protection Mode..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager" /v "ProtectionMode" /t REG_DWORD /d "0" /f 
timeout /t 1 /nobreak > NUL 

echo %g% - IRQ8 Priority ..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ8Priority" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\PriorityControl" /v "IRQ8Priority" /t REG_DWORD /d "1" /f

echo %g% - IRQ16 Priority ..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ16Priority" /t REG_DWORD /d "2" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\PriorityControl" /v "IRQ16Priority" /t REG_DWORD /d "2" /f
timeout /t 1 /nobreak > NUL 

cls
echo %g% - Disable Prefetch and superfetch ..
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d "0" /f

echo %b% - Decrease processes kill time and menu show delay ..
Reg.exe add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f
Reg.exe add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "HungAppTimeout" /t REG_SZ /d "1000" /f
Reg.exe add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "WaitToKillAppTimeout" /t REG_SZ /d "2000" /f
Reg.exe add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "LowLevelHooksTimeout" /t REG_SZ /d "1000" /f
Reg.exe add "HKEY_CURRENT_USER\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\SYSTEM\CurrentControlSet\Control" /v "WaitToKillServiceTimeout" /t REG_SZ /d "2000" /f 
timeout /t 2 /nobreak > nul
cls
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\943c8cb6-6f93-4227-ad87-e9a3feec08d1" /v "Attributes" /t REG_DWORD /d "2" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINESystemCurrentControlSetControlDeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d "2" /f
Reg.exe add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d "2" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d "fffffff" /f
Reg.exe add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoInstrumentation" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoInstrumentation" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d "1" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "ThreadDpcEnable" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Control Panel\Keyboard" /v "KeyboardDelay" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_USERS\.DEFAULT\Control Panel\Keyboard" /v "KeyboardDelay" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Control Panel\Accessibility\MouseKeys" /v "Flags" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_CURRENT_USER\Control Panel\Accessibility\ToggleKeys" /v "Flags" /t REG_DWORD /d "0" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d "2" /f
timeout /t 1 /nobreak > nul
@echo off

echo %b% - Setting System Responsiveness..
Reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "0" /f 

echo %b% - CPU Power Settings..
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\be337238-0d82-4146-a960-4f3749d470c7" /v "Attributes" /t "REG_DWORD" /d "2" /f
timeout /t 1 /nobreak > nul

echo %b% - NtfsDisableLastAccessUpdate..
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /v "NtfsDisableLastAccessUpdate" /t "REG_DWORD" /d "1" /f

echo %b% - NetFX3 USB Install..
Dism /online /enable-feature /featurename:"NetFX3" /All /Source:"D:\sources\sxs" /LimitAccess

cls
echo %g% - Disabling unused features...
dism /online /disable-feature /featurename:"MicrosoftWindowsPowerShellV2Root" /norestart
dism /online /disable-feature /featurename:"MediaPlayback" /norestart
dism /online /disable-feature /featurename:"WorkFolders-Client" /norestart
dism /online /disable-feature /featurename:"Printing-Foundation-LPRPortMonitor" /norestart
dism /online /disable-feature /featurename:"Printing-Foundation-InternetPrinting-Client" /norestart
dism /online /disable-feature /featurename:"RemoteAssistance" /norestart

echo %j% - Disable Windows Tips..
reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableSoftLanding" /t "REG_DWORD" /d "1" /f
reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsSpotlightFeatures" /t "REG_DWORD" /d "1" /f
reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t "REG_DWORD" /d "1" /f
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t "REG_DWORD" /d "1" /f

echo %j% - Disable Windows Feedback..
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t "REG_DWORD" /d "0" /f
reg delete "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /f

echo %j% - Disable Experimentation..
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowExperimentation" /v "value" /t "REG_DWORD" /d "0" /f

echo %b% - Disabling devices power saving.. 
POWERSHELL.exe "$devices = Get-WmiObject Win32_PnPEntity; $powerMgmt = Get-WmiObject MSPower_DeviceEnable -Namespace root\wmi; foreach ($p in $powerMgmt){$IN = $p.InstanceName.ToUpper(); foreach ($h in $devices){$PNPDI = $h.PNPDeviceID; if ($IN -like \"*$PNPDI*\"){$p.enable = $False; $p.psbase.put()}}}"
cls

echo %g% - Debloat en cours....
timeout /t 4 /nobreak > nul

echo %g% - Power Automate
powershell -command "Get-AppxPackage *Microsoft.PowerAutomateDesktop* | Remove-AppxPackage"

echo %p% - People
powershell -command "Get-AppxPackage *Microsoft.People* | Remove-AppxPackage"

echo %z% - Actualités
powershell -command "Get-AppxPackage *Microsoft.bingNews* | Remove-AppxPackage"

echo %b% - Assistance rapide
powershell -command "Get-AppxPackage *MicrosoftCorporationII.QuickAssist* | Remove-AppxPackage"

echo %w% - Outlook
powershell -command "Get-AppxPackage *Microsoft.OutlookForWindows* | Remove-AppxPackage"

echo %j% - DevHome
powershell -command "Get-AppxPackage *Microsoft.Windows.DevHome* | Remove-AppxPackage"

echo %g% - WebpImageExtension
powershell -command "Get-AppxPackage *Microsoft.WebpImageExtension* | Remove-AppxPackage"

echo %p% - RawImageExtension
powershell -command "Get-AppxPackage *Microsoft.RawImageExtension* | Remove-AppxPackage"

echo %j% - HEIFImageExtension
powershell -command "Get-AppxPackage *Microsoft.HEIFImageExtension* | Remove-AppxPackage"

echo %z% - Windows Tips
powershell -command "Get-AppxPackage *GetStarted* | Remove-AppxPackage"

echo %b% - Calculatrices
powershell -command "Get-AppxPackage *windowscalculator* | Remove-AppxPackage"

echo %p% - Cartes
powershell -command "Get-AppxPackage *windowsmaps* | Remove-AppxPackage"

echo %z% - Cortana
powershell -command "Get-AppxPackage *Microsoft.549981C3F5F10* | Remove-AppxPackage"

echo %j% - Courrier et calendrier
powershell -command "Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage"

echo %p% - Enregistreur vocal
powershell -command "Get-AppxPackage *SoundRecorder* | Remove-AppxPackage"

echo %z% - Film et TV
powershell -command "Get-AppxPackage *ZuneVideo* | Remove-AppxPackage"

echo %g% - Horloge
powershell -command "Get-AppxPackage *Microsoft.WindowsAlarms* | Remove-AppxPackage"

echo %w% - Hub de commentaire
powershell -command "Get-AppxPackage *WindowsFeedbackHub* | Remove-AppxPackage"

echo %b% - Météo
powershell -command "Get-AppxPackage *BingWeather* | Remove-AppxPackage"

echo %p% - Microsoft 365 (office)
powershell -command "Get-AppxPackage *OfficeHub* | Remove-AppxPackage"
timeout /t 1 /nobreak > nul

echo %g% - Microsoft Clipchamp
powershell -command "Get-AppxPackage *Clipchamp* | Remove-AppxPackage"

echo %j% - Microsoft Teams
powershell -command "Get-AppxPackage *Teams* | Remove-AppxPackage"

echo %z% - Microsoft To Do
powershell -command "Get-AppxPackage *ToDo* | Remove-AppxPackage"

echo %p% - Mobile connecté
powershell -command "Get-AppxPackage *YourPhone* | Remove-AppxPackage"

echo %w% - Obtenir de l'aide
powershell -command "Get-AppxPackage *GetHelp* | Remove-AppxPackage"

echo %g% - Pense-bêtes
powershell -command "Get-AppxPackage *Microsoft.MicrosoftStickyNotes* | Remove-AppxPackage"

echo %z% - Realteck Audio Console
powershell -command "Get-AppxPackage *RealtekAudioConsole* | Remove-AppxPackage"

echo %j% - Solitaire & Casual Games
powershell -command "Get-AppxPackage *MicrosoftSolitaireCollection* | Remove-AppxPackage"

echo %p% - Xbox Game Bar
powershell -command "Get-AppxPackage *XboxGamingOverlay* | Remove-AppxPackage"

echo %z% - Xbox Speech Windows
powershell -command "Get-AppxPackage *XboxSpeech* | Remove-AppxPackage"
timeout /t 1 /nobreak > nul

cls
echo %g% - Delete useless apps..
powershell -command "Get-AppxPackage *Microsoft.PowerAutomateDesktop* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *Microsoft.People* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *Microsoft.bingNews* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *MicrosoftCorporationII.QuickAssist* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *Microsoft.OutlookForWindows* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *Microsoft.Windows.DevHome* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *Microsoft.WebpImageExtension* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *Microsoft.RawImageExtension* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *Microsoft.HEIFImageExtension* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *GetStarted* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *windowsmaps* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *Microsoft.549981C3F5F10* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *HEVC* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *ZuneVideo* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *WindowsFeedbackHub* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *Microsoft.ZuneMusic* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *BingWeather* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *OfficeHub* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *Clipchamp* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *Teams* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *ToDo* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *YourPhone* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *GetHelp* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *Microsoft.MicrosoftStickyNotes* | Remove-AppxPackage"
powershell -command "Get-AppxPackage *MicrosoftSolitaireCollection* | Remove-AppxPackage"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Printing-Foundation-Features -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Printing-Foundation-InternetPrinting-Client -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Printing-Foundation-LPDPrintService -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Printing-Foundation-LPRPortMonitor -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-RemoteDesktopConnection -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName HypervisorPlatform -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Tools-All -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Management-PowerShell -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Hypervisor -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Services -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-Management-Clients -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Windows-Defender-ApplicationGuard -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName Printing-XPSServices-Features -NoRestart"
powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName WorkFolders-Client -NoRestart"
powershell -Command "Disable-NetAdapterBinding -Name * -ComponentID ms_server"
powershell -Command "Disable-NetAdapterBinding -Name * -ComponentID ms_msclient"  
@echo off

echo %w% - Disable Xbox Speech Windows..
powershell -command "Get-AppxPackage *XboxSpeech* | Remove-AppxPackage"

cls
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
timeout /t 1 /nobreak > nul
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61
timeout /t 1 /nobreak > nul
powercfg -attributes 2a737441-1930-4402-8d77-b2bebba308a3 d4e98f31-5ffe-4ce1-be31-1b38b384c009 -ATTRIB_HIDE
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 465e1f50-b610-473a-ab58-00d1077dc418 -ATTRIB_HIDE
powercfg -attributes  54533251-82be-4824-96c1-47b60b740d00 619b7505-003b-4e82-b7a6-4dd29c300971 -ATTRIB_HIDE
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 be337238-0d82-4146-a960-4f3749d470c7 -ATTRIB_HIDE
powercfg -attributes 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e -ATTRIB_HIDE
powercfg /changename e9a42b02-d5df-448d-aa00-03f14749eb61 "Performances optimales V2 - @inso.vs" "Déblocages de certains paramètres "important" inaccessibles en temps normal."
powercfg -hibernate off
timeout /t 1 /nobreak > nul

CLS
setlocal EnableDelayedExpansion
schtasks /change /tn "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable
schtasks /change /tn "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable
schtasks /change /tn "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable
schtasks /change /tn "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable

endlocal

echo %b% - Kill Foreground
taskkill /F /IM "MicrosoftEdge.exe" 1>NUL 2>NUL

echo %b% - Uninstall OneDrive;..
taskkill /F /IM "OneDrive.exe" 1>NUL 2>NUL
%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall 1>NUL 2>NUL

if exist "%systemroot%\System32\OneDriveSetup.exe" (
    "%systemroot%\System32\OneDriveSetup.exe" /uninstall
)
if exist "%systemroot%\SysWOW64\OneDriveSetup.exe" (
    "%systemroot%\SysWOW64\OneDriveSetup.exe" /uninstall
)

rd "%UserProfile%\OneDrive" /Q /S 1>NUL 2>NUL
rd "%LocalAppData%\Microsoft\OneDrive" /Q /S 1>NUL 2>NUL
rd "%ProgramData%\Microsoft OneDrive" /Q /S 1>NUL 2>NUL
rd "C:\OneDriveTemp" /Q /S 1>NUL 2>NUL
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v OneDriveSetup /f
del "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk" /f

echo %g%Désinstallation de Microsoft Edge..

powershell -command "Get-AppxPackage *Microsoft.MicrosoftEdge.Stable* | Remove-AppxPackage"

winget uninstall Microsoft.Edge --accept-source-agreements --disable-interactivity

echo %g%Désinstallation de Microsoft Edge...
start /wait /min "" wmic product where "name like 'Microsoft Edge%%'" call uninstall /nointeractive
echo Microsoft Edge a été désinstallé

echo %g%Désactivation de Microsoft Edge...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "AuditDisabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "UpdateDefault" /t REG_DWORD /d 0 /f >nul 2>&1
echo Microsoft Edge a été désactivé
cls

echo %b%Désactivation des tâches planifiées Microsoft Edge Update...
schtasks /change /tn "Microsoft\MicrosoftEdge\Update\MicrosoftEdgeUpdateTaskMachineUA" /disable >nul 2>&1
schtasks /change /tn "Microsoft\MicrosoftEdge\Update\MicrosoftEdgeUpdateTaskMachineCore" /disable >nul 2>&1
schtasks /change /tn "MicrosoftEdgeUpdateTaskMachineCore{AED49F43-D410-426C-98B5-931A5CD45EED}" /disable
schtasks /change /tn "MicrosoftEdgeUpdateTaskMachineUA{97D554FE-B2D7-4761-9ADD-90722C8D1638}" /disable
echo Les tâches planifiées Microsoft Edge Update ont été désactivées .
cls

echo %g%Merci de patienter un instant ....

endlocal

echo %b% - Delete "Microsoft Edge" shortcut from Desktop
del /f /q "C:\Users\%USERNAME%\Desktop\Microsoft Edge.lnk" 1>NUL 2>NUL

echo %b% - Delete "Your Phone" shortcut from Desktop
del /f /q "C:\Users\%USERNAME%\Desktop\Your Phone.lnk" 1>NUL 2>NUL

echo %b% - Disable Services..
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushsvc" /v "Start" /t REG_DWORD /d "4" /f 1>NUL 2>NUL
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f 1>NUL 2>NUL
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PeerDistSvc" /v "Start" /t REG_DWORD /d "4" /f 1>NUL 2>NUL

echo %j% - Enable Developer mode..
::reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /v "AllowDevelopmentWithoutDevLicense" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
::reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /v "AllowAllTrustedApps" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

echo %j% - Change Folder options..
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowStatusBar" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

echo %j% - Enable Peek at desktop..
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisablePreviewDesktop" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

echo %j% - Disable Windows Defender SmartScreen Filter..
reg add "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

cls
mode con cols=125 lines=32

echo %g% - Disable all Content Delivery Manager features..
timeout /t 1 /nobreak > nul
@echo on
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "FeatureManagementEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RemediationRequired" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314563Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
@echo off
timeout /t 1 /nobreak > nul

cls
echo %b% - Disable all suggested apps..
timeout /t 1 /nobreak > nul
@echo on
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "22StokedOnIt.NotebookPro_ffs55s3hze5sr" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "2FE3CB00.PicsArt-PhotoStudio_crhqpqs3x1ygc" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "41038Axilesoft.ACGMediaPlayer_wxjjre7dryqb6" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "5CB722CC.SeekersNotesMysteriesofDarkwood_ypk0bew5psyra" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "7458BE2C.WorldofTanksBlitz_x4tje2y229k00" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "828B5831.HiddenCityMysteryofShadows_ytsefhwckbdv6" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "828B5831.TheSecretSociety-HiddenMystery_ytsefhwckbdv6" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "89006A2E.AutodeskSketchBook_tf1gferkr813w" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "9E2F88E3.Twitter_wgeqdkkx372wm" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "A278AB0D.AsphaltStreetStormRacing_h6adky7gbf63m" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "A278AB0D.DisneyMagicKingdoms_h6adky7gbf63m" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "A278AB0D.DragonManiaLegends_h6adky7gbf63m" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "A278AB0D.MarchofEmpires_h6adky7gbf63m" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "AdobeSystemsIncorporated.PhotoshopElements2018_ynb6jyjzte8ga" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "CAF9E577.Plex_aam28m9va5cke" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "DolbyLaboratories.DolbyAccess_rz1tebttyb220" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Drawboard.DrawboardPDF_gqbn7fs4pywxm" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Expedia.ExpediaHotelsFlightsCarsActivities_0wbx8rnn4qk5c" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Facebook.317180B0BB486_8xx8rvfyw5nnt" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Facebook.Facebook_8xx8rvfyw5nnt" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Facebook.InstagramBeta_8xx8rvfyw5nnt" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Fitbit.FitbitCoach_6mqt6hf9g46tw" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "flaregamesGmbH.RoyalRevolt2_g0q0z3kw54rap" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "GAMELOFTSA.Asphalt8Airborne_0pp20fcewvvtj" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "king.com.BubbleWitch3Saga_kgqvnymyfvs32" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "king.com.CandyCrushSaga_kgqvnymyfvs32" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "king.com.CandyCrushSodaSaga_kgqvnymyfvs32" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.AgeCastles_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.BingNews_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.BingSports_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.BingWeather_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "microsoft.microsoftskydrive_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.MicrosoftSolitaireCollection_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.MinecraftUWP_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Microsoft.MSPaint_8wekyb3d8bbwe" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "NAVER.LINEwin8_8ptj331gd3tyt" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "Nordcurrent.CookingFever_m9bz608c1b9ra" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "SiliconBendersLLC.Sketchable_r2kxzpx527qgj" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "SpotifyAB.SpotifyMusic_zpdnekdrzrea0" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "ThumbmunkeysLtd.PhototasticCollage_nfy108tqq3p12" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "USATODAY.USATODAY_wy7mw3214mat8" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /v "WinZipComputing.WinZipUniversal_3ykzqggjzj4z0" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
@echo off

cls
echo %b% - Disable Gamebar..
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\GameBar" /v "UseNexusForGameBarEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AudioCaptureEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "CursorCaptureEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "MicrophoneCaptureEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

echo %z% - Disable Game Mode..
reg add "HKCU\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

echo %z% - Disable Aero Shake..
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisallowShaking" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

echo %z% - Disable "Look for an app in the Store" dialogue..
reg add "HKLM\Software\Policies\Microsoft\Windows\Explorer" /v "NoUseStoreOpenWith" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

echo %z% - Disable "Windows protected your PC" dialogue..
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v "SaveZoneInformation" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

echo %z% - Disable Error Reporting..
reg add "HKLM\Software\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

echo %z% - Keep thumbnail cache upon Restart..
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Thumbnail Cache" /v "Autorun" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Thumbnail Cache" /v "Autorun" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
timeout /t 1 /nobreak > nul

echo %g% - Disable Cortana..
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Windows Search" /v "CortanaConsent" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "DisableVoice" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

echo %g% - Remove "Open PowerShell window here" from Shift+Right-click context menus..
reg delete "HKCR\Directory\shell\Powershell" /f 1>NUL 2>NUL
reg delete "HKCR\Directory\Background\shell\Powershell" /f 1>NUL 2>NUL

echo %w% - Disable wide context menu..
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\FlightedFeatures" /v "ImmersiveContextMenu" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

cls
title                                                                                            Optmimisation du systeme en cours...
chcp 65001
mode con cols=125 lines=32

echo %w% - Remove 3D Objects from This PC..
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f 1>NUL 2>NUL
reg delete "HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f 1>NUL 2>NUL

echo %w% - Disable search history in File Explorer..
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "DisableSearchBoxSuggestions" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

echo %w% - Remove OneDrive from Navigation Pane..
reg add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

echo %w% - Remove external drives from Navigation Pane..
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\DelegateFolders\{F5FB2C77-0E2F-4A16-A381-3E560C68BC83}" /f 1>NUL 2>NUL

echo %w% - Disable suggested apps Windows Ink WorkSpace..
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PenWorkspace" /v "PenWorkspaceAppSuggestionsEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Classes\CLSID\{679f85cb-0220-4080-b29b-5540cc05aab6}" /v "AllowSuggestedAppsInWindowsInkWorkspace" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

echo %w% - Disable Sharing of handwriting data..
reg add "HKLM\Software\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
timeout /t 1 /nobreak > nul

echo %w% - Disable Sharing of handwriting error reports..
reg add "HKLM\Software\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

echo %w% - Disable Inventory Collector..
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v "DisableInventory" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

echo %w% - Disable Microsoft conducting experiments with this machine..
reg add "HKLM\Software\Microsoft\PolicyManager\current\device\System" /v "AllowExperimentation" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

echo %w% - Disable advertisements via Bluetooth..
reg add "HKLM\Software\Microsoft\PolicyManager\current\device\Bluetooth" /v "AllowAdvertising" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

echo %w% - Disable tracking of application startups.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

echo %w% - Disable telemetry..
reg add "HKLM\SYSTEM\ControlSet001\Services\DiagTrack" /v "Start" /t REG_DWORD /d "4" /f 1>NUL 2>NUL
reg add "HKLM\SYSTEM\ControlSet001\Services\dmwappushservice" /v "Start" /t REG_DWORD /d "4" /f 1>NUL 2>NUL
reg add "HKLM\SYSTEM\ControlSet001\Control\WMI\Autologger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
timeout /t 1 /nobreak > nul

echo %w% - Disable synchronization of all settings to Microsoft..
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync" /v "SyncPolicy" /t REG_DWORD /d "5" /f 1>NUL 2>NUL

echo %w% - Disable functionality to locate the system..
reg add "HKLM\Software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvider" /t REG_DWORD /d "1" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d "1" /f 1>NUL 2>NUL

echo %w% - Disable peer-to-peer functionality in Windows Update..
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d "0" /f 1>NUL 2>NUL
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownloadMode" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

echo %w% - Disable ads in File Explorer and OneDrive..
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

echo %w% - Remove People buttom from taskbar..
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v "PeopleBand" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

echo %w% - Disable Open File security warning..
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1806" /t "REG_DWORD" /d "00000000" /f 1>NUL 2>NUL
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1806" /t "REG_DWORD" /d "00000000" /f 1>NUL 2>NUL
reg add "HKLM\Software\Policies\Microsoft\Internet Explorer\Security" /v "DisableSecuritySettingsCheck" /t "REG_DWORD" /d "00000001" /f 1>NUL 2>NUL

echo %w% - Remove "Include in library" from context menus..
reg delete "HKCR\Folder\ShellEx\ContextMenuHandlers\Library Location" /f 1>NUL 2>NUL

echo %w% - Disable Microsoft Edge prelaunching..
reg add "HKCU\Software\Policies\Microsoft\MicrosoftEdge\TabPreloader" /v "AllowPrelaunch" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

echo %w% - Disable Microsoft Edge tab preloading..
reg add "HKCU\Software\Policies\Microsoft\MicrosoftEdge\TabPreloader" /v "AllowTabPreloading" /t REG_DWORD /d "0" /f 1>NUL 2>NUL

cls
echo %g% - Applying tweaks to improve system performance...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnableSuperfetch /t REG_DWORD /d 0 /f

echo %j% - Disabling telemetry and data collection...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v AITEnable /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v DisableInventory /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v DisablePCA /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v DisableUAR /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v DisableWer /t REG_DWORD /d 1 /f

cls
title                                                                                                                     By inso.vs

echo %b% - Remove potential bloat..
timeout /t 1 /nobreak > nul
@echo on 
powershell.exe "Get-AppxPackage *Microsoft.3DBuilder* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.Appconnector* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.BingFinance* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.BingNews* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.BingSports* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.BingTranslator* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.BingWeather* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.FreshPaint* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.DesktopAppInstaller* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.Getstarted* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.GetHelp* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.Messaging* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.Microsoft3DViewer* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.MicrosoftOfficeHub* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.MicrosoftPowerBIForWindows* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.MicrosoftStickyNotes* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.MinecraftUWP* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.NetworkSpeedTest* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.WindowsPhone* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.CommsPhone* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.ConnectivityStore* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.Office.Sway* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.BingFoodAndDrink* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.BingTravel* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.BingHealthAndFitness* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *9E2F88E3.Twitter* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *PandoraMediaInc.29680B314EFC2* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Flipboard.Flipboard* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *ShazamEntertainmentLtd.Shazam* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *king.com.CandyCrushSaga* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *king.com.CandyCrushSodaSaga* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *king.com.* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *ClearChannelRadioDigital.iHeartRadio* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *4DF9E0F8.Netflix* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *6Wunderkinder.Wunderlist* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Drawboard.DrawboardPDF* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *22StokedOnIt.NotebookPro* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *2FE3CB00.PicsArt-PhotoStudio* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *41038Axilesoft.ACGMediaPlayer* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *5CB722CC.SeekersNotesMysteriesofDarkwood* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *7458BE2C.WorldofTanksBlitz* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *D52A8D61.FarmVille2CountryEscape | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *TuneIn.TuneInRadio* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *GAMELOFTSA.Asphalt8Airborne* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *TheNewYorkTimes.NYTCrossword* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *DB6EA5DB.CyberLinkMediaSuiteEssentials* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Facebook.Facebook* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *flaregamesGmbH.RoyalRevolt2* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Playtika.CaesarsSlotsFreeCasino* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *A278AB0D.MarchofEmpires* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *KeeperSecurityInc.Keeper* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *ThumbmunkeysLtd.PhototasticCollage* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *INGAG.XING* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *89006A2E.AutodeskSketchBook* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *D5EA27B7.Duolingo-LearnLanguagesforFree* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *46928bounde.EclipseManager* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *ActiproSoftwareLLC.562882FEEB49* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *DolbyLaboratories.DolbyAccess* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *SpotifyAB.SpotifyMusic* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *A278AB0D.DisneyMagicKingdoms* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *WinZipComputing.WinZipUniversal* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.Office.OneNote* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.OneConnect* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.People* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.Print3D* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.SkypeApp* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.Wallet* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.Windows.Photos* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.WindowsAlarms* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.WindowsCamera* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.windowscommunicationsapps* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.WindowsFeedbackHub* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.WindowsMaps* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.WindowsSoundRecorder* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.XboxApp* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.Xbox.TCUI* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.ZuneMusic* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.ZuneVideo* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *828B5831.HiddenCityMysteryofShadows* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *king.com.BubbleWitch3Saga* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Fitbit.FitbitCoach* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Facebook.InstagramBeta* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Facebook.317180B0BB486* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Expedia.ExpediaHotelsFlightsCarsActivities* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *CAF9E577.Plex* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *AdobeSystemsIncorporated.PhotoshopElements2018* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *A278AB0D.DragonManiaLegends* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *A278AB0D.AsphaltStreetStormRacing* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *828B5831.TheSecretSociety-HiddenMystery* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *USATODAY.USATODAY* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *SiliconBendersLLC.Sketchable* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Nordcurrent.CookingFever* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *NAVER.LINEwin8* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *microsoft.microsoftskydrive* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.AgeCastles* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.ScreenSketch* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.YourPhone* | Remove-AppxPackage"
powershell.exe "Get-AppxPackage *Microsoft.MixedReality.Portal* | Remove-AppxPackage"
@echo off

cls

echo %g% - Remove potential bloat for new users..
timeout /t 1 /nobreak > nul
@echo on

powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.DesktopAppInstaller* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.3DBuilder* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.Appconnector* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.BingFinance* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.BingNews* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.BingSports* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.BingTranslator* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.BingWeather* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.FreshPaint* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.DesktopAppInstaller* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.Getstarted* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.GetHelp* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.Messaging* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.Microsoft3DViewer* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.MicrosoftOfficeHub* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.MicrosoftPowerBIForWindows* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.MicrosoftStickyNotes* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.MinecraftUWP* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.NetworkSpeedTest* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.WindowsPhone* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.CommsPhone* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.ConnectivityStore* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.Office.Sway* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.BingFoodAndDrink* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.BingTravel* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.BingHealthAndFitness* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *9E2F88E3.Twitter* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *PandoraMediaInc.29680B314EFC2* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Flipboard.Flipboard* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *ShazamEntertainmentLtd.Shazam* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *king.com.CandyCrushSaga* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *king.com.CandyCrushSodaSaga* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *king.com.* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *ClearChannelRadioDigital.iHeartRadio* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *4DF9E0F8.Netflix* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *6Wunderkinder.Wunderlist* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Drawboard.DrawboardPDF* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *22StokedOnIt.NotebookPro* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *2FE3CB00.PicsArt-PhotoStudio* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *41038Axilesoft.ACGMediaPlayer* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *5CB722CC.SeekersNotesMysteriesofDarkwood* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *7458BE2C.WorldofTanksBlitz* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *D52A8D61.FarmVille2CountryEscape | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *TuneIn.TuneInRadio* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *GAMELOFTSA.Asphalt8Airborne* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *TheNewYorkTimes.NYTCrossword* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *DB6EA5DB.CyberLinkMediaSuiteEssentials* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Facebook.Facebook* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *flaregamesGmbH.RoyalRevolt2* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Playtika.CaesarsSlotsFreeCasino* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *A278AB0D.MarchofEmpires* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *KeeperSecurityInc.Keeper* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *ThumbmunkeysLtd.PhototasticCollage* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *INGAG.XING* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *89006A2E.AutodeskSketchBook* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *D5EA27B7.Duolingo-LearnLanguagesforFree* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *46928bounde.EclipseManager* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *ActiproSoftwareLLC.562882FEEB49* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *DolbyLaboratories.DolbyAccess* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *SpotifyAB.SpotifyMusic* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *A278AB0D.DisneyMagicKingdoms* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *WinZipComputing.WinZipUniversal* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.MSPaint* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.Office.OneNote* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.OneConnect* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.People* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.Print3D* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.SkypeApp* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.Wallet* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.Windows.Photos* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.WindowsAlarms* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.WindowsCamera* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.windowscommunicationsapps* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.WindowsFeedbackHub* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.WindowsMaps* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.WindowsSoundRecorder* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.XboxApp* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.Xbox.TCUI* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.ZuneMusic* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.ZuneVideo* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *828B5831.HiddenCityMysteryofShadows* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *king.com.BubbleWitch3Saga* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Fitbit.FitbitCoach* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Facebook.InstagramBeta* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Facebook.317180B0BB486* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Expedia.ExpediaHotelsFlightsCarsActivities* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *CAF9E577.Plex* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *AdobeSystemsIncorporated.PhotoshopElements2018* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *A278AB0D.DragonManiaLegends* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *A278AB0D.AsphaltStreetStormRacing* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *828B5831.TheSecretSociety-HiddenMystery* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *USATODAY.USATODAY* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *SiliconBendersLLC.Sketchable* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Nordcurrent.CookingFever* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *NAVER.LINEwin8* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *microsoft.microsoftskydrive* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.AgeCastles* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.ScreenSketch* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.YourPhone* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.WebMediaExtensions* | Remove-AppxProvisionedPackage -Online"
powershell.exe "Get-AppxProvisionedPackage -Online | where Displayname -EQ *Microsoft.MixedReality.Portal* | Remove-AppxProvisionedPackage -Online"
chcp 65001
@echo off

cls

echo Disabling unnecessary animations...
echo.- !!! Selectionnes ces 3 options:
echo.
echo.
echo.- Afficher des miniatures au lieu d'icones.
echo
echo.- Afficher le contenu des fenetres pendant leurs deplacement.
echo.
echo.- Lissez les polices écran.

echo.- et dans l'onglet Avancé ---» Moddifier ---» et verifiez
echo.que la casse en en haut a droite soit cocher !
echo.
echo.
SystemPropertiesPerformance.exe /s AnimationOff

mode con cols=130 lines=50
chcp 65001
cls


echo %g% Created By
echo.
echo %r%██╗███╗  ██  ██████╗  █████╗    
echo %r%██║████╗ ██ ██╔════╝ ██╔══██╗      
echo %r%██║██╔██╗██ ╚█████╗  ██║  ██║    
echo %r%██║██║╚████  ╚═══██╗ ██║  ██║     
echo %r%██║██║ ╚███ ██████╔╝ ╚█████╔╝ ██  vs
echo %r%╚═╝╚═╝ ╚══╝ ╚═════╝   ╚════╝       
echo.
echo %g%!! si tu as payez pour ce script sache que tu t'es fait %z%SCAM..
echo. %b%"═══════════════════════════════════════════════════════"
echo. %j%             Press any key to continue.....
echo. %b%"═══════════════════════════════════════════════════════"
pause > nul
cls

cls
echo %w% - Apply DNS Google..
timeout /t 1 /nobreak > nul
netsh interface ipv4 set dnsservers name=%%i source=static address=8.8.8.8 validate=no
netsh interface ipv4 add dnsservers name=%%i address=8.8.4.4 validate=no index=2
timeout /t 1 /nobreak > nul

@echo off
cls

%g%
echo %g% - repair Windows Services..
timeout /t 4 /nobreak > nul
sc config AJRouter start= demand
sc config ALG start= demand
sc config AppHostSvc start= Auto
sc config AppIDSvc start= demand
sc config Appinfo start= demand
sc config AppMgmt start= demand
sc config AppReadiness start= demand
sc config AppXSvc start= demand
sc config aspnet_state start= demand
sc config AudioEndpointBuilder start= Auto
sc config Audiosrv start= Auto
sc config AxInstSV start= demand
sc config BDESVC start= demand
sc config BFE start= Auto
sc config BITS start= Auto
sc config BrokerInfrastructure start= Auto
sc config Browser start= demand
sc config BthHFSrv start= demand
sc config bthserv start= demand
sc config c2wts start= demand
sc config CDPSvc start= demand
sc config CertPropSvc start= demand
sc config ClipSVC start= demand
sc config COMSysApp start= demand
sc config CoreMessagingRegistrar start= Auto
sc config CryptSvc start= Auto
sc config CscService start= demand
sc config DcomLaunch start= Auto
sc config DcpSvc start= demand
sc config defragsvc start= demand
sc config DeviceAssociationService start= Auto
sc config DeviceInstall start= demand
sc config DevQueryBroker start= demand
sc config Dhcp start= Auto
sc config diagnosticshub.standardcollector.service start= demand
sc config DiagTrack start= Auto
sc config DmEnrollmentSvc start= demand
sc config dmwappushservice start= Auto
sc config Dnscache start= Auto
sc config DoSvc start= Auto
sc config dot3svc start= demand
sc config DPS start= Auto
sc config DsmSvc start= demand
sc config DsRoleSvc start= demand
sc config DsSvc start= demand
sc config Eaphost start= demand
sc config EFS start= demand
sc config embeddedmode start= demand
sc config EntAppSvc start= demand
sc config EventLog start= Auto
sc config EventSystem start= Auto
sc config Fax start= demand
sc config fdPHost start= demand
%j%
sc config FDResPub start= demand
sc config fhsvc start= demand
sc config FontCache start= Auto
sc config FontCache3.0.0.0 start= demand
sc config ftpsvc start= Auto
sc config gpsvc start= Auto
sc config hidserv start= demand
sc config HomeGroupListener start= Auto
sc config HomeGroupProvider start= Auto
sc config HvHost start= Auto
sc config icssvc start= demand
sc config IEEtwCollectorService start= demand
sc config IISADMIN start= Auto
sc config IKEEXT start= demand
sc config iphlpsvc start= Auto
sc config iprip start= Auto
sc config KeyIso start= demand
sc config KtmRm start= demand
sc config LanmanServer start= Auto
sc config LanmanWorkstation start= Auto
sc config lfsvc start= demand
sc config LicenseManager start= demand
sc config lltdsvc start= demand
sc config lmhosts start= demand
sc config LPDSVC start= Auto
sc config LSM start= Auto
sc config MapsBroker start= Auto
sc config MpsSvc start= Auto
sc config MSDTC start= demand
sc config MSiSCSI start= demand
sc config msiserver start= demand
sc config MSMQ start= Auto
sc config MSMQTriggers start= Auto
sc config NcaSvc start= demand
sc config NcbService start= demand
sc config NcdAutoSetup start= demand
sc config Netlogon start= Auto
sc config Netman start= demand
sc config NetMsmqActivator start= Auto
sc config NetPipeActivator start= Auto
sc config netprofm start= demand
sc config NetSetupSvc start= demand
sc config NetTcpActivator start= Auto
sc config NetTcpPortSharing start= demand
sc config NgcCtnrSvc start= demand
sc config NgcSvc start= demand
sc config NlaSvc start= Auto
sc config nsi start= Auto
sc config p2pimsvc start= demand
sc config p2psvc start= demand
sc config PcaSvc start= Auto
sc config PeerDistSvc start= demand
sc config PerfHost start= demand
sc config pla start= demand
sc config PlugPlay start= demand
sc config PNRPAutoReg start= demand
sc config PNRPsvc start= demand
sc config PolicyAgent start= demand
sc config Power start= Auto
sc config PrintNotify start= demand
sc config ProfSvc start= Auto
sc config QWAVE start= demand
sc config RasAuto start= demand
sc config RasMan start= demand
sc config RemoteAccess start= Disabled
%b%
sc config RemoteRegistry start= Disabled
sc config RetailDemo start= demand
sc config RpcEptMapper start= Auto
sc config RpcLocator start= demand
sc config RpcSs start= Auto
sc config SamSs start= Auto
sc config SCardSvr start= Disabled
sc config ScDeviceEnum start= demand
sc config Schedule start= Auto
sc config SCPolicySvc start= demand
sc config SDRSVC start= demand
sc config seclogon start= demand
sc config SENS start= Auto
sc config SensorDataService start= demand
sc config SensorService start= demand
sc config SensrSvc start= demand
sc config SessionEnv start= demand
sc config SharedAccess start= demand
sc config ShellHWDetection start= Auto
sc config simptcp start= Auto
sc config smphost start= demand
sc config SmsRouter start= demand
sc config SNMP start= Auto
sc config SNMPTRAP start= demand
sc config Spooler start= Auto
sc config sppsvc start= Auto
sc config SSDPSRV start= demand
sc config SstpSvc start= demand
sc config StateRepository start= demand
sc config stisvc start= demand
sc config StorSvc start= demand
sc config svsvc start= demand
sc config swprv start= demand
sc config SysMain start= Auto
sc config SystemEventsBroker start= Auto
sc config TabletInputService start= Auto
sc config TapiSrv start= demand
sc config TermService start= Auto
sc config Themes start= Auto
sc config tiledatamodelsvc start= Auto
sc config TimeBroker start= demand
sc config TrkWks start= Auto
sc config TrustedInstaller start= demand
sc config UI0Detect start= demand
sc config UmRdpService start= demand
sc config upnphost start= demand
sc config UserManager start= Auto
sc config UsoSvc start= demand
sc config VaultSvc start= demand
sc config vds start= demand
sc config vmicguestinterface start= demand
sc config vmicheartbeat start= demand
sc config vmickvpexchange start= demand
sc config vmicrdv start= demand
sc config vmicshutdown start= demand
sc config vmictimesync start= demand
sc config vmicvmsession start= demand
%r%
sc config vmicvss start= demand
sc config vmms start= Auto
sc config vmvss start= demand
sc config VSS start= demand
sc config W32Time start= Auto
sc config w3logsvc start= demand
sc config W3SVC start= Auto
sc config WalletService start= demand
sc config WAS start= demand
sc config wbengine start= demand
sc config WbioSrvc start= demand
sc config Wcmsvc start= Auto
sc config wcncsvc start= demand
sc config WcsPlugInService start= demand
sc config WdiServiceHost start= demand
sc config WdiSystemHost start= demand
sc config WdNisSvc start= demand
sc config WebClient start= demand
sc config Wecsvc start= demand
sc config WEPHOSTSVC start= demand
sc config wercplsupport start= demand
sc config WerSvc start= demand
sc config WiaRpc start= demand
sc config WinDefend start= Auto
sc config WinHttpAutoProxySvc start= demand
sc config Winmgmt start= Auto
sc config WinRM start= demand
%p%
sc config WlanSvc start= Auto
sc config wlidsvc start= demand
sc config wmiApSrv start= demand
sc config WMPNetworkSvc start= Auto
sc config Wms start= Auto
sc config WmsRepair start= Auto
sc config WMSVC start= demand
sc config workfolderssvc start= demand
sc config WPDBusEnum start= demand
sc config WpnService start= demand
sc config wscsvc start= Auto
sc config WSearch start= Auto
sc config WSService start= demand
sc config wuauserv start= demand
sc config wudfsvc start= demand
sc config WwanSvc start= Auto
sc config XblAuthManager start= demand
sc config XblGameSave start= demand
sc config XboxNetApiSvc start= demand
cls

echo %g% - disable useless Windows Services..
timeout /t 5 /nobreak > nul
sc config "Eaphost" start= disabled
sc config "IKEEXT" start= disabled
sc config "iphlpsvc" start= disabled
sc config "RasMan" start= disabled
sc config "fdPHost" start= disabled
sc config "FDResPub" start= disabled
sc config "lmhosts" start= disabled
sc config "SSDPSRV" start= disabled
sc config "Themes" start= disabled
sc config "WinHttpAutoProxySvc" start= disabled
sc config "WdiServiceHost" start= disabled
sc config "WdiSystemHost" start= disabled
sc config "NdisVirtualBus" start= disabled
sc config "fhsvc" start= disabled
sc config "edgeupdate" start= disabled
sc config "FrameServer" start= disabled
sc config "SessionEnv" start= disabled
sc config "ShellHWDetection" start= disabled
sc config "StiSvc" start= disabled
sc config "PeerDistSvc" start= disabled
sc config "wmiApSrv" start= disabled
sc config "TrkWks" start= disabled
sc config "SessionEnv" start= disabled
sc config "DusmSvc" start= disabled
sc config "WpcMonSvc" start= disabled
                                  timeout /t 1 /nobreak > nul 

sc config "diagsvc" start= disabled
sc config "DialogBlockingService" start= disabled
sc config "DiagTrack" start= disabled
sc config "CscService" start= disabled
sc config "MsKeyboardFilter" start= disabled 
sc config "WinRM" start= disabled
sc config "AppMgmt" start= disabled
sc config "p2pimsvc" start= disabled
sc config "MapsBroker" start= disabled
sc config "RasAuto" start= disabled
sc config "SEMgrSvc" start= disabled
sc config "p2psvc" start= disabled
sc config "WdiSystemHost" start= disabled
sc config "SNMPTrap" start= disabled
sc config "Netlogon" start= disabled
sc config "tzautoupdate" start= disabled
sc config "CertPropSvc" start= disabled
sc config "PNRPsvc" start= disabled
sc config "RemoteRegistry" start= disabled
sc config "RemoteAccess" start= disabled
sc config "vmicguestinterface" start= disabled
sc config "vmicrdv" start= disabled
sc config "HvHost" start= disabled
sc config "AppVClient" start= disabled
sc config "vmicvss" start= disabled
sc config "vmickvpexchange" start= disabled
sc config "vmicshutdown" start= disabled
                                  timeout /t 1 /nobreak > nul

sc config "vmicvmsession" start= disabled
sc config "vmicheartbeat" start= disabled
sc config "vmictimesync" start= disabled
sc config "UevAgentService" start= disabled
sc config "wisvc" start= disabled
sc config "shpamsvc" start= disabled
sc config "Spooler" start= disabled
sc config "SCPolicySvc" start= disabled
sc config "SysMain" start= disabled
sc config "Fax" start= disabled
sc config "WebClient" start= disabled
sc config "WSearch" start= disabled
sc config "PhoneSvc" start= disabled
sc config "icssvc" start= disabled
sc config "WMPNetworkSvc" start= disabled
sc config "diagnosticshub.standardcollector.service" start= disabled
sc config "SensorService" start= disabled
sc config "BDESVC" start= disabled
sc config "RetailDemo" start= disabled
sc config "PcaSvc" start= disabled
sc config "BTAGService" start= disabled
sc config "DPS" start= disabled
sc config "SensrSvc" start= disabled 
sc config "TabletInputService" start= disabled
sc config "ScDeviceEnum" start= disabled
sc config "WerSvc" start= disabled
sc config "dmwappushservice" start= disabled
sc config "lfsvc" start= disabled
sc config "RemoteAccess" start= disabled
sc config "RemoteRegistry" start= disabled
sc config "WalletService" start= disabled
sc config "TapiSrv" start= disabled
sc config "TermService" start= disabled
sc config "EpicOnlineServices" start= disabled
sc config "RpcLocator" start= disabled
sc config "lltdsvc" start= disabled
                                timeout /t 1 /nobreak > nul

sc config "SharedAccess" start= disabled
sc config "TrkWks" start= disabled
sc config "WbioSrvc" start= disabled
sc config "WMPNetworkSvc" start= disabled
sc config "wuauserv" start= disabled
sc config "wscsvc" start= disabled
sc config "WSearch" start= disabled
sc config "XblAuthManager" start= disabled
sc config "XblGameSave" start= disabled
sc config "XboxNetApiSvc" start= disabled
sc config "ndu" start= disabled
sc config "WpcMonSvc" start= disabled
sc config "AMD Crash Denfender Service" start= disabled
sc config "AMD External Events Utility" start= disabled
sc config "BcastDVRUserService" start= disabled
sc config "SCardSvr" start= disabled
sc config "LanmanWorkstation" start= disabled
sc config "LanmanServer" start= disabled
sc config "DispBrokerDesktopSvc" start= disabled
sc config "WpnService" start= disabled
sc config "TabletInputService" start= disabled
sc config "VaultSvc" start= disabled
                               timeout /t 1 /nobreak > nul

%b%
sc stop "seclogon"
sc stop "CDPSvc"
sc stop "CscService"
sc stop "PhoneSvc"
sc stop "Fax"
sc stop "InstallService"
sc stop "icssvc"
sc stop "SEMgrSvc"
sc stop "SmsRouter"
sc stop "Spooler"
sc stop "SysMain"
sc stop "WpnService"
sc stop "WSearch"
sc stop "stisvc"
sc stop "DiagTrack"
sc stop "MapsBroker"
sc stop "CertPropSvc"
sc stop "WbioSrvc"
sc stop "wuauserv"
sc stop "BDESVC"
sc stop "DPS"
sc stop "fhsvc"
sc stop "SharedAccess"
sc stop "Netlogon"
timeout /t 1 /nobreak > nul

sc stop "PcaSvc"
sc stop "WpcMonSvc"
sc stop "lmhosts"
sc stop "WerSvc"
sc stop "FrameServer"
sc stop "wisvc"
sc stop "VaultSvc"
sc stop "BTAGService"
sc stop "DusmSvc"
sc stop "DoSvc"
sc stop "dmwappushservice"
sc stop "lfsvc"
sc stop "NcdAutoSetup"
sc stop "QWAVE"
sc stop "RmSvc"
sc stop "RasMan"
sc stop "RasAuto"
sc stop "ScDeviceEnum"
sc stop "SCardSvr"
sc stop "TapiSrv"
sc stop "DispBrokerDesktopSvc"
sc stop "SENS"
sc stop "fdpHost"
sc stop "FDResPub"
sc stop "SCardSvr"
sc stop "ndu"
timeout /t 1 /nobreak > nul
@echo off
mode con cols=120 lines=45
chcp 65001

@CLS
sc stop "PcaSvc"
sc stop "WpcMonSvc"
sc stop "lmhosts"
sc stop "WerSvc"
sc stop "FrameServer"
sc stop "wisvc"
sc stop "VaultSvc"
sc stop "BTAGService"
sc stop "DusmSvc"
sc stop "DoSvc"
sc stop "dmwappushservice"
sc stop "lfsvc"
sc stop "NcdAutoSetup"
sc stop "QWAVE"
sc stop "RmSvc"
sc stop "RasMan"
sc stop "RasAuto"
sc stop "ScDeviceEnum"
sc stop "SCardSvr"
sc stop "TapiSrv"
sc stop "DispBrokerDesktopSvc"
sc stop "SENS"
sc stop "fdpHost"
sc stop "FDResPub"
sc stop "SCardSvr"
sc stop "ndu"
timeout /t 1 /nobreak > nul

cls
DISM /Online /Cleanup-Image /CheckHealth
sfc /scannow

@echo off
mode con cols=130 lines=50
set w=[97m
set p=[95m
set b=[96m
set g=[92m
set z=[91m
set i=[94m
set j=[93m
chcp 65001

@CLS
:start
title Optmimisation Terminé !
chcp 65001
mode con cols=130 lines=50
echo. 
echo.                
echo.               
echo.                         %b%██╗ ███╗  ██  ██████╗  █████╗          ██╗   ██╗████████╗██╗██╗     ██╗████████╗██╗   ██╗
echo.                         %b%██║ ████╗ ██ ██╔════╝ ██╔══██╗         ██║   ██║╚══██╔══╝██║██║     ██║╚══██╔══╝╚██╗ ██╔╝
echo.                         %b%██║ ██╔██╗██ ╚█████╗  ██║  ██║         ██║   ██║   ██║   ██║██║     ██║   ██║    ╚████╔╝
echo.                         %b%██║ ██║╚████  ╚═══██╗ ██║  ██║         ██║   ██║   ██║   ██║██║     ██║   ██║     ╚██╔╝
echo.                         %b%██║ ██║ ╚███ ██████╔╝ ╚█████╔╝         ╚██████╔╝   ██║   ██║███████╗██║   ██║      ██║
echo.                         %b%╚═╝ ╚═╝ ╚══╝ ╚═════╝   ╚════╝           ╚═════╝    ╚═╝   ╚═╝╚══════╝╚═╝   ╚═╝      ╚═╝%w%  
echo.
echo.
echo.%w%//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
echo.                                                     %j%Created By 'inso.vs™'
echo.%w%//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
echo.
echo.
echo.%g%- L'optimisation est Terminé ! (pensez a reboot le PC pour appliquer les Tweaks).
echo.%g%- N'hesitez pas a rejoindre le Discord, pour suivres les nouvelles maj du Script et accéder 
echo.%g%- a d'autres de mes créations/conseils et tutoriels.
echo.
echo.
echo.
echo.
start https://guns.lol/inso.vs




choice /c:y /n /m "redémarrer pour appliquer les modifications ? [Y]es
if %ERRORLEVEL% == 1 shutdown /r /t 18 /f /d p:0:0 /c "Optimized By - "inso.vs"

GOTO Quitter
