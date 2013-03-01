From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci: add function get_cd
Date: Fri, 1 Mar 2013 11:19:19 +0800
Message-ID: <CADz5_gLXMu3ODUj-k2R4J0kZzjPQzYCu34nZ2QqXAfK2mQBL-w@mail.gmail.com>
References: <1362019202-21934-1-git-send-email-kliu5@marvell.com>
	<CACRpkda-Jwemm6Dy_KjbXGYs1G2b9Y++4fv-CbPTdKFAQ2g1dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:35727 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696Ab3CADTU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Feb 2013 22:19:20 -0500
Received: by mail-oa0-f49.google.com with SMTP id j6so5023684oag.36
        for <linux-mmc@vger.kernel.org>; Thu, 28 Feb 2013 19:19:19 -0800 (PST)
In-Reply-To: <CACRpkda-Jwemm6Dy_KjbXGYs1G2b9Y++4fv-CbPTdKFAQ2g1dw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Kevin Liu <kliu5@marvell.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>, Stephen Warren <swarren@wwwdotorg.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>

2013/3/1 Linus Walleij <linus.walleij@linaro.org>:
> On Thu, Feb 28, 2013 at 3:40 AM, Kevin Liu <kliu5@marvell.com> wrote:
>
>> 1. mmc_rescan will call get_cd to know whether the card is present
>> before mmc_rescan_try_freq to avoid useless trials during
>> card removal or start host is called when card is not present.
>> 2. get_cd need to be checked to resolve slow card removal issue.
>>
>> Signed-off-by: Kevin Liu <kliu5@marvell.com>
>
> Lookin' good!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
Linus,

Thanks for the review. Can you also help to review the latest v3?
The only difference to v2 is swap the check sequence between gpio and
cd-broken quirk.

Kevin
> Yours,
> Linus Walleij
