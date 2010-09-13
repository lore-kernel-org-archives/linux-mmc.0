From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 7/7] sdhci: Tidy up sdhci.c
Date: Mon, 13 Sep 2010 18:39:59 +0100
Message-ID: <20100913173958.20345.58843.stgit@localhost.localdomain>
References: <20100913172738.20345.61119.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28933 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752515Ab0IMSYq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 13 Sep 2010 14:24:46 -0400
In-Reply-To: <20100913172738.20345.61119.stgit@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org

While we are passing through..

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/mmc/host/sdhci.c |   39 +++++++++++++++++++--------------------
 1 files changed, 19 insertions(+), 20 deletions(-)


diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9d8047c..dcafe13 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1,5 +1,6 @@
 /*
- *  linux/drivers/mmc/host/sdhci.c - Secure Digital Host Controller Interface driver
+ *  linux/drivers/mmc/host/sdhci.c - Secure Digital Host Controller Interface
+ *				     driver
  *
  *  Copyright (C) 2005-2008 Pierre Ossman, All Rights Reserved.
  *
@@ -30,14 +31,14 @@
 #define DRIVER_NAME "sdhci"
 
 #define DBG(f, x...) \
-	pr_debug(DRIVER_NAME " [%s()]: " f, __func__,## x)
+	pr_debug(DRIVER_NAME " [%s()]: " f, __func__, ## x)
 
 #if defined(CONFIG_LEDS_CLASS) || (defined(CONFIG_LEDS_CLASS_MODULE) && \
 	defined(CONFIG_MMC_SDHCI_MODULE))
 #define SDHCI_USE_LEDS_CLASS
 #endif
 
-static unsigned int debug_quirks = 0;
+static unsigned int debug_quirks;
 
 static void sdhci_prepare_data(struct sdhci_host *, struct mmc_data *);
 static void sdhci_finish_data(struct sdhci_host *);
@@ -479,7 +480,8 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 		if (offset) {
 			if (data->flags & MMC_DATA_WRITE) {
 				buffer = sdhci_kmap_atomic(sg, &flags);
-				WARN_ON(((long)buffer & PAGE_MASK) > (PAGE_SIZE - 3));
+				WARN_ON(((long)buffer & PAGE_MASK)
+							> (PAGE_SIZE - 3));
 				memcpy(align, buffer, offset);
 				sdhci_kunmap_atomic(buffer, &flags);
 			}
@@ -587,7 +589,8 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 				size = 4 - (sg_dma_address(sg) & 0x3);
 
 				buffer = sdhci_kmap_atomic(sg, &flags);
-				WARN_ON(((long)buffer & PAGE_MASK) > (PAGE_SIZE - 3));
+				WARN_ON(((long)buffer & PAGE_MASK)
+							> (PAGE_SIZE - 3));
 				memcpy(buffer, align, size);
 				sdhci_kunmap_atomic(buffer, &flags);
 
@@ -975,7 +978,7 @@ static void sdhci_finish_command(struct sdhci_host *host)
 	if (host->cmd->flags & MMC_RSP_PRESENT) {
 		if (host->cmd->flags & MMC_RSP_136) {
 			/* CRC is stripped so we need to do some shifting. */
-			for (i = 0;i < 4;i++) {
+			for (i = 0; i < 4; i++) {
 				host->cmd->resp[i] = sdhci_readl(host,
 					SDHCI_RESPONSE + (3-i)*4) << 8;
 				if (i != 3)
@@ -1019,7 +1022,7 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	if (clock == 0)
 		goto out;
 
-	for (div = 1;div < 256;div *= 2) {
+	for (div = 1; div < 256; div *= 2) {
 		if ((host->max_clk / div) <= clock)
 			break;
 	}
@@ -1215,7 +1218,7 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	 * signalling timeout and CRC errors even on CMD0. Resetting
 	 * it on each ios seems to solve the problem.
 	 */
-	if(host->quirks & SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS)
+	if (host->quirks & SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS)
 		sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
 
 out:
@@ -1302,7 +1305,7 @@ static void sdhci_tasklet_card(unsigned long param)
 	struct sdhci_host *host;
 	unsigned long flags;
 
-	host = (struct sdhci_host*)param;
+	host = (struct sdhci_host *)param;
 
 	spin_lock_irqsave(&host->lock, flags);
 
@@ -1332,7 +1335,7 @@ static void sdhci_tasklet_finish(unsigned long param)
 	unsigned long flags;
 	struct mmc_request *mrq;
 
-	host = (struct sdhci_host*)param;
+	host = (struct sdhci_host *)param;
 
 	spin_lock_irqsave(&host->lock, flags);
 
@@ -1385,7 +1388,7 @@ static void sdhci_timeout_timer(unsigned long data)
 	struct sdhci_host *host;
 	unsigned long flags;
 
-	host = (struct sdhci_host*)data;
+	host = (struct sdhci_host *)data;
 
 	spin_lock_irqsave(&host->lock, flags);
 
@@ -1566,7 +1569,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 static irqreturn_t sdhci_irq(int irq, void *dev_id)
 {
 	irqreturn_t result;
-	struct sdhci_host* host = dev_id;
+	struct sdhci_host *host = dev_id;
 	u32 intmask;
 	int cardint = 0;
 
@@ -1667,7 +1670,6 @@ int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state)
 
 	return ret;
 }
-
 EXPORT_SYMBOL_GPL(sdhci_suspend_host);
 
 int sdhci_resume_host(struct sdhci_host *host)
@@ -1699,7 +1701,6 @@ int sdhci_resume_host(struct sdhci_host *host)
 
 	return ret;
 }
-
 EXPORT_SYMBOL_GPL(sdhci_resume_host);
 
 #endif /* CONFIG_PM */
@@ -1727,7 +1728,6 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 
 	return host;
 }
-
 EXPORT_SYMBOL_GPL(sdhci_alloc_host);
 
 int sdhci_add_host(struct sdhci_host *host)
@@ -1940,7 +1940,8 @@ int sdhci_add_host(struct sdhci_host *host)
 	/*
 	 * Maximum block count.
 	 */
-	mmc->max_blk_count = (host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK) ? 1 : 65535;
+	mmc->max_blk_count = (host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK)
+								? 1 : 65535;
 
 	/*
 	 * Init tasklets.
@@ -1959,7 +1960,8 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
 	if (IS_ERR(host->vmmc)) {
-		printk(KERN_INFO "%s: no vmmc regulator found\n", mmc_hostname(mmc));
+		printk(KERN_INFO "%s: no vmmc regulator found\n",
+							mmc_hostname(mmc));
 		host->vmmc = NULL;
 	} else {
 		regulator_enable(host->vmmc);
@@ -2008,7 +2010,6 @@ untasklet:
 
 	return ret;
 }
-
 EXPORT_SYMBOL_GPL(sdhci_add_host);
 
 void sdhci_remove_host(struct sdhci_host *host, int dead)
@@ -2060,14 +2061,12 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 	host->adma_desc = NULL;
 	host->align_buffer = NULL;
 }
-
 EXPORT_SYMBOL_GPL(sdhci_remove_host);
 
 void sdhci_free_host(struct sdhci_host *host)
 {
 	mmc_free_host(host->mmc);
 }
-
 EXPORT_SYMBOL_GPL(sdhci_free_host);
 
 /*****************************************************************************\

