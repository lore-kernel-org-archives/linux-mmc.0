From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: omap_hsmmc: Fix UHS card with DDR50 support
Date: Tue, 25 Nov 2014 13:22:20 +0100
Message-ID: <1416918140-24385-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:40937 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390AbaKYMW0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Nov 2014 07:22:26 -0500
Received: by mail-la0-f52.google.com with SMTP id q1so395471lam.39
        for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2014 04:22:24 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: Seungwon Jeon <tgih.jun@samsung.com>

The commit, mmc: omap: clarify DDR timing mode between SD-UHS and eMMC,
switched omap_hsmmc to support MMC DDR mode instead of UHS DDR50 mode.

Add UHS DDR50 mode again and this time let's also keep the MMC DDR mode.

Fixes: 5438ad95a57c (mmc: omap: clarify DDR timing mode between SD-UHS and eMMC)
Reported-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/omap_hsmmc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 82b40b8..7c71dcd 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -628,6 +628,7 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_host *host)
 	 */
 	if ((mmc_pdata(host)->features & HSMMC_HAS_HSPE_SUPPORT) &&
 	    (ios->timing != MMC_TIMING_MMC_DDR52) &&
+	    (ios->timing != MMC_TIMING_UHS_DDR50) &&
 	    ((OMAP_HSMMC_READ(host->base, CAPA) & HSS) == HSS)) {
 		regval = OMAP_HSMMC_READ(host->base, HCTL);
 		if (clkdiv && (clk_get_rate(host->fclk)/clkdiv) > 25000000)
@@ -647,7 +648,8 @@ static void omap_hsmmc_set_bus_width(struct omap_hsmmc_host *host)
 	u32 con;
 
 	con = OMAP_HSMMC_READ(host->base, CON);
-	if (ios->timing == MMC_TIMING_MMC_DDR52)
+	if (ios->timing == MMC_TIMING_MMC_DDR52 ||
+	    ios->timing == MMC_TIMING_UHS_DDR50)
 		con |= DDR;	/* configure in DDR mode */
 	else
 		con &= ~DDR;
-- 
1.9.1

