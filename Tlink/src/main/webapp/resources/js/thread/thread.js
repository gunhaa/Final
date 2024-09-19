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
    formData.append("chatType", "chat");

    fetch('/chat/insert', {
        method: 'POST',
        body: formData
    })
    .then( resp => resp.json())
    .then( result => {
        console.log("gg");
    });
})