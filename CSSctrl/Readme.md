# javascript를 활용하여 CSS의 속성 제어

## 속성값 조회 - getBoundingClientRect

```html
    <style>
    body{
        padding:0;
        margin:0;
    }
    #target{
        width:100px;
        height:100px;
        border:50px solid #1065e6;
        padding:50px;
        margin:50px;
    }
    </style>
    <div id="target">
        Coding
    </div>
    <script>
    var t = document.getElementById('target');
    console.log(t.getBoundingClientRect()); // div의 css속성을 ClientRect객체로 반환
    </script>
```

![](https://s3.ap-northeast-2.amazonaws.com/opentutorials-user-file/module/904/2402.png)

## 어떤 객체를 기준으로 거리를 재는가? - offsetParent

```html
<style>
    body{
        padding:0;
        margin:0;
    }
    div{
        border:50px solid #1065e6;
        padding:50px;
        margin:50px;
    }
    #target{
        width:100px;
        height:100px;
    }
</style>
<div>
    <div id="target">
        Coding
    </div>
</div>
<script>
var t = document.getElementById('target');
console.log(t.getBoundingClientRect());
console.log(t.offsetParent);
</script>

```

![](https://s3.ap-northeast-2.amazonaws.com/opentutorials-user-file/module/904/2404.png)
![](https://s3.ap-northeast-2.amazonaws.com/opentutorials-user-file/module/904/2406.png)

```css
    
    div{
        border:50px solid #1065e6;
        padding:50px;
        margin:50px;
    }
    #target{
        width:100px;
        height:100px;
    }

    left거리 계산 
    부모 div의 margin + border + padding = 150px + 자식 div(id: target)의 margin 50px = 200px
    이것을 보면 부모 div부터의 상대거리가 아닌 body태그로부터의 상대거리임을 알 수 있다.
    그러면 이 상대적 척도가 되는 태그는 어떻게 알 수 있는가?
    => offsetParent
```

## 테두리 제외 태그의 넓이, 높이

+ ClientWidth
+ ClientHeight

## viewport

![](https://s3.ap-northeast-2.amazonaws.com/opentutorials-user-file/module/904/2408.png)

+ getBoundingClientRect() : viewprot와의 상대적 거리요소들의 집합(viewport좌표 집합)
+ pageYoffset : 상/하 스크롤을 얼마나 내렸는지에 대한 상대적 거리
+ pageXoffset : 좌/우 스크롤을 얼마나 내렸는지에 대한 상대적 거리

```html
<style>
    body{
        padding:0;
        margin:0;
    }
    div{
        border:50px solid #1065e6;
        padding:50px;
        margin:50px;
    }
    #target{
        width:100px;
        height:2000px;
    }
</style>
    <div>
        <div id="target">
            Coding
        </div>
    </div>
 
<script>
var t = document.getElementById('target');
// setInterval함수는 지정된 시간마다 반복되게 하는 함수
setInterval(function(){ 
    console.log('getBoundingClientRect : ', t.getBoundingClientRect().top, 'pageYOffset:', window.pageYOffset);
}, 1000)
</script>
```

## 스크롤 제어

+ scrollTo(x좌표, y좌표);
+ scrollLeft(), scrollTop() - 원상복구

## 스크린 크기 구하기

```html
<script>
console.log('window.innerWidth:', window.innerWidth, 'window.innerHeight:', window.innerHeight); // viewport의 크기
console.log('screen.width:', screen.width, 'screen.height:', screen.height); // 모니터 해상도
</script>
```