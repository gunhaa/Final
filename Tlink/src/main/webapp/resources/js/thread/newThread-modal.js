const modal = document.getElementById("modalContainer");
let memberList = document.getElementById("listArea");

const createBtn = document.getElementById("createThread");
createBtn.addEventListener("click", ()=>{
    modal.classList.toggle("hidden");
})

const closeBtn = document.getElementById("closeBtn");
closeBtn.addEventListener("click", () =>{
    modal.classList.toggle("hidden");
})

const selectMember = document.getElementById("query");
selectMember.addEventListener("input", ()=>{

    if( selectMember.value.trim().length == 0 ){
        return;
    }

    fetch("/thread/selectMember?projectNo="+ projectNo + "&query=" + selectMember.value)
    .then(resp => resp.json())
    .then(result => {
        const selectResult = document.getElementById("queryResult");
        selectResult.innerText = "";

        for( let item of result ){

            console.log(item);

            const li = document.createElement("li");
            const info = document.createElement("span");
            info.innerHTML = `<strong>${item.USER_NAME}</strong> - ${item.USER_EMAIL}`;

            const addBtn = document.createElement("button");
            addBtn.classList.add("addBtn");
            addBtn.setAttribute("type", "button");
            addBtn.setAttribute("onclick", `addMember(${JSON.stringify(item)})`);
            addBtn.innerText = "추가";

            li.append(info, addBtn);
            selectResult.append(li);
        }

        selectResult.style.display = "block";
    })
    .catch( e => console.log(e))
})

function deleteMember(index){
    memberList.splice(index);

    refreshMemberList(memberList);
}

function addMember(member){

    const memberItem = document.createElement("div");
    memberItem.classList.add("memberItem");

    const memberInfo = document.createElement("div");
    memberInfo.classList.add("memberInfo");

    const profile = document.createElement("img");
    if( member.profileImage != null ){
        profile.setAttribute("src", member.PROFILE_IMG);
    } else {
        profile.setAttribute("src", "/resources/images/common/user.png");
    }

    const nickname = document.createElement("span");
    nickname.classList.add("memberNickname");
    nickname.innerText = member.USER_NAME;

    const memberId = document.createElement("span");
    memberId.classList.add("memberId");
    memberId.innerText = member.USER_EMAIL;

    memberInfo.append(profile, nickname, memberId);

    const deleteMember = document.createElement("button");
    deleteMember.classList.add("deleteMemberBtn");
    deleteMember.innerText = "삭제";
    deleteMember.setAttribute("type", "button");

    const userNo = document.createElement("input");
    userNo.setAttribute("type", "hidden");
    userNo.value = member.USER_NO;
    userNo.setAttribute("name", "userList");

    memberItem.append(memberInfo, deleteMember, userNo);
    
    memberList.append(memberItem);
}

function invalid(){

    const threadName = document.getElementById("threadTitle");
    if( threadName.value.trim().length == 0 ){
        alert("스레드 이름을 입력해주세요");
        return false;
    }

    return true;
}