# 简历构建指引（流程 D 详细版）

## 文件布局

```
简历/
├── assets/photo.jpg                 # 证件照（可选，无则删掉模板里的 <img>）
├── {{姓名}}-{{岗位}}-{{年份}}校招.md    # 内容源（人读、AI 改）
├── {{姓名}}-{{岗位}}-{{年份}}校招.html  # 排版源（PDF 的直接来源）
└── {{姓名}}-{{岗位}}-{{年份}}校招.pdf   # 成品（投出去的东西）
```

一个求职方向一个版本（如 C++ 版、后端版），文件名带岗位后缀区分。**md 和 html 是同一内容的两种载体，改了 md 必须同步改 html**，两份不一致以 md 为准重新对齐。

## 内容原则

1. **数据红线**：每个数字（并发数、性能提升、测试数、commit 数）和头衔（负责人、主导）必须能在 `个人档案.md` 找到依据。没有依据的量化表述一律不写——"做了 X 次 commit 迭代"这种真实可查的数据可以写。
2. 动词开头、结果导向；技术名词用 `code` 样式突出；一段经历 3–5 个要点，最重要的放最前。
3. 技能措辞与 `个人档案.md §1` 的三列表（技能-真实水平-简历措辞）对齐，"熟悉 / 了解 / 学习中"三档宁低勿高。
4. 目标单页 A4。内容溢出时**先压措辞再动排版**（合并同类要点、删弱化词），排版参数是调过的。

## 排版参数（html 模板已内置，勿乱动）

- `@page { size: A4; margin: 0 }`，body 宽 794px、padding 约 `32px 56px 22px`。
- 正文 9.5pt / 行高 1.38；姓名 20pt；节标题 11.5pt 深蓝带下划线。
- 字体栈 `"Microsoft YaHei", "PingFang SC", sans-serif`（Windows/macOS 都有兜底）。
- 条目块加 `class="keep"`（`break-inside: avoid`），防止跨页截断。

## 生成 PDF（无头浏览器，跨平台）

原理：Edge、Chrome、Chromium 是同一内核，无头打印参数完全一致，机器上有**任意一个**即可；按当前操作系统选下面对应写法。命令里的"目标.html / 目标.pdf"换成实际文件名，工作目录取工作区根目录。

### 第 1 步：找到浏览器可执行文件

常见默认路径（存在哪个用哪个；都不在就用 `where`/`which` 或让用户确认安装位置）：

- Windows：`C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe`、`C:\Program Files\Microsoft\Edge\Application\msedge.exe`；Chrome 对应 `...\Google\Chrome\Application\chrome.exe`。
- macOS：`/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge`、`/Applications/Google Chrome.app/Contents/MacOS/Google Chrome`。
- Linux：PATH 中的 `microsoft-edge`、`google-chrome`、`google-chrome-stable`、`chromium`、`chromium-browser` 之一。

### 第 2 步：无头打印

**Windows PowerShell**（路径加引号，用调用运算符 `&`；file URL 用正斜杠的绝对路径，形如 `file:///D:/...`）：

```powershell
& "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --headless --disable-gpu `
  --no-pdf-header-footer --print-to-pdf="简历\目标.pdf" `
  "file:///D:/求职工作区/简历/目标.html"
```

**Windows Git Bash / macOS / Linux**（Git Bash 的 file URL 形如 `file:///d:/...`，盘符小写；macOS/Linux 用 `"file://$PWD/简历/目标.html"`）：

```bash
# Windows Git Bash（二选一安装路径）
"/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe" --headless --disable-gpu \
  --no-pdf-header-footer --print-to-pdf="简历/目标.pdf" \
  "file:///$(pwd -W 2>/dev/null || pwd)/简历/目标.html"

# macOS（Edge 或 Chrome 二选一）
"/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge" --headless --disable-gpu \
  --no-pdf-header-footer --print-to-pdf="简历/目标.pdf" \
  "file://$PWD/简历/目标.html"

# Linux（命令名按第 1 步探测结果替换）
google-chrome --headless --disable-gpu \
  --no-pdf-header-footer --print-to-pdf="简历/目标.pdf" \
  "file://$PWD/简历/目标.html"
```

参数说明：

- 老版本 Chrome 不认 `--no-pdf-header-footer`，换成 `--print-to-pdf-no-header`；Edge 与新版 Chrome 两者都可。
- 无头模式偶发首次启动慢，失败可重试一次；仍失败换另一个浏览器，不要死磕同一个可执行文件。
- 输出路径建议写绝对路径或确认当前工作目录是工作区根，避免 PDF 落到意外位置。

### 第 3 步兜底：手动打印

命令行不可用、无 Chromium 系浏览器，或无头打印反复失败：让用户用 Chrome/Edge 打开 html → 打印（Ctrl/Cmd+P）→ 目标打印机选"另存为 PDF" → 纸张 A4、边距无、取消页眉页脚 → 保存到 `简历/`，并肉眼确认单页。

## 单页校验

PDF 内部每个页面对象带 `/Type /Page` 标记，但页树根节点是 `/Type /Pages`（多一个 s），朴素匹配会把根节点误计 1 次；此外 grep 默认把 PDF 当二进制、只报一次匹配，必须加 `-a`。按当前 shell 选命令，输出必须为 1：

```powershell
# Windows PowerShell：(?!s) 负向断言排除 /Type /Pages 根节点
(Select-String -Path "简历\目标.pdf" -Pattern "/Type /Page(?!s)" -AllMatches).Matches.Count
```

```bash
# Git Bash / macOS / Linux：-a 把 PDF 当文本处理；总匹配数减去 /Type /Pages 根节点数
total=$(grep -a -o "/Type /Page"  "简历/目标.pdf" | wc -l | tr -d ' ')
root=$(grep  -a -o "/Type /Pages" "简历/目标.pdf" | wc -l | tr -d ' ')
echo $((total - root))   # 必须为 1
```

- 上述命令已在 Edge 无头打印产物上实测（1 页输出 1、6 页输出 6）；遇到压缩对象流等情况仍可能输出异常（0、报错），此时直接打开 PDF 肉眼确认页数，不要死磕命令。
- 超过 1 页 → 回到内容层压缩；压完重新生成再校验。

## 版本记录

每次改简历后，在 `投递跟踪.md` 的"简历版本记录"表加一行或更新状态（版本定位 / 日期 / 改了什么），然后：

- git 可用：`git add -A && git commit -m "简历：{{版本}} {{一句话改动}}"`；
- 未启用 git：做一次带日期的工作区备份，并如实告知用户未提交。

## docx 说明

部分网申系统只收 docx。本 skill 的零依赖方案只出 PDF；确需 docx 时用 Word/LibreOffice 手动转一份，或在 html 上加注释说明转换来源，转换后人工核对排版。不提供 Node 脚本生成 docx 的能力。
