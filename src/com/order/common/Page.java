package com.order.common;

/**
 * 数据库分页类
 * @author 周小波
 *
 */
public class Page {
	private int startPage;//每一页开始页码
	private int endPage;//每一页的末尾页码
	private int pageNum;//总的分页数
	private int totalRecord;//总的记录数
	private int currentPage;//当前页
	private int pagePerShow;//每页显示的页码数
	
	//maxCount:每页显示最大记录数;
	public Page(int maxCount,int totalRecord,int currentPage,int pagePerShow){
		this.pageNum = totalRecord % maxCount == 0 ? totalRecord / maxCount : totalRecord / maxCount + 1;
		this.totalRecord = totalRecord;
		this.currentPage = currentPage;
		this.pagePerShow = pagePerShow;
		showPerPages(currentPage,pageNum,pagePerShow);
	}
	
	//每一页的页码设置(显示多少页码)
	public void showPerPages(int currentPage,int pageNum,int pagePerShow){
		if(pagePerShow >= pageNum){
			startPage = 1;
			endPage = pageNum;
		}else{
			if(currentPage <= pagePerShow/2){
				startPage =1;
				endPage = pagePerShow;
			}else if((currentPage+pagePerShow/2) > pageNum){
				startPage = pageNum - pagePerShow + 1;
				endPage = pageNum;
			}else{
				startPage = currentPage - (pagePerShow - 1)/2;
				endPage = currentPage + pagePerShow/2;
			}
		}
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public int getPageNum() {
		return pageNum;
	}

	public int getTotalRecord() {
		return totalRecord;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public int getPagePerShow() {
		return pagePerShow;
	}
	
	
}
