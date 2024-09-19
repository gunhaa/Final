const modal = document.getElementById("modalContainer");
let memberList = document.getElementById("listArea").getElementsByClassName("memberItem");

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

    fetch("/chat/selectMember?memberName=" + selectMember.value)
    .then(resp => resp.json())
    .then(result => {
        const selectResult = document.getElementById("queryResult");
        selectResult.innerText = "";

        for( let item of result ){
            const li = document.createElement("li");
            const info = document.createElement("span");
            info.innerText = '<strong>\${item.memberNickname}</strong> - \${item.memberId}';

            const addBtn = document.createElement("button");
            addBtn.classList.add("addBtn");
            addBtn.setAttribute("onclick", "addMember(" + item + ")");
            addBtn.innerText = "추가";

            li.append(a, addBtn);
            selectResult.append(li);
        }

        selectResult.style.display = "block";
    })
    .catch( e => console.log(e))
})

function refreshMemberList(memberList){
    const memberArea = document.getElementById("listArea");

    memberArea.innerText = "";

    let index = 0;
    for( let member of memberList ){
        const memberItem = document.createElement("div");
        memberItem.classList.add("memberItem");

        const memberInfo = document.createElement("div");
        memberInfo.classList.add("memberInfo");

        const profile = document.createElement("img");
        if( member.profileImage != null ){
            profile.setAttribute("src", member.profileImage);
        } else {
            profile.setAttribute("src", "/resources/images/chat/user.png");
        }

        const nickname = document.createElement("span");
        nickname.classList.add("memberNickname");
        nickname.innerText = member.memberNickname;

        const memberId = document.createElement("span");
        memberId.classList.add("memberId");
        memberId.innerText = member.memberId;

        memberInfo.append(profile, nickname, memberId);

        if( loginMemberNo != member.memberNo ){
            const deleteMember = document.createElement("button");
            deleteMember.classList.add("deleteMemberBtn");
            deleteMember.setAttribute("onclick", "deleteMember(" + index + ")");
            deleteMember.innerText = "삭제";
        }

        index++;
    }
}

function deleteMember(index){
    memberList.splice(index);

    refreshMemberList(memberList);
}

function addMember(member){

    memberList = [...memberList, member];

    refreshMemberList(memberList);
}

function invalid(){

    const threadName = document.getElementById("threadName");
    if( threadName.value.trim().length == 0 ){
        alert("스레드 이름을 입력해주세요");
        return false;
    }

    return true;
}