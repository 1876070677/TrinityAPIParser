from fastapi import FastAPI
from pydantic import BaseModel
from bs4 import BeautifulSoup
import time
import requests
import uuid
import json

app = FastAPI()

class catlog():
    def __init__(self):
        self.session = ''
        self.req_login = ''

    def login(self, userId, userPassword):
        sessid_1 = str(uuid.uuid4())
        sessid_2 = str(uuid.uuid4())

        sessid = sessid_1.replace('-', '') + sessid_2.replace('-', '')

        headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101 Firefox/72.0'}
        cookies = {'SESSION_SSO': sessid + '.c3R3X2RvbWFpbi9zc29fMg=='}

        re = requests.get('https://uportal.catholic.ac.kr/sso/jsp/sso/ip/login_form.jsp', headers=headers,
                          cookies=cookies)

        html = re.text
        soup = BeautifulSoup(html, 'html.parser')
        samlRequest = soup.find('input', {'name': 'samlRequest'}).get('value')

        data1 = {'userId': userId, 'password': userPassword, 'samlRequest': samlRequest}

        req = requests.post('https://uportal.catholic.ac.kr/sso/processAuthnResponse.do', headers=headers,
                            cookies=cookies, data=data1)

        html = req.text
        soup = BeautifulSoup(html, 'html.parser')
        SAMLResponse = soup.find('input', {'name': 'SAMLResponse'}).get('value')

        data2 = {'SAMLResponse': SAMLResponse}

        self.session = requests.session()
        self.req_login = self.session.post('https://uportal.catholic.ac.kr/portal/login/login.ajax', headers=headers,
                                           data=data2)

    def find(self, id, no, json_data):
        # json_data = self.get_json()
        try:
            for i in range(len(json_data["DS_CURR_OPSB010"])):
                if json_data["DS_CURR_OPSB010"][i]["sbjtNo"] == id and json_data["DS_CURR_OPSB010"][i]['clssNo'] == no:
                    cnt = json_data["DS_CURR_OPSB010"][i]['tlsnAplyRcnt']  # 신청인원
                    cnt2 = json_data["DS_CURR_OPSB010"][i]['tlsnLmtRcnt']  # 제한인원
                    cnt3 = json_data["DS_CURR_OPSB010"][i]['sbjtKorNm']  # 과목명

            return cnt, cnt2, cnt3
        except:
            return 'Error', 'Error', 'Error'

    def get_json(self, year, semester):
        html = self.req_login.text
        soup = BeautifulSoup(html, 'html.parser')
        csrf = soup.find('meta', {'id': '_csrf'}).get('content')

        headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101 Firefox/72.0',
                   'Accept': 'application/json, text/javascript, */*; q=0.01',
                   'Accept-Encoding':'gzip, deflate, br',
                   'Accept-Language':'ko-KR,ko;q=0.8,en-US;q=0.5,en;q=0.3',
                   'X-CSRF-TOKEN': csrf,
                   'X-Requested-With': 'XMLHttpRequest',
                   'Origin': 'https://uportal.catholic.ac.kr',
                   'Referer': 'https://uportal.catholic.ac.kr/stw/scsr/scoo/scooOpsbOpenSubjectInq.do'
                   }

        data = {'quatFg': 'INQ', 'posiFg': semester, 'openYyyy': year, 'openShtm': semester, 'campFg': 'M', 'sustCd': '%',
                'corsCd': '|', 'danFg': '', 'pobtFgCd': '%'}

        cookies = {'UCUPS_PT_SESSION': self.session.cookies.get_dict()['UCUPS_PT_SESSION']}

        return requests.post('https://uportal.catholic.ac.kr/stw/scsr/scoo/findOpsbOpenSubjectInq.json',
                             headers=headers, cookies=cookies, data=data).json()

    def hak(self):
        html = self.req_login.text
        soup = BeautifulSoup(html, 'html.parser')
        csrf = soup.find('meta', {'id': '_csrf'}).get('content')

        headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101 Firefox/72.0',
                   'Accept': 'application/json, text/javascript, */*; q=0.01',
                   'X-CSRF-TOKEN': csrf,
                   'Referer': 'https://uportal.catholic.ac.kr/portal/main.do',
                   'Content-Type': 'application/json'
                   }

        cookies = {'UCUPS_PT_SESSION': self.session.cookies.get_dict()['UCUPS_PT_SESSION']}

        data = {"sysDate": "2020.03.24(화)", "toDay": "20200324", "weekDay": 2, "yyyy": "2020", "MM": "03", "dd": "24"}

        return requests.post('https://uportal.catholic.ac.kr/portal/portlet/P018/listData.ajax',
                             headers=headers, cookies=cookies, data=json.dumps(data)).json()



class Subj(BaseModel):
    subjNo: str
    no: str
    userId: str
    userPw: str
    year: str
    semester: str

@app.post("/search")
async def searchMaxStudent(event: Subj):
    try:
        subj = event.subjNo
        no = event.no
        userId = event.userId
        userPw = event.userPw
        year = event.year
        semester = event.semester
    except:
        errMsg = {
            "errCode": 11,
            "message": "필수 인자가 전달되어야 합니다."
        }
        return{
            'statusCode': 400,
            'headers': {
                'Access-Control-Allow-Origin': '*'
            },
            'body': json.dumps(errMsg)
        }
    try:
        catApi = catlog()
        catApi.login(userId,userPw)
    except:
        errMsg = {
            "errCode": 20,
            "message": "트리니티 정보 조회에 실패하였습니다."
        }
        return{
            'statusCode': 400,
            'headers': {
                'Access-Control-Allow-Origin': '*'
            },
            'body': json.dumps(errMsg)
        }

    try:
        jsonData = catApi.get_json(year, semester)
        now, limit, className = catApi.find(subj, no, jsonData)
        resMsg = {
            "totalNum": limit,
            "nowNum": now,
            "className": className
        }
        return{
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Origin': '*'
            },
            'body': json.dumps(resMsg)
        }
    except:
        errMsg = {
            "errCode": 21,
            "message": "트리니티 정보 조회에 실패하였습니다."
        }
        return{
            'statusCode': 400,
            'headers': {
                'Access-Control-Allow-Origin': '*'
            },
            'body': json.dumps(errMsg)
        }