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
let memberNo = new URLSearchParams(location.search).get("memberNo");
let projectNo = new URLSearchParams(location.search).get("projectNo");
let memberName = new URLSearchParams(location.search).get("memberName");
let myStream;
let camera = true;
let mic = true;
let display = true;
let otherMemberNoSet = new Set();
let peerConnectionMap = new Map();
let state = "camera";
const changeTitleBtn = document.querySelector("#changeTitle-btn");
const bookedMessageBtn = document.querySelector(".chat-booked");
const cameraBtn = document.querySelector("#video-btn");
const micBtn = document.querySelector("#mic-btn");
const displayBtn = document.querySelector("#display-btn");
const exitBtn = document.querySelector("#exit-btn");
const changeBtn = document.querySelector("#change-btn");
const optionBox = document.querySelector(".optionBox");
const option1 = document.querySelector(".options1");
const option2 = document.querySelector(".options2");
const myVideo = document.querySelector("#video-container");
const chatInput = document.querySelector(".chat-input");
const chatBtn = document.querySelector(".chat-send");
changeTitleBtn.addEventListener("click", e => {
    inputTitleModal("주제 변경", "이 화상회의의 주제는 무엇인가요?");
});
bookedMessageBtn.addEventListener("click", e => {
    inputBookedModal("메시지 예약", "메시지를 입력해주세요.");
});
const inputTitleModal = (title, placeHolder) => {
    var _a;
    (_a = document.querySelector("main")) === null || _a === void 0 ? void 0 : _a.insertAdjacentHTML("afterbegin", `<div id="main-container">
            <div class="modal-background">
                <div id="content-box1">
                    <div id="content-box-wrapper1">
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
                fetch("/video/changeRoomName", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json",
                    },
                    body: JSON.stringify({
                        projectNo: projectNo,
                        title: input === null || input === void 0 ? void 0 : input.value
                    })
                })
                    .then(resp => resp.json())
                    .then(data => {
                    // console.log(data);
                    if (data > 0) {
                        nowtitle.innerHTML = `<b>${input.value}</b>`;
                        const existingModal = document.querySelector("#main-container");
                        if (existingModal) {
                            existingModal.remove();
                        }
                    }
                    else {
                        alert("주제 변경 실패");
                    }
                })
                    .catch(e => {
                    console.log("주제 변경 실패 : ", e);
                });
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
};
const inputBookedModal = (title, placeHolder) => {
    var _a;
    (_a = document.querySelector("main")) === null || _a === void 0 ? void 0 : _a.insertAdjacentHTML("afterbegin", `<div id="main-container">
            <div class="modal-background">
                <div id="content-box2">
                    <div id="content-box-wrapper2">
                    <div id="content-box-item1">${title}</div>
                    <input id="content-box-item2" placeholder="${placeHolder}"></input>
                    <input id="content-box-item2" type="datetime-local" class="datetime"></input>
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
                const bookedInput = document.querySelector(".datetime");
                const msgInput = document.querySelector("#content-box-item2");
                // console.log(bookedInput!.value);
                // console.log(msgInput!.value);
                socket.send(JSON.stringify({
                    "type": "booked",
                    "bookedMsg": msgInput.value,
                    "bookedTime": bookedInput.value,
                    "projectNo": projectNo,
                    "memberNo": memberNo,
                }));
                const existingModal = document.querySelector("#main-container");
                if (existingModal) {
                    existingModal.remove();
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
};
// 웹소켓 코드
let socket;
const connectWebsocket = () => {
    return new Promise((resolve, reject) => {
        socket = new SockJS(`${req}/videoConference`);
        socket.onopen = (e) => {
            if (socket.readyState === WebSocket.OPEN) {
                socket.send(JSON.stringify({
                    "type": "addSession",
                    "memberNo": memberNo,
                    "projectNo": projectNo,
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
            var _a;
            const parsedMessage = yield JSON.parse(e.data);
            console.log("Received Message:", parsedMessage);
            // 모두가 실행되는 코드
            if (parsedMessage.type === "needMemberKey") {
                socket.send(JSON.stringify({
                    "type": "memberNo",
                    "memberNo": memberNo,
                    "projectNo": projectNo,
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
                // console.log("answer응답 받았음, map에 원격 세팅중", parsedMessage.setAnswerMemberNo);
            }
            if (parsedMessage.type === "icecandidate") {
                peerConnectionMap.get(parsedMessage.iceSender).addIceCandidate(new RTCIceCandidate({ candidate: parsedMessage.candidate, sdpMLineIndex: parsedMessage.sdpMLineIndex, sdpMid: parsedMessage.sdpMid }));
            }
            if (parsedMessage.type === "chat") {
                // console.log("chat 실행됬음");
                const content = makeChatBlock(parsedMessage.memberNo, parsedMessage.chatContent);
                const tempDiv = document.createElement('div');
                tempDiv.innerHTML = content;
                const chatBlock = tempDiv.firstElementChild;
                (_a = document.querySelector(".chat-itembox")) === null || _a === void 0 ? void 0 : _a.insertAdjacentElement("beforeend", chatBlock);
            }
            if (parsedMessage.type === "exit") {
                peerConnectionMap.delete(parsedMessage.exitMemberNo);
                otherMemberNoSet.delete(parsedMessage.exitMemberNo);
                const video = document.getElementById(parsedMessage.exitMemberNo);
                video.parentElement.remove();
                videoSizeHandler();
                console.log("제거 완료");
            }
        });
        socket.onclose = (e) => {
            reject();
            console.log(e);
            console.log("websocket 끊겼음");
        };
    });
};
// 화상 회의
const getMedia = () => __awaiter(void 0, void 0, void 0, function* () {
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
        if (video) {
            let existVideo = document.querySelectorAll("video")[0];
            existVideo.srcObject = myStream;
            existVideo.addEventListener("click", () => {
                existVideo.requestFullscreen();
            });
            otherMemberNoSet.forEach((otherMemberNo) => {
                // console.log("재협상중");
                const videoTrack = myStream.getVideoTracks()[0];
                const sender = peerConnectionMap.get(otherMemberNo).getSenders().find((s) => s.track.kind === 'video');
                sender.replaceTrack(videoTrack);
                peerConnectionMap.set(otherMemberNo, createConnection(otherMemberNo));
                sendOffer(peerConnectionMap.get(otherMemberNo), otherMemberNo);
            });
        }
        else {
            console.log("camera video 만들기 실행");
            let videoParent = document.createElement("div");
            videoParent.classList.add("videoParent");
            myVideo.appendChild(videoParent);
            let newVideo = document.createElement("video");
            newVideo.autoplay = true;
            newVideo.id = memberNo;
            newVideo.srcObject = myStream;
            videoParent.appendChild(newVideo);
            let nameTag = document.createElement("div");
            nameTag.id = `${memberNo}$1`;
            nameTag.classList.add("nameTag1");
            nameTag.innerText = memberName;
            videoParent.appendChild(nameTag);
            videoSizeHandler();
            newVideo.addEventListener("click", () => {
                newVideo.requestFullscreen();
            });
        }
    }
    catch (e) {
        console.error('Error occurred in getUserMedia:', e);
        if (e.name === 'NotFoundError' || e.name === 'DevicesNotFoundError' || e.name === 'NotReadableError') {
            console.log('No media devices found. Switching to getDisplay.');
            getDisplay();
        }
        else {
            console.log('An unexpected error occurred:', e);
        }
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
        if (video) {
            video.srcObject = myStream;
        }
        else {
            console.log("display video 만들기 실행");
            let videoParent = document.createElement("div");
            videoParent.classList.add("videoParent");
            myVideo.appendChild(videoParent);
            let newVideo = document.createElement("video");
            newVideo.autoplay = true;
            newVideo.id = memberNo;
            newVideo.srcObject = myStream;
            videoParent.appendChild(newVideo);
            let nameTag = document.createElement("div");
            nameTag.id = `${memberNo}$1`;
            nameTag.classList.add("nameTag1");
            nameTag.innerText = memberName;
            videoParent.appendChild(nameTag);
            videoSizeHandler();
            newVideo.addEventListener("click", () => {
                newVideo.requestFullscreen();
            });
        }
        // 비디오 클릭 시 전체화면 전환 이벤트 추가
        video.addEventListener("click", () => {
            video.requestFullscreen();
        });
        //재협상
        otherMemberNoSet.forEach((otherMemberNo) => {
            console.log("재협상중");
            const videoTrack = screenStream.getVideoTracks()[0];
            const sender = peerConnectionMap.get(otherMemberNo).getSenders().find((s) => s.track.kind === 'video');
            sender.replaceTrack(videoTrack);
            peerConnectionMap.set(otherMemberNo, createConnection(otherMemberNo));
            sendOffer(peerConnectionMap.get(otherMemberNo), otherMemberNo);
        });
    }
    catch (e) {
        console.log(e);
    }
});
const handleCameraBtn = () => {
    myStream.getVideoTracks()[0].enabled = !(myStream.getVideoTracks()[0].enabled);
    if (camera) {
        cameraBtn.innerHTML = '<span class="material-symbols-outlined">videocam_off</span>';
        camera = false;
        display = false;
    }
    else {
        cameraBtn.innerHTML = '<span class="material-symbols-outlined">videocam</span>';
        camera = true;
        display = false;
    }
};
const handleMicBtn = () => {
    myStream.getAudioTracks()[0].enabled = !(myStream.getAudioTracks()[0].enabled);
    if (mic) {
        micBtn.innerHTML = '<span class="material-symbols-outlined">mic_off</span>';
        mic = false;
    }
    else {
        micBtn.innerHTML = '<span class="material-symbols-outlined">mic</span>';
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
    fetch("/video/");
    if (document.getElementById(`${otherMemberNo}`) === null) {
        let videoParent = document.createElement("div");
        videoParent.classList.add("videoParent");
        myVideo.appendChild(videoParent);
        const video = document.createElement('video');
        video.height = 270;
        video.width = 270;
        video.autoplay = true;
        video.id = otherMemberNo;
        video.srcObject = event.streams[0];
        video.addEventListener("click", () => {
            video.requestFullscreen();
        });
        videoParent.appendChild(video);
        let nameTag = document.createElement("div");
        nameTag.id = `${otherMemberNo}$1`;
        nameTag.classList.add("nameTag2");
        nameTag.innerText = otherMemberNo;
        videoParent.appendChild(nameTag);
    }
    else {
        const video = document.getElementById(`${otherMemberNo}`);
        video.srcObject = event.streams[0];
    }
    videoSizeHandler();
};
const iceHandler = (event, targetNo) => {
    console.log("ICE실행");
    if (event.candidate) {
        socket.send(JSON.stringify({
            "type": "icecandidate",
            "body": event.candidate,
            "targetNo": targetNo,
            "iceSender": memberNo,
            "projectNo": projectNo,
        }));
    }
};
const setLocal = (myPeerConnection, offerOrAnswer) => {
    myPeerConnection.setLocalDescription(offerOrAnswer);
};
const needMemberKey = () => {
    socket.send(JSON.stringify({
        "type": "needMemberKey",
        "projectNo": projectNo,
    }));
};
const sendOffer = (myPeerConnection, targetNo) => {
    myPeerConnection.createOffer().then((offer) => {
        setLocal(myPeerConnection, offer);
        socket.send(JSON.stringify({
            "type": "offer",
            "body": offer,
            "targetNo": targetNo,
            "makeAnswerMemberNo": memberNo,
            "projectNo": projectNo,
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
            "setAnswerMemberNo": memberNo,
            "projectNo": projectNo,
        }));
        console.log("send Answer");
    });
};
const roomlimit = () => {
    if (otherMemberNoSet.size > 3) {
        socket.close();
        alert("인원이 초과되었습니다");
        setTimeout(() => {
            byebye();
        }, 2000);
    }
};
const sendChat = () => {
    socket.send(JSON.stringify({
        "type": "chat",
        "chatContent": chatInput.value,
        "memberNo": memberNo,
        "projectNo": projectNo,
    }));
    // fetch("/video/chatSend", {
    //     method : "POST",
    //     headers : {
    //         "Content-Type" : "application/json",
    //     },
    //     body : JSON.stringify({
    //         "memberNo": memberNo,
    //         "projectNo": projectNo,
    //         "chatContent" : chatInput.value,
    //     })
    // })
    // .then(resp => resp.json())
    // .then(data => {
    // })
    // .catch(e => {
    //     console.log("채팅 전송 실패 : ", e);
    // })
    console.log("send 실행");
    chatInput.value = "";
};
const makeChatBlock = (chatNo, chatContent) => {
    return `<div class="chat-item">
                <img src="/resources/images/loofy1.jpg" class="chat-prof-img">
                <div class="chat-id">${chatNo}</div>
                <div class="chat-content">${chatContent}</div>
            </div>`;
};
const videoSizeHandler = () => {
    const video = document.querySelectorAll("video");
    if (otherMemberNoSet.size === 0) {
        Array.from(video).forEach(item => {
            item.height = 500;
            item.width = 500;
            const tag = item.nextElementSibling;
            tag.classList.remove("nameTag2");
            tag.classList.add("nameTag1");
        });
    }
    if (otherMemberNoSet.size === 1) {
        Array.from(video).forEach(item => {
            item.height = 270;
            item.width = 270;
            const tag = item.nextElementSibling;
            tag.classList.remove("nameTag1");
            tag.classList.add("nameTag2");
        });
    }
    if (otherMemberNoSet.size === 2) {
        Array.from(video).forEach(item => {
            item.height = 270;
            item.width = 270;
            const tag = item.nextElementSibling;
            tag.classList.remove("nameTag1");
            tag.classList.add("nameTag2");
        });
    }
    if (otherMemberNoSet.size === 3) {
        Array.from(video).forEach(item => {
            item.height = 270;
            item.width = 270;
            const tag = item.nextElementSibling;
            tag.classList.remove("nameTag1");
            tag.classList.add("nameTag2");
        });
    }
};
const startVideoConference = () => __awaiter(void 0, void 0, void 0, function* () {
    // 1. 소켓을 연결한다.
    yield connectWebsocket();
    // 2. 화면을 얻어온다.
    yield getMedia();
    // 3. signaling server에 신호를 보내 otherMemberList를 채운다.
    yield needMemberKey();
    // 방의 인원을 select해오고, 인원이 맞으면 해당 코드 실행으로 바꾸기 넣어야함
    setTimeout(() => {
        // 해당 방의 현재인원을 검색해서, 4명이 넘는다면 창을 끄고 종료시킨다.(경고 모달 출력)
        roomlimit();
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
chatBtn.addEventListener("click", sendChat);
startVideoConference();
// 수정 projectNo4
//# sourceMappingURL=popup.js.map