@echo off
chcp 65001 >nul
echo ========================================
echo 智慧农业项目 - 分卷文件合并工具
echo ========================================
echo.

REM 合并 0-制作日志.zip
if exist "0-制作日志.zip.part1" (
    echo 正在合并: 0-制作日志.zip
    copy /b "0-制作日志.zip.part1"+"0-制作日志.zip.part2" "0-制作日志.zip"
    echo ✓ 0-制作日志.zip 合并完成
)

REM 合并 3-模型训练.zip
if exist "3-模型训练.zip.part1" (
    echo 正在合并: 3-模型训练.zip
    copy /b "3-模型训练.zip.part1"+"3-模型训练.zip.part2"+"3-模型训练.zip.part3" "3-模型训练.zip"
    echo ✓ 3-模型训练.zip 合并完成
)

echo.
echo ========================================
echo 所有文件合并完成!
echo ========================================
echo.
echo 现在可以删除 .part 分卷文件了
pause
