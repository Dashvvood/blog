---
title: 'Python_Basic'
date: 2024-07-01T01:47:40+02:00
draft: false
tags: ["default"]
weight: 10
typora-copy-images-to: ${filename}.assets
summary: null
# cover:
#   image: /poi.jpg
#   caption: "poi"
---



## Pandas

### Grapha Pandas[^1]

```python
import pandas as pd
import numpy as np
dates = pd.date_range('20130101', periods=6)
df = pd.DataFrame(np.random.randn(6,4), index=dates, columns=list('ABCD'))
df.head()
```

|            |         A |         B |         C |         D |
| ---------: | --------: | --------: | --------: | --------: |
| 2013-01-01 |  0.007402 |  0.203137 |  0.911132 |  0.680898 |
| 2013-01-02 | -2.105881 |  0.634541 | -0.043929 | -0.411951 |
| 2013-01-03 |  0.615758 | -0.716790 | -1.098351 |  0.173866 |
| 2013-01-04 | -0.236918 |  0.135650 | -0.986342 |  0.124379 |
| 2013-01-05 | -0.632543 |  1.112146 | -0.495817 | -0.761970 |

```python
df.tail(3)			# display last rows
df.index			
df.columns
df.values
df.describe()
df.T
df.sort_index(axis=1, ascending=False) 
df.sort_values(by='B')
df['A']
df[0:3]
df['20130102':'20130104']
```

```python
df.loc[dates[0]]
df.loc[:,['A','B']]
df.loc['20130102':'20130104',['A','B']]
df.loc[dates[0],'A']
df.at[dates[0],'A']
df.iloc[3]
df.iloc[3:5, 0:2]
df.iat[1, 1]
```

```python
df[df.A>0]
df[df>0]
df2 = df.copy()
```

```python
df.dropna(how='any')		# Discard rows containing NaN
df.fillna(value=5)			# Fill in missing data
pd.isnull(df)
```





## Reference

[^1]: https://pandas.liuzaoqi.com/doc/chapter0/10%E5%88%86%E9%92%9F%E5%85%A5%E9%97%A8pandas.html