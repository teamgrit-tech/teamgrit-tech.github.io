---
layout: article
title: GDG Golang Korea Go1.18 릴리즈 파티 발표 후기
date: 2022.04.20
tags: golang 발표
comment: true
key: article-post-gdg-golang-korea
---
안녕하세요? 팀그릿에서 미디어 스토리지를 개발하고 있는 [박현상(HyunSang Park)](https://github.com/Dev-HyunSang)입니다.
  
2022년 3월 31일 [GDG Golang Korea Go1.18 릴리즈 파티](https://gdg.community.dev/events/details/google-gdg-golang-korea-presents-golang-118-release-party/)에서 **"Go와 FFmpeg를 이용한 영상 처리 그리고 AWS S3 활용하기"**라는 주제로 발표를 진행하였습니다. 팀그릿에서 어떻게 미디어 스토리지를 개발하였는지를 중점으로 이야기 하였습니다.  
기술과 관련된 발표가 처음이었고 많은 부분이 매끄럽진 않지만 재밌게 발표하였습니다.  

<img src="https://rawcdn.githack.com/teamgrit-tech/teamgrit-tech.github.io/ff3324efb08d786fdff2844d85c0ffc99145e660/_posts/images/2022-04-01/00.png" width="500" height="500">
<iframe width="560" height="315" src="https://www.youtube.com/embed/W-VWcP_vnZ4" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
<iframe src="https://docs.google.com/presentation/d/e/2PACX-1vTf17q9nxK_SaRP_mgQFEyFIZ9rDSDg6PnrhhXJ_aXZEM-_xryLF-8KbWMXW7Ngug/embed?start=false&loop=false&delayms=5000" frameborder="0" width="480" height="299" allowfullscreen="true" mozallowfullscreen="true" webkitallowfullscreen="true"></iframe>


## 들어가기 앞서서 미디어 스토리지를 왜 개발하게 되었는가?
팀그릿에서 자체적으로 개발한 미디어 서버인 Spider가 있습니다. Spider에서 녹화된 영상들을 저장하고 가공 해야하는 필요성을 느끼게 되어 개발하게 되었습니다. 즉 사용자가 Spider를 통해 녹화한 영상을 VOD 서비스처럼 제공해 줄 필요성이 늦게 되었습니다. 더불어 Spider 자체적으로 미디어를 저장하는 것보다 다른 시스템에 저장하는 것이 미디어를 관리 및 제공함에 있어서 더욱 효율적이라 생각이 들어 개발하게 되었습니다.
영상에 대한 **가공**하고 **저장하는 공간**을 만드는 게 핵심적인 업무였습니다.  
미디어 스토리지를 Go와 FFmpeg, AWS S3, AWS CloudFront, SQLite 등을 사용하여서 개발하였습니다.  
사내에서는 "Scorpion"라는 이름으로 불리고 있습니다. 현재까지도 더 필요한 기능들이 있는지 물색하고 업그레이드 하고 있습니다.

## 발표는 왜 하게 되었는지?
저는 "Go언어"는 제게 있어서 너무나도 애증하는 관계입니다. 애증하는 마음만큼 많이 사용하고 있습니다. 우연히 회사에서 미디어 스토리지를 Go언어를 이용하여 개발할 수 있는 계기가 생기게 되었습니다. Go언어를 좋아하는 만큼 자주 Golang Korea의 행사에 참여하게 되었고 행사에서 꾸준히 발표자를 구하고 있다는 이야기를 들어 [GDG Golang Korea 발표자 모집 (Application)](https://docs.google.com/forms/d/e/1FAIpQLSc0VPn4haGPNRWMv5uAmbdHpfND6qMEYX-Mxwjetb0UdxemFw/viewform)를 통해서 발표를 신청하게 되었습니다.

![GDG Golang Korea E-mail](https://rawcdn.githack.com/teamgrit-tech/teamgrit-tech.github.io/95d6101673d2501a6bd38b43ce2cb8a8e447e107/_posts/images/01.png)

발표 요청을 드렸더니 메일로 발표가 가능한지 물어봐 주셔서 저는 당연히 된다고 하였고 본격적으로 발표를 준비하게 되었습니다.

## 발표자료 준비하기
처음으로 기술과 관련된 발표를 진행하다 보니 고민이 많았습니다. 무엇을 중점적으로 이야기를 해야하는지 그리고 내가 말하는 내용이 과연 정확한지 등 수많은 고민을 하였지만 주변 분들께서 "자신에 대한 자신감을 가지고 발표자료를 만들라"라는 충고를 받게 되었습니다.  

**중점적으로**  
1. Golang와 FFmpeg를 어떻게 사용하면 좋은지?
    - Golang와 FFmpeg를 함께 사용하면서 이었던 시행착오들
2. AWS S3와 관련된 기능들 
    - 업로드, 버킷 생성, 버킷 리스트 등...

## Go와 FFmpeg 그리고 AWS S3
본격적으로 미디어 스토리지를 개발하기 전 Go, FFmpeg, AWS S3를 함께 사용하기 위해서는 "무엇이 필요한지", "고려할 사항들은 무엇인지" 등을 고민하게 됩니다.

### Go와 FFmpeg를 사용할 수 있는 방법은?
Golang과 FFmpeg를 활용하기로 결정하면서 "어떻게 잘 사용할 수 있도록 할까?"라는 생각을 하게 되었습니다.
두 가지 방법이 있습니다. **기존의 오픈 되어 있는 패키지 사용하자** 또는 **새로운 패키지를 만들자**라는 생각이 들었습니다.   
중점적으로는 `.webm`에서 `.mp4`로의 변환, `.mp4`에서 HLS(HTTP Live Streaming) 서비스를 할 수 있도록 기능을 개발하였습니다.

- `.webm`에서 `.mp4`로 변환하는 경우에는 오픈되어 있는 패키지를 사용하지 않고 따로 패키지를 개발하였습니다.
- `.mp4`에서 HLS(HTTP Live Streaming)로 서비스하는 경우 오픈되어 있는 패키지를 사용하여 개발하였습니다.

#### 사용할 수 있는 패키지
GitHub에 오픈되어 있는 패키지들에 대해서 살펴보았습니다.
- [u2takey/ffmpeg-go](https://github.com/u2takey/ffmpeg-go)
- [xfrr/goffmpeg](https://github.com/xfrr/goffmpeg)
- [shimberger/gohls](https://github.com/shimberger/gohls)

위 3가지의 패키지들을 중점적으로 살펴 보았습니다. `.webm`에서 `.mp4`로 변환하는 경우를 오픈소스 패키지로 테스트를 진행한 결과 올바른 결과물(영상)이 나오지 않아 오픈된 패키지를 사용하지 않고 새로운 패키지를 만들어 사용하는 방안으로 결정하여 사용중입니다.

### webm에서 mp4로 변환해 보자!
본격적으로 FFmpeg와 Golang를 통해서 변환을 하는 방법에 대해서 이야기 해 보도록 하겠습니다.  
초반에 테스트 과정에서는 [u2takey/ffmpeg-go](https://github.com/u2takey/ffmpeg-go)를 사용하여 테스트 하였지만 원하는 결과물(영상)을 도출하지 못 하여서 따로 패키지를 만들어서 사용하는 방안을 선택하였습니다. 또한 기본적인 명령어를 사용하여 FFmpeg를 사용하는 경우 오류가 발생되어 중복 프레임을 거를 수 있는 필터를 사용하여 개발을 진행하였습니다.  

```go
// 로컬 터미널에서 FFmpeg 명령어를 이용하여서 영상을 변환합니다.
// webm to mp4(h.264)
func LocalMP4Extensions(channel, objectName string) error {
	input := fmt.Sprintf("%s/videos/download/%s/%s.webm", config.PathWay(), channel, objectName) // 1
	output := fmt.Sprintf("%s/videos/ffmpeg/%s/%s.mp4", config.PathWay(), channel, objectName) // 2
	ffmpegCommand := fmt.Sprintf("-i %s -vf mpdecimate,setpts=N/FRAME_RATE/TB -c:a copy -c:v libx264 -preset medium -crf 18 -max_muxing_queue_size 1024 %s", input, output) // 3
	cmd := strings.Split(ffmpegCommand, " ") // 4
	log.Println(color.BlueString("Input Location"), input)
	log.Println(color.BlueString("Output Location"), output)

	ffmpegPath := "/usr/local/bin/ffmpeg" // 5 
	ffmpeg := exec.Command(ffmpegPath, cmd...) // 6

	ffmpeg.Stdout = os.Stdout
	ffmpeg.Stderr = os.Stderr

	err := ffmpeg.Start()
	log.Println(color.GreenString("SUCCESS"), "successfully converted")

	return err
}
```
위와 같은 내용으로 개발하였습니다. 또한 서버에서 FFmpeg를 이용하여서 변환할 수 있도록 개발하였습니다.

1. Spider 서버에서 저장되어 있는 영상의 위치를 지정합니다.
2. FFmpeg의 변환 이후 저장되어야할 위치를 지정합니다.
3. FFmpeg 명령어를 입력하였습니다.
	- FFmpeg와 관련된 명령어는 [ffmpeg Documentation](https://ffmpeg.org/ffmpeg.html)에서 볼 수 있습니다.
4. `strings.Split`를 사용하지 않는 경우 오류가 발생하여 `strings.Split`를 사용하여서 해결해 주었습니다.
5. FFmpeg 설치 되어 있는 경로를 지정하였습니다. 타 오픈소스의 경우에도 이렇게 동작하는 것을 확인하여 따라서 개발하였습니다.
6. 최종적으로 실행하게 되며, 변환되는 로그들이 터미널에 그대로 출력되게 됩니다.

#### 문제점
위 코드에서 몇 가지의 문제점이 발생하게 됩니다. 만약 클라우드(AWS, NCP...)를 사용하고 있다면 몇 가지의 문제점이 발생할 수 있습니다. FFmpeg를 사용하여 영상 변환을 하게 된다면 하드웨어적인 리소스를 많이 사용하게 됩니다. 영상 변환에 상당한 리소스를 사용하게 되며, 그로 인해서 시스템이 느려지거나 사용자 요청에 있어서 오래 걸릴 수도 있다는 단점이 존재하게 됩니다.  
위와 같은 문제점을 해결하고자 추후에는 AWS Lambda를 이용해서 영상을 변환하고자 합니다.  

## 마무리 
발표 내용을 다 쓰려고 하였지만 너무 길어지면 재미가 없어질 것 같아서 이쯤에서 마무리합니다!  
더 궁금하신 점이 있으시다면 제 발표 영상 및 제 발표 자료를 봐 주시면 감사합니다.  

아직은 많이 부족한 주니어 개발자의 글이자 발표 봐 주셔서 감사합니다.  
아직은 배울 점이 많지만 시간이 지날수록 부족한 채워질 것이라 생각이 듭니다.  
제 발표에서 궁금한 점이 생기셨다면 [*hyun.sang@teamgrit.kr*](mailto:hyun.sang@teamgrit.kr)로 연락 주시면 제가 아는 선에서 최대한 답변 드리겠습니다. 읽어주셔서 감사합니다!