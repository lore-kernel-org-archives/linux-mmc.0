From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH v4 12/15] mmc: core: add new 1.8v flag for mmc
Date: Wed, 26 Sep 2012 19:38:44 +0800
Message-ID: <1348659527-4200-13-git-send-email-keyuan.liu@gmail.com>
References: <1348659527-4200-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:45551 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755646Ab2IZLoh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Sep 2012 07:44:37 -0400
In-Reply-To: <1348659527-4200-1-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com
Cc: hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

From: Kevin Liu <kliu5@marvell.com>

Mmc does NOT have special sequence requirements for 1.8v
signal voltage setting compared to sd and sdio.
Add a new 1.8v flag for mmc so as to use the same
start_signal_voltage_switch interface.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/core/mmc.c   |    3 ++-
 include/linux/mmc/host.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 7509de1..3aa7f14 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -758,7 +758,8 @@ static int mmc_select_hs200(struct mmc_card *card)
 
 	if (err && card->ext_csd.card_type & EXT_CSD_CARD_TYPE_SDR_1_8V &&
 			host->caps2 & MMC_CAP2_HS200_1_8V_SDR)
-		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180, 0);
+		err = mmc_set_signal_voltage(host,
+			MMC_SIGNAL_VOLTAGE_MMC_180, 0);
 
 	/* If fails try again during next card power cycle */
 	if (err)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 0ee92d2..d9ab286 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -71,6 +71,7 @@ struct mmc_ios {
 #define MMC_SIGNAL_VOLTAGE_330	0
 #define MMC_SIGNAL_VOLTAGE_180	1
 #define MMC_SIGNAL_VOLTAGE_120	2
+#define MMC_SIGNAL_VOLTAGE_MMC_180	3
 
 	unsigned char	drv_type;		/* driver type (A, B, C, D) */
 
-- 
1.7.0.4

