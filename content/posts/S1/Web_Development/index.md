---
title: 'Web Development'
date: 2024-07-01T02:08:01+02:00
draft: false
tags: ["default"]
weight: 10
typora-copy-images-to: ${filename}.assets
summary: null
# cover:
#   image: /poi.jpg
#   caption: "poi"
---

## Javascript

https://github.com/Asabeneh/30-Days-Of-JavaScript

### Data Types

```javascript
let numOne = 3
let numTwo = 3
console.log(numOne == numTwo)      // true
let js = 'JavaScript'
let py = 'Python'
console.log(js == py)             //false 
let lightOn = true
let lightOff = false
console.log(lightOn == lightOff) // false
```



## Server

https://javascript.info/url

![image-20240416150757929](./index.assets/image-20240416150757929.png)





## Some QA

### **readFile vs readFileSync**[^4]

**readFile() and the fs. readFileSync() method. The first method will read the file content in a non-blocking asynchronous manner and return the content in a callback function. **The readFileSync() method, on the other hand, will read the file synchronously i.e, code executions are blocked until this process is completed.



### Difference between `<button type="submit">` and `<input type="submit">`[^5]

The difference is that `<button>` can have content, whereas `<input>` cannot (it is a null element). While the button-text of an `<input>` can be specified, you cannot add markup to the text or insert a picture. So `<button>` has a wider array of display options.





## Reference

[^1]: [Difference between Display:none and visibility:hidden](https://www.linkedin.com/pulse/difference-between-displaynone-visibilityhidden-aman-varshney/)
[^2]:  https://www.w3schools.com/css/tryit.asp?filename=trycss_display
[^3]: [AJAX - The XMLHttpRequest Object](https://www.w3schools.com/js/js_ajax_http.asp)
[^4]: https://www.memberstack.com/blog/reading-files-in-node-js
[^5]: https://html.com/attributes/button-type/#ixzz8XkG11tMR