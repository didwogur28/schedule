package com.schedule.login.vo;

import lombok.experimental.Delegate;
import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;

public class LoginVO implements java.io.Serializable {

    private String usrId;				// 사용자아이디
    private String usrNm;				// 사용자명
    private String pwdNo;				// 비밀번호
    private String phoNo;               // 전화번호
    private String roles;               // 역할

    private Boolean isEnable = true;

    public String getUsrId() {
        return usrId;
    }

    public void setUsrId(String usrId) {
        this.usrId = usrId;
    }

    public String getUsrNm() {
        return usrNm;
    }

    public void setUsrNm(String usrNm) {
        this.usrNm = usrNm;
    }

    public String getPwdNo() {
        return pwdNo;
    }

    public void setPwdNo(String pwdNo) {
        this.pwdNo = pwdNo;
    }

    public String getPhoNo() {
        return phoNo;
    }

    public void setPhoNo(String phoNo) {
        this.phoNo = phoNo;
    }

    public String getRoles() {
        return roles;
    }

    public void setRoles(String roles) {
        this.roles = roles;
    }

    public Boolean getisEnable() {
        return isEnable;
    }

    public void setisEnable(Boolean enable) {
        isEnable = enable;
    }

    @Override
    public String toString() {
        return "LoginVO{" +
                "usrId='" + usrId + '\'' +
                ", usrNm='" + usrNm + '\'' +
                ", pwdNo='" + pwdNo + '\'' +
                ", phoNo='" + phoNo + '\'' +
                ", roles='" + roles + '\'' +
                ", isEnable=" + isEnable +
                '}';
    }
}
