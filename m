From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 4/4] mmc: eSDHC: Some eSDHC host need long time to generate command interrupt
Date: Mon, 8 Jul 2013 10:12:25 +0800
Message-ID: <1373249545-23928-4-git-send-email-Haijun.Zhang@freescale.com>
References: <1373249545-23928-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db8lp0184.outbound.messaging.microsoft.com ([213.199.154.184]:5641
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753390Ab3GHDCO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Jul 2013 23:02:14 -0400
In-Reply-To: <1373249545-23928-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, AFLEMING@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

Command complete interrupt not always generate within 10 * HZ. Sometimes
500 * HZ or more. So enlarge this detecting value to ensure the host had
sufficient time to generate command complete interrupt.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c |  3 +++
 drivers/mmc/host/sdhci.c          | 10 +++++++++-
 include/linux/mmc/sdhci.h         |  2 ++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index b22cab0..b616b03 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -331,6 +331,9 @@ static void esdhc_of_platform_init(struct sdhci_host *host)
 
 	if (vvn > VENDOR_V_22)
 		host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
+
+	if (fsl_svr_is(SVR_B4860) || fsl_svr_is(SVR_T4240))
+		host->quirks2 |= SDHCI_QUIRK2_LONG_TM_CMD_COMPLETE_IRQ;
 }
 
 static int esdhc_pltfm_bus_width(struct sdhci_host *host, int width)
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index de7fa81..35015ba 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -986,6 +986,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	int flags;
 	u32 mask;
 	unsigned long timeout;
+	int timer = 10;
 
 	WARN_ON(host->cmd);
 
@@ -1014,7 +1015,14 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		mdelay(1);
 	}
 
-	mod_timer(&host->timer, jiffies + 10 * HZ);
+	/*
+	 * Some eSDHC controller need long time to generate command complete
+	 * interrupt, 1000 * HZ will be enough.
+	 */
+	if (host->quirks2 & SDHCI_QUIRK2_LONG_TM_CMD_COMPLETE_IRQ)
+		timer = 1000;
+
+	mod_timer(&host->timer, jiffies + timer * HZ);
 
 	host->cmd = cmd;
 
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index dc608d7..68e7dd1 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -100,6 +100,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_BROKEN_HOST_CONTROL		(1<<5)
 /* The host support VS300 even if the capacity detailed not */
 #define SDHCI_QUIRK2_CIRCUIT_SUPPORT_VS30		(1<<6)
+/* Some controller need long time to generate command complete interrupt */
+#define SDHCI_QUIRK2_LONG_TM_CMD_COMPLETE_IRQ		(1<<7)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.8.0


