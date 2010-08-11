From: akpm@linux-foundation.org
Subject: [patch 053/177] sdhci: add regulator support
Date: Tue, 10 Aug 2010 18:01:59 -0700
Message-ID: <201008110101.o7B11xvU027106@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46840 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932208Ab0HKBWQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Aug 2010 21:22:16 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, m.szyprowski@samsung.com, broonie@opensource.wolfsonmicro.com, kyungmin.park@samsung.com, linux-mmc@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

This patch adds support for regulator API to sdhci core driver. 
Regulators can be used to disable power in suspended state to reduce
dissipated energy.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci.c |   26 +++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff -puN drivers/mmc/host/sdhci.c~sdhci-add-regulator-support drivers/mmc/host/sdhci.c
--- a/drivers/mmc/host/sdhci.c~sdhci-add-regulator-support
+++ a/drivers/mmc/host/sdhci.c
@@ -19,6 +19,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/scatterlist.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/leds.h>
 
@@ -1608,7 +1609,10 @@ int sdhci_suspend_host(struct sdhci_host
 
 	free_irq(host->irq, host);
 
-	return 0;
+	if (host->vmmc)
+		ret = regulator_disable(host->vmmc);
+
+	return ret;
 }
 
 EXPORT_SYMBOL_GPL(sdhci_suspend_host);
@@ -1617,6 +1621,13 @@ int sdhci_resume_host(struct sdhci_host 
 {
 	int ret;
 
+	if (host->vmmc) {
+		int ret = regulator_enable(host->vmmc);
+		if (ret)
+			return ret;
+	}
+
+
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
 		if (host->ops->enable_dma)
 			host->ops->enable_dma(host);
@@ -1889,6 +1900,14 @@ int sdhci_add_host(struct sdhci_host *ho
 	if (ret)
 		goto untasklet;
 
+	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
+	if (IS_ERR(host->vmmc)) {
+		printk(KERN_INFO "%s: no vmmc regulator found\n", mmc_hostname(mmc));
+		host->vmmc = NULL;
+	} else {
+		regulator_enable(host->vmmc);
+	}
+
 	sdhci_init(host, 0);
 
 #ifdef CONFIG_MMC_DEBUG
@@ -1973,6 +1992,11 @@ void sdhci_remove_host(struct sdhci_host
 	tasklet_kill(&host->card_tasklet);
 	tasklet_kill(&host->finish_tasklet);
 
+	if (host->vmmc) {
+		regulator_disable(host->vmmc);
+		regulator_put(host->vmmc);
+	}
+
 	kfree(host->adma_desc);
 	kfree(host->align_buffer);
 
diff -puN drivers/mmc/host/sdhci.h~sdhci-add-regulator-support drivers/mmc/host/sdhci.h
--- a/drivers/mmc/host/sdhci.h~sdhci-add-regulator-support
+++ a/drivers/mmc/host/sdhci.h
@@ -249,6 +249,8 @@ struct sdhci_host {
 
 	const struct sdhci_ops	*ops;		/* Low level hw interface */
 
+	struct regulator	*vmmc;		/* Power regulator */
+
 	/* Internal data */
 	struct mmc_host		*mmc;		/* MMC structure */
 	u64			dma_mask;	/* custom DMA mask */
_
