From: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Subject: [PATCH V6 4/4] mmc: sdhci-esdhc: enable esdhc on imx53
Date: Thu, 17 Mar 2011 14:34:07 +0800
Message-ID: <1300343647-15735-4-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1300343647-15735-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:33473 "EHLO
	TX2EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689Ab1CQGeb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Mar 2011 02:34:31 -0400
In-Reply-To: <1300343647-15735-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, w.sang@pengutronix.de, linuxzsc@gmail.com, eric.miao@linaro.org, Richard Zhu <Hong-Xing.Zhu@freescale.com>, Richard Zhao <richard.zhao@freescale.com>

Fix the NO INT in the Multi-BLK IO in SD/MMC, and Multi-BLK
read in SDIO on imx53.

The CMDTYPE of the CMD register (offset 0xE) should be set to
"11" when the STOP CMD12 is issued on imx53 to abort one
open ended multi-blk IO. Otherwise one the TC INT wouldn't
be generated.

In exact block transfer, the controller doesn't complete the
operations automatically as required at the end of the
transfer and remains on hold if the abort command is not sent on
imx53.
As a result, the TC flag is not asserted and SW  received timeout
exeception. set bit1 of Vendor Spec registor to fix it.

Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   42 ++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 5768e06..96d131e 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -19,13 +19,31 @@
 #include <linux/slab.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sdhci-pltfm.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/sdio.h>
 #include <mach/hardware.h>
 #include <mach/esdhc.h>
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
 
+/* VENDOR SPEC register */
+#define SDHCI_VENDOR_SPEC		0xC0
+#define  SDHCI_VENDOR_SPEC_SDIO_QUIRK	0x00000002
+
 #define IMX_GPIO_CD_WP			(1 << 0)
+/*
+ * The CMDTYPE of the CMD register (offset 0xE) should be set to
+ * "11" when the STOP CMD12 is issued on imx53 to abort one
+ * open ended multi-blk IO. Otherwise the TC INT wouldn't
+ * be generated.
+ * In exact block transfer, the controller doesn't complete the
+ * operations automatically as required at the end of the
+ * transfer and remains on hold if the abort command is not sent.
+ * As a result, the TC flag is not asserted and SW  received timeout
+ * exeception. Bit1 of Vendor Spec registor is used to fix it.
+ */
+#define IMX_MULTIBLK_NO_INT		(1 << 1)
 
 struct pltfm_imx_data {
 	int flags;
@@ -80,6 +98,15 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 		 */
 		val &= ~(SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT);
 
+	if (unlikely((imx_data->flags & IMX_MULTIBLK_NO_INT)
+				&& (reg == SDHCI_INT_STATUS)
+				&& (val & SDHCI_INT_DATA_END))) {
+			u32 v;
+			v = readl(host->ioaddr + SDHCI_VENDOR_SPEC);
+			v &= ~SDHCI_VENDOR_SPEC_SDIO_QUIRK;
+			writel(v, host->ioaddr + SDHCI_VENDOR_SPEC);
+	}
+
 	writel(val, host->ioaddr + reg);
 }
 
@@ -103,9 +130,21 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 		 * Postpone this write, we must do it together with a
 		 * command write that is down below.
 		 */
+		if ((host->cmd->opcode == SD_IO_RW_EXTENDED)
+				&& (host->cmd->data->blocks > 1)
+				&& (host->cmd->data->flags & MMC_DATA_READ)
+				&& (imx_data->flags & IMX_MULTIBLK_NO_INT)) {
+			u32 v;
+			v = readl(host->ioaddr + SDHCI_VENDOR_SPEC);
+			v |= SDHCI_VENDOR_SPEC_SDIO_QUIRK;
+			writel(v, host->ioaddr + SDHCI_VENDOR_SPEC);
+		}
 		imx_data->mod_val = val;
 		return;
 	case SDHCI_COMMAND:
+		if ((host->cmd->opcode == MMC_STOP_TRANSMISSION)
+			&& (imx_data->flags & IMX_MULTIBLK_NO_INT))
+			val |= SDHCI_CMD_ABORTCMD;
 		writel(val << 16 | imx_data->mod_val,
 			host->ioaddr + SDHCI_TRANSFER_MODE);
 		return;
@@ -213,6 +252,9 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
 		sdhci_esdhc_ops.get_ro = esdhc_pltfm_get_ro;
 	}
 
+	if (!(cpu_is_mx25() || cpu_is_mx35() || cpu_is_mx51()))
+		imx_data->flags |= IMX_MULTIBLK_NO_INT;
+
 	if (boarddata) {
 		err = gpio_request_one(boarddata->wp_gpio, GPIOF_IN, "ESDHC_WP");
 		if (err) {
-- 
1.7.1


