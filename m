From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 06/38] mmc: sdhci: allow sdio interrupts while sdhci runtime
 suspended
Date: Wed, 23 Apr 2014 20:06:40 +0100
Message-ID: <E1Wd2VE-0003ue-RN@rmk-PC.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46365 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932381AbaDWTGm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Apr 2014 15:06:42 -0400
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

Allow SDIO interrupts to be received while the SDHCI host is runtime
suspended.  We do this by leaving the AHB clock enabled while the
host is runtime suspended so we can access the SDHCI registers, and
so read and raise the SDIO card interrupt.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 12 ++++++++----
 drivers/mmc/host/sdhci.c           |  7 +++----
 drivers/mmc/host/sdhci.h           |  5 +++++
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index b841bb7cd371..b0b4eea8d232 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1170,8 +1170,10 @@ static int sdhci_esdhc_runtime_suspend(struct device *dev)
 
 	ret = sdhci_runtime_suspend_host(host);
 
-	clk_disable_unprepare(imx_data->clk_per);
-	clk_disable_unprepare(imx_data->clk_ipg);
+	if (!sdhci_sdio_irq_enabled(host)) {
+		clk_disable_unprepare(imx_data->clk_per);
+		clk_disable_unprepare(imx_data->clk_ipg);
+	}
 	clk_disable_unprepare(imx_data->clk_ahb);
 
 	return ret;
@@ -1183,8 +1185,10 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = pltfm_host->priv;
 
-	clk_prepare_enable(imx_data->clk_per);
-	clk_prepare_enable(imx_data->clk_ipg);
+	if (!sdhci_sdio_irq_enabled(host)) {
+		clk_prepare_enable(imx_data->clk_per);
+		clk_prepare_enable(imx_data->clk_ipg);
+	}
 	clk_prepare_enable(imx_data->clk_ahb);
 
 	return sdhci_runtime_resume_host(host);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 878c6eb5aa8b..3af58f3cc165 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1709,8 +1709,7 @@ static int sdhci_get_ro(struct mmc_host *mmc)
 
 static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int enable)
 {
-	/* SDIO IRQ will be enabled as appropriate in runtime resume */
-	if (!(host->flags & SDHCI_DEVICE_DEAD) || host->runtime_suspended) {
+	if (!(host->flags & SDHCI_DEVICE_DEAD)) {
 		if (enable)
 			sdhci_unmask_irqs(host, SDHCI_INT_CARD_INT);
 		else
@@ -2421,7 +2420,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 
 	spin_lock(&host->lock);
 
-	if (host->runtime_suspended) {
+	if (host->runtime_suspended && !sdhci_sdio_irq_enabled(host)) {
 		spin_unlock(&host->lock);
 		return IRQ_NONE;
 	}
@@ -2687,7 +2686,7 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
 	}
 
 	spin_lock_irqsave(&host->lock, flags);
-	sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
+	sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK & ~SDHCI_INT_CARD_INT);
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	synchronize_hardirq(host->irq);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0a3ed01887db..fc6f81d2f377 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -397,6 +397,11 @@ extern void sdhci_remove_host(struct sdhci_host *host, int dead);
 extern void sdhci_send_command(struct sdhci_host *host,
 				struct mmc_command *cmd);
 
+static inline bool sdhci_sdio_irq_enabled(struct sdhci_host *host)
+{
+	return !!(host->flags & SDHCI_SDIO_IRQ_ENABLED);
+}
+
 #ifdef CONFIG_PM
 extern int sdhci_suspend_host(struct sdhci_host *host);
 extern int sdhci_resume_host(struct sdhci_host *host);
-- 
1.8.3.1

