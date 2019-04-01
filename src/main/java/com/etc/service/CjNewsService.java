package com.etc.service;

import com.etc.common.JsonResult;
import com.etc.dao.CjNewsMapper;
import com.etc.entity.CjNewsDetail;
import com.etc.entity.CjNewsSrcDict;
import com.xiaoleilu.hutool.util.CollectionUtil;
import com.xiaoleilu.hutool.util.ObjectUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CjNewsService {
    @Autowired
    private CjNewsMapper cjNewsMapper;

    public JsonResult findNewsDict() {
        List<CjNewsSrcDict> dictList = cjNewsMapper.findNewsDict();
        List<Object> newsList = new ArrayList<>();
        for (CjNewsSrcDict dict : dictList) {
            Map<String, Object> newsDict = (Map<String, Object>) CollectionUtil.findOneByField(newsList, "src", dict.getSrc());
            if (ObjectUtil.isNotNull(newsDict)) {
                List<Object> channel = (List<Object>) newsDict.get("channel");
                Map<String, Object> channelMap = new HashMap<>();
                channelMap.put("id", dict.getChannel());
                channelMap.put("channelName", dict.getChannelName());
                channelMap.put("sort", dict.getSort());
                channel.add(channelMap);
                newsDict.put("channel", channel);
            } else {
                Map<String, Object> dictMap = new HashMap<>();
                List<Object> channel = new ArrayList<>();
                Map<String, Object> channelMap = new HashMap<>();
                dictMap.put("src", dict.getSrc());
                dictMap.put("srcName", dict.getSrcName());
                dictMap.put("des", dict.getDes());
                channelMap.put("id", dict.getChannel());
                channelMap.put("channelName", dict.getChannelName());
                channelMap.put("sort", dict.getSort());
                channel.add(channelMap);
                dictMap.put("channel", channel);
                newsList.add(dictMap);
            }
        }

        return new JsonResult(newsList);
    }

    public JsonResult findPageNewsDetail(Integer pageStart, Integer pageSize, CjNewsDetail cjNewsDetail) {
        List<CjNewsDetail> detailList = cjNewsMapper.findPageNewsDetail(pageStart, pageSize, cjNewsDetail);
        List<Object> resutl = new ArrayList<>();
        for (CjNewsDetail newsDetail : detailList) {
            Map<String, String> detailMap = new HashMap<>();
            detailMap.put("id", newsDetail.getId());
            detailMap.put("title", newsDetail.getTitle());
            detailMap.put("content", newsDetail.getContent());
            detailMap.put("subContent", newsDetail.getSubContent());
            detailMap.put("newsDate", newsDetail.getNewsDate());
            detailMap.put("src", newsDetail.getSrc());
            detailMap.put("channels", newsDetail.getChannels());
            detailMap.put("createDate", newsDetail.getCreateDate());
            resutl.add(detailMap);
        }

        Integer count = cjNewsMapper.findNewsDetailCount(cjNewsDetail);
        return new JsonResult(count, resutl.toArray());
    }
}