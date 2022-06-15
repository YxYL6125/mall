package com.yxyl.springboot.config;

import ch.qos.logback.classic.Level;
import ch.qos.logback.classic.spi.ILoggingEvent;
import ch.qos.logback.core.pattern.color.ANSIConstants;
import ch.qos.logback.core.pattern.color.ForegroundCompositeConverterBase;

/**
 * @program: mall
 * @description: 日志配置类
 * @author: YxYL
 * @create: 2022-06-15 19:15
 **/


public class LogbackColorfulConfig  extends ForegroundCompositeConverterBase<ILoggingEvent> {


    @Override
    protected String getForegroundColorCode(ILoggingEvent iLoggingEvent) {
        Level level = iLoggingEvent.getLevel();
        switch (level.toInt()){
            case Level.ERROR_INT:
                return ANSIConstants.RED_FG;
            case Level.WARN_INT:
                return ANSIConstants.YELLOW_FG;
            case Level.INFO_INT:
                return ANSIConstants.BLUE_FG;
            case Level.DEBUG_INT:
                return ANSIConstants.GREEN_FG;

            default:return ANSIConstants.DEFAULT_FG;

        }

    }
}
