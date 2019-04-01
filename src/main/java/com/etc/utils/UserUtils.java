package com.etc.utils;

import com.etc.entity.BsUser;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.xml.ws.spi.http.HttpContext;

public class UserUtils {
    public static BsUser getUser(){
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        BsUser user = (BsUser) request.getSession().getAttribute("user");
        return user;
    }
}
