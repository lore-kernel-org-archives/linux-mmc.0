From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCHv2 4/4] sdhci: add regulator support
Date: Thu, 29 Jul 2010 14:34:35 +0200
Message-ID: <1280406875-31830-5-git-send-email-m.szyprowski@samsung.com>
References: <1280406875-31830-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1280406875-31830-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: m.szyprowski@samsung.com, kyungmin.park@samsung.com, kgene.kim@samsung.com, ben-linux@fluff.org, akpm@linux-foundation.org, broonie@opensource.wolfsonmicro.com
List-Id: linux-mmc@vger.kernel.org

This patch adds support for regulator API to sdhci core driver. Regulators
can be used to disable power in suspended state to reduce dissipated
energy.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---

Changes since V1:
- moved regulator support from sdhci-s3c sub-driver to the main sdhci
driver

---
 drivers/mmc/host/sdhci.c |   26 +++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 95f44ac..cdd974e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -23,6 +23,7 @@
 #include <linux/mutex.h>
 #include <linux/scatterlist.h>
 #include <linux/jiffies.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/leds.h>
 
@@ -1573,7 +1574,10 @@ int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state)
 
 	free_irq(host->irq, host);
 
-	return 0;
+	if (host->vmmc)
+		ret = regulator_disable(host->vmmc);
+
+	return ret;
 }
 
 EXPORT_SYMBOL_GPL(sdhci_suspend_host);
@@ -1582,6 +1586,13 @@ int sdhci_resume_host(struct sdhci_host *host)
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
@@ -1878,6 +1889,14 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (ret)
 		return ret;
 
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
@@ -1955,6 +1974,11 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 
 	flush_work(&host->finish_work);
 
+	if (host->vmmc) {
+		regulator_disable(host->vmmc);
+		regulator_put(host->vmmc);
+	}
+
 	kfree(host->adma_desc);
 	kfree(host->align_buffer);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 253773e..4d03e24 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -253,6 +253,8 @@ struct sdhci_host {
 
 	const struct sdhci_ops	*ops;		/* Low level hw interface */
 
+	struct regulator	*vmmc;		/* Power regulator */
+
 	/* Internal data */
 	struct mmc_host		*mmc;		/* MMC structure */
 	u64			dma_mask;	/* custom DMA mask */
-- 
1.7.1.569.g6f426
