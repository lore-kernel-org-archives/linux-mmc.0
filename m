From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH 1/2] clk: hisilicon: add hi3620_mmc_clks
Date: Tue, 14 Jan 2014 19:53:39 -0800
Message-ID: <20140115035339.4167.51194@quantum>
References: <1389604469-8064-1-git-send-email-zhangfei.gao@linaro.org>
 <1389604469-8064-2-git-send-email-zhangfei.gao@linaro.org>
 <20140114201740.4167.52076@quantum> <52D5E709.7040105@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gg0-f169.google.com ([209.85.161.169]:47937 "EHLO
	mail-gg0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbaAODxs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jan 2014 22:53:48 -0500
Received: by mail-gg0-f169.google.com with SMTP id j5so362983ggn.14
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jan 2014 19:53:47 -0800 (PST)
In-Reply-To: <52D5E709.7040105@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei <zhangfei.gao@linaro.org>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, brooke.wangzhigang@huawei.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org

Quoting zhangfei (2014-01-14 17:40:25)
> Dear Mike
> 
> On 01/15/2014 04:17 AM, Mike Turquette wrote:
> > Quoting Zhangfei Gao (2014-01-13 01:14:28)
> >> Suggest by Arnd: abstract mmc tuning as clock behavior,
> >> also because different soc have different tuning method and registers.
> >> hi3620_mmc_clks is added to handle mmc clock specifically on hi3620.
> >>
> >> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> >> Acked-by: Arnd Bergmann <arnd@arndb.de>
> >> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> >
> > Patch looks good to me with one exception. I do not have
> > Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt in the
> > clk-next branch. Is there a stable branch I can pull in as a dependency?
> 
> Mach-hisi just have been uploaeded.
> Have tried next-20140114, the patch can be applied successfully.
> While v3.13-rc8 still can not.
> 
> Is this fine?

Can you give me a link to the branch that introduces
Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt?

I guess the patch introducing it is going through arm-soc. Is this going
in for 3.14? If so then perhaps the clk tree and the arm-soc tree can
share a stable branch that introduces it.

Regards,
Mike

> 
> Thanks
