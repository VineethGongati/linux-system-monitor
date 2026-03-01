#!/bin/bash

# ============================================
#   Linux System Health Monitor
#   Author: VineethGongati
#   Description: Monitors CPU, Memory, Disk
#   and Processes and generates health report
# ============================================

# --- Color Codes ---
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
BOLD="\e[1m"
RESET="\e[0m"

# --- Thresholds ---
CPU_WARN=70
CPU_DANGER=90
MEM_WARN=70
MEM_DANGER=90
DISK_WARN=70
DISK_DANGER=90
PROC_WARN=200

# --- Report File ---
REPORT="health_report_$(date +%Y%m%d_%H%M%S).txt"

# --- Overall Status Tracker ---
OVERALL="HEALTHY"

# ============================================
# FUNCTIONS
# ============================================

# Function to print divider
divider() {
    echo -e "${BLUE}============================================${RESET}"
}

# Function to check status and return color
check_status() {
    local VALUE=$1
    local WARN=$2
    local DANGER=$3

    if [ "$VALUE" -ge "$DANGER" ]; then
        echo "DANGER"
    elif [ "$VALUE" -ge "$WARN" ]; then
        echo "WARNING"
    else
        echo "NORMAL"
    fi
}

# Function to print colored status
print_status() {
    local STATUS=$1
    if [ "$STATUS" = "NORMAL" ]; then
        echo -e "${GREEN}✅ Normal${RESET}"
    elif [ "$STATUS" = "WARNING" ]; then
        echo -e "${YELLOW}⚠️  Warning${RESET}"
        OVERALL="ATTENTION NEEDED"
    else
        echo -e "${RED}🔴 DANGER${RESET}"
        OVERALL="CRITICAL"
    fi
}

# ============================================
# GATHER SYSTEM DATA
# ============================================

# --- Get CPU Usage ---
CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d'.' -f1)
CPU_USAGE=$((100 - CPU_IDLE))

# --- Get Memory Usage ---
MEM_TOTAL=$(free -m | awk 'NR==2{print $2}')
MEM_USED=$(free -m | awk 'NR==2{print $3}')
MEM_USAGE=$(awk "BEGIN {printf \"%d\", ($MEM_USED/$MEM_TOTAL)*100}")

# --- Get Disk Usage ---
DISK_USAGE=$(df -h / | awk 'NR==2{print $5}' | cut -d'%' -f1)

# --- Get Running Processes ---
PROC_COUNT=$(ps aux | wc -l)

# --- Get System Info ---
HOSTNAME=$(hostname)
UPTIME=$(uptime -p)
CURRENT_TIME=$(date "+%Y-%m-%d %H:%M:%S")

# ============================================
# GENERATE REPORT
# ============================================

{
echo ""
divider
echo -e "${BOLD}         LINUX SYSTEM HEALTH MONITOR${RESET}"
divider
echo -e "  Hostname    : ${BLUE}$HOSTNAME${RESET}"
echo -e "  Checked At  : $CURRENT_TIME"
echo -e "  Uptime      : $UPTIME"
divider
echo ""

# --- CPU ---
CPU_STATUS=$(check_status "$CPU_USAGE" "$CPU_WARN" "$CPU_DANGER")
echo -ne "  CPU Usage      : ${BOLD}$CPU_USAGE%${RESET}  →  "
print_status "$CPU_STATUS"

# --- Memory ---
MEM_STATUS=$(check_status "$MEM_USAGE" "$MEM_WARN" "$MEM_DANGER")
echo -ne "  Memory Usage   : ${BOLD}$MEM_USAGE%${RESET}  ($MEM_USED MB / $MEM_TOTAL MB)  →  "
print_status "$MEM_STATUS"

# --- Disk ---
DISK_STATUS=$(check_status "$DISK_USAGE" "$DISK_WARN" "$DISK_DANGER")
echo -ne "  Disk Usage     : ${BOLD}$DISK_USAGE%${RESET}  →  "
print_status "$DISK_STATUS"

# --- Processes ---
if [ "$PROC_COUNT" -ge "$PROC_WARN" ]; then
    PROC_STATUS="WARNING"
    OVERALL="ATTENTION NEEDED"
else
    PROC_STATUS="NORMAL"
fi
echo -ne "  Running Procs  : ${BOLD}$PROC_COUNT${RESET}  →  "
print_status "$PROC_STATUS"

echo ""
divider

# --- Overall Status ---
echo -ne "  ${BOLD}Overall Status : "
if [ "$OVERALL" = "HEALTHY" ]; then
    echo -e "${GREEN}✅ ALL SYSTEMS HEALTHY${RESET}"
elif [ "$OVERALL" = "ATTENTION NEEDED" ]; then
    echo -e "${YELLOW}⚠️  ATTENTION NEEDED${RESET}"
else
    echo -e "${RED}🔴 CRITICAL - IMMEDIATE ACTION REQUIRED${RESET}"
fi

divider
echo -e "  Report saved to: $REPORT"
divider
echo ""

} | tee "$REPORT"
