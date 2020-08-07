# Text 객체

![](https://s3.ap-northeast-2.amazonaws.com/opentutorials-user-file/module/904/2257.png)


## 기능
- 조회
  - data
  - nodeValue

```html
<p id="target1"><span>Hello world</span></p>
<p id="target2">
    <span>Hello world</span>
</p>
<script>
var t1 = document.getElementById('target1').firstChild;
var t2 = document.getElementById('target2').firstChild;
 
console.log(t1.firstChild.nodeValue);
try{
    console.log(t2.firstChild.nodeValue);   
} catch(e){
    console.log(e);
}
console.log(t2.nextSibling.firstChild.nodeValue);
 
</script>
```

- 조작
  - appendData(data)
  - deleteData(start,end)
  - insertData(start,data)
  - replaceData(start,end,data)
  - subStringData(start,end)

```
ex)

start = 1
end = 5

a b c d e f g
_ _ _ _ _ _ _ ...
0 1 2 3 4 5 6
  ^
  start
  ^
  1 2 3 4 5
          ^
          end

bcdef까지가 선택범위
```

```html
<!DOCTYPE html>
<html>
<head>
    <style>
    #target{
        font-size:77px;
        font-family: georgia;
        border-bottom:1px solid black;
        padding-bottom:10px;
    }
    p{
        margin:5px;
    }
    </style>
</head>
<body>
<p id="target">Cording everybody!</p>
<p> data : <input type="text" id="datasource" value="JavaScript" /></p>
<p>   start :<input type="text" id="start" value="5" /></p>
<p> end : <input type="text" id="end" value="5" /></p>
<p><input type="button" value="appendData(data)" onclick="callAppendData()" />
<input type="button" value="deleteData(start,end)" onclick="callDeleteData()" />
<input type="button" value="insertData(start,data)" onclick="callInsertData()" />
<input type="button" value="replaceData(start,end,data)" onclick="callReplaceData()" />
<input type="button" value="substringData(start,end)" onclick="callSubstringData()" /></p>
<script>
    var target = document.getElementById('target').firstChild;
    var data = document.getElementById('datasource');
    var start = document.getElementById('start');
    var end = document.getElementById('end');
    function callAppendData(){
        target.appendData(data.value);
    }
    function callDeleteData(){
        target.deleteData(start.value, end.value);
    }
    function callInsertData(){
        target.insertData(start.value, data.value); 
    }
    function callReplaceData(){
        target.replaceData(start.value, end.value, data.value);
    }
    function callSubstringData(){
        alert(target.substringData(start.value, end.value));
```

- 생성방법
    - document.createTextNode()