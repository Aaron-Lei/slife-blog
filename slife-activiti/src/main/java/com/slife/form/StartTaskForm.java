package com.slife.form;

import lombok.Data;
import org.hibernate.validator.constraints.NotEmpty;

/**
 * @Author felixu
 * @Date 2018.08.14
 */
@Data
public class StartTaskForm {
    @NotEmpty
    public String procDefKey;
//    @NotEmpty
    public String entityId;
    @NotEmpty
    public String title;
//    public String userId;
    public String comment;
}
