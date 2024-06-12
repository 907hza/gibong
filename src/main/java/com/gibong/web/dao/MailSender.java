package com.gibong.web.dao;

import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;

// 해당 인터페이스는 심플 메일 메세지를 전달받아 메일을 발송하는 기능을 정의하고 있으
// 심플 메일 메세지는 메일 제목과 단순 텍스트 내용으로 구성된 메일을 발송할 때 사용
// 해당 클래스를 통해 빈 설정을 하면 된다
public interface MailSender 
{
	/**
	 * Send the given simple mail message.
	 * @param simpleMessage the message to send
	 * @throws MailParseException in case of failure when parsing the message
	 * @throws MailAuthenticationException in case of authentication failure
	 * @throws MailSendException in case of failure when sending the message
	 */
	void send(SimpleMailMessage simpleMessage) throws MailException;

	/**
	 * Send the given array of simple mail messages in batch.
	 * @param simpleMessages the messages to send
	 * @throws MailParseException in case of failure when parsing a message
	 * @throws MailAuthenticationException in case of authentication failure
	 * @throws MailSendException in case of failure when sending a message
	 */
	void send(SimpleMailMessage... simpleMessages) throws MailException;
}
