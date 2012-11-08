From: dragos.tatulea@intel.com
Subject: [PATCH v2 21/26] mmc: sdhci: panic write: poll interrupts
Date: Thu,  8 Nov 2012 15:06:19 +0200
Message-ID: <1352379984-18381-22-git-send-email-dragos.tatulea@intel.com>
References: <1352379984-18381-1-git-send-email-dragos.tatulea@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352379984-18381-1-git-send-email-dragos.tatulea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: kirill.shutemov@linux.intel.com, irina.tirdea@intel.com, octavian.purdila@intel.com, tony.luck@intel.com, keescook@chromium.org, dragos.tatulea@gmail.com, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

We really don't want to use interrupts while doing a panic dump, so
implement polling.

The mmc panic begin/end ops have also been added for sdhci.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/mmc/host/sdhci.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e096526..d85e9d5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -131,6 +131,8 @@ static void sdhci_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
 	ier &= ~clear;
 	ier |= set;
 	sdhci_writel(host, ier, SDHCI_INT_ENABLE);
+	if (mmc_panic_task_active(host->mmc))
+		ier = 0;
 	sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
 }
 
@@ -1267,6 +1269,8 @@ static int sdhci_set_power(struct sdhci_host *host, unsigned short power)
  *                                                                           *
 \*****************************************************************************/
 
+static irqreturn_t sdhci_irq(int irq, void *dev_id);
+
 static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct sdhci_host *host;
@@ -1347,6 +1351,11 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	mmiowb();
 	sdhci_unlock_irqrestore(host, flags);
+
+	if (mmc_am_panic_task(host->mmc)) {
+		while (host->mrq)
+			sdhci_irq(0, host);
+	}
 }
 
 static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
@@ -2066,6 +2075,27 @@ void sdhci_unlock_irqrestore(struct sdhci_host *host, unsigned long flags)
 		spin_unlock_irqrestore(&host->lock, flags);
 }
 
+static void sdhci_panic_begin(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
+}
+
+static void sdhci_panic_end(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u32 ier;
+
+	ier = sdhci_readl(host, SDHCI_INT_ENABLE);
+	sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
+}
+
+static const struct mmc_panic_ops sdhci_pops = {
+	.begin		= sdhci_panic_begin,
+	.end		= sdhci_panic_end,
+};
+
 #endif
 
 /*****************************************************************************\
@@ -2854,6 +2884,9 @@ int sdhci_add_host(struct sdhci_host *host)
 	 * Set host parameters.
 	 */
 	mmc->ops = &sdhci_ops;
+#ifdef CONFIG_MMC_BLOCK_PANIC_WRITE
+	mmc->pops = &sdhci_pops;
+#endif
 	mmc->f_max = host->max_clk;
 	if (host->ops->get_min_clock)
 		mmc->f_min = host->ops->get_min_clock(host);
-- 
1.7.9.5
