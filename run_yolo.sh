#!/bin/bash

# docker run 첫 번째 인자로 전달된 URL을 변수에 저장
IMAGE_URL=$1

# wget을 사용하여 url로부터 이미지를 다운로드하여 'input.jpg'로 저장
wget -O input.jpg $IMAGE_URL

# 다운로드 된 이미지에 대해 dockerfile 에서 다운로드 해둔 yolo 가중치를 사용하여 객체 검출 수행 
./darknet detector test cfg/coco.data cfg/yolov3.cfg yolov3.weights input.jpg

# 결과 이미지를 /output 디렉토리에 result.jpg로 복사
cp predictions.jpg /output/result.jpg