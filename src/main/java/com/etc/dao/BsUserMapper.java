package com.etc.dao;


import com.etc.entity.BsUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BsUserMapper {

    int insert(@Param("user") BsUser user);

    List<BsUser> findList();

    BsUser findUserByEmail(@Param("email") String email);

    Integer updateUserByEmail(@Param("user") BsUser user);

    BsUser getUserById(@Param("id") String id);

    BsUser getByName(@Param("name") String name);

    void updateUserType(@Param("user") BsUser user);
}