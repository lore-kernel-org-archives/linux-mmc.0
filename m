From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 2/2] mmc: dw_mmc: k3: remove clk_table
Date: Fri, 17 Jan 2014 23:43:36 +0900
Message-ID: <000601cf1392$80cdd600$82698200$%jun@samsung.com>
References: <1389604469-8064-1-git-send-email-zhangfei.gao@linaro.org>
 <1389604469-8064-3-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:25935 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbaAQOni (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jan 2014 09:43:38 -0500
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Seungwon Jeon' <tgih.jun@samsung.com>, 'Zhangfei Gao' <zhangfei.gao@linaro.org>, 'Chris Ball' <chris@printf.net>, 'Arnd Bergmann' <arnd@arndb.de>, 'Mike Turquette' <mturquette@linaro.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Haojian Zhuang' <haojian.zhuang@linaro.org>, brooke.wangzhigang@huawei.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org

+ Chris Ball (New e-mail)

On Tue, January 14, 2014, Seungwon Jeon wrote:
> On Monday, January 13, 2014, Zhangfei Gao wrote:
> > Remove clk_table and directly use ios->clock as clock source rate.
> > Abstract init clock rate and max clock limitation in clk.c
> >
> > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> 
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
> 
> Thanks,
> Seungwon Jeon

