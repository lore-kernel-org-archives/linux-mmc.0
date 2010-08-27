From: Chris Ball <cjb@laptop.org>
Subject: [PATCH RESEND] OMAP HSMMC: fix a racing case between kmmcd and
	omap_hsmmc_suspend
Date: Fri, 27 Aug 2010 21:18:06 +0100
Message-ID: <20100827201806.GR23079@void.printf.net>
References: <AANLkTilPeWe7ygUv0npuAhn-MnJhoPdnAu9C7S85OQUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55181 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141Ab0H0USP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Aug 2010 16:18:15 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTilPeWe7ygUv0npuAhn-MnJhoPdnAu9C7S85OQUQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ethan Du <ethan.too@gmail.com>
Cc: akpm@linux-foundation.org, Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, linux-mmc <linux-mmc@vger.kernel.org>

Hi,

This doesn't seem to have been merged -- Andrew, could you take it?

From: Ethan Du <ethan.too@gmail.com>
Date: Mon, 21 Jun 2010 19:20:41 +0800

If suspend called when kmmcd is doing host->ops->disable,
as kmmcd already increased host->en_dis_recurs to 1, the mmc_host_enable
in suspend function will return directly without increase the nesting_cnt,
which will cause the followed register access carried out to the disabled host.

mmc_suspend_host will enable host itself. No need to enable host before it.
Also works on kmmcd will get flushed in mmc_suspend_host, enable host after
it will be safe. So make the mmc_host_enable after it.

Signed-off-by: Ethan <ethan.too@gmail.com>
Acked-by: Adrian Hunter <adrian.hunter@nokia.com>
Acked-by: Madhusudhan Chikkature <madhu.cr@ti.com>
[cjb: rebase against current Linus]
---
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index ba623d6..1f7d01a 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2323,8 +2323,8 @@ static int omap_hsmmc_suspend(struct device *dev)
 			}
 		}
 		cancel_work_sync(&host->mmc_carddetect_work);
-		mmc_host_enable(host->mmc);
 		ret = mmc_suspend_host(host->mmc);
+		mmc_host_enable(host->mmc);
 		if (ret == 0) {
 			omap_hsmmc_disable_irq(host);
 			OMAP_HSMMC_WRITE(host->base, HCTL,
--
1.7.0.1

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
