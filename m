From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: mmc: sdhci stop SDCLK during asynchronous interrupt peroid
Date: Wed, 5 Jan 2011 04:39:09 -0500
Message-ID: <AANLkTimXQMkWhJZ=nD8r-odmU+J6nf+7U+6KOHr5E1N1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38682 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514Ab1AEJjL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Jan 2011 04:39:11 -0500
Received: by fxm20 with SMTP id 20so14862040fxm.19
        for <linux-mmc@vger.kernel.org>; Wed, 05 Jan 2011 01:39:09 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@stericsson.com>

>From 7554ead744bfdc7304a7ae9fb227212bf548161a Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Wed, 5 Jan 2011 17:21:00 -0500
Subject: [PATCH] mmc: sdhci stop SDCLK during asynchronous interrupt peroid

	V3 controller could stop SDCLK during asynchronous interrupt peroid
to save power, via set SDHCI_CTRL2_AINT bit 14 of
SDHCI_HOST_CONTROL2(0x3e)
	Two conditions:
	1. card support asynchronous interrupt
	2. Asynchronous interrupt support is set to 1 in the capabilities register.

	How to enable: mmc->caps |= MMC_CAP_CLOCK_GATE

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 drivers/mmc/host/sdhci.c |   14 ++++++++++++++
 drivers/mmc/host/sdhci.h |    2 ++
 include/linux/mmc/host.h |    2 ++
 3 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index aafbb42..946b947 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1261,6 +1261,15 @@ static void sdhci_set_ios(struct mmc_host *mmc,
struct mmc_ios *ios)
 	if(host->quirks & SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS)
 		sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);

+	if (mmc->caps & MMC_CAP_CLOCK_GATE) {
+		u16 con;
+
+		con = readw(host->ioaddr + SDHCI_HOST_CONTROL2);
+		con |= SDHCI_CTRL2_AINT;
+		writew(con, host->ioaddr + SDHCI_HOST_CONTROL2);
+	}
+
+
 out:
 	mmiowb();
 	spin_unlock_irqrestore(&host->lock, flags);
@@ -1808,6 +1817,11 @@ int sdhci_add_host(struct sdhci_host *host)
 			mmc->caps |= (MMC_CAP_1_8V_DDR);
 	}

+	if (mmc->caps & MMC_CAP_CLOCK_GATE) {
+		if (!(caps & SDHCI_CAN_ASYN_INT))
+			mmc->caps &= ~MMC_CAP_CLOCK_GATE;
+	}
+
 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
 		host->flags |= SDHCI_USE_SDMA;
 	else if (!(caps & SDHCI_CAN_DO_SDMA))
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c4bd5dd..907de87 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -153,6 +153,7 @@
 #define   SDHCI_CTRL2_SDR104	0x0003
 #define   SDHCI_CTRL2_DDR50	0x0004
 #define  SDHCI_CTRL2_1_8V	0x0008
+#define  SDHCI_CTRL2_AINT	0x4000

 #define SDHCI_CAPABILITIES	0x40
 #define  SDHCI_TIMEOUT_CLK_MASK	0x0000003F
@@ -172,6 +173,7 @@
 #define  SDHCI_CAN_VDD_300	0x02000000
 #define  SDHCI_CAN_VDD_180	0x04000000
 #define  SDHCI_CAN_64BIT	0x10000000
+#define  SDHCI_CAN_ASYN_INT	0x20000000

 #define SDHCI_CAPABILITIES_1	0x44
 #define  SDHCI_CAN_SDR50	0x00000001
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index bcb793e..2a53a94 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -173,6 +173,8 @@ struct mmc_host {
 						/* DDR mode at 1.2V */
 #define MMC_CAP_POWER_OFF_CARD	(1 << 13)	/* Can power off after boot */
 #define MMC_CAP_BUS_WIDTH_TEST	(1 << 14)	/* CMD14/CMD19 bus width ok */
+#define MMC_CAP_CLOCK_GATE	(1 << 15)	/* V3 controller */
+						/* support clock gating */

 	mmc_pm_flag_t		pm_caps;	/* supported pm features */

-- 
1.7.0.4
