From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 3/5] mmc: omap_hsmmc: fix timeout for cmd and data soft reset
Date: Mon, 21 Oct 2013 00:25:20 +0530
Message-ID: <1382295322-18995-3-git-send-email-balajitk@ti.com>
References: <1382295322-18995-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43126 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751574Ab3JTSzi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 20 Oct 2013 14:55:38 -0400
In-Reply-To: <1382295322-18995-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com
Cc: linux-omap@vger.kernel.org, Jianpeng Ma <majianpeng@gmail.com>, Balaji T K <balajitk@ti.com>

From: Jianpeng Ma <majianpeng@gmail.com>

With HSMMC_HAS_UPDATED_RESET reset of cmd/data (SRC/SRD) can be to
quick and can be missed resulting in wait for software timeout.
With cpu_relax timeout can be long and unpredictable. Use udelay instead for
timeout implementation.

Reported-by: Yuzheng Ma <mayuzheng@kedacom.com>
Tested-by: Yuzheng Ma <mayuzheng@kedacom.com>
Reviewed-by: Hein Tibosch <hein_tibosch@yahoo.es>
Signed-off-by: Jianpeng Ma <majianpeng@gmail.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 9ebff99..9f74a57 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -119,7 +119,8 @@
 		BRR_EN | BWR_EN | TC_EN | CC_EN)
 
 #define MMC_AUTOSUSPEND_DELAY	100
-#define MMC_TIMEOUT_MS		20
+#define MMC_TIMEOUT_MS		20		/* 20 mSec */
+#define MMC_TIMEOUT_US		20000		/* 20000 micro Sec */
 #define OMAP_MMC_MIN_CLOCK	400000
 #define OMAP_MMC_MAX_CLOCK	52000000
 #define DRIVER_NAME		"omap_hsmmc"
@@ -967,8 +968,7 @@ static inline void omap_hsmmc_reset_controller_fsm(struct omap_hsmmc_host *host,
 						   unsigned long bit)
 {
 	unsigned long i = 0;
-	unsigned long limit = (loops_per_jiffy *
-				msecs_to_jiffies(MMC_TIMEOUT_MS));
+	unsigned long limit = MMC_TIMEOUT_US;
 
 	OMAP_HSMMC_WRITE(host->base, SYSCTL,
 			 OMAP_HSMMC_READ(host->base, SYSCTL) | bit);
@@ -980,13 +980,13 @@ static inline void omap_hsmmc_reset_controller_fsm(struct omap_hsmmc_host *host,
 	if (mmc_slot(host).features & HSMMC_HAS_UPDATED_RESET) {
 		while ((!(OMAP_HSMMC_READ(host->base, SYSCTL) & bit))
 					&& (i++ < limit))
-			cpu_relax();
+			udelay(1);
 	}
 	i = 0;
 
 	while ((OMAP_HSMMC_READ(host->base, SYSCTL) & bit) &&
 		(i++ < limit))
-		cpu_relax();
+		udelay(1);
 
 	if (OMAP_HSMMC_READ(host->base, SYSCTL) & bit)
 		dev_err(mmc_dev(host->mmc),
-- 
1.7.5.4

