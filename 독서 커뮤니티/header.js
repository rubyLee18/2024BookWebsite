// 로그인 상태를 확인하는 변수 (false는 비로그인, true는 로그인 상태)
let isLoggedIn = false; // 기본적으로 로그아웃 상태. 실제로는 서버 상태에 따라 변경해야 함

// 상태에 따라 버튼 텍스트 및 기능 설정
function updateButtons() {
    const signupButton = document.getElementById('signup');
    const loginButton = document.getElementById('login');

    if (isLoggedIn) {
        // 로그인 상태일 경우
        signupButton.textContent = '회원탈퇴';
        signupButton.onclick = () => {
            const confirmed = confirm('정말 회원탈퇴 하시겠습니까?');
            if (confirmed) {
                isLoggedIn = false; // 로그아웃 상태로 변경
                updateButtons(); // 버튼 상태 업데이트
                alert('회원탈퇴가 완료되었습니다.');
            }
        };

        loginButton.textContent = '로그아웃';
        loginButton.onclick = () => {
            isLoggedIn = false; // 로그아웃 상태로 변경
            updateButtons(); // 버튼 상태 업데이트
            alert('로그아웃 되었습니다.');
        };
    } else {
        // 비로그인 상태일 경우
        signupButton.textContent = '회원가입';
        signupButton.onclick = () => {
            window.location.href = 'signup.html'; // 회원가입 페이지로 이동
        };

        loginButton.textContent = '로그인';
        loginButton.onclick = () => {
            window.location.href = 'login.html'; // 로그인 페이지로 이동
        };
    }
}

// 헤더 페이지 불러오기 및 스크립트 적용
fetch('header.html')
    .then(response => response.text())
    .then(data => {
        document.getElementById('header-container').innerHTML = data;
        
        // 헤더가 로드된 후 버튼 이벤트 설정
        document.getElementById("myDiv").addEventListener("click", function() {
            location.href = "mainpage.html"; 
        });
        document.getElementById("signup").addEventListener("click", function() {
            location.href = "signup.html"; 
        });
        document.getElementById("login").addEventListener("click", function() {
            location.href = "login.html"; 
        });

        updateButtons(); // 헤더가 로드된 후 버튼 상태 업데이트
    })
    .catch(error => console.error("헤더 로드 실패:", error));
