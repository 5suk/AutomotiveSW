#!/bin/bash

IMAGE_NAME="5suk/yolo-assignment:latest"
RESULT_DIR="results"
RESULT_FILE="result.jpg"

# ./run.sh 의 첫 번째 인자로 check 옵션이 주어졌는지 검사
if [ "$1" == "check" ]; then
    # check 모드 일 경우 이미지 URL은 두 번째 인자($2)
    URL=$2
    # 객체 인식 결과를 저장 할 디렉토리를 생성
    mkdir -p $RESULT_DIR
    # check 모드 이므로 도커 내부의 객체 인식 결과 이미지 파일을 호스트로 복사하기 위해 데이터 볼륨을 설정하여 docker run 실행
    docker run -v $(pwd)/$RESULT_DIR:/output $IMAGE_NAME "$URL" && code -r $RESULT_DIR/$RESULT_FILE
else
    # 기본 모드 일 경우 이미지 URL은 첫 번째 인자($1)
    URL=$1
    # docker run 볼륨 마운트 없이 실행
    docker run $IMAGE_NAME "$URL"
fi