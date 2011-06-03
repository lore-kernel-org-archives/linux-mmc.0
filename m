From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/4] mmc: support sdhci-pxav3.c
Date: Fri, 3 Jun 2011 18:14:26 +0200
Message-ID: <201106031814.26414.arnd@arndb.de>
References: <1307094572-8378-1-git-send-email-zhangfei.gao@marvell.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:62364 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965Ab1FCQOf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Jun 2011 12:14:35 -0400
In-Reply-To: <1307094572-8378-1-git-send-email-zhangfei.gao@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@marvell.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Qiming Wu <wuqm@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Friday 03 June 2011, Zhangfei Gao wrote:
>         Instead of sharing sdhci-pxa.c, use sdhci-pxav3.c for mmp2.
>         The original method is not easy to track, which is share sdhci-pxa.c among pxa serious, like pxa910, mmp2, etc,
>         and put the platfrom difference under arch/arm.
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> Signed-off-by: Philip Rakity <prakity@marvell.com>

Looks very good now,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
