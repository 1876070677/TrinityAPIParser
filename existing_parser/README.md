# haenu-api (서비스 종료)
가톨릭대학교 트리니티 정보 API Documents

- classStudents.py : 강의번호와 분반번호로 호출시 현재인원, 남은인원 확인
- API Endpoint : https://49oxwvvi8h.execute-api.ap-northeast-2.amazonaws.com/default/classStudents (2022.01.13 기준)

## 참고사항
- AWS Lambda 용으로 제작된 코드이기때문에 일반적인 환경에서 실행을 위해서는 일부 코드를 삭제, 수정해야합니다.
- 학기가 바뀔 때마다 classStudent.py 기준 82번째 줄을 수정해야 합니다.
