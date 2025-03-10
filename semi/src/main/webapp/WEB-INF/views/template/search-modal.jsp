<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div
	class="search-modal none justify-center items-center fixed left-0 top-0 w-100p h-100p opacity-40"
>
  <div class="light w-650 h-450 round-6">
    <div class="flex items-center p-16 bb-1 line-base">
      <img src="/img/search.svg" class="mr-8" >
      <input name="keyword" 
      		placeholder="일정 내용을 검색하세요"
      		class="keyword-input flex-1 outline-none border-none p-0 text-16 title-font-color" >
    </div>
    <div class="search-hist h-361 p-16 overflow-auto">
      <span class="text-12 subtitle-font-color">최근 검색</span>
      <div class="search-hist-content">
      </div>
      <div class="no-search-result none mt-12">
      	<span class="text-14 title-font-color">최근 검색 결과가 없습니다.</span>
      </div>
    </div>
  </div>
</div>