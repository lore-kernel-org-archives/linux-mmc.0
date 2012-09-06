From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 2/2] mmc: sdhci: add asynchronous interrupt support
Date: Thu,  6 Sep 2012 18:07:36 +0800
Message-ID: <1346926056-7668-2-git-send-email-kliu5@marvell.com>
References: <1346926056-7668-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:52755 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754428Ab2IFKRS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Sep 2012 06:17:18 -0400
In-Reply-To: <1346926056-7668-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, drzeus@drzeus.cx
Cc: prakity@marvell.com, cxie4@marvell.com, hzhuang1@marvell.com, Kevin Liu <kliu5@marvell.com>

If host support asynchronous interrupt and sdio device has enabled it,
then enable/disable asynchronous interrupt on host when enable/disable
sdio irq.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |   16 ++++++++++++++++
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d98b199..834be2f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1567,6 +1567,8 @@ static int sdhci_get_ro(struct mmc_host *mmc)
 
 static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int enable)
 {
+	u16 ctrl;
+
 	if (host->flags & SDHCI_DEVICE_DEAD)
 		goto out;
 
@@ -1575,6 +1577,16 @@ static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int enable)
 	else
 		host->flags &= ~SDHCI_SDIO_IRQ_ENABLED;
 
+	if ((host->mmc->caps2 & MMC_CAP2_ASYNC_INT) &&
+		(host->mmc->card->cccr.async_int)) {
+		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		if (enable)
+			ctrl |= SDHCI_CTRL_ASYNC_INT_ENABLE;
+		else
+			ctrl &= ~SDHCI_CTRL_ASYNC_INT_ENABLE;
+		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+	}
+
 	/* SDIO IRQ will be enabled as appropriate in runtime resume */
 	if (host->runtime_suspended)
 		goto out;
@@ -2887,6 +2899,10 @@ int sdhci_add_host(struct sdhci_host *host)
 	else
 		mmc->power_notify_type = MMC_HOST_PW_NOTIFY_NONE;
 
+	/* Does the host support async int? */
+	if (caps[0] & SDHCI_CAN_ASYNC_INT)
+		mmc->caps2 |= MMC_CAP2_ASYNC_INT;
+
 	/* Initial value for re-tuning timer count */
 	host->tuning_count = (caps[1] & SDHCI_RETUNING_TIMER_COUNT_MASK) >>
 			      SDHCI_RETUNING_TIMER_COUNT_SHIFT;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 97653ea..2e89dac 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -167,6 +167,7 @@
 #define   SDHCI_CTRL_DRV_TYPE_D		0x0030
 #define  SDHCI_CTRL_EXEC_TUNING		0x0040
 #define  SDHCI_CTRL_TUNED_CLK		0x0080
+#define  SDHCI_CTRL_ASYNC_INT_ENABLE	0x4000
 #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
 
 #define SDHCI_CAPABILITIES	0x40
@@ -187,6 +188,7 @@
 #define  SDHCI_CAN_VDD_300	0x02000000
 #define  SDHCI_CAN_VDD_180	0x04000000
 #define  SDHCI_CAN_64BIT	0x10000000
+#define  SDHCI_CAN_ASYNC_INT	0x20000000
 
 #define  SDHCI_SUPPORT_SDR50	0x00000001
 #define  SDHCI_SUPPORT_SDR104	0x00000002
-- 
1.7.0.4

