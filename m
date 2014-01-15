From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 3/7] mmc: omap: clarify DDR timing mode between SD-UHS and eMMC
Date: Wed, 15 Jan 2014 23:11:56 +0900
Message-ID: <002101cf11fb$bf5c6280$3e152780$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:57202 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbaAOOL7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 09:11:59 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MZG007974RYN860@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 15 Jan 2014 23:11:58 +0900 (KST)
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <chris@printf.net>, 'Balaji T K' <balajitk@ti.com>
Cc: linux-mmc@vger.kernel.org

Replaced UHS_DDR50 with MMC_DDR52.

CC: Balaji T K <balajitk@ti.com>
Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/omap_hsmmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index dbd32ad..cca397e 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -540,7 +540,7 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_host *host)
 	 *	- MMC/SD clock coming out of controller > 25MHz
 	 */
 	if ((mmc_slot(host).features & HSMMC_HAS_HSPE_SUPPORT) &&
-	    (ios->timing != MMC_TIMING_UHS_DDR50) &&
+	    (ios->timing != MMC_TIMING_MMC_DDR52) &&
 	    ((OMAP_HSMMC_READ(host->base, CAPA) & HSS) == HSS)) {
 		regval = OMAP_HSMMC_READ(host->base, HCTL);
 		if (clkdiv && (clk_get_rate(host->fclk)/clkdiv) > 25000000)
@@ -560,7 +560,7 @@ static void omap_hsmmc_set_bus_width(struct omap_hsmmc_host *host)
 	u32 con;
 
 	con = OMAP_HSMMC_READ(host->base, CON);
-	if (ios->timing == MMC_TIMING_UHS_DDR50)
+	if (ios->timing == MMC_TIMING_MMC_DDR52)
 		con |= DDR;	/* configure in DDR mode */
 	else
 		con &= ~DDR;
-- 
1.7.0.4


