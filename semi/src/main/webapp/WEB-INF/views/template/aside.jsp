<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<aside class="sidebar aside-anim light-dark w-260 h-100v px-16">
  <div class="flex justify-between items-center pt-8">
    <button
      class="profile-btn trans-color border-none outline-none flex items-center px-8 py-9 round-6"
    >
      <img src="${picture}" class="mr-8 round-full" width="26" height="26" />
      <span class="profile-membername title-font-color text-16">${name}</span>
    </button>
    <div class="flex items-center">
      <button
        class="bell-btn trans-color border-none outline-none w-24 h-24 p-0 mr-16 round-6"
      >
        <img src="/img/bell.svg" class="w-100p h-100p" />
      </button>
      <button
        class="sidebar-btn trans-color border-none outline-none w-24 h-24 p-0 round-6"
      >
        <img src="/img/sidebar.svg" class="w-100p h-100p" />
      </button>
    </div>
  </div>
  <div class="title-tab pt-12">
    <button
      class="search-btn trans-color border-none outline-none flex items-center w-100p px-8 py-9 round-6"
    >
      <img src="/img/search.svg" class="mr-8" width="24" height="24" />
      <span class="title-font-color text-16">검색</span>
    </button>
    <button
      class="social-btn trans-color border-none outline-none flex items-center w-100p px-8 py-9 mt-6 round-6"
    >
      <img src="/img/social.svg" class="mr-8" width="24" height="24" />
      <span class="title-font-color text-16">소셜</span>
    </button>
    <button
      class="trans-color border-none outline-none flex items-center w-100p px-8 py-9 mt-6 round-6"
    >
      <img src="/img/calendar.svg" class="mr-8" width="24" height="24" />
      <span class="title-font-color text-16">달력</span>
    </button>
  </div>
  <div class="tab">
    <div
      class="date-title-tab flex justify-between items-center px-8 py-11 mt-24 round-6"
    >
      <span class="text-font-color text-14">일정 관리</span>
      <button
        class="plus-btn none trans-color border-none outline-none w-24 h-24 p-0 round-6"
      >
        <img src="/img/plus.svg" class="w-100p h-100p" />
      </button>
    </div>
    <div class="date-page-tab overflow-scroll-y h-664"></div>
  </div>
</aside>
