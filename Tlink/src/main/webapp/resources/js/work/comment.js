



$(`.commentInsert`).on("click", function(){
    const data={ 
        "commentCon"  : commentCon, 
        "workNo"      : workNo, 
        "userNo"      : userNo
    };
    fetch("/commentWork", { method: "POST", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data) })
    .then (rep => rep.json())
    .then (res => {


        console.log(res);


        // const work=res;
        // work.workNo!=0 ?  alert("성공하였습니다.") : alert("실패하였습니다."); 
        // if(work.workNo!=0){ 
            
        // $(this).parents(`td`).find(`ul`).append(`<li>
        //         <span class="workNo" hidden>\${work.workNo}</span>
        //         <a href="/workSheet?workNo=\${work.workNo}&projectNo=\${projectNo}"><span class="material-symbols-outlined">draft</span></a>
        //         <span class="workTitle" contenteditable="true">\${work.workTitle}</span>
        //         <span class="material-symbols-outlined deleteWork">close</span>
        //     </li>`)
        // }


    })
    .catch(err => console.log(err))
        
})





$(`.commentDelete`).on("click", function(){
    const commentNo=$(this).pFind(`section`,`.commentNo`).text();
    console.log(commentNo);

    const data={
        "commentNo"  : commentNo, 
    };
    fetch("/commentWork", { method: "DELETE", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data) })
    .then (rep => rep.json())
    .then (res => {

        console.log(res);

    })
    .catch(err => console.log(err))
        
})



function selectComment(){
    
    console.log(workNo);

    const data={ 
        "workNo"      : workNo, 
    };
    fetch("/commentWork/select", { method: "POST", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data) })
    .then (rep => rep.json())
    .then (res => {


        console.log(res);


        // const work=res;
        // work.workNo!=0 ?  alert("성공하였습니다.") : alert("실패하였습니다."); 
        // if(work.workNo!=0){ 
            
        // $(this).parents(`td`).find(`ul`).append(`<li>
        //         <span class="workNo" hidden>\${work.workNo}</span>
        //         <a href="/workSheet?workNo=\${work.workNo}&projectNo=\${projectNo}"><span class="material-symbols-outlined">draft</span></a>
        //         <span class="workTitle" contenteditable="true">\${work.workTitle}</span>
        //         <span class="material-symbols-outlined deleteWork">close</span>
        //     </li>`)
        // }


    })
    .catch(err => console.log(err))
        
}
selectComment();

