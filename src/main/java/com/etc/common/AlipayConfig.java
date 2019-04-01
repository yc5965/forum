package com.etc.common;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.xml.ws.spi.http.HttpContext;
import java.io.FileWriter;
import java.io.IOException;

/* *
 *类名：AlipayConfig
 *作者：AAA_有梦想一起实现
 */

public class AlipayConfig{

    // ↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

    // 应用ID,您的APPID，收款账号既是您的APPID对应支付宝账号
    public static String app_id = "2016092600598267";//例：2016082600317257

    // 商户私钥，您的PKCS8格式RSA2私钥
    public static String merchant_private_key = "MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDa1YEegenmC3GXhiQSc7ar0u9+LYdiEjnaKHHSAr0az+GkhiaGffSwC98rx3DJsRsdfm8Swm70CJF+MwjhkOE4+f4VWgeL50YLEFDn5AXbAskKGpxZIm7TB/tehO0kh1NdT0z6IunrBmtZXWwSqxUUQGcugNLWsIiFBwTLyIxygr4WWx62Hwm6Vt/Ew01Vej559OFCTN9vgdbJ3Qb9as44GDRN8Gk5rZkXnu3jRcgXr/nGMXUfZX0JU7dHc9/xv7WXB1klG2fE7skFnekyGKwVNByKzzqXARTioaF60yeb3frFHMQTVRezjLINSiRNwpWXpN6RU78PzHcKgrVRngUnAgMBAAECggEBAJ2rJQvJCLBh4GcPFCBjVOM56KpdvWSQwzQG3fM1W/DchLQYn9tZFxpcg2A0o3P+cg3vEbJPesfDAKkPtj9nNo7puALEShmn+ZRxHgnmBb4FpLnt8GZcY8MSxi8U0RP3mL3rLAgxbZ6Tknbh08Mjlt1vhahA0ygyKzrFktQM2/yIF2k4VCcBortC2mlWvL1GOtS49+xl27J7RsV5BDyvRPU8yiu/RYM/Oz5tX1x95nAdyJ4z9ww7qBfvx+pAfVTB4GUp9guAWJgimwLLZjsifa4XEBqdEVyo5ISyeobtztjGrIDWLxnPAIbD7wvADMigqsmB0xfEY6IZo9hOpf9lnRkCgYEA94/L+qAe0HSll9xeKNCoB8dAl0WswLe1o5z50WXbdv72v0xW2zS8YyhlPmKvCY9Dhhzt9N6VdcMck/5EpyyohP4EGG1yGuPOv9yGSMqrIumR7jF2yg9nIPNzJwpNc3XskZxiblc4p3F5lcowbpwS6C2VVv20/o+jtRdYYuQes+sCgYEA4ksIL5EkQFZKRJKPc7S0VFwO5VQSHksRlV8rCRq8pog/qegjSalhDfU1FtfXf+XO/sn6w6ArGmuCyRT+lPelN55OwItM1HQR1J4+iA2OcLBjC8ybSvRVo/JwnrO52AvpTdZPq/bsaD8Oylrn6lVouS778vrM5eKMRpwm+akWcLUCgYAVsKWgidLpVK8FhStCzDVMqSqBlnsyT2Y8tY41yITYAjLARAIAJriyv2FPe/n2DnVOFM7Me4wAy11/ofGF7CW/sTnOohgzPu5oZPvm+MrRvkEo63CK95qDipD2RLLQgO5/O4JsRHwUP571fseLiWUmroe9HXF0NEWVojv+PhpqjQKBgQC3gTL1J9Tm21LEgrkTkjE9y51EuMUsjaGHqLIEYwsiXJCL3rRm8pTCtdrEWGnnzFrsYKwaYVMyzIY1O/IqqRvwm06vcwbtreYbret1dtDQbykSk2xG/xZHqb1L5ODK4vXhae4XvFf/PUtoKwmwDGys5v3nDxyDOxCX3d75S/XnlQKBgQCfrWvdOg0BVxjj8q+NbEXpQIqIvlsw9WcJE4p1/7dqrt9ns6q8UwBvpMbT092hDxa7G5LjUNfq25gnpLkSvP24Rzf8mdwayzgdZohwCkm+UKti6A0T73ZPkrS14FNxzRYyy9JJQJpiFHN63HUSxy6vUxDGnYWX/3liQ4/dnh/SfQ==";
    // 支付宝公钥,查看地址：https://openhome.alipay.com/platform/keyManage.htm
    // 对应APPID下的支付宝公钥。
    public static String alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA766FfoOhHaO1FVAXcFtCRwuuxySh8BcfLPaQfvtbh2dkOc4hXYxGcBbaFJ08bXMCPESXEcRm6v3MVwkuSCWj4VvNIOO2djqoeszJS1LPOsesQwTwU6GlyWMFFdYcV6wmwTHiVobI/V2KMMRIEIpeuS0HNNahynGUwyX9EBUjZ5mM+KfXX6hP4kGJS9JzwaF6U11StujtuVjVPgfWlYYi07q+Edla7z8Etr6kH52zi+WoxYvpEMuJB3/8xbwPxQ6H4ovsMSj44tV1hAawrA8MJd01pq0cp0sykKQRd3hKLSTRIDZ3CNI7ak/zVD9z5AFvPec5aLu4Zkg8FlTz6/C6ZwIDAQAB";
    // 服务器异步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
    /**
     * 返回的时候此页面不会返回到用户页面，只会执行你写到控制器里的地址
     */
    public static String notify_url = "http://localhost:8080/bsPay/alipayNotifyNotice";
    // 页面跳转同步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
    /**
     * 此页面是同步返回用户页面，也就是用户支付后看到的页面，上面的notify_url是异步返回商家操作，谢谢
     * 要是看不懂就找度娘，或者多读几遍，或者去看支付宝第三方接口API，不看API直接拿去就用，遇坑不怪别人
     */
    public static String return_url = "http://localhost:8080/bsPay/alipayReturnNotice";
    // 签名方式
    public static String sign_type = "RSA2";
    // 字符编码格式
    public static String charset = "utf-8";
    // 支付宝网关
    public static String gatewayUrl = "https://openapi.alipaydev.com/gateway.do";
    // 日志地址
    public static String log_path = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getServletContext().getRealPath("/upload");
    // ↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

}

