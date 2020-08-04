# note

1. script 파일의 위치

```html
<!DOCTYPE html>
<html lang="kor">
    <head>
         <script type="text/javascript">
            var hw = document.getElementById('hw'); <!-- 여기까지 인터프리터가 읽으면 hw는 이보다 아래에 있기 때문에 인지를 못한다. -->
                                                    <!-- 때문에 hw에는 null이 담기게 된다 -->
            hw.addEventListener('click', () -> alert('Hello world'););
        </script>
    </head>
    <body>
        <input type="button" id="hw" value="Hello world" />
    </body>
</html>
```

2. 위 코드의 문제를 해결

```html
<!DOCTYPE html>
<html lang="kor">
    <head>
         <script type="text/javascript">
         <!--
         onload는 웹페이지의 모두 읽히고, 페이지가 완성이 되었을 때
         onload메소드가 호출된다.
         때문에 onload가 실행되면서 여기의 코드가 하나하나 실행된다.
         -->
            window.onload = () -> {
                var hw = document.getElementById('hw');
                hw.addEventListener('click', () -> alert('Hello world'););
            }
        </script>
    </head>
    <body>
        <input type="button" id="hw" value="Hello world" />
    </body>
</html>
```

그래서 script태그는 body태그의 끝부분에 넣는게 좋다. 속도측면에서도 좋다