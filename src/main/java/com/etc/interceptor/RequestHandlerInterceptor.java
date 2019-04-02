package com.etc.interceptor;

import com.etc.entity.BsUser;
import com.xiaoleilu.hutool.util.ObjectUtil;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 对请求进行拦截，判断请求路径是否包含admin，如果包含则判断是否有管理员权限
 * @author chengzi
 *
 */
public class RequestHandlerInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String path = request.getRequestURL().toString();
		BsUser user = (BsUser) request.getSession().getAttribute("user");
		if (path.contains("admin")) {
			if (ObjectUtil.isNull(user)&&user.getUserType().equals("0")) {
				return true;
			}else{
				response.sendRedirect("/home/index");
				return false;
			}
		}else if(ObjectUtil.isNull(user)) {
			response.sendRedirect("/home/index");
			return false;
		}else if(path.contains("caixin")){
			if (ObjectUtil.isNull(user)||user.getUserType().equals("1")) {
				response.sendRedirect("/home/index");
				return false;
			}
			return true;
		}else {
			return true;
		}
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub

	}

}
