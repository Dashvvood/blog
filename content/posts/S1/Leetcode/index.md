---
title: 'Leetcode'
date: 2024-07-01T01:59:10+02:00
draft: false
tags: ["default"]
weight: 10
typora-copy-images-to: ${filename}.assets
summary: "leetcode note"
# cover:
#   image: /poi.jpg
#   caption: "poi"
---

## Basic

**max(vector)**

```c++
// Returns an iterator pointing to the element with the largest value in the range [first,last)
std::max_element(v.begin(), v.end()); 
*std::max_element(dp.begin(), dp.end());
```

**argmin(vector)**

```c++
size_t argmin(vector<int> &v) {
    return std::distance(v.begin(), std::min_element(v.begin(), v.end()));
}
```

**lower_bound**

```c++
auto it = lower_bound(temp.begin(), temp.end(), nums[i]); 
```



**vector.method**

```c++
int main() {
    vector<int> v = {1,3,6,7,9,4,10,5,6};
    cout << v.front() << " " << v.back() << endl;
    cout << *v.begin() << " " << *v.end() << endl;

    cout << &v.front() << " " << &v.back() << endl;
    cout << &*v.begin() << " " << &*v.end() << endl;
    return 0;
}
/*
1 6
1 0
0x5fed60e25eb0 0x5fed60e25ed0
0x5fed60e25eb0 0x5fed60e25ed4
*/
```



**lambda**

```c++
vector<int> v = {3, 7, 2};
void addOne(int x, function<void(int)> f) {
    f(x);
}
int main() {
    fmt::print("{}\n", v);
    addOne(0, [=](int i) {v[i] += 1;});
    fmt::print("{}\n", v);
    addOne(0, [&](int i) {v[i] += 1;});
    fmt::print("{}\n", v);
    addOne(0, [](int i) {v[i] += 1;});
    fmt::print("{}\n", v);
    return 0;
}

/*
[3, 7, 2]
[4, 7, 2]
[5, 7, 2]
[6, 7, 2]
*/
```

---

---

## Exercise

[<img alt="Static Badge" src="https://img.shields.io/badge/300-longest%20increasing%20subsequence-%23FFA116?style=flat&logo=leetcode">](https://leetcode.cn/problems/longest-increasing-subsequence/description/)

**A fast solution**

```c++
class Solution {
public:
    int lengthOfLIS(vector<int>& nums) {
        vector<int> temp;
        for (int i = 0; i < nums.size(); i++) {
            auto it = lower_bound(temp.begin(), temp.end(), nums[i]);
            if (it != temp.end()) {
                *it = nums[i];
            } else {
                temp.push_back(nums[i]);
            }
        }
        return temp.size();
    }
};
```

>Cool: auto it = lower_bound(temp.begin(), temp.end(), nums[i]);

**DP method 1**

Define dp[i]  as the length of the longest increasing subsequence that ends with the i-th element when considering the first i elements. Note that nums[i] must be included.

```c++
if (nums[j] < nums[i]) {
    dp[i] = max(dp[i], dp[j] + 1);
}
// https://leetcode.cn/problems/longest-increasing-subsequence/solutions/147667/zui-chang-shang-sheng-zi-xu-lie-by-leetcode-soluti/
```



**DP method 2**

Define `dp[i]` as the minimum value of  the last element of the longest increasing subsequence.

```c++
if (nums[i] > d[len]) {
    d[++len] = nums[i];
} else {
    // Binary Search Method
    d[pos + 1] = nums[i];
}
```

---

[<img alt="Static Badge" src="https://img.shields.io/badge/673-number%20of%20longest%20increasing%20subsequence-%23FFA116?style=flat&logo=leetcode">](https://leetcode.cn/problems/number-of-longest-increasing-subsequence/description/)

**DP method 1**

- `dp[i]` represents the length of *subsequence* ended by `nums[i]`
- `cnt[i]` count the number of subsequence with same length.

```c++
class Solution {
public:
    int findNumberOfLIS(vector<int>& nums) {
        int n = nums.size(); 
        int ans = 0;
        int max_len = 0;
        vector<int> dp(n, 1);
        vector<int> cnt(n, 1);

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (nums[i] > nums[j]) {
                    if (dp[j] + 1 > dp[i]) {
                        dp[i] = dp[j] + 1;
                        cnt[i] = cnt[j];
                    } else if (dp[j] + 1 == dp[i]) {
                        cnt[i] += cnt[j];
                    }
                } 
            }
            if (dp[i] > max_len) {
                max_len = dp[i];
                ans = cnt[i];
            } else if (dp[i] == max_len) {
                ans += cnt[i];
            }
        }
        return ans;
    }
};
```

**Faster solution**

```c++
int binarySearch(int n, function<bool(int)> f) {
    int l = 0, r = n;
    while (l < r) {
        int mid = (l + r) / 2;
        if (f(mid)) {
            r = mid;
        } else {
            l = mid + 1;
        }
    }
    return l;
}

 int i = binarySearch(d.size(), [&](int i) { return d[i].back() >= v; });
```

---

[<img alt="Static Badge" src="https://img.shields.io/badge/354-russian%20doll%20envelopes-%23FFA116?style=flat&logo=leetcode">](https://leetcode.cn/problems/russian-doll-envelopes/)

two dimensions dp problem, fix the first dimension, we then get a single dimension problem like N.300.

**key sort rule**

```c++
sort(envelopes.begin(), envelopes.end(), [](const auto& e1, const auto& e2) {
    return e1[0] < e2[0] || (e1[0] == e2[0] && e1[1] > e2[1]);
});
```

---

[<img alt="Static Badge" src="https://img.shields.io/badge/0-maximum%20subarray-%23FFA116?style=flat&logo=leetcode">](https://leetcode.cn/problems/russian-doll-envelopes/)