From: Chris Ball <cjb@laptop.org>
Subject: Re: [RFC/PATCH RESEND] mmc: sdhci: Enable high speed support for MMC cards
Date: Sat, 28 Aug 2010 12:24:24 -0400
Message-ID: <m362yu4sef.fsf@pullcord.laptop.org>
References: <20100827191945.GI20407@void.printf.net>
	<AANLkTinmaio2PAcnwP7+U8P4O1-T3HiLYz_ej3zGAV5Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54978 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752755Ab0H1QYf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 28 Aug 2010 12:24:35 -0400
In-Reply-To: <AANLkTinmaio2PAcnwP7+U8P4O1-T3HiLYz_ej3zGAV5Y@mail.gmail.com>
	(Kyungmin Park's message of "Sat, 28 Aug 2010 14:39:59 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-mmc@vger.kernel.org, "George G. Davis" <gdavis@mvista.com>, Zhangfei Gao <zgao6@marvell.com>

Hi Kyungmin,

   > It's already patched. you can find it easily at list.

I think you're talking about this patch from Zhangfei:

From: Zhangfei Gao <zgao6@marvell.com>
Date: Mon, 16 Aug 2010 21:15:32 -0400
Subject: [PATCH] sdhci: support MMC_CAP_MMC_HIGHSPEED

Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
Acked-by: Matt Fleming <matt@console-pimps.org>
Acked-by: Kyungmin Park <kmpark@infradead.org>
---
 drivers/mmc/host/sdhci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7855121..913555e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1823,7 +1823,7 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc->caps |= MMC_CAP_4_BIT_DATA;

 	if (caps & SDHCI_CAN_DO_HISPD)
-		mmc->caps |= MMC_CAP_SD_HIGHSPEED;
+		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;

 	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
-- 

But this patch wasn't sent to Andrew either -- and so isn't in Linus'
or Andrew's tree -- and it's also only one of the two hunks in George's
earlier patch.  George also had:

--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1180,7 +1180,8 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		ctrl &= ~SDHCI_CTRL_4BITBUS;
 
-	if (ios->timing == MMC_TIMING_SD_HS &&
+	if ((ios->timing == MMC_TIMING_SD_HS ||
+	     ios->timing == MMC_TIMING_MMC_HS) &&
 	    !(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT))
 		ctrl |= SDHCI_CTRL_HISPD;
 	else
       
So, we still have to send a patch to Andrew, and decide which patch it
should be.  What do you think?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
