package com.etc.dao;

import com.etc.entity.BsView;
import com.etc.entity.EcharsData;

import java.util.List;

public interface BsViewMapper {

    void insert(BsView bsView);

    List<EcharsData> getzData();
    List<EcharsData> getsData();
}