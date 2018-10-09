package com.slife.ext;

import com.slife.util.SnowflakeIdGenerator;

/**
 * @Author felixu
 * @Date 2018.08.14
 */
public class IdGenerator implements org.activiti.engine.impl.cfg.IdGenerator {

    @Override
    public String getNextId() {
        return SnowflakeIdGenerator.getInstance().nextId() + "";
    }
}
