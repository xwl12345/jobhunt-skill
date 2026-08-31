<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<title>{{姓名}} - {{岗位方向}} - {{年份}}校招</title>
<style>
  /* 排版参数已调优（A4 单页），改内容不改样式；溢出先压措辞再动字号行距 */
  @page { size: A4; margin: 0; }
  * { margin: 0; padding: 0; box-sizing: border-box; }
  html, body { width: 794px; }
  body {
    font-family: "Microsoft YaHei", "PingFang SC", sans-serif;
    color: #2B2B2B;
    font-size: 9.5pt;
    line-height: 1.38;
    padding: 32px 56px 22px;
    background: #ffffff;
  }
  b, strong { font-weight: 700; }
  .header { display: flex; align-items: center; gap: 14px; }
  .photo { width: 84px; height: 118px; object-fit: cover; flex: none; }
  .h-name-block { flex: 1 1 auto; }
  .h-name { font-size: 20pt; font-weight: 700; color: #16283C; line-height: 1.12; letter-spacing: 2px; }
  .h-intent { font-size: 10.5pt; font-weight: 700; color: #2E6DA4; margin-top: 4px; }
  .h-meta { font-size: 9pt; color: #5F7181; margin-top: 3px; }
  .h-contact { flex: none; text-align: right; font-size: 9pt; color: #2B2B2B; line-height: 1.65; }
  .top-rule { border-bottom: 1.6px solid #1F3A5F; margin-top: 8px; }
  h2.sec {
    font-size: 11.5pt; font-weight: 700; color: #1F3A5F;
    border-bottom: 1px solid #9FB3C4;
    padding-bottom: 2px; margin: 8px 0 4px;
  }
  .entry { display: flex; justify-content: space-between; align-items: baseline; margin-top: 2px; }
  .entry .e-name { font-size: 10.5pt; font-weight: 700; color: #1F3A5F; }
  .entry .e-role { font-size: 10pt; font-weight: 700; color: #2E6DA4; margin-left: 8px; }
  .entry .e-date { font-size: 9pt; color: #5F7181; flex: none; padding-left: 12px; }
  ul { list-style: none; margin: 1px 0 0; }
  li { position: relative; padding-left: 15px; margin-bottom: 2.5px; text-align: justify; }
  li::before { content: "•"; position: absolute; left: 3px; color: #2E6DA4; font-weight: 700; }
  ul ul { margin-top: 1px; }
  ul ul li { padding-left: 29px; margin-bottom: 2px; }
  ul ul li::before { content: "–"; left: 16px; }
  code { font-family: Consolas, "Courier New", monospace; font-size: 9pt; color: #2E6DA4; }
  .muted { color: #5F7181; }
  .keep { break-inside: avoid; }
</style>
</head>
<body>

<div class="header keep">
  <!-- 无证件照时删除下一行 img -->
  <img class="photo" src="assets/photo.jpg" alt="证件照">
  <div class="h-name-block">
    <div class="h-name">{{姓名}}</div>
    <div class="h-intent">求职意向：{{岗位方向}}</div>
    <div class="h-meta">{{届别}}应届生 · {{出生年月，可选}}</div>
  </div>
  <div class="h-contact">
    电话：{{手机}}<br>
    邮箱：{{邮箱}}<br>
    GitHub：{{仓库主页，可选，不用就删这行}}
  </div>
</div>
<div class="top-rule"></div>

<h2 class="sec">教育经历</h2>
<div class="entry keep">
  <div><span class="e-name">{{学校}}</span><span class="e-role">{{专业}} · {{学历层次}}</span></div>
  <div class="e-date">{{入学}}.09 – {{毕业}}.06</div>
</div>
<div class="muted">{{排名/获奖，有优势才写}}主修课程：{{与岗位相关的 4–6 门}}</div>

<h2 class="sec">实习经历</h2>
<div class="entry keep">
  <div><span class="e-name">{{公司}}</span><span class="e-role">{{岗位}}</span></div>
  <div class="e-date">{{起始}} – {{结束}}</div>
</div>
<div>{{一句话项目背景与技术栈，技术名词用 <code>code</code> 样式}}：</div>
<ul>
  <li class="keep"><b>{{负责模块/任务 1}}</b>：{{做法 + 技术决策 + 真实成果}}</li>
  <li class="keep"><b>{{任务 2}}</b>：{{…}}</li>
</ul>

<h2 class="sec">项目经历</h2>
<div class="entry keep">
  <div><span class="e-name">{{项目名}} — {{一句话定位}}</span><span class="e-role">{{角色}}</span></div>
  <div class="e-date">{{github 链接 或 "代码可提供"}}</div>
</div>
<ul class="keep">
  <li>{{背景与目标}}</li>
  <li>{{关键技术做法，<code>技术名词</code> 用 code 样式}}</li>
  <li>{{真实成果：commit 数 / 测试数 / 上线情况}}</li>
</ul>

<h2 class="sec">专业技能</h2>
<ul>
  <li><b>{{语言}}：</b>{{熟悉/了解 + 具体范围与工具}}</li>
  <li><b>{{框架/领域}}：</b>{{…}}</li>
  <li><b>{{基础}}：</b>{{…}}</li>
</ul>

<!-- 获奖太少可整节删除
<h2 class="sec">获奖/证书</h2>
<ul>
  <li>{{奖项}}</li>
</ul>
-->

</body>
</html>
