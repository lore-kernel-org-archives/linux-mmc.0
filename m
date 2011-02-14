From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] mmc: rename ddr to uhs in ios structure to indicate usage
Date: Sun, 13 Feb 2011 23:13:37 -0800
Message-ID: <52D7AFC3-31CF-4938-90EC-3BB4B701CCD4@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:60017 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751721Ab1BNHSH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 02:18:07 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


uhs mode comprises dual data rate, single data rate options
such as ddr_1_8v as well as sdr50 and sdr104
ddr name changed to indicate its true usage

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/core/core.c  |   10 +++++-----
 drivers/mmc/core/core.h  |    2 +-
 drivers/mmc/core/mmc.c   |    4 ++--
 include/linux/mmc/host.h |    2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d9fb0d3..cc67a37 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -712,13 +712,13 @@ void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode)
 }
 
 /*
- * Change data bus width and DDR mode of a host.
+ * Change data bus width and UHS mode of a host.
  */
-void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width,
-			   unsigned int ddr)
+void mmc_set_bus_width_uhs(struct mmc_host *host, unsigned int width,
+			   unsigned int uhs)
 {
 	host->ios.bus_width = width;
-	host->ios.ddr = ddr;
+	host->ios.uhs = uhs;
 	mmc_set_ios(host);
 }
 
@@ -727,7 +727,7 @@ void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width,
  */
 void mmc_set_bus_width(struct mmc_host *host, unsigned int width)
 {
-	mmc_set_bus_width_ddr(host, width, MMC_SDR_MODE);
+	mmc_set_bus_width_uhs(host, width, MMC_SDR_MODE);
 }
 
 /**
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 20b1c08..2c9f456 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -38,7 +38,7 @@ void mmc_ungate_clock(struct mmc_host *host);
 void mmc_set_ungated(struct mmc_host *host);
 void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode);
 void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
-void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width,
+void mmc_set_bus_width_uhs(struct mmc_host *host, unsigned int width,
 			   unsigned int ddr);
 u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
 void mmc_set_timing(struct mmc_host *host, unsigned int timing);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 6c5d3d4..00b9cb5 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -640,7 +640,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 					 EXT_CSD_BUS_WIDTH,
 					 ext_csd_bits[idx][0]);
 			if (!err) {
-				mmc_set_bus_width_ddr(card->host,
+				mmc_set_bus_width_uhs(card->host,
 						      bus_width, MMC_SDR_MODE);
 				/*
 				 * If controller can't handle bus width test,
@@ -667,7 +667,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			goto free_card;
 		} else if (ddr) {
 			mmc_card_set_ddr_mode(card);
-			mmc_set_bus_width_ddr(card->host, bus_width, ddr);
+			mmc_set_bus_width_uhs(card->host, bus_width, ddr);
 		}
 	}
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index bcb793e..f11307e 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -51,7 +51,7 @@ struct mmc_ios {
 #define MMC_TIMING_MMC_HS	1
 #define MMC_TIMING_SD_HS	2
 
-	unsigned char	ddr;			/* dual data rate used */
+	unsigned char	uhs;			/* uhs mode used (ddr - sdr) */
 
 #define MMC_SDR_MODE		0
 #define MMC_1_2V_DDR_MODE	1
-- 
1.7.0.4


