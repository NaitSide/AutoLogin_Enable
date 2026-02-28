@echo off
chcp 65001 >nul
title Включение AutoLogin - NaitSide Custom Build

:: Сохраняем пользователя ДО проверки прав
set "CURRENT_USER=%USERNAME%"

:: Проверка прав администратора
net session >nul 2>&1
if %errorlevel% neq 0 (
    cls
    echo.
    echo =========================================================
    echo    [ОШИБКА] Требуются права администратора!
    echo =========================================================
    echo.
    echo    Запустите скрипт правой кнопкой мыши
    echo    -^> "Запуск от имени администратора"
    echo.
    echo =========================================================
    echo.
    pause
    exit /b
)

cls
echo.
echo =========================================================
echo    Включение AutoLogin Windows
echo    NaitSide Custom Build
echo =========================================================
echo.
echo  Этот скрипт настроит автоматический вход Windows
echo  без запроса пароля на экране приветствия.
echo.
echo =========================================================
echo    GitHub: github.com/NaitSide
echo =========================================================
echo.
set /p "confirm=  Нажмите Y для подтверждения: "

if /i not "%confirm%"=="y" (
    echo.
    echo  Отменено пользователем.
    pause
    exit /b
)

cls
echo.
echo =========================================================
echo    Выполнение...
echo =========================================================
echo.

:: Путь в реестре
set "REG_PATH=HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"

:: Включаем автологин
reg add "%REG_PATH%" /v AutoAdminLogon   /t REG_SZ /d "1"          /f >nul
reg add "%REG_PATH%" /v DefaultUserName  /t REG_SZ /d "%CURRENT_USER%"  /f >nul
reg add "%REG_PATH%" /v DefaultPassword  /t REG_SZ /d ""            /f >nul
reg add "%REG_PATH%" /v DefaultDomainName /t REG_SZ /d "%COMPUTERNAME%" /f >nul

echo.
echo =========================================================
echo    [OK] Автологин настроен для пользователя: %CURRENT_USER%
echo =========================================================
echo.
echo  Изменения вступят в силу после перезагрузки.
echo.
echo  ВНИМАНИЕ: Пароль хранится в реестре в открытом виде.
echo  Не используйте на общедоступных компьютерах.
echo.
echo =========================================================
echo    NaitSide Custom Build
echo    github.com/NaitSide
echo =========================================================
echo.
pause