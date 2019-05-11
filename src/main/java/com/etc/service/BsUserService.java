package com.etc.service;

import com.etc.common.EnDecryptUtil;
import com.etc.dao.BsUserMapper;
import com.etc.entity.BsUser;
import com.etc.utils.UserUtils;
import com.xiaoleilu.hutool.date.DateUtil;
import com.xiaoleilu.hutool.util.ObjectUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Service
public class BsUserService {
    @Autowired
    private BsUserMapper bsUserMapper;

    public Boolean regUser(BsUser user){
        int i = bsUserMapper.insert(user);
        if (i > 0) {
            return true;
        }
        return false;
    }

    public BsUser checkUser(String email, String upwd) {
        BsUser user = bsUserMapper.findUserByEmail(email);
        if (ObjectUtil.isNotNull(user)) {
            if (upwd.length()>=6) {
                upwd = EnDecryptUtil.MD5(upwd);
            }
            if (upwd.equals(user.getPassword())) {
                return user;
            }
        }
        return null;
    }

    public BsUser findUserByEmail(String email){
        return bsUserMapper.findUserByEmail(email);
    }

    public Integer updateUserByEmail(BsUser user) {
        user.setPassword(EnDecryptUtil.MD5(user.getPassword()));
        return bsUserMapper.updateUserByEmail(user);
    }

    public BsUser getUserById(String id) {
        return bsUserMapper.getUserById(id);
    }

    public BsUser getByName(String name) {
        return bsUserMapper.getByName(name);
    }

    public void updateUserType(String userType,String price) {
        BsUser user = UserUtils.getUser();
        user.setUserType(userType);
        Date date = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        if (price.equals("263.00")){
            cal.add(Calendar.YEAR, 1);
            user.setExpireDate(DateUtil.date(cal));

        }else if(price.equals("68.00")){
            cal.add(Calendar.MONTH, 3);
            user.setExpireDate(DateUtil.date(cal));
        }else if(price.equals("25.00")){
            cal.add(Calendar.MONTH, 1);
            user.setExpireDate(DateUtil.date(cal));
        }
        bsUserMapper.updateUserType(user);
    }

    public List<BsUser> findListUser(Integer pageStart,Integer pageSize) {
        return bsUserMapper.findListUser(pageStart,pageSize);
    }

    public List<BsUser> findList() {
        return bsUserMapper.findList();
    }
}