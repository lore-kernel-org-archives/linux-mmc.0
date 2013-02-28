From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/2] mmc: sdhci: add function get_cd
Date: Fri, 1 Mar 2013 00:57:52 +0100
Message-ID: <CACRpkda-Jwemm6Dy_KjbXGYs1G2b9Y++4fv-CbPTdKFAQ2g1dw@mail.gmail.com>
References: <1362019202-21934-1-git-send-email-kliu5@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171]:35514 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383Ab3B1X5x (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Feb 2013 18:57:53 -0500
Received: by mail-ia0-f171.google.com with SMTP id z13so2116580iaz.2
        for <linux-mmc@vger.kernel.org>; Thu, 28 Feb 2013 15:57:52 -0800 (PST)
In-Reply-To: <1362019202-21934-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <kliu5@marvell.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>, Stephen Warren <swarren@wwwdotorg.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>

On Thu, Feb 28, 2013 at 3:40 AM, Kevin Liu <kliu5@marvell.com> wrote:

> 1. mmc_rescan will call get_cd to know whether the card is present
> before mmc_rescan_try_freq to avoid useless trials during
> card removal or start host is called when card is not present.
> 2. get_cd need to be checked to resolve slow card removal issue.
>
> Signed-off-by: Kevin Liu <kliu5@marvell.com>

Lookin' good!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
