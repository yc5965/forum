package com.etc.controller;

import com.etc.common.EnDecryptUtil;
import com.etc.common.JsonResult;
import com.etc.entity.BsUser;
import com.etc.service.BsUserService;
import com.xiaoleilu.hutool.util.ObjectUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.UUID;

@Controller
@RequestMapping(value ="/bs/bsUser")
public class BsUserController {

    @Autowired
    private BsUserService bsUserService;


}
