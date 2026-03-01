# 🖥️ Linux System Health Monitor

A bash script that monitors system health in real time and generates
a detailed report with color-coded alerts using built-in Linux tools.

---

## 📌 What This Project Does

- Checks CPU usage in real time
- Monitors RAM/Memory usage
- Checks Disk space usage
- Counts running processes
- Color coded output (Green/Yellow/Red)
- Saves report to a timestamped .txt file
- Shows overall system health status

---

## 🚦 Alert Thresholds

| Metric | Normal | Warning | Danger |
|--------|--------|---------|--------|
| CPU | Below 70% | 70-90% | Above 90% |
| Memory | Below 70% | 70-90% | Above 90% |
| Disk | Below 70% | 70-90% | Above 90% |
| Processes | Below 200 | Above 200 | - |

---

## 🛠️ Tools Used

| Tool | Purpose |
|------|---------|
| `df` | Check disk space usage |
| `free` | Check memory usage |
| `top` | Check CPU usage |
| `ps` | Count running processes |
| `bash` | Script automation |

---

## 🚀 How to Run

**Step 1 — Clone the repository:**
\`\`\`bash
git clone git@github.com:VineethGongati/linux-system-monitor.git
cd linux-system-monitor
\`\`\`

**Step 2 — Give permission:**
\`\`\`bash
chmod +x monitor.sh
\`\`\`

**Step 3 — Run the monitor:**
\`\`\`bash
./monitor.sh
\`\`\`

---

## 📊 Sample Output

\`\`\`
============================================
         LINUX SYSTEM HEALTH MONITOR
============================================
  Hostname    : vineeth
  Checked At  : 2026-03-01 12:56:08
  Uptime      : up 2 hours
============================================
  CPU Usage      : 8%   → ✅ Normal
  Memory Usage   : 45%  → ✅ Normal
  Disk Usage     : 5%   → ✅ Normal
  Running Procs  : 132  → ✅ Normal
============================================
  Overall Status : ✅ ALL SYSTEMS HEALTHY
============================================
\`\`\`

---

## 💡 What I Learned

- Using df, free, top, ps commands for system monitoring
- Writing functions in bash scripts
- Adding colors to bash output
- If/else conditions in bash
- Automating system checks with shell scripting

---

## 👤 Author

**VineethGongati**
GitHub: https://github.com/VineethGongati
