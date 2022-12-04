const fs = require('fs');

fs.readFile('input', 'utf-8', (err, data) => {
  let lines = data.trim().split("\n");
  let input = lines.map(line => line.split(",").map(pair => pair.split("-").map(num => parseInt(num))));

  let result1 = input.map(([[a, b], [c, d]]) => {
    if (a <= c && b >= d || a >= c && b <= d) { // fully contains each other
      return 1;
    } else {
      return 0;
    }
  }).reduce((acc, val) => acc + val, 0);

  let result2 = input.map(([[a, b], [c, d]]) => {
    if (a < c && b < c || c < a && d < a) { // disjoint
      return 0;
    } else {
      return 1;
    }
  }).reduce((acc, val) => acc + val, 0);

  console.log(result1);
  console.log(result2);
});
