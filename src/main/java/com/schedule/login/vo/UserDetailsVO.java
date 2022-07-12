package com.schedule.login.vo;

import com.schedule.login.service.LoginService;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.experimental.Delegate;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;

@RequiredArgsConstructor
@Getter
public class UserDetailsVO implements UserDetails {

    @Delegate
    private final LoginVO loginVO;
    private final Collection<? extends GrantedAuthority> authorities;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public String getPassword() {
        return loginVO.getPwdNo();
    }

    @Override
    public String getUsername() {
        return loginVO.getUsrId();
    }

    @Override
    public boolean isAccountNonExpired() {
        return loginVO.getisEnable();
    }

    @Override
    public boolean isAccountNonLocked() {
        return loginVO.getisEnable();
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return loginVO.getisEnable();
    }

    @Override
    public boolean isEnabled() {
        return loginVO.getisEnable();
    }
}
