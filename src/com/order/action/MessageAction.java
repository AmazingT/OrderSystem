package com.order.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;
import com.order.common.NextPage;
import com.order.common.QueryResult;
import com.order.dao.MessageDao;
import com.order.dao.UserDao;
import com.order.entity.Message;
import com.order.entity.ShowMessage;
import com.order.entity.User;

@Controller @Scope("prototype")
public class MessageAction {
	@Resource private UserDao userDao;
	@Resource private NextPage nextPage;
	@Resource private MessageDao messageDao;
	private Message message;
	private int page;
	
	//后台管理员查询出所有留言信息
	public String msgList(){
		ActionContext ac = ActionContext.getContext();
		String orderby = "order by o.id desc";
		ac.getSession().put("msgList", pageUtil(orderby));
		
		return "msgList";
	}
	
	//前台显示所有用户留言信息
	public String messageList(){
		ActionContext ac = ActionContext.getContext();
		String orderby = "order by o.id desc";
		ac.getSession().put("mgList", pageUtil(orderby));
		
		return "mgList";
	}
	
	//查询出所有的留言信息并分页显示，首先要判断用户是否登录。若没有登录则跳转到登录界面。
	public String userMsgList(){
		ActionContext ac = ActionContext.getContext();
		if(ac.getSession().get("user_name")!=null){//用户已经登录了
			String orderby = "order by o.id desc";
			ac.getSession().put("msgList", pageUtil(orderby));
			
			return "mgList";
		}else{
			//如果用户没有登录，则跳转到登录界面
			return "noLogin";
		}
	}
	
	//用分页查询的方法根据需求传入的orderby查找相关记录
	public List<ShowMessage> pageUtil(String orderby){
		List<ShowMessage> list = new ArrayList<ShowMessage>();
		
		HttpServletRequest request = ServletActionContext.getRequest();

		String Page = request.getParameter("currentPage");
		Page = Page == null ? "1" : Page;// 执行删除和更新操作时会重定向到该处执行，此时的currentPage为null

		int currentPage = Integer.parseInt(Page);
		if (currentPage < 1)
			currentPage = 1;
		QueryResult<Message> qr = nextPage.viewList(messageDao, currentPage, 6, Message.class, orderby);
		
		//ShowMessage实体类是用来封装用户评论信息的
		for(Message m:qr.getResultSet()){
			ShowMessage sm = new ShowMessage();
			Message mm = messageDao.findById(m.getId());
			
			sm.setUsername(mm.getUser().getUser_name());
			sm.setMessageID(m.getId());
			sm.setContent(m.getContent());
			sm.setDate(m.getDate());
			sm.setSubject(m.getSubject());
			sm.setHeadImg(mm.getUser().getUser_head());
			
			list.add(sm);
		}
		return list;
	}
	
	//保存用户的留言信息到数据库
	public String saveUserMessage(){
		ActionContext ac = ActionContext.getContext();
		String name = (String) ac.getSession().get("user_name");
	
		if(name != null){
			User u = userDao.findByName(name);
			message.setUser(u);
			
			Calendar time = Calendar.getInstance();
			SimpleDateFormat fmt = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");
			String t = fmt.format(time.getTime());
			//留言时间
			message.setDate(t);
			messageDao.save(message);
			
			return "saveUserMsg";
		}else{		
			return "noLogin";
		}
	}
	
	//用户查找自己的留言信息
	public String queryMessage(){
		ActionContext ac = ActionContext.getContext();
		int id =(Integer)ac.getSession().get("user_id");
		Set<Message> set = userDao.findMessageById(id);
		
		if(set.size()>0){
			ac.getSession().put("oneselfList", set);			
		}else{
			String message = "对不起，没有您的留言记录！";
			ac.getSession().put("message", message);
		}
		return "show";
	}
	
	//管理员删除所勾选的留言记录
	public String deleteMessage(){
		HttpServletRequest req = ServletActionContext.getRequest();
		String[] msg = req.getParameterValues("messages");//获取复选框中已选的值,其值就是对应留言记录的id值
		
		for(int i=0;i<msg.length;i++){
			int id = Integer.parseInt(msg[i]);
			messageDao.delete(Message.class, id);
		}
		return "deleteSuccess";
		
	}
	
	//获取一条留言记录，并封装到showMessage类供页面显示使用
	public String getOneMessage(){
		HttpServletRequest req = ServletActionContext.getRequest();
		int id = Integer.parseInt(req.getParameter("messageID"));
		
		Message msg = messageDao.findById(id);
		ShowMessage sm = new ShowMessage();
		
		sm.setContent(msg.getContent());
		sm.setDate(sm.getDate());
		sm.setSubject(msg.getSubject());
		sm.setUsername(msg.getUser().getUser_name());
		
		req.getSession().setAttribute("oneMessage", sm);
		return "oneMessage";
	}
	
	public Message getMessage() {
		return message;
	}
	public void setMessage(Message message) {
		this.message = message;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
}
