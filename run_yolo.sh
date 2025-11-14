#!/bin/bash

# 1. 'docker run' 명령어의 첫 번째 인자(URL)를 변수에 저장
IMAGE_URL=$1

# 2. URL에서 이미지를 다운로드 (이름을 'input.jpg'로 강제 지정)
#    -O 옵션: 다른 이름으로 저장
wget -O input.jpg $IMAGE_URL

# 3. 다운로드한 'input.jpg' 파일을 대상으로 객체 검출 실행 [cite: 19]
./darknet detector test cfg/coco.data cfg/yolov3.cfg yolov3.weights input.jpg

# 4. 결과 파일을 '/output/result.jpg'로 이동
cp predictions.jpg /output/result.jpg