From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 08/31] mmc: sdhci: allow sdio interrupts while sdhci
 runtime suspended
Date: Tue, 18 Feb 2014 15:09:43 +0000
Message-ID: <E1WFmIp-0006mG-KK@rmk-PC.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40460 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755933AbaBRPJp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 10:09:45 -0500
In-Reply-To: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>

Allow SDIO interrupts to be received while the SDHCI host is runtime
suspended.  We do this by leaving the AHB clock enabled while the
host is runtime suspended so we can access the SDHCI registers, and
so read and raise the SDIO card interrupt.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
=-DO NOT APPLY-=
 drivers/mmc/host/sdhci-esdhc-imx.c | 12 ++++++++----
 drivers/mmc/host/sdhci.c           |  7 +++----
 drivers/mmc/host/sdhci.h           |  5 +++++
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index b841bb7cd371..b0b4eea8d232 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-esdhc-imx.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1170,8 +1170,10 @@ static int sdhci_esdhc_runtime_suspend(struct device *dev)
 
 	ret = sdhci_runtime_suspend_host(host);
 
-	clk_disable_unprepare(imx_data->clk_per);
-	clk_disable_unprepare(imx_data->clk_ipg);
=+DO NOT APPLY+=	if (!sdhci_sdio_irq_enabled(host)) {
=+DO NOT APPLY+=		clk_disable_unprepare(imx_data->clk_per);
=+DO NOT APPLY+=		clk_disable_unprepare(imx_data->clk_ipg);
=+DO NOT APPLY+=	}
 	clk_disable_unprepare(imx_data->clk_ahb);
 
 	return ret;
@@ -1183,8 +1185,10 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = pltfm_host->priv;
 
-	clk_prepare_enable(imx_data->clk_per);
-	clk_prepare_enable(imx_data->clk_ipg);
=+DO NOT APPLY+=	if (!sdhci_sdio_irq_enabled(host)) {
=+DO NOT APPLY+=		clk_prepare_enable(imx_data->clk_per);
=+DO NOT APPLY+=		clk_prepare_enable(imx_data->clk_ipg);
=+DO NOT APPLY+=	}
 	clk_prepare_enable(imx_data->clk_ahb);
 
 	return sdhci_runtime_resume_host(host);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index dfec8aab1a4a..576ded2406d9 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci.c
@@ -1709,8 +1709,7 @@ static int sdhci_get_ro(struct mmc_host *mmc)
 
 static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int enable)
 {
-	/* SDIO IRQ will be enabled as appropriate in runtime resume */
-	if (!(host->flags & SDHCI_DEVICE_DEAD) || host->runtime_suspended) {
=+DO NOT APPLY+=	if (!(host->flags & SDHCI_DEVICE_DEAD)) {
 		if (enable)
 			sdhci_unmask_irqs(host, SDHCI_INT_CARD_INT);
 		else
@@ -2422,7 +2421,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 
 	spin_lock(&host->lock);
 
-	if (host->runtime_suspended) {
=+DO NOT APPLY+=	if (host->runtime_suspended && !sdhci_sdio_irq_enabled(host)) {
 		spin_unlock(&host->lock);
 		pr_warning("%s: got irq while runtime suspended\n",
 		       mmc_hostname(host->mmc));
@@ -2690,7 +2689,7 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
 	}
 
 	spin_lock_irqsave(&host->lock, flags);
-	sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
=+DO NOT APPLY+=	sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK & ~SDHCI_INT_CARD_INT);
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	synchronize_hardirq(host->irq);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0a3ed01887db..fc6f81d2f377 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci.h
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci.h
@@ -397,6 +397,11 @@ extern void sdhci_remove_host(struct sdhci_host *host, int dead);
 extern void sdhci_send_command(struct sdhci_host *host,
 				struct mmc_command *cmd);
 
=+DO NOT APPLY+=static inline bool sdhci_sdio_irq_enabled(struct sdhci_host *host)
=+DO NOT APPLY+={
=+DO NOT APPLY+=	return !!(host->flags & SDHCI_SDIO_IRQ_ENABLED);
=+DO NOT APPLY+=}
=+DO NOT APPLY+=
 #ifdef CONFIG_PM
 extern int sdhci_suspend_host(struct sdhci_host *host);
 extern int sdhci_resume_host(struct sdhci_host *host);
-- 
1.8.3.1

