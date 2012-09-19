From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [RFC/PATCH 2/3] mmc: sdio: add asynchronous interrupt support on device
Date: Wed, 19 Sep 2012 11:12:51 +0800
Message-ID: <1348024372-32073-3-git-send-email-keyuan.liu@gmail.com>
References: <1348024372-32073-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:48667 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753623Ab2ISDRf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Sep 2012 23:17:35 -0400
In-Reply-To: <1348024372-32073-1-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu
Cc: hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

From: Kevin Liu <kliu5@marvell.com>

Enable asynchronous interrupt on device by default if both host
and device support it and clock gating is allowed.

If asynchronous interrupt is enabled, then no need to switch bus
width to 1bit before suspend.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/core/sdio.c  |   22 +++++++++++++++++++---
 include/linux/mmc/card.h |    3 ++-
 include/linux/mmc/host.h |    1 +
 include/linux/mmc/sdio.h |    5 +++++
 4 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 909c835..0e6634f 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -199,6 +199,21 @@ static int sdio_read_cccr(struct mmc_card *card, u32 ocr)
 		}
 	}
 
+	if (cccr_vsn >= SDIO_CCCR_REV_3_00) {
+		if (!(card->quirks & MMC_QUIRK_BROKEN_CLK_GATING) &&
+			(card->host->caps2 & MMC_CAP2_ASYNC_INT)) {
+			if (mmc_io_rw_direct(card, 0, 0,
+				SDIO_CCCR_INT_EXT, 0, &data))
+				goto out;
+			if (data & SDIO_INT_SAI) {
+				data |= SDIO_INT_EAI;
+				if (mmc_io_rw_direct(card, 1, 0,
+					SDIO_CCCR_INT_EXT, data, NULL))
+					goto out;
+				card->cccr.async_int = 1;
+			}
+		}
+	}
 out:
 	return ret;
 }
@@ -290,7 +305,6 @@ static int sdio_disable_wide(struct mmc_card *card)
 	return 0;
 }
 
-
 static int sdio_enable_4bit_bus(struct mmc_card *card)
 {
 	int err;
@@ -917,7 +931,8 @@ static int mmc_sdio_suspend(struct mmc_host *host)
 		}
 	}
 
-	if (!err && mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host)) {
+	if (!err && mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host)
+		&& !host->card->cccr.async_int) {
 		mmc_claim_host(host);
 		sdio_disable_wide(host->card);
 		mmc_release_host(host);
@@ -940,7 +955,8 @@ static int mmc_sdio_resume(struct mmc_host *host)
 	if (mmc_card_is_removable(host) || !mmc_card_keep_power(host))
 		err = mmc_sdio_init_card(host, host->ocr, host->card,
 					mmc_card_keep_power(host));
-	else if (mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host)) {
+	else if (mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host)
+		&& !host->card->cccr.async_int) {
 		/* We may have switched to 1-bit mode during suspend */
 		err = sdio_enable_4bit_bus(host->card);
 		if (err > 0) {
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 78cc3be..0913bd5 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -169,7 +169,8 @@ struct sdio_cccr {
 				wide_bus:1,
 				high_power:1,
 				high_speed:1,
-				disable_cd:1;
+				disable_cd:1,
+				async_int:1;
 };
 
 struct sdio_cis {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index d5d9bd4..78fd877 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -257,6 +257,7 @@ struct mmc_host {
 #define MMC_CAP2_HC_ERASE_SZ	(1 << 9)	/* High-capacity erase size */
 #define MMC_CAP2_CD_ACTIVE_HIGH	(1 << 10)	/* Card-detect signal active high */
 #define MMC_CAP2_RO_ACTIVE_HIGH	(1 << 11)	/* Write-protect signal active high */
+#define MMC_CAP2_ASYNC_INT	(1 << 12)	/* Asynchronous interrupt support */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 	unsigned int        power_notify_type;
diff --git a/include/linux/mmc/sdio.h b/include/linux/mmc/sdio.h
index 47e579d..abbb6c8 100644
--- a/include/linux/mmc/sdio.h
+++ b/include/linux/mmc/sdio.h
@@ -161,6 +161,11 @@
 #define  SDIO_DTSx_SET_TYPE_A	(1 << SDIO_DRIVE_DTSx_SHIFT)
 #define  SDIO_DTSx_SET_TYPE_C	(2 << SDIO_DRIVE_DTSx_SHIFT)
 #define  SDIO_DTSx_SET_TYPE_D	(3 << SDIO_DRIVE_DTSx_SHIFT)
+
+#define SDIO_CCCR_INT_EXT	0x16
+#define SDIO_INT_SAI		0x01
+#define SDIO_INT_EAI		0x02
+
 /*
  * Function Basic Registers (FBR)
  */
-- 
1.7.0.4

