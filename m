From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH] mmc: core: Set correct bus mode before card init
Date: Thu, 15 Sep 2011 17:50:38 +0200
Message-ID: <1316101838-22660-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:53079 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934067Ab1IOQMV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Sep 2011 12:12:21 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

Earlier all cards where initiated with bus mode set as OPENDRAIN, and then
later switched to PUSHPULL. According to the MMC/SD/SDIO specifications only
MMC cards use OPENDRAIN during init. For both SD and SDIO the bus mode shall
be PUSHPULL before attempting to init the card.

The consequence of having incorrect bus mode can lead to not being able
to detect the card. Therefore the default behavior have now been changed to
PUSHPULL in mmc_power_up, and will only be temporarily switched when trying
to attach or init a MMC card.

Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
Signed-off-by: Ulf HANSSON <ulf.hansson@stericsson.com>
---
 drivers/mmc/core/core.c |    8 +++-----
 drivers/mmc/core/mmc.c  |    8 ++++++++
 drivers/mmc/core/sd.c   |    2 --
 drivers/mmc/core/sdio.c |    2 --
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 91a0a74..2a47973 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1098,13 +1098,11 @@ static void mmc_power_up(struct mmc_host *host)
 		bit = fls(host->ocr_avail) - 1;
 
 	host->ios.vdd = bit;
-	if (mmc_host_is_spi(host)) {
+	if (mmc_host_is_spi(host))
 		host->ios.chip_select = MMC_CS_HIGH;
-		host->ios.bus_mode = MMC_BUSMODE_PUSHPULL;
-	} else {
+	else
 		host->ios.chip_select = MMC_CS_DONTCARE;
-		host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
-	}
+	host->ios.bus_mode = MMC_BUSMODE_PUSHPULL;
 	host->ios.power_mode = MMC_POWER_UP;
 	host->ios.bus_width = MMC_BUS_WIDTH_1;
 	host->ios.timing = MMC_TIMING_LEGACY;
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 5700b1c..b36d786 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -548,6 +548,10 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	BUG_ON(!host);
 	WARN_ON(!host->claimed);
 
+	/* Set correct bus mode for MMC before attempting init */
+	if (!mmc_host_is_spi(host))
+		mmc_set_bus_mode(host, MMC_BUSMODE_OPENDRAIN);
+
 	/*
 	 * Since we're changing the OCR value, we seem to
 	 * need to tell some cards to go back to the idle
@@ -1016,6 +1020,10 @@ int mmc_attach_mmc(struct mmc_host *host)
 	BUG_ON(!host);
 	WARN_ON(!host->claimed);
 
+	/* Set correct bus mode for MMC before attempting attach */
+	if (!mmc_host_is_spi(host))
+		mmc_set_bus_mode(host, MMC_BUSMODE_OPENDRAIN);
+
 	err = mmc_send_op_cond(host, 0, &ocr);
 	if (err)
 		return err;
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 633975f..b0f0216 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -904,8 +904,6 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		err = mmc_send_relative_addr(host, &card->rca);
 		if (err)
 			return err;
-
-		mmc_set_bus_mode(host, MMC_BUSMODE_PUSHPULL);
 	}
 
 	if (!oldcard) {
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 262fff0..7fc9953 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -408,8 +408,6 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 		 */
 		if (oldcard)
 			oldcard->rca = card->rca;
-
-		mmc_set_bus_mode(host, MMC_BUSMODE_PUSHPULL);
 	}
 
 	/*
-- 
1.7.5.4

