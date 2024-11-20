// 서버에서 로그인 상태를 가져오는 함수
async function fetchLoginStatus() {
    try {
        const response = await fetch('checkLoginStatus.jsp'); // 서버에서 로그인 상태 확인
        const result = await response.json();
        return result.loggedIn; // 로그인 상태 반환 (true 또는 false)
    } catch (error) {
        console.error("로그인 상태 확인 실패: ", error);
        return false; // 기본적으로 비로그인 상태로 처리
    }
}

//세션 초기화 및 버튼 상태 업데이트
async function resetSessionAndUpdateButtons(message) {
	try{
		await fetch('logout.jsp');		//세션 초기화 (logout.jsp로 요청)
		alert(message);		//전달받은 메시지 출력
		await updateButtons();		//버튼 상태 업데이트
	}
	catch(error) {
		console.error("세션 초기화 실패: ", error);
	}
}


// 서버에 로그아웃 요청을 보내는 함수
async function logoutRequest() {
	try {
		const response=await fetch('logout.jsp');		//로그아웃 처리
		if(response.ok) {
			alert('로그아웃 되었습니다.');
			window.location.href='mainpage.html';
		}
		else {
			alert('로그아웃 처리 중 문제가 발생했습니다. 다시 시도해주세요.');
		}
	}
	catch(error) {
		console.error("로그아웃 요청 실패: ", error);
		alert('로그아웃 처리 중 문제가 발생했습니다.');
	}
}

// 서버에 회원탈퇴 요청을 보내는 함수
async function deleteAccountRequest() {
    const confirmed = confirm('정말 회원탈퇴 하시겠습니까?');
    if (!confirmed) return; // 취소 시 아무 작업도 하지 않음

    try {
        await fetch('deleteAccount.jsp');		//회원탈퇴 처리
		await resetSessionAndUpdateButtons('회원탈퇴가 완료되었습니다.');
		window.location.href='mainpage.html';
    } catch (error) {
        console.error("회원탈퇴 요청 실패: ", error);
    }
}

// 상태에 따라 버튼 텍스트 및 기능 설정
async function updateButtons() {
    const signupButton = document.getElementById('signup');
    const loginButton = document.getElementById('login');

    const isLoggedIn = await fetchLoginStatus(); // 로그인 상태 가져오기

    if (isLoggedIn) {
        // 로그인 상태일 경우
        signupButton.textContent = '회원탈퇴';
        signupButton.onclick = () => deleteAccountRequest();

        loginButton.textContent = '로그아웃';
        loginButton.onclick = () => logoutRequest();
    } else {
        // 비로그인 상태일 경우
        signupButton.textContent = '회원가입';
        signupButton.onclick = () => {
            window.location.href = 'signup.html';
        };

        loginButton.textContent = '로그인';
        loginButton.onclick = () => {
            window.location.href = 'login.html';
        };
    }
}

// 헤더 페이지 로드 및 버튼 상태 업데이트
fetch('header.html')
    .then(response => response.text())
    .then(data => {
        document.getElementById('header-container').innerHTML = data;

        // "독서 커뮤니티" 클릭 이벤트 추가
        const communityTitle = document.getElementById("myDiv");
        if (communityTitle) {
            communityTitle.addEventListener("click", () => {
                window.location.href = "mainpage.html"; // 메인 페이지로 이동
            });
        }

        updateButtons(); // 헤더 로드 후 버튼 상태 업데이트
    })
    .catch(error => console.error("헤더 로드 실패:", error));
