MATCH (c:Component)
OPTIONAL MATCH (c)-[r]->()
WITH c, COUNT(r) AS fan_out
OPTIONAL MATCH ()-[r]->(c)
WITH c, fan_out, COUNT(r) AS fan_in
WITH c, fan_in, fan_out,
     CASE 
       WHEN fan_in + fan_out = 0 THEN NULL
       ELSE toFloat(fan_out) / (fan_in + fan_out)
     END AS instability
RETURN 
  c.name AS Component,
  c.type AS Type,
  fan_in AS `Fan-In`,
  fan_out AS `Fan-Out`,
  CASE 
    WHEN instability IS NULL THEN 'N/A'
    ELSE toString(instability)
  END AS `Instability (I)`,
  CASE 
    WHEN instability IS NULL THEN 'Isolated'
    WHEN instability = 0 THEN 'Stable'
    WHEN instability < 0.3 THEN 'Mostly Stable'
    WHEN instability < 0.6 THEN 'Moderate'
    WHEN instability < 0.9 THEN 'Unstable'
    ELSE 'Very Unstable'
  END AS `Stability`
ORDER BY instability DESC NULLS LAST;