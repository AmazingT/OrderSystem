package com.order.common;

import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.stereotype.Service;

@Service
public class MailUtil{
	//to:接收对象;text:发送内容
	public void send_mail(String toUser,String sendContent) throws MessagingException{
		Properties properties = new Properties();
		properties.put("mail.smtp.host","smtp.qq.com");//发送邮件服务器
		properties.put("mail.smtp.port","465");//发送端口
		properties.put("mail.smtp.auth","true");
		properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			//发送邮件的账号和密码
			Session session = Session.getInstance(properties,new Authenticator(){
			protected PasswordAuthentication getPasswordAuthentication(){
				return new PasswordAuthentication("1334099433@qq.com","zznzuazfhgyqfifh");//授权码
			}
		});
		//session.setDebug(true);
		
		//创建邮件对象
		Message message = new MimeMessage(session);
		//设置发件人
		message.setFrom(new InternetAddress("1334099433@qq.com"));
		//设置收件人
		message.setRecipient(Message.RecipientType.TO,new InternetAddress(toUser));
		//设置主题
		message.setSubject("乐卖用户注册验证码");
		//设置邮件内容(发送类型)
		message.setContent(sendContent,"text/html;charset=UTF-8");//setText();
		//设置发件时间
		message.setSentDate(new Date());
		//保存前面的设置
		message.saveChanges();
		//发送
		Transport.send(message);
	}
}
