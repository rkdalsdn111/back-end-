📋 Board Management System
Spring Framework와 MyBatis를 활용한 게시판 관리 시스템입니다.
🚀 주요 기능

✅ 게시글 CRUD: 게시글 등록, 조회, 수정, 삭제
📈 조회수 관리: 게시글 조회 시 자동 조회수 증가
📎 파일 업로드: 다중 파일 첨부 기능 (UUID 기반 관리)
💬 댓글 시스템: RESTful API 기반 댓글 CRUD
🔍 검색 기능: 제목, 내용, 작성자 기준 검색
📄 페이징 처리: 효율적인 데이터 표시

🛠 기술 스택
Backend

Java 14
Spring Framework 5.0.7
MyBatis 3.4.6
Oracle Database 11g

Frontend

JSP
JavaScript
CSS3

Build Tool

Maven 3.6.0

📁 프로젝트 구조
BoardProject/
├── src/
│   ├── main/
│   │   ├── java/cs/dit/
│   │   │   ├── controller/     # 컨트롤러
│   │   │   ├── service/        # 서비스 레이어
│   │   │   ├── domain/         # VO 객체
│   │   │   └── mapper/         # 매퍼 인터페이스
│   │   ├── resources/
│   │   │   └── mappers/        # MyBatis XML
│   │   └── webapp/
│   │       └── WEB-INF/
│   │           ├── spring/     # Spring 설정
│   │           └── views/      # JSP 파일
│   └── test/                   # 테스트 코드
└── pom.xml                     # Maven 설정
💾 데이터베이스 설정
1. 사용자 생성 및 권한 부여
sql-- Oracle에 시스템 사용자로 접속
CREATE USER board IDENTIFIED BY board;
GRANT CONNECT, RESOURCE, DBA TO board;
2. 테이블 생성
sql-- 게시글 테이블
CREATE TABLE tbl_board (
    bno NUMBER(10, 0) PRIMARY KEY,
    title VARCHAR2(200) NOT NULL,
    content VARCHAR2(2000) NOT NULL,
    writer VARCHAR2(50) NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    updateDate DATE DEFAULT SYSDATE,
    viewCount NUMBER(10, 0) DEFAULT 0
);

-- 시퀀스 생성
CREATE SEQUENCE seq_board START WITH 1 INCREMENT BY 1;

-- 첨부파일 테이블
CREATE TABLE tbl_attach (
    fno NUMBER(10, 0) PRIMARY KEY,
    uuid VARCHAR2(100) NOT NULL,
    uploadPath VARCHAR2(200) NOT NULL,
    fileName VARCHAR2(100) NOT NULL,
    fileType CHAR(1) DEFAULT 'N',
    bno NUMBER(10, 0) NOT NULL,
    fileSize NUMBER(20, 0) DEFAULT 0
);

CREATE SEQUENCE seq_attach START WITH 1 INCREMENT BY 1;

ALTER TABLE tbl_attach 
    ADD CONSTRAINT fk_board_attach 
    FOREIGN KEY (bno) 
    REFERENCES tbl_board(bno) 
    ON DELETE CASCADE;

-- 댓글 테이블
CREATE TABLE tbl_comment (
    cno NUMBER(10, 0) PRIMARY KEY,
    bno NUMBER(10, 0) NOT NULL,
    content VARCHAR2(500) NOT NULL,
    writer VARCHAR2(50) NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    updateDate DATE DEFAULT SYSDATE
);

CREATE SEQUENCE seq_comment START WITH 1 INCREMENT BY 1;

ALTER TABLE tbl_comment 
    ADD CONSTRAINT fk_board_comment 
    FOREIGN KEY (bno) 
    REFERENCES tbl_board(bno) 
    ON DELETE CASCADE;
🔧 설치 및 실행 방법
1. 사전 요구사항

JDK 14 이상
Apache Tomcat 9.0
Oracle Database 11g 이상
Maven 3.6 이상

2. 프로젝트 클론
bashgit clone [repository-url]
cd BoardProject
3. 데이터베이스 설정
src/main/webapp/WEB-INF/spring/root-context.xml 파일에서 데이터베이스 접속 정보 수정:
xml<bean id="hikariConfig" class="com.zaxxer.hikari.HikariConfig">
    <property name="driverClassName" value="oracle.jdbc.driver.OracleDriver"/>
    <property name="jdbcUrl" value="jdbc:oracle:thin:@localhost:1521:XE"/>
    <property name="username" value="board"/>
    <property name="password" value="board"/>
</bean>
4. 파일 업로드 경로 설정
다음 폴더들을 미리 생성:
C:/upload/
C:/upload/tmp/
5. 빌드 및 실행
bash# Maven 빌드
mvn clean install

# Tomcat에 배포
# 생성된 WAR 파일을 Tomcat의 webapps 폴더에 복사
6. 접속
브라우저에서 http://localhost:8080/board/list 접속
📝 주요 API 엔드포인트
게시글 API
MethodURL설명GET/board/list게시글 목록 조회GET/board/register게시글 등록 페이지POST/board/register게시글 등록 처리GET/board/get?bno={bno}게시글 상세 조회POST/board/modify게시글 수정POST/board/remove게시글 삭제
댓글 REST API
MethodURL설명POST/comments/new댓글 등록GET/comments/pages/{bno}댓글 목록 조회GET/comments/{cno}댓글 조회PUT/PATCH/comments/{cno}댓글 수정DELETE/comments/{cno}댓글 삭제
🎯 주요 기능 설명
1. 조회수 기능
게시글을 조회할 때마다 자동으로 조회수가 1씩 증가합니다.
java// BoardServiceImpl.java
@Override
public BoardVO get(Long bno) {
    // 조회수 증가
    mapper.updateViewCount(bno);
    
    // 게시글 정보 조회
    return mapper.read(bno);
}
2. 파일 업로드

UUID를 사용한 파일명 중복 방지
날짜별 폴더 자동 생성 (YYYY/MM/DD)
이미지 파일 자동 구분

java// UUID 생성
String uuid = UUID.randomUUID().toString();

// 날짜별 폴더 생성
String uploadFolderPath = getFolder(); // 예: 2025/12/25
3. 댓글 시스템
RESTful API로 구현되어 AJAX를 통한 비동기 처리가 가능합니다.
javascript// 댓글 등록
fetch('/comments/new', {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify(comment)
});
🐛 트러블슈팅
문제 1: 파일 업로드 실패
원인: 업로드 폴더가 존재하지 않음
해결: C:/upload 및 C:/upload/tmp 폴더 생성
문제 2: 한글 깨짐
원인: 인코딩 설정 누락
해결: web.xml에 Character Encoding Filter 추가됨
📚 참고 자료

Spring Framework 공식 문서
MyBatis 공식 문서
코드로 배우는 스프링 웹 프로젝트

👨‍💻 개발자

이름: [제출자명]
소속: 컴퓨터소프트웨어과
과목: 백엔드프로그래밍II
담당교수: 김진숙

📄 라이선스
본 프로젝트는 학습 목적으로 제작되었습니다.

작성일: 2025년 12월 25일
