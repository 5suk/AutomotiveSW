#!/bin/bash

IMAGE_NAME="5suk/yolo-assignment:latest"
RESULT_DIR="results"
RESULT_FILE="result.jpg"

# 1. 첫 번째 인자가 'check'인지 확인
if [ "$1" == "check" ]; then
    # "check" 모드 (결과 이미지 저장 및 VS Code로 열기)
    
    # URL은 두 번째 인자($2)가 됨
    URL=$2
    
    # URL이 비어있는지 확인
    if [ -z "$URL" ]; then
        echo "오류: 'check' 모드에서는 URL을 두 번째 인자로 입력해야 합니다."
        echo "사용법: ./run.sh check \"<URL>\""
        exit 1
    fi
    
    echo "Check 모드로 실행합니다. 결과를 ${RESULT_DIR}/${RESULT_FILE}에 저장하고 VS Code로 엽니다..."
    
    # 결과 폴더 생성 (이미 있어도 오류 없음)
    mkdir -p $RESULT_DIR
    
    # Docker 실행 (볼륨 마운트) && VS Code로 결과 열기
    # (Windows PowerShell의 경우 $(pwd) 대신 ${PWD} 사용)
    docker run -v $(pwd)/$RESULT_DIR:/output $IMAGE_NAME "$URL" && code -r $RESULT_DIR/$RESULT_FILE

else
    # 기본 모드 (터미널에만 출력)
    
    # URL은 첫 번째 인자($1)가 됨
    URL=$1
    
    # URL이 비어있는지 확인
    if [ -z "$URL" ]; then
        echo "오류: URL을 입력해야 합니다."
        echo "사용법: ./run.sh \"<URL>\""
        exit 1
    fi
    
    echo "기본 모드로 실행합니다. 결과를 터미널에 출력합니다..."
    
    # Docker 실행 (기본)
    docker run $IMAGE_NAME "$URL"
fi