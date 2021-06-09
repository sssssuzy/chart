package com.example.controller;


import java.io.File;
import java.io.FileInputStream;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class UploadController {
   @Resource(name="uploadPath")
   String path;
   
   @RequestMapping("/uploadForm")
   public void uploadForm(){
      
   }
   @RequestMapping("/uploadAjax")
   public void uploadAjax(){      
   }
   
   //���Ͼ��ε� Form
   @RequestMapping(value="/uploadForm", method=RequestMethod.POST)
   public void uploadFormPost(MultipartFile file)throws Exception{
      System.out.println("���ε��н�:" + path);
      System.out.println("���ϻ�����:" + file.getSize());
      System.out.println("����Ÿ��:" + file.getContentType());
      System.out.println("���ϸ�:" + file.getOriginalFilename());
      UUID uid=UUID.randomUUID();
      String savedName=uid.toString()+"_"+file.getOriginalFilename();
      File target = new File(path, savedName);
      FileCopyUtils.copy(file.getBytes(), target);
   }
   
// ���Ͼ��ε� Ajax
	@ResponseBody
	@RequestMapping(value = "/uploadFile", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public String uploadAjaxPost(MultipartFile file) throws Exception {
		UUID uid = UUID.randomUUID();
		String fullName = uid.toString() + "_" + file.getOriginalFilename();
		File target = new File(path, fullName);
		FileCopyUtils.copy(file.getBytes(), target);
		return fullName;
	}
   
   //�̹��� ���
   @ResponseBody
   @RequestMapping("/displayFile")
   public byte[] display(String fullName)throws Exception{
      FileInputStream in=new FileInputStream(path + "/" + fullName);
      byte[] image=IOUtils.toByteArray(in);
      in.close();
      return image;
   }
   
   //���ϻ���
   @ResponseBody
   @RequestMapping("/deleteFile")
   public void deleteFile(String fullName){
      new File(path + "/" + fullName).delete();
   }
   
   //���� �ٿ�ε�
   @ResponseBody
   @RequestMapping(value="/downloadFile")
   public ResponseEntity<byte[]> downloadFile(String fullName)throws Exception{
      ResponseEntity<byte[]> entity=null;
      FileInputStream in=null;
      try{
         in= new FileInputStream(path + "/" + fullName);
         fullName = fullName.substring(fullName.indexOf("_") + 1);
         HttpHeaders headers = new HttpHeaders();
         headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
         headers.add("Content-Disposition", "attachment;filename=\"" 
                                            + new String(fullName.getBytes("UTF-8"), "ISO-8859-1") + "\"");
         entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
       }catch(Exception e){
          entity= new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
       }finally{
          in.close();
       }
      return entity;
   }
}