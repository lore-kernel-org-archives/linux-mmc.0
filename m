From: Chris Ball <cjb@laptop.org>
Subject: [RFC/PATCH RESEND] mmc: sdhci: Enable high speed support for MMC
	cards
Date: Fri, 27 Aug 2010 20:19:45 +0100
Message-ID: <20100827191945.GI20407@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46466 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752750Ab0H0TTq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Aug 2010 15:19:46 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: "George G. Davis" <gdavis@mvista.com>

Hi,

This patch wasn't responded to -- any feedback from the list?

From: George G. Davis <gdavis@mvista.com>
Date: Thu, 18 Feb 2010 15:27:53 -0500

Allow high speed mode for high speed capable ver 4.x MMC cards.

Comments and/or feedback appreciated.

Signed-off-by: George G. Davis <gdavis@mvista.com>
[cjb: rebase patch against Linus]
Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/sdhci.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fdc9233..8e360e1 100644
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
@@ -1823,8 +1824,10 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
 
-	if (caps & SDHCI_CAN_DO_HISPD)
+	if (caps & SDHCI_CAN_DO_HISPD) {
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED;
+		mmc->caps |= MMC_CAP_MMC_HIGHSPEED;
+    }
 
 	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
-- 
1.7.0.1

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
