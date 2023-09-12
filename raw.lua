categories = {
  
  ['EXAM'] = {
    Weight = 50;
    CurrentPoints = 6;
    MaxPoints = 8;
  };
  
  ['TEST'] = {
    Weight = 50;
    CurrentPoints = 21;
    MaxPoints = 22;
  };

}

assignmentEditor = {
  
  ['ogive'] = {
    Category = 'TEST';
    CurrentPoints = 3;
    DesiredPoints = 4;
  };
  ['future test'] = {
    Category = 'TEST';
    CurrentPoints = 0;
    DesiredPoints = 4;
  };
  
}

-- CODE BELOW

for i,v in pairs(assignmentEditor) do
	local targetCategory = categories[v.Category]
  targetCategory.CurrentPoints = targetCategory.CurrentPoints + (v.DesiredPoints - v.CurrentPoints)
end

-- (pts/max) * weight = weighted percentage

local percentage = 0
local weight = 0

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function calculate(prnt)
  for i,v in pairs(categories) do
    local categorypercent = (v.CurrentPoints/v.MaxPoints)*v.Weight
    percentage = percentage + categorypercent
    weight = weight + v.Weight
    if prnt then
      print(i, '=', round(categorypercent, 2)..'%')
    end
  end
end

calculate(false)

if weight ~= 100 then
  error('Check Categories - Weight DOES NOT equal 100%')
end

print('\n', 'Final Grade W/ Fixed Assignment Points:', round(percentage, 2)..'%', '\n')

for i,v in pairs(assignmentEditor) do
	local targetCategory = categories[v.Category]
  targetCategory.CurrentPoints = targetCategory.CurrentPoints - (v.DesiredPoints - v.CurrentPoints)
end

percentage = 0

calculate(false)

print('\n', 'Final Grade Before:', round(percentage, 2)..'%', "(check if this is correct)")