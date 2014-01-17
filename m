From: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: k3: remove clk_table
Date: Fri, 17 Jan 2014 15:01:24 +0000
Message-ID: <86sism7iuz.fsf@void.printf.net>
References: <1389604469-8064-1-git-send-email-zhangfei.gao@linaro.org>
	<1389604469-8064-3-git-send-email-zhangfei.gao@linaro.org>
	<002b01cf1115$4cdfe240$e69fa6c0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <002b01cf1115$4cdfe240$e69fa6c0$%jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> (Seungwon
	Jeon's message of "Tue, 14 Jan 2014 19:42:19 +0900")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: 'Zhangfei Gao' <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Arnd Bergmann' <arnd-r2nGTMty4D4@public.gmane.org>, 'Mike Turquette' <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Jaehoon Chung' <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Haojian Zhuang' <haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, brooke.wangzhigang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Jan 14 2014, Seungwon Jeon wrote:
> On Monday, January 13, 2014, Zhangfei Gao wrote:
>> Remove clk_table and directly use ios->clock as clock source rate.
>> Abstract init clock rate and max clock limitation in clk.c
>> 
>> Signed-off-by: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> Acked-by: Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

It looks like patch 1/2 did not make 3.14.  Do you want me to take
this patch for 3.14 anyway?  (Why?)

Thanks,

- Chris.
-- 
Chris Ball   <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>   <http://printf.net/>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
