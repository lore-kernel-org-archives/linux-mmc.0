From: Zhangfei Gao <zhangfei.gao@marvell.com>
Subject: [PATCH 1/2] mmc: sdhci move vmmc to set_ios
Date: Tue, 26 Jul 2011 15:06:12 +0800
Message-ID: <1311663973-23715-2-git-send-email-zhangfei.gao@marvell.com>
References: <1311663973-23715-1-git-send-email-zhangfei.gao@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:39856 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603Ab1GZHGf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jul 2011 03:06:35 -0400
In-Reply-To: <1311663973-23715-1-git-send-email-zhangfei.gao@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Daniel Drake <dsd@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, linux-mmc@vger.kernel.o
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>, Ohad Ben-Cohen <ohad@wizery.com>

Move vmmc to set_ios, as a result mmc_power_up/down handles regulator_enable/disable vmmc
Move regulator outof spin_lock, since usually i2c operation is called
Remove vmmc from suspend/resume function, instead vmmc is handled properly in mmc_suspend/resume_host according to mmc_card_keep_power

CC: Ohad Ben-Cohen <ohad@wizery.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 drivers/mmc/host/sdhci.c  |   27 +++++++++++++++------------
 include/linux/mmc/sdhci.h |    1 +
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c31a334..ce4f97f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1279,6 +1279,13 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	host = mmc_priv(mmc);
 
+	if (host->vmmc) {
+		if (ios->power_mode != host->power_mode_old) {
+			if (ios->power_mode == MMC_POWER_UP)
+				regulator_enable(host->vmmc);
+		}
+	}
+
 	spin_lock_irqsave(&host->lock, flags);
 
 	if (host->flags & SDHCI_DEVICE_DEAD)
@@ -1426,6 +1433,14 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 out:
 	mmiowb();
 	spin_unlock_irqrestore(&host->lock, flags);
+
+	if (host->vmmc) {
+		if (ios->power_mode != host->power_mode_old) {
+			if (ios->power_mode == MMC_POWER_OFF)
+				regulator_disable(host->vmmc);
+		}
+		host->power_mode_old = ios->power_mode;
+	}
 }
 
 static int check_ro(struct sdhci_host *host)
@@ -2262,9 +2277,6 @@ int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state)
 
 	free_irq(host->irq, host);
 
-	if (host->vmmc)
-		ret = regulator_disable(host->vmmc);
-
 	return ret;
 }
 
@@ -2274,13 +2286,6 @@ int sdhci_resume_host(struct sdhci_host *host)
 {
 	int ret;
 
-	if (host->vmmc) {
-		int ret = regulator_enable(host->vmmc);
-		if (ret)
-			return ret;
-	}
-
-
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
 		if (host->ops->enable_dma)
 			host->ops->enable_dma(host);
@@ -2749,8 +2754,6 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (IS_ERR(host->vmmc)) {
 		printk(KERN_INFO "%s: no vmmc regulator found\n", mmc_hostname(mmc));
 		host->vmmc = NULL;
-	} else {
-		regulator_enable(host->vmmc);
 	}
 
 	sdhci_init(host, 0);
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 5666f3a..2e6e711 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -94,6 +94,7 @@ struct sdhci_host {
 	const struct sdhci_ops *ops;	/* Low level hw interface */
 
 	struct regulator *vmmc;	/* Power regulator */
+	unsigned char power_mode_old;	/* power supply mode */
 
 	/* Internal data */
 	struct mmc_host *mmc;	/* MMC structure */
-- 
1.7.0.4

