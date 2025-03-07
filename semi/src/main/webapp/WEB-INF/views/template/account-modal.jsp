<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div
   class="account-modal none justify-center items-center fixed left-0 top-0 w-100p h-100p opacity-40"
 >
   <div class="light top-50 left-50 w-400 round-6">
     <div class="flex justify-between px-16 py-11 bb-1 line-base">
       <span class="title-font-color text-16">계정</span>
       <button
         class="modal-close-btn trans-color border-none outline-none w-24 h-24 p-0 round-6"
       >
         <img src="/img/close.svg" class="w-100p h-100p" />
       </button>
     </div>
     <div class="content p-32">
       <div>
         <span class="subtitle-font-color text-14">프로필 정보</span>
         <div class="flex items-center mt-12">
           <img src="${picture}" width="86" height="86" class="mr-16 round-full" />
           <div class="flex flex-col">
             <span class="subtitle-font-color text-14">이름</span>
             <input
               type="text"
               name="memberName"
               value="${name}"
               class="w-204 border-1 line-base outline-none mt-4 px-14 py-9 text-14 round-6"
             />
             <span class="err-msg none btn-negative text-12"
               >첫 글자 한글이며 한글 또는 숫자 2 ~ 10자입니다.</span
             >
           </div>
         </div>
       </div>
       <div class="flex flex-col mt-16">
         <span class="subtitle-font-color text-14">로그아웃</span>
         <div class="mt-8">
           <button
             class="logout-btn border-none outline-none px-14 py-9 text-14 subtitle-font-color netural round-6"
           >
             로그아웃
           </button>
         </div>
       </div>
       <div class="flex flex-col mt-16">
         <span class="subtitle-font-color text-14">회원 탈퇴</span>
         <span class="subtext-font-color text-12 mt-4"
           >계정을 탈퇴하면 데이터들을 복구할 수 없습니다.</span
         >
         <div class="mt-8">
           <button
             class="member-delete-btn border-1 negative-b trans-color outline-none px-14 py-9 text-14 btn-negative round-6"
           >
             계정 탈퇴
           </button>
         </div>
       </div>
       <div class="flex justify-end mt-32">
         <button
           class="save-btn border-none outline-none brand-dark light-font px-14 py-9 text-14 round-6"
         >
           저장
         </button>
       </div>
     </div>
   </div>
 </div>