# DOM 이란?

Document Object Model로 웹페이지를 자바스크립트로 제어하기 위한 객체 모델을 의미한다. 
window 객체의 document 프로퍼티를 통해서 사용할 수 있다. Window 객체가 창을 의미한다면 
Document 객체는 윈도우에 로드된 문서를 의미한다고 할 수 있다. 
문서를 제어하는 방법에 대한 내용을 알아보자

# DOM Tree

![DOMTREE](https://s3.ap-northeast-2.amazonaws.com/opentutorials-user-file/module/904/2234.png)

# 제어할 대상 찾기

```html
        <ul>
            <li class="active">HTML</li>
            <li class="active">CSS</li>
            <li id = "active">JavaScript</li>
        </ul>
        <ol>
            <li>HTML</li>
            <li>CSS</li>
            <li>JavaScript</li>
        </ol>
        <ul>
            <li>HTML</li>
            <li>CSS</li>
            <li>JavaScript</li>
        </ul>
```

+ 태그이름 이용
  ```javascript
          var ul = document.getElementsByTagName('ul')[0]; // 두개의 ul 중 제일 처음의 ul만 고른다.
            console.log(document.getElementsByTagName('ul'));
            console.log(ul);
            var lis = ul.getElementsByTagName('li'); // ul하위의 li만 적용되게
            for(var i = 0; i<lis.length; ++i){
                lis[i].style.color = 'red';
            }
  ```
+ 클래스이름 이용
```javascript
            var lis = document.getElementsByClassName('active'); // class 이름이 active인         element만 
            for(var i = 0; i<lis.length; ++i){
                lis[i].style.color = 'red';
            }
```
+ 아이디이름 이용 - document에서 unique하기에 하나만 조회됨
```javascript
            var li = document.getElementById('active'); // id 이름이 active인 element만
            li.style.color = 'green';
```
+ css 선택 이용
```javascript
            var lis = document.querySelectorAll('li'); // 모든 li태그 리턴
            for(var index in lis){ // property가 순회됨
                alert(typeof index);
                lis[index].style.color = 'red';
            }
            var li = document.querySelector('#active'); // id가 active인거 하나만 리턴됨
            li.style.color = 'blue';
```

# jQuery Tutorial
jQuery의 간단한 사용법
```html
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script> <!-- #include 같은 역할 -->
    <script>
    jQuery( document ).ready(function( $ ) {
        // body의 바로 앞에 (prepend) 추가한다.
      $('body').prepend('<h1>Hello world</h1>');
    });
    </script>
```

```html
<!-- 
    $는 함수 - jqeury function
    인자로는 css가 선택자가 주로 들어온다.
    jquery 객체를 리턴
-->

<!DOCTYPE html>
<html>
<head>
    <style>
    #demo{width:200px;float: left; margin-top:120px;}
    #execute{float: left; margin:0; font-size:0.9em;}
    #execute{padding-left: 5px}
    #execute li{list-style: none}
    #execute pre{border:1px solid gray; padding:10px;}
    </style>
</head>
<body>
<ul id="demo">
    <li class="active">HTML</li>
    <li id="active">CSS</li>
    <li class="active">JavaScript</li>
</ul>
<ul id="execute">
    <li>
        <pre>
            var lis = document.getElementsByTagName('li');
            for(var i=0; i&lt;lis.length; i++){
                lis[i].style.color='red';   
        </pre>
        <pre>
            $('li').css('color', 'red')     
        </pre>
        <input type="button" value="execute" onclick="$('li').css('color', 'red')" />
    </li>
    <li>
        <pre>
            var lis = document.getElementsByClassName('active');
                for(var i=0; i &lt; lis.length; i++){
                    lis[i].style.color='red';   
                }
        </pre>
        <pre>
            $('.active').css('color', 'red')
        </pre>
        <input type="button" value="execute" onclick="$('.active').css('color', 'red')" />
    </li>
    <li>
        <pre>
            var li = document.getElementById('active');
            li.style.color='red';
            li.style.textDecoration='underline';
        </pre>
        <pre>
            $('$active').css('color', 'red').css('textDecoration', 'underline');
        </pre>
        <!--
            $('#active').css('color', 'red').css('textDecoration', 'underline')
            jquery 객체 리턴 -> css메소드가 객체 리턴 -> css메소드가 객체 리턴
            chaining(연속적으로 메소드 호출해서 서로다른 결과를 합쳐서 최종 객체를 만든다.) 
        -->
        <input type="button" value="execute" onclick="$('#active').css('color', 'red').css('textDecoration', 'underline')" />
    </li>
</ul>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
</body>
</html>

```

# HTMLElement
    ```html
    <ul>
    <li>HTML</li>
    <li>CSS</li>
    <li id="active">JavaScript</li>
</ul>
<script>
    /*
        HTMLLIElement - 단수개의 객체
        HTMLCollection - 복수개의 객체
    */
    var li = document.getElementById('active');
    console.log(li.constructor.name); // 객체이름을 조회
    var lis = document.getElementsByTagName('li');
    console.log(lis.constructor.name);

    /*
        HTML + 태그이름 + Element

        - 공통속성도 있고(id, class etc..) - 상속
        - 각 태그에 걸맞는 속성도 있다

        태그들의 자세한 속성을 보기위해서 아래의 링크를 참조
        https://www.w3.org/TR/2003/REC-DOM-Level-2-HTML-20030109/html.html#ID-74680021
    */
    var target = document.getElementById('list');
    console.log(target.constructor.name); //HTMLLIElement
 
    var target = document.getElementById('anchor');
    console.log(target.constructor.name); //HTMLAnchorElement
 
    var target = document.getElementById('button');
    console.log(target.constructor.name); // HTMLInputElement
</script>
    ```
# HTMLCollection
```html
    <ul>
        <li>HTML</li>
        <li>CSS</li>
        <li id="active">JavaScript</li>
    </ul>
    <script>
        console.group('before'); // groupEnd까지 log를 모아서 출력 로그를 그룹핑
        var lis = document.getElementsByTagName('li'); // HTMLCollenction - 유사배열, 배열을 다루듯이 다룰 수 있다.
        for(var i = 0; i < lis.length; i++){
            console.log(lis[i]);
        }
        console.groupEnd();
        console.group('after');
        lis[1].parentNode.removeChild(lis[1]); // element 삭제, 제거 순간 바로 반영
        for(var i = 0; i < lis.length; i++){
            console.log(lis[i]);
        }
        console.groupEnd();
    </script>
```
# jQuery Object

```javascript
    /*
    jquery 함수 $()의 리턴결과가 jquery 객체이다.

    jQuery 객체의 가장 중요한 특성은 암시적인 반복을 수행한다는 것이다. 
    DOM과 다르게 jQuery 객체의 메소드를 실행하면 선택된 엘리먼트 전체에 대해서 동시에 작업이 처리된다.
    암시적 반복은 값을 설정할 때만 동작한다. 값을 가져올 때는 선택된 엘리먼트 중 첫번째에 대한 값만을 반환한다.

    jQuery의 많은 메소드 들이 
    설정방식 - 메소드이름(속성,설정값);
    조회방식 - 메소드이름(속성);
    */    
    // 예시
    // 설정
    $('li').css('color', 'red');
    // 조회
    $('li').css('color');

    var lis = $('li');
    for(var i=0; i<lis.length; ++i){
        console.log(lis[i].constructor); // 각각의 li태그들이 튀어나옴, DOM객체
        lis[i].css('color', 'red'); // error - 왜? dom객체이기 때문에 css라는 메소드가 없음
        $(lis[i]).css('color','red'); // 이제 jquery객체가 되기 때문에 위 코드의 에러가 사라짐
    }

    // map
    var li = $('li');
    li.map(function(index,elem){ // map은 인자로 받은 함수에 index와 dom객체를 넘겨주면서 순회한다.
        console.log(index, elem);
        $(elem).css('color', 'red');
    });
```

# jQuery API

[jQuery API](https://api.jquery.com)

# Element 객체

Element 객체는 엘리먼트를 추상화한 객체다. HTMLElement 객체와의 관계를 이해하기 위해서는 DOM의 취지에 대한 이해가 선행되야 한다. 
DOM은 HTML만을 제어하기 위한 모델이 아니다. HTML이나 XML, SVG, XUL과 같이 마크업 형태의 언어를 제어하기 위한 규격이기 때문에 
Element는 마크업 언어의 일반적인 규격에 대한 속성을 정의하고 있고, 각각의 구체적인 언어(HTML,XML,SVG)를 위한 기능은 HTMLElement, SVGElement, XULElement와 같은 객체를 통해서 추가해서 사용하고 있다.

![DOM 계층구조](https://s3.ap-northeast-2.amazonaws.com/opentutorials-user-file/module/904/2240.png)

+ Element.tagName
    - 해당 엘리먼트의 태그 이름을 알아낸다. 태그 이름을 변경하지는 못한다.
```html
    <ul>
        <li>html</li>
        <li>css</li>
        <li id="active" class="important current">JavaScript</li>
    </ul>
    <script>
        console.log(document.getElementById('active').tagName)
    </script>
```
+ Element.id
    - 문서에서 id는 단 하나만 등장할 수 있는 식별자다. 아래 예제는 id의 값을 읽고 변경하는 방법을 보여준다. 

```html
    <ul>
    <li>html</li>
    <li>css</li>
    <li id="active">JavaScript</li>
    </ul>
    <script>
        var active = document.getElementById('active');
        console.log(active.id);
        active.id = 'deactive';
        console.log(active.id);
    </script>
```

+ Element.className

```html
    <ul>
    <li>html</li>
    <li>css</li>
    <li id="active">JavaScript</li>
    </ul>
    <script>
        var active = document.getElementById('active');
        // class 값을 변경할 때는 프로퍼티의 이름으로 className을 사용한다.
        active.className = "important current";
        console.log(active.className);
        // 클래스를 추가할 때는 아래와 같이 문자열의 더한다.
        active.className += " readed"
    </script>
```

+ Element.classList

```html
    <ul>
    <li>html</li>
    <li>css</li>
    <li id="active" class="important current">JavaScript</li>
    </ul>
    <script>
        function loop(){
            for(var i=0; i<active.classList.length; i++){
                console.log(i, active.classList[i]);
            }
        }
    // 클래스를 추가
    </script>
    <!-- 
        <tag class ="a b c">
            DOMTokenList
            3개
    -->
    <input type="button" value="DOMTokenList" onclick="console.log(active.classList);" />
    <input type="button" value="조회" onclick="loop();" />
    <input type="button" value="추가" onclick="active.classList.add('marked');" /> <!-- 추가 -->
    <input type="button" value="제거" onclick="active.classList.remove('important');" /> <!-- 삭제 -->
    <input type="button" value="토글" onclick="active.classList.toggle('current');" /> <!-- 실행시 마다 넣었다 뺐다가 -->

```

+ 어떤 태그의 하위 태그 속성을 조회할 때

Elment.getElementBy*

```html

<ul>
    <li class="marked">html</li>
    <li>css</li>
    <li id="active"> JavaScript
        <ul>
            <li>JavaScript Core</li>
            <li class="marked">DOM</li>
            <li class="marked">BOM</li>
        </ul>
    </li>
</ul>
<script>
    var list = document.getElementsByClassName('marked');
    console.group('document');
    for(var i=0; i<list.length; i++){
        console.log(list[i].textContent);
    }
    console.groupEnd();
     
    console.group('active');
    var active = document.getElementById('active');     
    var list = active.getElementsByClassName('marked');
    for(var i=0; i<list.length; i++){
        console.log(list[i].textContent);
    }
    console.groupEnd();
</script>
```

+ 실행결과
  + ![](https://s3.ap-northeast-2.amazonaws.com/opentutorials-user-file/module/904/2241.png)

+ Attribute
  + Element.getAttribute(name);
  + Element.setAttribute(name, value);
  + Element.hasAttribute(name);
  + Element.removeAttribute(name);

+ 속성(attribute)과 property의 차이
  + 실제 태그속성의 이름과 같을 때 attribute ex) id
  + 실제 태그속성의 이름과 다를 때 property ex) class, className
  + 둘이 값이 다를 수도 있다.

```html
    <a id="target" href="./demo1.html">ot</a>
    <script>
    //현재 웹페이지가 http://localhost/webjs/Element/attribute_api/demo3.html 일 때 
    var target = document.getElementById('target');
    // http://localhost/webjs/Element/attribute_api/demo1.html 
    console.log('target.href', target.href);
    // ./demo1.html
    console.log('target.getAttribute("href")', target.getAttribute("href"));
    </script>
```

+ jQuery로 속성 제어하기

```html
    <a id="target" href="http://opentutorials.org">opentutorials</a>
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
    <script>
        var t = $('#target');
        console.log(t.attr('href')); //http://opentutorials.org
        t.attr('title', 'opentutorials.org'); // title 속성의 값을 설정한다.
        t.removeAttr('title'); // title 속성을 제거한다.
    </script>
```

[property와 attribute 차이](https://medium.com/@jeongwooahn/html-attribute%EC%99%80-property-%EC%9D%98-%EC%B0%A8%EC%9D%B4-d3c172cebc41)

+ 문서전체말고 일부구역의 element만 조회하고 싶다.
    - selector context
    ```html
        <ul>
            <li class="marked">html</li>
            <li>css</li>
            <li id="active">JavaScript
                <ul>
                    <li>JavaScript Core</li>
                    <li class="marked">DOM</li>
                    <li class="marked">BOM</li>
                </ul>
            </li>
        </ul>
        <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
        <script>
            $( ".marked", "#active").css( "background-color", "red" ); // active구역내의 하위 태그들만을 조회, jquery 함수 두번째 인자로 상위 태그를 넘긴다.
        </script>
    ```
    - 상속관계를 공백을 기준으로 구분지어 jquery 함수 인자로 넘기기
    ```html
         <ul>
            <li class="marked">html</li>
            <li>css</li>
            <li id="active">JavaScript
                <ul>
                    <li>JavaScript Core</li>
                    <li class="marked">DOM</li>
                    <li class="marked">BOM</li>
                </ul>
            </li>
        </ul>
        <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
        <script>
           $( "#active .marked").css( "background-color", "red" );
        </script>
    ```
    - .find(), chaining관계를 유지하며 조회하고 싶을 때 사용
    ```html
        <ul>
            <li class="marked">html</li>
            <li>css</li>
            <li id="active" style="color: blue;">JavaScript
                <ul>
                    <li>JavaScript Core</li>
                    <li class="marked" style="background-color: red;">DOM</li>
                    <li class="marked" style="background-color: red;">BOM</li>
                </ul>
            </li>
        </ul>
    ```

# Node 객체

### DOM에서 최상위 객체

![](https://s3.ap-northeast-2.amazonaws.com/opentutorials-user-file/module/904/2242.png)

+ 관계
  - 엘리먼트는 서로 부모, 자식, 혹은 형제자매 관계로 연결되어 있다. 각각의 Node가 다른 Node와 연결된 정보를 보여주는 API를 통해서 문서를 프로그래밍적으로 탐색할 수 있다.
  - 주의할 점은 태그들 사이의 `\n`과 `' '`들도 text객체로 자식에 포함됨 무조건 태그를 가르키는게 아니라는 점
  - Node.childNodes
  - Node.parentNode
  - Node.firstChild
  - Node.lastChild
  - Node.nextSibling
  - Node.previousSibling
  - Node.contains()
  - Node.hasChildNodes()

+ 종류
  - Node 객체는 모든 구성요소를 대표하는 객체이기 때문에 각각의 구성요소가 어떤 카테고리에 속하는 것인지를 알려주는 식별자를 제공한다. 
  - Node.nodeType
  ```javascript
        for(let name in Node){
            console.log(name, Node[name]); // type별로 숫자 식별자가 있음
        }
  ```
  - Node.nodeName 

+ 값
  - Node 객체의 값을 제공하는 API
  - Node.nodeValue
  - Node.textContent

+ 자식관리
    - Node 객체의 자식을 추가하는 방법에 대한 API
    - Node.appendChild()
    - Node.removeChild()

