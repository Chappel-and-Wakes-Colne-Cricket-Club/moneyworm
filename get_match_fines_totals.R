values <- totals[(totals$Category == "1s Match Fines" & totals$WeekStart > "2026-01-01"),]$Amount
sum(values)