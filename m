From: Seungwon Jeon <essuuj@gmail.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: k3: remove clk_table
Date: Sat, 18 Jan 2014 01:10:23 +0900
Message-ID: <CAFt19AB2Yk4U06-R9rMqFgEHFjN_L-pnc1wR35SQUjX28j7tZQ@mail.gmail.com>
References: <1389604469-8064-1-git-send-email-zhangfei.gao@linaro.org>
	<1389604469-8064-3-git-send-email-zhangfei.gao@linaro.org>
	<002b01cf1115$4cdfe240$e69fa6c0$%jun@samsung.com>
	<86sism7iuz.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:64047 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbaAQQKY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jan 2014 11:10:24 -0500
In-Reply-To: <86sism7iuz.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Zhangfei Gao <zhangfei.gao@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Mike Turquette <mturquette@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, brooke.wangzhigang@huawei.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org

On Sat, Jan 18, 2014 at 12:01 AM, Chris Ball <chris@printf.net> wrote:
>
> Hi,
>
> On Tue, Jan 14 2014, Seungwon Jeon wrote:
> > On Monday, January 13, 2014, Zhangfei Gao wrote:
> >> Remove clk_table and directly use ios->clock as clock source rate.
> >> Abstract init clock rate and max clock limitation in clk.c
> >>
> >> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> >
> > Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
>
> It looks like patch 1/2 did not make 3.14.  Do you want me to take
> this patch for 3.14 anyway?  (Why?)
Yes, I hope that it would be merged this time.
I think that this change should have been applied to (036f29: mmc:
dw_mmc: add dw_mmc-k3 for k3 platform) originally.

Thanks,
sw-j
