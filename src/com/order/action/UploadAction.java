package com.order.action;

import java.io.File;
import java.io.IOException;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;
import com.order.dao.UserDao;
import com.order.entity.User;

/**
 * 单个文件上传
 * @author 周小波
 *
 */
@Controller @Scope("prototype")
public class UploadAction {
	private File upload;//上传的文件
	private String uploadFileName;//文件名
	private String uploadContentType;//文件类型
	@Resource private UserDao userDao;
	
	public String fileUpload() throws Exception{
		ActionContext ac = ActionContext.getContext();
		String realPath = ServletActionContext.getServletContext().getRealPath("/image");
		String name = (String) ac.getSession().get("user_name");
		
		User user = userDao.findByName(name);
		
		String imgFormat = uploadFileName.substring(uploadFileName.lastIndexOf("."));//截取图片格式
		
		if(upload != null){
			File saveDir = new File(realPath);
			if(!saveDir.exists())
				saveDir.mkdirs();
			uploadFileName = user.getUser_id()+imgFormat;//命令格式为"用户ID"+"图片格式"
			//System.out.println(uploadFileName);
			//创建保存的文件
			File saveFile = new File(saveDir,uploadFileName);
			//使用commons-io组件的FileUtils上传文件
			try{
				FileUtils.copyFile(upload,saveFile);
			}catch(IOException e){
				e.printStackTrace();
			}
		}
		user.setUser_head(uploadFileName);//保存该用户上传的头像路径到数据库
		ac.getSession().remove("user_head");
		ac.getSession().put("user_head", uploadFileName);
		
		userDao.update(user);
		
		return "success";
	}
	
	public File getUpload() {
		return upload;
	}
	public void setUpload(File upload) {
		this.upload = upload;
	}
	public String getUploadFileName() {
		return uploadFileName;
	}
	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}
	public String getUploadContentType() {
		return uploadContentType;
	}
	public void setUploadContentType(String uploadContentType) {
		this.uploadContentType = uploadContentType;
	}
}










