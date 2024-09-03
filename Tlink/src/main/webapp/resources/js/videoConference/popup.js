"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
const changeTitleBtn = document.querySelector("#changeTitle-btn");
changeTitleBtn.addEventListener("click", e => {
    inputModal("주제 변경", "이 화상회의의 주제는 무엇인가요?");
});
function inputModal(title, placeHolder) {
    var _a;
    (_a = document.querySelector("main")) === null || _a === void 0 ? void 0 : _a.insertAdjacentHTML("afterbegin", `<div id="main-container">
            <div class="modal-background">
                <div id="content-box">
                    <div id="content-box-wrapper">
                    <div id="content-box-item1">${title}</div>
                    <input id="content-box-item2" placeholder="${placeHolder}"></input>
                    <button id="content-box-item3" class="btn">확인</button>
                    <button id="content-box-item4" class="btn">취소</button>
                 </div>
            </div>
        </div>`);
    setTimeout(() => {
        const confirmButton = document.querySelector("#content-box-item3");
        const cancelButton = document.querySelector("#content-box-item4");
        if (confirmButton) {
            confirmButton.addEventListener("click", () => {
                // fetch를 통한 업데이트 구문 추가
                const nowtitle = document.querySelector("#title-container");
                const input = document.querySelector("#content-box-item2");
                if (nowtitle) {
                    nowtitle.innerHTML = `<b>${input === null || input === void 0 ? void 0 : input.value}</b>`;
                    const existingModal = document.querySelector("#main-container");
                    if (existingModal) {
                        existingModal.remove();
                    }
                }
                else {
                    console.log("title이 없습니다.");
                }
            });
        }
        if (cancelButton) {
            cancelButton.addEventListener("click", () => {
                const existingModal = document.querySelector("#main-container");
                if (existingModal) {
                    existingModal.remove();
                }
            });
        }
    }, 10);
}
// 웹소켓 코드
let socket;
connectWebsocket();
function connectWebsocket() {
    socket = new SockJS(`${req}/videoConference`);
    socket.onopen = (e) => {
        console.log("websocket 연결됨");
    };
    socket.onmessage = (e) => __awaiter(this, void 0, void 0, function* () {
        //console.log("받은거" + e);
        const parsedMessage = yield JSON.parse(e.data);
        console.log("Received Message:", parsedMessage);
        // if (parsedMessage.type == "offer") {
        // 상대방에게서 실행되는 코드
        // await handleOffer(parsedMessage);
        // console.log("handleOffer 전달됨");
        //console.log(parsedMessage.sdp)
        // }
        // if (parsedMessage.type == "answer") {
        // await handleAnswer(parsedMessage);
        //console.log(parsedMessage);
        //console.log("answer 전달에 성공했음 handleAnswer 하면됨")
        // }
        // if (parsedMessage.hasOwnProperty("candidate")) {
        // console.log("candidate에 들어가는 그거는 이거임 : " , parsedMessage)
        // handleIceCandidate(parsedMessage);
        //console.log(parsedMessage);
        //console.log("candidate만 실행되는 메소드 만들기에 도달했음");
        // }
        // if(parsedMessage.msg == "somebodyjoinroom"){
        // 	console.log("원하는거 실행됬고, 이곳에서 offer 함수 실행되야함");
        // 	makeOffer();
        // }
    });
    socket.onclose = (e) => {
        console.log("websocket 끊겼음");
    };
}
// 화상회의 코드
let myStream;
let camera = true;
let mic = true;
let display = true;
let state = "camera";
const cameraBtn = document.querySelector("#video-btn");
const micBtn = document.querySelector("#mic-btn");
const displayBtn = document.querySelector("#display-btn");
const exitBtn = document.querySelector("#exit-btn");
const changeBtn = document.querySelector("#change-btn");
const optionBox = document.querySelector(".optionBox");
const option1 = document.querySelector(".options1");
const option2 = document.querySelector(".options2");
const myVideo = document.querySelectorAll(".video-item")[0];
const getMedia = (deviceId) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const initialConstrains = {
            audio: {
                echoCancellation: true,
                noiseSuppression: true
            },
            video: { facingMode: "user" }
        };
        const cameraConstraints = {
            audio: {
                echoCancellation: true,
                noiseSuppression: true
            },
            video: { deviceId: { exact: deviceId } }
        };
        myStream = yield navigator.mediaDevices.getUserMedia(deviceId ? cameraConstraints : initialConstrains);
        myVideo.innerHTML = "";
        let video = document.createElement("video");
        video.height = 210;
        video.width = 210;
        video.autoplay = true;
        video.srcObject = myStream;
        myVideo.appendChild(video);
        // 카메라 바꾸기
        // if (!deviceId) {
        //     await getCameras();
        // }
    }
    catch (err) {
        console.log(err);
    }
});
// 화면 공유
const getDisplay = () => __awaiter(void 0, void 0, void 0, function* () {
    try {
        // 화면 공유 시작
        const screenStream = yield navigator.mediaDevices.getDisplayMedia({
            video: {
                cursor: "always" // 항상 커서를 표시
            },
            audio: false
        });
        myStream = screenStream;
        myVideo.innerHTML = "";
        let video = document.createElement("video");
        video.height = 210;
        video.width = 210;
        video.autoplay = true;
        video.srcObject = myStream;
        // 비디오 클릭 시 전체화면 전환 이벤트 추가
        video.addEventListener("click", () => {
            video.requestFullscreen();
        });
        myVideo.appendChild(video);
    }
    catch (e) {
        console.log(e);
    }
});
const handleCameraBtn = () => {
    myStream.getVideoTracks()[0].enabled = !(myStream.getVideoTracks()[0].enabled);
    if (camera) {
        cameraBtn.innerText = "비X";
        camera = false;
        display = false;
    }
    else {
        cameraBtn.innerText = "비";
        camera = true;
        display = false;
    }
};
const handleMicBtn = () => {
    myStream.getAudioTracks()[0].enabled = !(myStream.getAudioTracks()[0].enabled);
    if (mic) {
        micBtn.innerText = "마X";
        mic = false;
    }
    else {
        micBtn.innerText = "마";
        mic = true;
    }
};
const handleChangeBtn = () => {
    optionBox.classList.toggle("none");
};
const option1btn = () => {
    if (camera) {
        optionBox.classList.toggle("none");
        option1.innerText = "카메라(사용중)";
        option2.innerText = "화면공유";
        state = "camera";
        getMedia();
    }
    else {
        optionBox.classList.toggle("none");
        alert("카메라를 끄고 전환할 수 없습니다.");
    }
};
const option2btn = () => {
    if (camera) {
        optionBox.classList.toggle("none");
        option1.innerText = "카메라";
        option2.innerText = "화면공유(사용중)";
        state = "display";
        getDisplay();
    }
    else {
        optionBox.classList.toggle("none");
        alert("카메라를 끄고 전환할 수 없습니다.");
    }
};
const byebye = () => {
    window.close();
};
//displayBtn.addEventListener("click", getDisplay);
option1.addEventListener("click", option1btn);
option2.addEventListener("click", option2btn);
cameraBtn.addEventListener("click", handleCameraBtn);
micBtn.addEventListener("click", handleMicBtn);
changeBtn.addEventListener("click", handleChangeBtn);
exitBtn.addEventListener("click", byebye);
getMedia();
//# sourceMappingURL=popup.js.map