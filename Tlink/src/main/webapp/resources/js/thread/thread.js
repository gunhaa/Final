const inputBox = document.getElementById("inputBox");
const message = document.getElementById("message");
const sendBtn = document.getElementById("send");
const inputFile = document.getElementById("inputFile");
let threadNo = new URLSearchParams(location.search).get("threadNo");


let formData = new FormData();

inputBox.addEventListener("input", ()=>{
    message.value = inputBox.innerText;
})

inputBox.addEventListener("drop", e =>{
    e.preventDefault();

    const file = e.dataTransfer.files[0];

    if( file != undefined ){
        const fileName = file.name;

        const reader = new FileReader();
        reader.readAsDataURL(file);

        reader.onload = e=>{
            drowFile(fileName);
            formData.append("files", file);
        }
    }
})

inputFile.addEventListener("change", e =>{
    console.log(e);

    for( let file of e.target.files ){

        if( file != undefined ){

            let fileName = file.name;

            const reader = new FileReader();
            reader.readAsDataURL(file);

            reader.onload = e=> {
                drowFile(fileName);
                formData.append("files", file);
            }
        }
    }
})

function drowFile(fileName){
    let fileListBox = inputBox.getElementsByClassName("fileListBox")[0];

    if( fileListBox == undefined ){
        fileListBox = document.createElement("div");
        fileListBox.classList.add("fileListBox");
        inputBox.append(fileListBox);
    }

    const fileBox = document.createElement("div");
    fileBox.classList.add("fileBox");
    fileBox.innerText = fileName;
    fileBox.setAttribute("contenteditable", false);

    const deleteBtn = document.createElement("span");
    deleteBtn.classList.add("delete-image");
    deleteBtn.innerHTML = '&times;';

    fileBox.append(deleteBtn);

    fileListBox.append(fileBox);
}

sendBtn.addEventListener("click", ()=>{
    console.log(new URLSearchParams(location.search).get("threadNo"));
    
    formData.append("message", message.value);
    formData.append("chatType", "normal");
    formData.append("threadNo", new URLSearchParams(location.search).get("threadNo"));


    fetch('/thread/insert', {
        method: 'POST',
        body: formData
    })
    .then( resp => resp.json())
    .then( res => {
        // 화면 만드는 코드
        console.log("fetch 작동");
    
        if(res.memberProfile=="" || res.memberProfile==null){
            res.memberProfile = "/resources/images/common/user.png";
        }

        const now = new Date();

        const year = now.getFullYear();
        const month = (now.getMonth() + 1).toString().padStart(2, '0');
        const day = now.getDate().toString().padStart(2, '0');
        const hours = now.getHours().toString().padStart(2, '0');
        const minutes = now.getMinutes().toString().padStart(2, '0');
        
        const formattedTime = `${year}-${month}-${day} ${hours}:${minutes}`;

        document.querySelector("#chatBox").insertAdjacentHTML("beforeend", 
                                `<li class="chatNormal">
                                    <div class="profile">
                                        <img src="${res.memberProfile}">
                                    </div>
                                    <div>
                                        <div class="infoLine">
                                            <span>${res.memberNickname}</span>
                                            <span class="createDate">${formattedTime}</span>
                                        </div>
                                        <div>${res.chatMessage}</div>
                                    </div>
                                </li>`);
        
        inputBox.value="";

        
       /*  socket.send({
            type: "chat",
            content: {
                message.value
            } 

        }) */
        
    });
})



// const joinChat = document.getElementById("joinChat");
// joinChat.addEventListener("click", ()=>{
//     fetch("/thread/message", {
//         method:"POST",
//         headers: {
//             "Content-Type" : "application/json"
//         },
//         body: {
            
//         }
//     })
// })
