package com.atguigu.atcrowdfunding;

public class LoginacctException extends RuntimeException {
    //自定义异常
    public LoginacctException(){}

    public LoginacctException(String message){
       super(message);
    }
}
