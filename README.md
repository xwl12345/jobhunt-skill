# jobhunt — 通用秋招/校招 AI 执行助手（跨 Agent 平台 Skill）

把"AI 长期维护一个版本化求职工作区"这件事做成一个可安装的 skill。它遵循开放的 Agent Skills 标准（带 YAML frontmatter 的 `SKILL.md` + `references/` + `assets/` 结构），不绑定任何特定 AI 工具——Claude Code、Cursor、OpenAI Codex、Windsurf、GitHub Copilot、Gemini CLI、ZCode 等读取该标准的 agent 都能用：

- **首次调用**：自动进入计划阶段，分批收集学历 / 技能 / 实习项目经历 / 求职意向，按五维可行性分析给出**保底 / 主攻 / 冲刺**三层求职方向规划，确认后一次性搭好工作区（个人档案、投递跟踪、进度与薄弱点、AGENTS.md、简历 V1），git 可用时 `git init` 提交。
- **日常使用**：进度打卡、投递跟踪、面试复盘（被问倒的点回填待补强，同类问题被问倒 ≥2 次自动升级为专项任务）、简历构建（md→html→PDF 单页校验）。
- **信息更新默认通过 git 提交留痕**，换电脑 clone 即接手（AGENTS.md 约定）；没有 git 也能完整运行，降级为带日期的手动备份。

不伪造不夸大是硬规矩：简历上每个数字和头衔都必须在个人档案里有依据。

## 安装（跨平台）

skill 本体就是一个名为 `jobhunt` 的文件夹，**整个文件夹复制到你所用 agent 的 skills 目录**即可。

### 各平台 skills 目录对照

| Agent 平台 | 用户级（本机所有项目可用） | 项目级（随仓库分发给协作者） |
|---|---|---|
| Claude Code | `~/.claude/skills/` | `.claude/skills/` |
| Cursor | `~/.cursor/skills/` | `.cursor/skills/` |
| OpenAI Codex | `~/.codex/skills/`（或通用 `~/.agents/skills/`） | `.agents/skills/` |
| Windsurf | `~/.windsurf/skills/` | `.windsurf/skills/` |
| GitHub Copilot | —（仅项目级） | `.github/copilot/skills/` |
| ZCode | `~/.zcode/skills/` | 工作区 skills 目录 |
| 其他遵循开放标准的工具 | `~/.agents/skills/` | `.agents/skills/` |

> `~` 指当前用户主目录：Windows 上是 `C:\Users\<你的用户名>`，macOS/Linux 上是 `/Users/<你>` 或 `/home/<你>`。各工具对标准的支持在持续更新，最终以其官方文档为准。

### 安装命令示例

Windows PowerShell（以 Claude Code 为例，换平台只改目录名）：

```powershell
New-Item -ItemType Directory -Force "$HOME\.claude\skills" | Out-Null
Copy-Item -Recurse "D:\U_Project\work\jobhunt" "$HOME\.claude\skills\jobhunt"
```

macOS / Linux（Git Bash、zsh 等）：

```bash
mkdir -p ~/.claude/skills
cp -r /path/to/jobhunt ~/.claude/skills/jobhunt
```

### 一份维护、多平台生效

同时用多个 agent 时，把正本放在通用目录 `~/.agents/skills/jobhunt`，再给各平台建软链接，以后只维护正本：

- Windows（管理员 PowerShell）：`New-Item -ItemType SymbolicLink -Path "$HOME\.claude\skills\jobhunt" -Target "$HOME\.agents\skills\jobhunt"`（cmd 下用 `mklink /D`）。
- macOS/Linux：`ln -s ~/.agents/skills/jobhunt ~/.claude/skills/jobhunt`。
- 也可以用 `npx skills add` 之类的社区安装器自动分发到各平台。

注意：

- 文件夹名必须为 `jobhunt`，与 `SKILL.md` frontmatter 里的 `name` 一致；若目标位置已有同名 skill，先确认避免互相遮蔽。
- 安装后**新开会话或重新加载窗口**生效（多数平台在会话启动时索引 skill 列表）。

## 使用

在任意想建求职档案的目录开一个新会话，说一句：

> 我想准备秋招，帮我规划

`SKILL.md` 的 description 里写了触发词，skill 会自动触发并进入初始化流程。支持斜杠命令的平台（如 Claude Code、ZCode）也可以用 `/jobhunt` 显式加载；不支持斜杠命令的平台直接自然语言触发即可。之后的日常：

| 你说 | 触发流程 |
|---|---|
| "打卡：今天投了 3 家，刷了 5 题" | 日常打卡回填 + git 提交（或手动备份） |
| "我现在的进度是什么" | 现状汇报 |
| "昨天面了 XX，被问到 YY 没答上" | 面试复盘 + 薄弱点归纳 |
| "改简历 / 生成简历 PDF" | 简历双源同步 + 无头打印 + 单页校验 |

## 运行依赖

- **必需**：agent 能读写本地文件、执行 shell 命令。
- **git：强烈建议，但非必需**。初始化时先探测；没装会说明 git 的作用并征求同意——同意就协助安装（Windows 用 winget 或官网安装器、macOS 用 xcode-select/brew、Linux 用包管理器）；不同意则照常运行，代价是失去版本历史、回滚与 clone 接手，改为每次重大更新前做带日期的文件夹备份。
- **简历 PDF 零依赖**：`.md`（内容源）+ `.html`（排版源）+ 系统已装的任意 Edge/Chrome/Chromium 无头打印，Windows（PowerShell 与 Git Bash）/macOS/Linux 命令都在 `references/resume-guide.md`；不出 docx（确需时手动转换）。
- **联网搜索为可选能力**：有时用当年招聘行情与真实 JD 佐证方向规划，无时基于收集信息分析并标注未核验。

## 结构

```
jobhunt/
├── SKILL.md               # 主流程（状态检测 → 初始化/打卡/汇报/复盘/简历 + 能力降级）
├── references/
│   ├── init-guide.md      # 信息收集清单（4 批）+ 方向五维可行性分析框架
│   └── resume-guide.md    # 排版参数、各平台无头打印命令、单页校验
└── assets/                # 工作区模板（{{占位符}}，初始化时填充）
    ├── AGENTS.md.tpl  个人档案.md.tpl  投递跟踪.md.tpl  进度与薄弱点.md.tpl
    └── 简历模板.md.tpl  简历模板.html.tpl  gitignore.tpl
```

想定制模板（默认字号、节结构、措辞口径）直接改 `assets/` 里的 `.tpl` 文件即可。

## 边界与说明

- 简历生成是零依赖方案：`.md`（内容源）+ `.html`（排版源）+ Edge/Chrome/Chromium 无头打印 PDF；不出 docx（确需时手动转换）。
- 求职工作区含手机号等隐私，启用 git 远端时**仓库必须私有**——初始化时 skill 也会提醒。
- 方向规划基于收集到的信息与（有联网能力时的）当年行情检索，是建议不是保证，最终决策在人。
