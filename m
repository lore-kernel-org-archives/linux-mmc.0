From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH 1/2] clk: hisilicon: add hi3620_mmc_clks
Date: Wed, 15 Jan 2014 00:29:08 -0800
Message-ID: <20140115082908.4167.34040@quantum>
References: <1389604469-8064-1-git-send-email-zhangfei.gao@linaro.org>
 <1389604469-8064-2-git-send-email-zhangfei.gao@linaro.org>
 <20140114201740.4167.52076@quantum> <52D5E709.7040105@linaro.org>
 <20140115035339.4167.51194@quantum> <52D623CC.50009@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f52.google.com ([209.85.213.52]:43053 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbaAOI3Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 03:29:16 -0500
Received: by mail-yh0-f52.google.com with SMTP id v1so444612yhn.25
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jan 2014 00:29:16 -0800 (PST)
In-Reply-To: <52D623CC.50009@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@linaro.org>, zhangfei <zhangfei.gao@linaro.org>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, brooke.wangzhigang@huawei.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org, Kevin Hilman <khilman@linaro.org>

Quoting Haojian Zhuang (2014-01-14 21:59:40)
> 
> On 01/15/2014 11:53 AM, Mike Turquette wrote:
> > Quoting zhangfei (2014-01-14 17:40:25)
> >> Dear Mike
> >>
> >> On 01/15/2014 04:17 AM, Mike Turquette wrote:
> >>> Quoting Zhangfei Gao (2014-01-13 01:14:28)
> >>>> Suggest by Arnd: abstract mmc tuning as clock behavior,
> >>>> also because different soc have different tuning method and registers.
> >>>> hi3620_mmc_clks is added to handle mmc clock specifically on hi3620.
> >>>>
> >>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> >>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
> >>>> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> >>> Patch looks good to me with one exception. I do not have
> >>> Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt in the
> >>> clk-next branch. Is there a stable branch I can pull in as a dependency?
> >> Mach-hisi just have been uploaeded.
> >> Have tried next-20140114, the patch can be applied successfully.
> >> While v3.13-rc8 still can not.
> >>
> >> Is this fine?
> > Can you give me a link to the branch that introduces
> > Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt?
> >
> > I guess the patch introducing it is going through arm-soc. Is this going
> > in for 3.14? If so then perhaps the clk tree and the arm-soc tree can
> > share a stable branch that introduces it.
> >
> > Regards,
> > Mike
> >
> Some patches are merged into arm-soc, and others are in clk tree.
> If sharing a stable branch between arm-soc and clk tree, it only means
> that we need to revert all commits that are in arm-soc and clk tree.
> I think it's too complex.

I'm suggesting reverting any patches that are applied to arm-soc. I'm
only suggesting that there might be a common branch that both the clk
and arm-soc trees can depend on to fix this problem.

> 
> How about split the patch? The patch on document should enter in arm-soc.

That is one approach. You might want to run it past the arm-soc folks
first to see if they will take in the binding definition for 3.14.

Regards,
Mike

> 
> Regards
> Haojian
