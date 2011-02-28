From: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Subject: [PATCH V3 4/4] mmc: sdhci-esdhc: enable esdhc on imx53
Date: Mon, 28 Feb 2011 19:32:05 +0800
Message-ID: <1298892725-23672-4-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1298892725-23672-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:24742 "EHLO
	TX2EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641Ab1B1Lca (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Feb 2011 06:32:30 -0500
In-Reply-To: <1298892725-23672-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, w.sang@pengutronix.de, linuxzsc@gmail.com, richard.zhao@freescale.com, Freescale@lists.linaro.org, eric.miao@linaro.org, Richard Zhu <Hong-Xing.Zhu@freescale.com>

Fix the NO INT in the Multi-BLK IO in SD/MMC, and
Multi-BLK read in SDIO

The CMDTYPE of the CMD register(offset 0xE) should be set to
"11" when the STOP CMD12 is issued on imx53 to abort one
open ended multi-blk IO. Otherwise one the TC INT wouldn't
be generated.

In exact block transfer, the controller doesn't complete the
operations automatically as required at the end of the
transfer and remains on hold if the abort command is not sent.
As a result, the TC flag is not asserted and SW  received timeout
exeception. set bit1 of Vendor Spec registor to fix it

Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   77 ++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci-pltfm.h     |    2 +-
 2 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 9b82910..32af7c4 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -15,13 +15,41 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/slab.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sdhci-pltfm.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/sdio.h>
 #include <mach/hardware.h>
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
 
+/* Abort type definition in the command register  */
+#define  SDHCI_CMD_ABORTCMD	0xC0
+/* VENDOR SPEC register */
+#define SDHCI_VENDOR_SPEC	0xC0
+
+/*
+ * The CMDTYPE of the CMD register(offset 0xE) should be set to
+ * "11" when the STOP CMD12 is issued on imx53 to abort one
+ * open ended multi-blk IO. Otherwise one the TC INT wouldn't
+ * be generated.
+ * In exact block transfer, the controller doesn't complete the
+ * operations automatically as required at the end of the
+ * transfer and remains on hold if the abort command is not sent.
+ * As a result, the TC flag is not asserted and SW  received timeout
+ * exeception. Bit1 of Vendor Spec registor is used to fix it.
+ */
+#define IMX_MULTIBLK_NO_INT		(1 << 0)
+
+struct pltfm_imx_data {
+	int flags;
+	u32 mod_val;
+};
+
+static struct sdhci_ops sdhci_esdhc_ops;
+
 static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, int reg)
 {
 	void __iomem *base = host->ioaddr + (reg & ~0x3);
@@ -38,20 +66,51 @@ static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
 	return readw(host->ioaddr + reg);
 }
 
+static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
+{
+	switch (reg) {
+	case SDHCI_INT_STATUS:
+		if (val & SDHCI_INT_DATA_END) {
+			u32 v;
+			v = readl(host->ioaddr + SDHCI_VENDOR_SPEC);
+			if (v & 0x2) {
+				v &= ~0x2;
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
+	struct pltfm_imx_data *imx_data =
+				(struct pltfm_imx_data *)pltfm_host->priv;
 
 	switch (reg) {
 	case SDHCI_TRANSFER_MODE:
+		if ((host->cmd->opcode == SD_IO_RW_EXTENDED)
+				&& (host->cmd->data->blocks > 1)
+				&& (host->cmd->data->flags & MMC_DATA_READ)
+				&& (imx_data->flags & IMX_MULTIBLK_NO_INT)) {
+			u32 v;
+			v = readl(host->ioaddr + SDHCI_VENDOR_SPEC);
+			v |= 0x2;
+			writel(v, host->ioaddr + SDHCI_VENDOR_SPEC);
+		}
 		/*
 		 * Postpone this write, we must do it together with a
 		 * command write that is down below.
 		 */
-		pltfm_host->scratchpad = val;
+		imx_data->mod_val = val;
 		return;
 	case SDHCI_COMMAND:
-		writel(val << 16 | pltfm_host->scratchpad,
+		if ((host->cmd->opcode == MMC_STOP_TRANSMISSION)
+			&& (imx_data->flags & IMX_MULTIBLK_NO_INT))
+			val |= SDHCI_CMD_ABORTCMD;
+		writel(val << 16 | imx_data->mod_val,
 			host->ioaddr + SDHCI_TRANSFER_MODE);
 		return;
 	case SDHCI_BLOCK_SIZE:
@@ -104,6 +163,10 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct clk *clk;
+	struct pltfm_imx_data *imx_data;
+
+	imx_data = kzalloc(sizeof(struct pltfm_imx_data), GFP_KERNEL);
+	pltfm_host->priv = (void *)imx_data;
 
 	clk = clk_get(mmc_dev(host->mmc), NULL);
 	if (IS_ERR(clk)) {
@@ -113,22 +176,30 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
 	clk_enable(clk);
 	pltfm_host->clk = clk;
 
-	if (cpu_is_mx35() || cpu_is_mx51())
+	if (!cpu_is_mx25())
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
 	/* Fix errata ENGcm07207 which is present on i.MX25 and i.MX35 */
 	if (cpu_is_mx25() || cpu_is_mx35())
 		host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK;
 
+	if (!(cpu_is_mx25() || cpu_is_mx35() || cpu_is_mx51())) {
+		imx_data->flags |= IMX_MULTIBLK_NO_INT;
+		sdhci_esdhc_ops.write_l = esdhc_writel_le;
+	}
+
 	return 0;
 }
 
 static void esdhc_pltfm_exit(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data =
+				(struct pltfm_imx_data *)pltfm_host->priv;
 
 	clk_disable(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
+	kfree(imx_data);
 }
 
 static struct sdhci_ops sdhci_esdhc_ops = {
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index ea2e44d..2b37016 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -17,7 +17,7 @@
 
 struct sdhci_pltfm_host {
 	struct clk *clk;
-	u32 scratchpad; /* to handle quirks across io-accessor calls */
+	void *priv; /* to handle quirks across io-accessor calls */
 };
 
 extern struct sdhci_pltfm_data sdhci_cns3xxx_pdata;
-- 
1.7.1


