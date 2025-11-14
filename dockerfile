# 1. 기본 이미지 설정 (Ubuntu 20.04)
FROM ubuntu:20.04

# 2. 작업에 필요한 기본 패키지 설치
# (git, make, wget, build-essential: C/C++ 컴파일 도구)
RUN apt-get update && apt-get install -y \
    git \
    make \
    wget \
    build-essential \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 3. Darknet 소스 코드 복제 [cite: 15]
# (/darknet 디렉토리에 복제)
RUN git clone https://github.com/pjreddie/darknet /darknet

# 4. 작업 디렉토리를 /darknet 으로 변경 [cite: 15]
WORKDIR /darknet

# 5. Darknet 컴파일 (make) [cite: 16]
RUN make

# 6. YOLOv3 가중치 파일 다운로드 [cite: 18]
RUN wget https://data.pjreddie.com/files/yolov3.weights

# 7. 실행 스크립트(run_yolo.sh)를 이미지 안으로 복사
COPY run_yolo.sh .

# 8. 스크립트에 실행 권한 부여
RUN chmod +x run_yolo.sh

# 9. 컨테이너가 시작될 때 실행할 기본 명령어 설정
ENTRYPOINT ["./run_yolo.sh"]