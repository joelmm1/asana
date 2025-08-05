#!/bin/bash
# CSV Validation Script for Asana Import Format

CSV_FILE="$1"

if [ -z "$CSV_FILE" ]; then
    echo "Usage: $0 <csv-file>"
    echo "Example: $0 master-projects.csv"
    exit 1
fi

if [ ! -f "$CSV_FILE" ]; then
    echo "Error: File '$CSV_FILE' not found"
    exit 1
fi

echo "Validating CSV file: $CSV_FILE"
echo "=================================="

# Check if file has header row
HEADER=$(head -n 1 "$CSV_FILE")
EXPECTED_HEADER="Task,Parent,Assignee,Assignee Email,Start Date,Due Date,Dependencies,Notes"

if [ "$HEADER" != "$EXPECTED_HEADER" ]; then
    echo "❌ Header mismatch!"
    echo "Expected: $EXPECTED_HEADER"
    echo "Found:    $HEADER"
    exit 1
else
    echo "✅ Header format correct"
fi

# Count total rows
TOTAL_ROWS=$(wc -l < "$CSV_FILE")
DATA_ROWS=$((TOTAL_ROWS - 1))
echo "✅ Total rows: $TOTAL_ROWS (including header)"
echo "✅ Data rows: $DATA_ROWS"

# Check for empty required fields (Task column)
EMPTY_TASKS=$(awk -F',' 'NR>1 && $1=="" {print NR}' "$CSV_FILE")
if [ -n "$EMPTY_TASKS" ]; then
    echo "❌ Empty Task names found on rows: $EMPTY_TASKS"
else
    echo "✅ All tasks have names"
fi

# Check date format (YYYY-MM-DD)
INVALID_DATES=$(awk -F',' 'NR>1 && ($5!="" && $5!~/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/) || ($6!="" && $6!~/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/) {print NR}' "$CSV_FILE")
if [ -n "$INVALID_DATES" ]; then
    echo "❌ Invalid date format found on rows: $INVALID_DATES"
    echo "   Expected format: YYYY-MM-DD"
else
    echo "✅ All dates in correct format"
fi

# Check for weekend dates (Saturday=6, Sunday=0)
WEEKEND_DATES=$(awk -F',' '
NR>1 {
    if ($5 != "") {
        cmd = "date -d " $5 " +%w"
        cmd | getline day_of_week
        close(cmd)
        if (day_of_week == 0 || day_of_week == 6) {
            print "Row " NR ": Start Date " $5 " is weekend"
        }
    }
    if ($6 != "") {
        cmd = "date -d " $6 " +%w"
        cmd | getline day_of_week
        close(cmd)
        if (day_of_week == 0 || day_of_week == 6) {
            print "Row " NR ": Due Date " $6 " is weekend"
        }
    }
}' "$CSV_FILE")

if [ -n "$WEEKEND_DATES" ]; then
    echo "⚠️  Weekend dates found:"
    echo "$WEEKEND_DATES"
else
    echo "✅ No weekend dates found"
fi

echo "=================================="
echo "Validation complete!"
