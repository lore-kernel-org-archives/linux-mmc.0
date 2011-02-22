From: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Subject: [PATCH v2 5/5] mmc: sdhci-esdhc: enable esdhc on imx53
Date: Tue, 22 Feb 2011 18:13:26 +0800
Message-ID: <1298369606-29972-5-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1298369606-29972-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:15505
	"EHLO VA3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753462Ab1BVKNu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Feb 2011 05:13:50 -0500
In-Reply-To: <1298369606-29972-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, w.sang@pengutronix.de, linuxzsc@gmail.com, richard.zhao@freescale.com, Richard Zhu <Hong-Xing.Zhu@freescale.com>

Fix the NO INT in the Multi-BLK IO in SD/MMC, and
Multi-BLK read in SDIO

Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   41 +++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci-esdhc.h     |    5 ++++
 2 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 9b82910..a09f786 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -17,6 +17,8 @@
 #include <linux/clk.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sdhci-pltfm.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/sdio.h>
 #include <mach/hardware.h>
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
@@ -38,6 +40,27 @@ static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
 	return readw(host->ioaddr + reg);
 }
 
+static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
+{
+	switch (reg) {
+	case SDHCI_INT_STATUS:
+		/*
+		 * Fix no INT bug in SDIO MULTI-BLK read
+		 * clear bit1 of Vendor Spec registor after TC
+		 */
+		if (val & SDHCI_INT_DATA_END) {
+			u32 v;
+			v = readl(host->ioaddr + SDHCI_VENDOR_SPEC);
+			if (v & 0x2) {
+				v &= (~0x2);
+				writel(v, host->ioaddr + SDHCI_VENDOR_SPEC);
+			}
+		}
+		break;
+	}
+	writel(val, host->ioaddr + reg);
+}
+
 static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -45,12 +68,27 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 	switch (reg) {
 	case SDHCI_TRANSFER_MODE:
 		/*
+		 * Fix no INT bug in SDIO MULTI-BLK read
+		 * set bit1 of Vendor Spec registor
+		 */
+		if ((host->cmd->opcode == SD_IO_RW_EXTENDED)
+				&& (host->cmd->data->blocks > 1)
+				&& (host->cmd->data->flags & MMC_DATA_READ)) {
+			u32 v;
+			v = readl(host->ioaddr + SDHCI_VENDOR_SPEC);
+			v |= 0x2;
+			writel(v, host->ioaddr + SDHCI_VENDOR_SPEC);
+		}
+		/*
 		 * Postpone this write, we must do it together with a
 		 * command write that is down below.
 		 */
 		pltfm_host->scratchpad = val;
 		return;
 	case SDHCI_COMMAND:
+		/*Set the CMD_TYPE of the CMD12, fix no INT in MULTI_BLK IO */
+		if (host->cmd->opcode == MMC_STOP_TRANSMISSION)
+			val |= SDHCI_CMD_ABORTCMD;
 		writel(val << 16 | pltfm_host->scratchpad,
 			host->ioaddr + SDHCI_TRANSFER_MODE);
 		return;
@@ -113,7 +151,7 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
 	clk_enable(clk);
 	pltfm_host->clk = clk;
 
-	if (cpu_is_mx35() || cpu_is_mx51())
+	if (!cpu_is_mx25())
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
 	/* Fix errata ENGcm07207 which is present on i.MX25 and i.MX35 */
@@ -133,6 +171,7 @@ static void esdhc_pltfm_exit(struct sdhci_host *host)
 
 static struct sdhci_ops sdhci_esdhc_ops = {
 	.read_w = esdhc_readw_le,
+	.write_l = esdhc_writel_le,
 	.write_w = esdhc_writew_le,
 	.write_b = esdhc_writeb_le,
 	.set_clock = esdhc_set_clock,
diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index 303cde0..c93168c 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -43,6 +43,11 @@
 
 #define ESDHC_HOST_CONTROL_RES	0x05
 
+/* Abort type definition in the command register  */
+#define  SDHCI_CMD_ABORTCMD	0xC0
+/* VENDOR SPEC register */
+#define SDHCI_VENDOR_SPEC	0xC0
+
 static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	int pre_div = 2;
-- 
1.7.1


