From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 1/2] mmc:sdhc: Add vendor specific interrupt and handle routine
Date: Tue, 17 Sep 2013 13:28:31 +0800
Message-ID: <1379395711-28462-2-git-send-email-Haijun.Zhang@freescale.com>
References: <1379395711-28462-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe005.messaging.microsoft.com ([216.32.180.188]:24499
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751130Ab3IQFdV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Sep 2013 01:33:21 -0400
In-Reply-To: <1379395711-28462-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, X.Xie@freescale.com, ulf.hansson@linaro.org, Haijun Zhang <Haijun.Zhang@freescale.com>

As spec detailed:
Error Interrupt Status Register(Offset 032h)[15-12]
Error Interrupt Status Enable Register (Offset 036h)[15-12]
Error Interrupt Signal Enable Register (Offset 03Ah)[15-12]

Bits above are specified by vendor itself.
So add interface to handle this requirememt.
Also share sdhci_dma_show in sdhc.h for platform usr.

Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
---
 drivers/mmc/host/sdhci.c | 25 +++++++++++++++++++------
 drivers/mmc/host/sdhci.h |  5 +++++
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b4d7f27..2ba9c6d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -238,16 +238,25 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 
 static void sdhci_init(struct sdhci_host *host, int soft)
 {
+	u32 pltm_irq = 0, irq = 0;
+
 	if (soft)
 		sdhci_reset(host, SDHCI_RESET_CMD|SDHCI_RESET_DATA);
 	else
 		sdhci_reset(host, SDHCI_RESET_ALL);
 
-	sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
-		SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT |
+	irq = SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT |
 		SDHCI_INT_DATA_CRC | SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_INDEX |
 		SDHCI_INT_END_BIT | SDHCI_INT_CRC | SDHCI_INT_TIMEOUT |
-		SDHCI_INT_DATA_END | SDHCI_INT_RESPONSE);
+		SDHCI_INT_DATA_END | SDHCI_INT_RESPONSE;
+	/* Vendor Specific Error Status, Status enable and Signal Enable */
+	if (host->ops->get_platform_irq)
+		host->ops->get_platform_irq(host, &pltm_irq);
+
+	if (pltm_irq)
+		irq |= pltm_irq;
+
+	sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, irq);
 
 	if (soft) {
 		/* force clock reconfiguration */
@@ -2241,6 +2250,9 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask)
 			SDHCI_INT_INDEX))
 		host->cmd->error = -EILSEQ;
 
+	if (host->ops->handle_platform_irq)
+		host->ops->handle_platform_irq(host, intmask);
+
 	if (host->cmd->error) {
 		tasklet_schedule(&host->finish_tasklet);
 		return;
@@ -2273,7 +2285,7 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask)
 }
 
 #ifdef CONFIG_MMC_DEBUG
-static void sdhci_show_adma_error(struct sdhci_host *host)
+void sdhci_show_adma_error(struct sdhci_host *host)
 {
 	const char *name = mmc_hostname(host->mmc);
 	u8 *desc = host->adma_desc;
@@ -2350,10 +2362,11 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		pr_err("%s: ADMA error\n", mmc_hostname(host->mmc));
 		sdhci_show_adma_error(host);
 		host->data->error = -EIO;
-		if (host->ops->adma_workaround)
-			host->ops->adma_workaround(host, intmask);
 	}
 
+	if (host->ops->handle_platform_irq)
+		host->ops->handle_platform_irq(host, intmask);
+
 	if (host->data->error)
 		sdhci_finish_data(host);
 	else {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index b037f18..a0f1734 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -292,6 +292,8 @@ struct sdhci_ops {
 	void	(*hw_reset)(struct sdhci_host *host);
 	void	(*platform_suspend)(struct sdhci_host *host);
 	void	(*platform_resume)(struct sdhci_host *host);
+	void    (*get_platform_irq)(struct sdhci_host *host, u32 *irq);
+	void    (*handle_platform_irq)(struct sdhci_host *host, u32 intmask);
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void	(*platform_init)(struct sdhci_host *host);
 	void    (*card_event)(struct sdhci_host *host);
@@ -405,4 +407,7 @@ extern int sdhci_runtime_suspend_host(struct sdhci_host *host);
 extern int sdhci_runtime_resume_host(struct sdhci_host *host);
 #endif
 
+#ifdef CONFIG_MMC_DEBUG
+extern void sdhci_show_adma_error(struct sdhci_host *host);
+#endif
 #endif /* __SDHCI_HW_H */
-- 
1.8.0


