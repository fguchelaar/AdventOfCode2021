# 08 [Seven Segment Search] 

Based on the provided information, all segments are labeled a-g as following:

```
  aaaa
 b    c
 b    c 
  dddd
 e    f
 e    f
  gggg
```

We need to follow some steps to deduce which segment is which, based on the provided patterns. First, here is a table with
the occurence-count of each segment for all digits 0-9

| Segment | Occurences |
| ------- | ---------- |
| a       | 8          |
| b       | 6          |
| c       | 8          |
| d       | 7          |
| e       | 4          |
| f       | 9          |
| g       | 7          |

Then you can deduce some segments directly based on the provided patterns. Namely segment `b`, `e` and `f`. Those have a unique count.

Then you can find segment `a`, which is the top segment of the digit `7`, after removing the two segments of `1`  (c,f) from the segments of `7` (a,c,f).

Now there is only one segment left with a count of 8, which is `c`.

Next up find `d` by subtracing segments `b`, `c` and `f` from the only pattern with a length of 4 (which is the `4` digit.)

That leaves us with the last segment: `g`.

The algorithm is also documented inline in the code.
