# [TeamGRIT, Inc. Tech Blog](https://blog.teamgrit.kr)
새로운 기술의 혁신, 팀그릿 기술 블로그입니다.   

## 주의사항
- MarkDown 문법을 지켰는지 확인 해 주세요.
- 문서상 오타에 대해서 확인 해 주세요.

## 작성 방법
### 포스트 생성하기
```txt
YEAH-MONTH-DAY-title.md
```
- YEAH: 네자리 숫자 (ex.2021)
- MONTH: 두자리 숫자 (ex.12)
- DAY: 두 자리 숫자 (ex.25)
```txt
Example
2011-12-31-new-years-eve-is-awesome.md
2012-09-12-how-to-write-a-blog.md
```
```md
---
layout: article
title: "Hello! We are TeamGRIT, Inc."
date: 2021.11.23
tags: "Hello"
---
```
- `layout`: 글에서 사용하는 레이아웃을 선택 해 주세요. 통상적인 글인 경우 `article`를 입력해 주세요.
- `title`: 글의 제목을 입력 해 주세요.
- `date`: 작성한 날짜를 입력 해 주세요. 파일 이름과 명시 되어 있는 날짜와
- `tags`: 글에서 태그를 달아주세요.
    - **띄어쓰기를 하는 경우 정상적으로 태그가 인식되지 않는 경우가 있습니다.**
        -  `"Hello TeamGRIT"`: 정상적인 인식이 됩니다.
        - `"Hello MicroService Architecture"`: 정상적인 인식이 안 됩니다. 
            - 해결법은 `"Hello MicroService-Architecture"`으로 해 주시면 됩니다.
    - 태그의 경우 자유롭게 달아 주셔도 됩니다. ***단, 언어와 기술에 관련된 경우 언와 기술에 대한 태그를 달아 주세요.***

## 커밋 규칙
커밋 규칙은 간단합니다. 커밋 권한이 없는 경우 요청 해 주세요.
- Branch를 생성해 주세요.
    - Branch 이름의 경우 각자의 성함 또는 닉네임으로 설정 해 주세요.
- 업로드 하고 싶으신 게시물을 작성 후 생성해 주신 Branch 커밋 해 주세요.
- 커밋 메시지는 되도록이면 [**Conventinal Commit Messages**](https://gist.github.com/qoomon/5dfcdf8eec66a051ecd85625518cfd13)를 참고하셔서 커밋 해 주세요.