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

# Check date format (YYYY-MM-DD) - using Python for better CSV parsing
python3 << EOF
import csv
import re
import sys

date_pattern = re.compile(r'^\d{4}-\d{2}-\d{2}$')
invalid_dates = []

try:
    with open('$CSV_FILE', 'r') as file:
        reader = csv.reader(file)
        next(reader)  # skip header
        for row_num, row in enumerate(reader, start=2):
            if len(row) >= 6:
                start_date = row[4].strip() if len(row) > 4 else ""
                due_date = row[5].strip() if len(row) > 5 else ""
                
                if start_date and not date_pattern.match(start_date):
                    invalid_dates.append(f"Row {row_num}: Start Date \"{start_date}\"")
                if due_date and not date_pattern.match(due_date):
                    invalid_dates.append(f"Row {row_num}: Due Date \"{due_date}\"")

    if invalid_dates:
        print("❌ Invalid date format found:")
        for invalid in invalid_dates:
            print(invalid)
        print("   Expected format: YYYY-MM-DD")
    else:
        print("✅ All dates in correct format")
except Exception as e:
    print("❌ Error checking dates:", str(e))
EOF

# Check for weekend dates (Saturday=6, Sunday=0) - using Python
python3 << EOF
import csv
import datetime
import sys

weekend_dates = []

try:
    with open('$CSV_FILE', 'r') as file:
        reader = csv.reader(file)
        next(reader)  # skip header
        for row_num, row in enumerate(reader, start=2):
            if len(row) >= 6:
                start_date = row[4].strip() if len(row) > 4 else ""
                due_date = row[5].strip() if len(row) > 5 else ""
                
                try:
                    if start_date:
                        date_obj = datetime.datetime.strptime(start_date, '%Y-%m-%d')
                        if date_obj.weekday() in [5, 6]:  # Saturday=5, Sunday=6 in Python
                            weekend_dates.append(f"Row {row_num}: Start Date {start_date} is weekend")
                    
                    if due_date:
                        date_obj = datetime.datetime.strptime(due_date, '%Y-%m-%d')
                        if date_obj.weekday() in [5, 6]:
                            weekend_dates.append(f"Row {row_num}: Due Date {due_date} is weekend")
                except ValueError:
                    # Invalid date format, will be caught by previous check
                    pass

    if weekend_dates:
        print("⚠️  Weekend dates found:")
        for weekend in weekend_dates:
            print(weekend)
    else:
        print("✅ No weekend dates found")
except Exception as e:
    print("❌ Error checking weekend dates:", str(e))
EOF

echo "=================================="
echo "Validation complete!"
