#!/bin/bash
# Terminal rendering benchmark - simulates long Claude Code sessions
# Run in both terminals to compare. Takes ~30-60s.

echo "Terminal: ${TERM_PROGRAM:-unknown}"
echo "============================================"
echo ""

time_it() {
  python3 -c 'import time; print(time.time())'
}

# ============================================
# Phase 1: Build up massive scrollback (like a long Claude session)
# ============================================
echo "[Phase 1] Building scrollback buffer (100k lines)..."
echo "  Simulating hours of Claude Code output..."
start=$(time_it)

# Simulate Claude-like output: code blocks, markdown, mixed formatting
for round in $(seq 1 200); do
  # Simulate a Claude response with markdown + code
  echo -e "\033[1;37m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo -e "\033[1;36m  Claude Response #$round\033[0m"
  echo -e "\033[1;37m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo ""
  echo "Let me analyze this code and suggest improvements."
  echo ""
  # Simulated code block with syntax highlighting colors
  echo -e "\033[90m\`\`\`typescript\033[0m"
  for line in $(seq 1 50); do
    echo -e "\033[34mimport\033[0m { \033[33mComponent\033[0m } \033[34mfrom\033[0m \033[32m'react'\033[0m;"
    echo -e "\033[34mconst\033[0m \033[33mhandleSubmit\033[0m = \033[34masync\033[0m (\033[33mevent\033[0m: \033[36mFormEvent\033[0m) => {"
    echo -e "  \033[34mconst\033[0m \033[33mresponse\033[0m = \033[34mawait\033[0m \033[33mfetch\033[0m(\033[32m'/api/data'\033[0m, {"
    echo -e "    \033[33mmethod\033[0m: \033[32m'POST'\033[0m,"
    echo -e "    \033[33mbody\033[0m: \033[33mJSON\033[0m.\033[33mstringify\033[0m({ \033[33mid\033[0m: \033[35m$line\033[0m, \033[33mvalue\033[0m: \033[32m'test'\033[0m }),"
    echo -e "  });"
    echo -e "};"
  done
  echo -e "\033[90m\`\`\`\033[0m"
  echo ""
  echo -e "I've updated the function to handle edge cases. The key changes are:"
  echo -e "  \033[32m+\033[0m Added error handling for network failures"
  echo -e "  \033[32m+\033[0m Implemented retry logic with exponential backoff"
  echo -e "  \033[31m-\033[0m Removed deprecated API call on line 42"
  echo ""
done

end=$(time_it)
duration=$(python3 -c "print(f'{$end - $start:.2f}')")
echo ""
echo "  => Scrollback built in ${duration}s"

# ============================================
# Phase 2: Measure responsiveness WITH heavy scrollback
# ============================================
echo ""
echo "[Phase 2] Testing responsiveness with full scrollback buffer..."
echo ""

# Test A: New output after huge scrollback
echo "  [2a] Fresh output after 100k lines of scrollback..."
start=$(time_it)
for i in $(seq 1 5000); do
  echo -e "\033[34mimport\033[0m { \033[33museMemo\033[0m } \033[34mfrom\033[0m \033[32m'react'\033[0m; // line $i"
done
end=$(time_it)
duration=$(python3 -c "print(f'{$end - $start:.2f}')")
echo "  => ${duration}s"

# Test B: Rapid interleaved color changes (cursor movement + redraws)
echo ""
echo "  [2b] Heavy ANSI formatting (progress bars, spinners)..."
start=$(time_it)
for i in $(seq 1 3000); do
  pct=$((i % 100))
  bar=$(printf '█%.0s' $(seq 1 $((pct / 2))))
  space=$(printf '░%.0s' $(seq 1 $((50 - pct / 2))))
  echo -ne "\r\033[K  \033[36m[$bar$space]\033[0m \033[33m${pct}%%\033[0m Processing file $i..."
done
echo ""
end=$(time_it)
duration=$(python3 -c "print(f'{$end - $start:.2f}')")
echo "  => ${duration}s"

# Test C: Wide lines (long file paths, wrapped output)
echo ""
echo "  [2c] Wide lines (long paths + wrapped content)..."
start=$(time_it)
for i in $(seq 1 5000); do
  echo -e "\033[90m/Users/developer/projects/my-awesome-app/src/components/features/authentication/providers/oauth2/handlers/CallbackHandler.tsx\033[0m:\033[33m$i\033[0m: \033[34mconst\033[0m \033[33mresult\033[0m = \033[34mawait\033[0m \033[33mauthenticate\033[0m(\033[33mrequest\033[0m, \033[33mresponse\033[0m, \033[33mnextFunction\033[0m);"
done
end=$(time_it)
duration=$(python3 -c "print(f'{$end - $start:.2f}')")
echo "  => ${duration}s"

echo ""
echo "============================================"
echo "  Done! Compare results between terminals."
echo "============================================"
