From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/2] mmc: sdhci: add function get_cd
Date: Fri, 1 Mar 2013 10:22:06 +0100
Message-ID: <CACRpkdbFNBt19d7QmgdCfLcG2UN+xL3S=hoKS7kW8shvv2oM5g@mail.gmail.com>
References: <1362019202-21934-1-git-send-email-kliu5@marvell.com>
	<CACRpkda-Jwemm6Dy_KjbXGYs1G2b9Y++4fv-CbPTdKFAQ2g1dw@mail.gmail.com>
	<CADz5_gLXMu3ODUj-k2R4J0kZzjPQzYCu34nZ2QqXAfK2mQBL-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176]:39732 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab3CAJWH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Mar 2013 04:22:07 -0500
Received: by mail-ia0-f176.google.com with SMTP id i18so2434378iac.21
        for <linux-mmc@vger.kernel.org>; Fri, 01 Mar 2013 01:22:06 -0800 (PST)
In-Reply-To: <CADz5_gLXMu3ODUj-k2R4J0kZzjPQzYCu34nZ2QqXAfK2mQBL-w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: Kevin Liu <kliu5@marvell.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>, Stephen Warren <swarren@wwwdotorg.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>

On Fri, Mar 1, 2013 at 4:19 AM, Kevin Liu <keyuan.liu@gmail.com> wrote:

> Thanks for the review. Can you also help to review the latest v3?
> The only difference to v2 is swap the check sequence between gpio and
> cd-broken quirk.

Yes I saw that, please add my Reviewed-by.

Yours,
Linus Walleij
