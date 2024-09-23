const inputBox = document.getElementById("inputBox");
const message = document.getElementById("message");
const sendBtn = document.getElementById("send");
const inputFile = document.getElementById("inputFile");

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

    formData.append("message", message.value);
    formData.append("chatType", "normal");

    fetch('/thread/insert', {
        method: 'POST',
        body: formData
    })
    .then( resp => resp.json())
    .then( result => {
        // 화면 만드는 코드
        for( chat of result ){
            const chatrow = document.createElement("li");
            if( chat.chatType == "normal"){
                chatrow.classList.add("chatNormal");
            } else if ( chat.chatType == "system" ){
                chatrow.classList.add("chatSystem");
            }
    
            const profile = document.createElement("div");
            profile.classList.add("profile");
    
            const img = document.createElement("img");
            if( chat.memberProfile != "" ){
                img.setAttribute("src", chat.memberProfile);
            } else {
                img.setAttribute("src", "/resources/images/common/user.png");
            }
            profile.append(img);
    
            const content = document.createElement("div");
            const infoLine = document.createElement("div");
            infoLine.classList.add(infoLine);
            
            const userName = document.createElement("span");
            userName.innerText = chat.memberNickname;
            const createDate = document.createElement("span");
            createDate.classList.add("createDate");
            createDate.innerText = chat.chatCreateDate;
    
            infoLine.append(userName, createDate);
    
            const message = docuemnt.createDate("div");
            message.innerText = chat.chatMessage;

            const fileList = document.createElement("div");
            fileList.classList.add("fileListBox");

            for( file of chat.fileList ){
                
                const fileBox = document.createElement("div");
                fileBox.classList.add("fileBox");
                fileBox.innerText = fileName;
                fileBox.setAttribute("contenteditable", false);
            
                const deleteBtn = document.createElement("span");
                deleteBtn.classList.add("delete-image");
                deleteBtn.innerHTML = '&times;';
            
                fileBox.append(deleteBtn);
            
                fileList.append(fileBox);
            }
    
            content.append(infoLine, message);
    
            chatrow.append(profile, content, fileList);
        }
        /*
        socket.send({
            type: "chat",
            content: message.value
        })
        
        */
    });
})

let threadNo = new URLSearchParams(location.search).get("threadNo");

const joinChat = document.getElementById("joinChat");
joinChat.addEventListener("click", ()=>{
    fetch("/thread/message", {
        method:"POST",
        headers: {
            "Content-Type" : "application/json"
        },
        body: {
            
        }
    })
})
