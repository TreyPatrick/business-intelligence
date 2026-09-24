# Extra Instructions

Rules the LLM follows when it writes SQL for `listings`.

- `price` is the nightly price in U.S. dollars. When the user asks 
what something costs, use `price` and round money to whole dollars in the answer.

- `host_is_superhost` is stored as text `'t'` or `'f'` not a boolean. Filter this by
using `host_is_superhost = 't'`

-  Match city names to the 3 values in `city`. If the user says Minneapolis
use `city = 'Twin Cities'`. If they name any other city say the data 
only covers Chicago, Columbus, and the Twin Cities.

- - When comparing prices or revenue across groups, report the median 
alongside the average, since a few very expensive listings skew the mean.



