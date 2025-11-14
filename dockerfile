# 기본 이미지를 Ubuntu 20.04로 설정
FROM ubuntu:20.04

# 패키지 설치
RUN apt-get update && apt-get install -y \
    git \
    make \
    wget \
    build-essential \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# darknet 저장소를 클론 하여 소스코드 가져오기
RUN git clone https://github.com/pjreddie/darknet /darknet
# 작업 디렉토리 변경
WORKDIR /darknet
# darknet 소스코드 컴파일
RUN make
# 가중치 파일 다운로드
RUN wget https://data.pjreddie.com/files/yolov3.weights
# 이미지 내부로 실행 스크립트 복사
COPY run_yolo.sh .
# 스크립트에 실행 권한 부여
RUN chmod +x run_yolo.sh
# 컨테이너 시작 시 기본 실행 명령어로 내부로 복사된 스크립트를 실행
ENTRYPOINT ["./run_yolo.sh"]