From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v3 3/7] mmc: omap: clarify DDR timing mode between SD-UHS and
 eMMC
Date: Fri, 07 Mar 2014 22:30:51 +0900
Message-ID: <002b01cf3a09$75586e00$60094a00$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
 <006201cf2a57$7d9c7280$78d55780$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:24915 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbaCGNaw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Mar 2014 08:30:52 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N2200IONIVFZKB0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 07 Mar 2014 22:30:51 +0900 (KST)
In-reply-to: <006201cf2a57$7d9c7280$78d55780$%jun@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Balaji T K' <balajitk@ti.com>

Replaced UHS_DDR50 with MMC_DDR52.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Acked-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e91ee21..b4de63b 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -582,7 +582,7 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_host *host)
 	 *	- MMC/SD clock coming out of controller > 25MHz
 	 */
 	if ((mmc_slot(host).features & HSMMC_HAS_HSPE_SUPPORT) &&
-	    (ios->timing != MMC_TIMING_UHS_DDR50) &&
+	    (ios->timing != MMC_TIMING_MMC_DDR52) &&
 	    ((OMAP_HSMMC_READ(host->base, CAPA) & HSS) == HSS)) {
 		regval = OMAP_HSMMC_READ(host->base, HCTL);
 		if (clkdiv && (clk_get_rate(host->fclk)/clkdiv) > 25000000)
@@ -602,7 +602,7 @@ static void omap_hsmmc_set_bus_width(struct omap_hsmmc_host *host)
 	u32 con;
 
 	con = OMAP_HSMMC_READ(host->base, CON);
-	if (ios->timing == MMC_TIMING_UHS_DDR50)
+	if (ios->timing == MMC_TIMING_MMC_DDR52)
 		con |= DDR;	/* configure in DDR mode */
 	else
 		con &= ~DDR;
-- 
1.7.0.4


