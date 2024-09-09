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
// declare const memberNo: any;
const changeTitleBtn = document.querySelector("#changeTitle-btn");
let memberNo = new URLSearchParams(location.search).get("memberNo");
let myStream;
let camera = true;
let mic = true;
let display = true;
let otherMemberNoSet = new Set();
let peerConnectionMap = new Map();
let state = "camera";
const cameraBtn = document.querySelector("#video-btn");
const micBtn = document.querySelector("#mic-btn");
const displayBtn = document.querySelector("#display-btn");
const exitBtn = document.querySelector("#exit-btn");
const changeBtn = document.querySelector("#change-btn");
const optionBox = document.querySelector(".optionBox");
const option1 = document.querySelector(".options1");
const option2 = document.querySelector(".options2");
const myVideo = document.querySelector("#video-container");
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
const connectWebsocket = () => {
    return new Promise((resolve, reject) => {
        socket = new SockJS(`${req}/videoConference`);
        socket.onopen = (e) => {
            if (socket.readyState === WebSocket.OPEN) {
                socket.send(JSON.stringify({
                    "type": "addSession",
                    "memberNo": memberNo
                }));
            }
            else {
                console.log('WebSocket 연결이 아직 준비되지 않았습니다.');
            }
            resolve();
            console.log("websocket 연결됨");
        };
        socket.onmessage = (e) => __awaiter(void 0, void 0, void 0, function* () {
            //console.log("받은거" + e);
            const parsedMessage = yield JSON.parse(e.data);
            console.log("Received Message:", parsedMessage);
            // 모두가 실행되는 코드
            if (parsedMessage.type === "needMemberKey") {
                socket.send(JSON.stringify({
                    "type": "memberNo",
                    "memberNo": memberNo
                }));
            }
            if (parsedMessage.type === "otherMemberNo") {
                if (parsedMessage.memberNo != memberNo) {
                    otherMemberNoSet.add(parsedMessage.memberNo);
                }
            }
            // 상대방에게서 실행되는 코드
            if (parsedMessage.type === "offer") {
                //console.log("parsedMessage.makeAnswerMemberNo : 보내는 곳이 이곳임 : ", parsedMessage.makeAnswerMemberNo);
                // console.log("parsedMessage.type", parsedMessage.type);
                // console.log("parsedMessage.sdp", parsedMessage.sdp);
                peerConnectionMap.set(parsedMessage.makeAnswerMemberNo, createConnection(parsedMessage.makeAnswerMemberNo));
                peerConnectionMap.get(parsedMessage.makeAnswerMemberNo).setRemoteDescription(new RTCSessionDescription({ type: parsedMessage.type, sdp: parsedMessage.sdp }));
                // map 세팅완료
                // answer 보내야함
                sendAnswer(peerConnectionMap.get(parsedMessage.makeAnswerMemberNo), parsedMessage.makeAnswerMemberNo);
            }
            if (parsedMessage.type === "answer") {
                peerConnectionMap.get(parsedMessage.setAnswerMemberNo).setRemoteDescription(new RTCSessionDescription({ type: parsedMessage.type, sdp: parsedMessage.sdp }));
                console.log("answer응답 받았음, map에 원격 세팅중", parsedMessage.setAnswerMemberNo);
            }
            if (parsedMessage.type === "icecandidate") {
                peerConnectionMap.get(parsedMessage.iceSender).addIceCandidate(new RTCIceCandidate({ candidate: parsedMessage.candidate, sdpMLineIndex: parsedMessage.sdpMLineIndex, sdpMid: parsedMessage.sdpMid }));
            }
            if (parsedMessage.type === "exit") {
                peerConnectionMap.delete(parsedMessage.exitMemberNo);
                otherMemberNoSet.delete(parsedMessage.exitMemberNo);
                const video = document.getElementById(parsedMessage.exitMemberNo);
                video === null || video === void 0 ? void 0 : video.remove();
                console.log("제거 완료");
            }
            // console.log("받은 exitMember", parsedMessage.exitMemberNo);
        });
        socket.onclose = (e) => {
            reject();
            console.log(e);
            console.log("websocket 끊겼음");
        };
    });
};
// 화상 회의
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
        let video = document.createElement("video");
        video.height = 270;
        video.width = 270;
        video.autoplay = true;
        video.id = memberNo;
        video.srcObject = myStream;
        myVideo.appendChild(video);
        video.addEventListener("click", () => {
            video.requestFullscreen();
        });
        // 카메라 바꾸기
        // if (!deviceId) {
        //     await getCameras();
        // }
    }
    catch (err) {
        console.log(err);
    }
});
// 카메라 변경
const getMedia2 = () => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const initialConstrains = {
            audio: {
                echoCancellation: true,
                noiseSuppression: true
            },
            video: { facingMode: "user" }
        };
        myStream = yield navigator.mediaDevices.getUserMedia(initialConstrains);
        let video = document.querySelectorAll("video")[0];
        video.srcObject = myStream;
        video.addEventListener("click", () => {
            video.requestFullscreen();
        });
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
        let video = document.querySelectorAll("video")[0];
        video.srcObject = myStream;
        // 비디오 클릭 시 전체화면 전환 이벤트 추가
        video.addEventListener("click", () => {
            video.requestFullscreen();
        });
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
        getMedia2();
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
const createConnection = (otherMemberNo) => {
    const configuration = {
        iceServers: [
            {
                urls: [
                    "stun:stun.l.google.com:19302"
                ]
            }
        ]
    };
    const myPeerConnection = new RTCPeerConnection(configuration);
    myPeerConnection.addEventListener("icecandidate", (event) => {
        iceHandler(event, otherMemberNo);
    });
    myPeerConnection.addEventListener("track", (event) => {
        trackHandler(event, otherMemberNo);
    });
    if (myStream !== undefined) {
        myStream.getTracks().forEach(track => {
            myPeerConnection.addTrack(track, myStream);
        });
    }
    return myPeerConnection;
};
const trackHandler = (event, otherMemberNo) => {
    if (document.getElementById(`${otherMemberNo}`) === null) {
        const video = document.createElement('video');
        video.height = 270;
        video.width = 270;
        video.autoplay = true;
        video.id = otherMemberNo;
        video.srcObject = event.streams[0];
        myVideo.appendChild(video);
    }
    else {
        const video = document.getElementById(`${otherMemberNo}`);
        video.srcObject = event.streams[0];
    }
};
const iceHandler = (event, targetNo) => {
    console.log("ICE실행");
    if (event.candidate) {
        socket.send(JSON.stringify({
            "type": "icecandidate",
            "body": event.candidate,
            "targetNo": targetNo,
            "iceSender": memberNo
        }));
    }
};
const setLocal = (myPeerConnection, offerOrAnswer) => {
    myPeerConnection.setLocalDescription(offerOrAnswer);
};
const needMemberKey = () => {
    socket.send(JSON.stringify({
        "type": "needMemberKey"
    }));
};
const sendOffer = (myPeerConnection, targetNo) => {
    myPeerConnection.createOffer().then((offer) => {
        setLocal(myPeerConnection, offer);
        socket.send(JSON.stringify({
            "type": "offer",
            "body": offer,
            "targetNo": targetNo,
            "makeAnswerMemberNo": memberNo
        }));
        console.log("send Offer");
    });
};
const sendAnswer = (myPeerConnection, targetNo) => {
    myPeerConnection.createAnswer().then((answer) => {
        setLocal(myPeerConnection, answer);
        socket.send(JSON.stringify({
            "type": "answer",
            "body": answer,
            "targetNo": targetNo,
            "setAnswerMemberNo": memberNo
        }));
        console.log("send Answer");
    });
};
const startVideoConference = () => __awaiter(void 0, void 0, void 0, function* () {
    // 소켓을 연결한다.
    yield connectWebsocket();
    // 1. 해당 방의 현재인원을 검색해서, 4명이 넘는다면 창을 끄고 종료시킨다.(경고 모달 출력)
    // 2. 화면을 얻어온다.
    yield getMedia();
    // 3. signaling server에 신호를 보내 otherMemberList를 채운다.
    yield needMemberKey();
    // 방의 인원을 select해오고, 인원이 맞으면 해당 코드 실행으로 바꾸기 넣어야함
    setTimeout(() => {
        otherMemberNoSet.forEach((otherMemberNo) => {
            if (!peerConnectionMap.has(otherMemberNo)) {
                peerConnectionMap.set(otherMemberNo, createConnection(otherMemberNo));
                sendOffer(peerConnectionMap.get(otherMemberNo), otherMemberNo);
            }
        });
    }, 1000);
});
option1.addEventListener("click", option1btn);
option2.addEventListener("click", option2btn);
cameraBtn.addEventListener("click", handleCameraBtn);
micBtn.addEventListener("click", handleMicBtn);
changeBtn.addEventListener("click", handleChangeBtn);
exitBtn.addEventListener("click", byebye);
startVideoConference();
//# sourceMappingURL=popup.js.map