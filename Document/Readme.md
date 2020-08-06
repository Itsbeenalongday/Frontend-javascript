# Document Object란?
+ html문서에서 HTMLDocument객체를 사용하여 문서를 제어

![](https://s3.ap-northeast-2.amazonaws.com/opentutorials-user-file/module/904/2255.png)

+ Node객체를 상속받는 객체이다

```html
<script>
//document 객체는 window 객체의 소속이다.
console.log(window.document);
//document 객체의 자식으로는 Doctype과 html이 있다. 
console.log(window.document.childNodes[0]);
console.log(window.document.childNodes[1]);
</script>
```

+ 노드 생성
```javascript
let li = document.createElement('li');
let txt = document.createTextNode();
```

+ 문서 전체에서 조회

```javascript
let li = document.getElmentByTagName('li');
```

+ 문서 정보 API
    - title
    - URL
    - reference(경유 링크)
    - lastModified