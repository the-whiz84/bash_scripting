1. Explaining IF

if [condition]
then
  statements(s) for when condition is true
elif [condition]
then
  statements(s) for when condition is true
elif...
then...

else
  statements(s) for when no previously conditions were true

# Alternative way
if [condition]; then
  statement(s) for when condition is true
elif [condition]; then
  statements(s) for when condition is true
else
  statements(s) for when no previously conditions were true

2. AND with if statement

if [condition] && [condition]; then
  statement(s) for when both conditions are true
fi

3. OR with if statement

if [condition] || [condition]; then
  statement(s) for when at least one condition is true
fi

4. Negate if condition

if [!condition]; then
  statement(s) when the condition is not true
fi

if ![condition]; then
  statement(s) when the condition is not true
fi
