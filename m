From: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Subject: [PATCH V5 4/6] mmc: sdhci-esdhc: make the writel/readl as the general APIs
Date: Wed, 2 Mar 2011 18:04:41 +0800
Message-ID: <1299060283-6404-4-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1299060283-6404-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1outboundpool.messaging.microsoft.com ([216.32.181.186]:47544
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756574Ab1CBKIt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Mar 2011 05:08:49 -0500
In-Reply-To: <1299060283-6404-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, w.sang@pengutronix.de, linuxzsc@gmail.com, richard.zhao@freescale.com, eric.miao@linaro.org, Richard Zhu <Hong-Xing.Zhu@freescale.com>

Add one flag to indicate the GPIO CD/WP is enabled or not
on imx platforms, and reuse the writel/readl as the general
APIs for imx SOCs.

Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   40 ++++++++++++++++++++++++++++++-----
 1 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 3b52485..42f5687 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
+#include <linux/slab.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sdhci-pltfm.h>
 #include <mach/hardware.h>
@@ -24,6 +25,13 @@
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
 
+#define IMX_GPIO_CD_WP			(1 << 0)
+
+struct pltfm_imx_data {
+	int flags;
+	u32 mod_val;
+};
+
 static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, int reg)
 {
 	void __iomem *base = host->ioaddr + (reg & ~0x3);
@@ -34,10 +42,15 @@ static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, i
 
 static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 {
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data =
+				(struct pltfm_imx_data *)pltfm_host->scratchpad;
+
 	/* fake CARD_PRESENT flag on mx25/35 */
 	u32 val = readl(host->ioaddr + reg);
 
-	if (unlikely(reg == SDHCI_PRESENT_STATE)) {
+	if (unlikely((reg == SDHCI_PRESENT_STATE)
+			&& (imx_data->flags & IMX_GPIO_CD_WP))) {
 		struct esdhc_platform_data *boarddata =
 				host->mmc->parent->platform_data;
 
@@ -55,7 +68,12 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 
 static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 {
-	if (unlikely(reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE))
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data =
+				(struct pltfm_imx_data *)pltfm_host->scratchpad;
+
+	if (unlikely((reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE)
+			&& (imx_data->flags & IMX_GPIO_CD_WP)))
 		/*
 		 * these interrupts won't work with a custom card_detect gpio
 		 * (only applied to mx25/35)
@@ -76,6 +94,8 @@ static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
 static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data =
+				(struct pltfm_imx_data *)pltfm_host->scratchpad;
 
 	switch (reg) {
 	case SDHCI_TRANSFER_MODE:
@@ -83,10 +103,10 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 		 * Postpone this write, we must do it together with a
 		 * command write that is down below.
 		 */
-		pltfm_host->scratchpad = val;
+		imx_data->mod_val = val;
 		return;
 	case SDHCI_COMMAND:
-		writel(val << 16 | pltfm_host->scratchpad,
+		writel(val << 16 | imx_data->mod_val,
 			host->ioaddr + SDHCI_TRANSFER_MODE);
 		return;
 	case SDHCI_BLOCK_SIZE:
@@ -146,7 +166,9 @@ static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
 }
 
 static struct sdhci_ops sdhci_esdhc_ops = {
+	.read_l = esdhc_readl_le,
 	.read_w = esdhc_readw_le,
+	.write_l = esdhc_writel_le,
 	.write_w = esdhc_writew_le,
 	.write_b = esdhc_writeb_le,
 	.set_clock = esdhc_set_clock,
@@ -168,6 +190,10 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
 	struct esdhc_platform_data *boarddata = host->mmc->parent->platform_data;
 	struct clk *clk;
 	int err;
+	struct pltfm_imx_data *imx_data;
+
+	imx_data = kzalloc(sizeof(struct pltfm_imx_data), GFP_KERNEL);
+	pltfm_host->scratchpad = (u32)imx_data;
 
 	clk = clk_get(mmc_dev(host->mmc), NULL);
 	if (IS_ERR(clk)) {
@@ -214,8 +240,7 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
 			goto no_card_detect_irq;
 		}
 
-		sdhci_esdhc_ops.write_l = esdhc_writel_le;
-		sdhci_esdhc_ops.read_l = esdhc_readl_le;
+		imx_data->flags |= IMX_GPIO_CD_WP;
 		/* Now we have a working card_detect again */
 		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 	}
@@ -234,6 +259,8 @@ static void esdhc_pltfm_exit(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct esdhc_platform_data *boarddata = host->mmc->parent->platform_data;
+	struct pltfm_imx_data *imx_data =
+				(struct pltfm_imx_data *)pltfm_host->scratchpad;
 
 	if (boarddata && gpio_is_valid(boarddata->wp_gpio))
 		gpio_free(boarddata->wp_gpio);
@@ -247,6 +274,7 @@ static void esdhc_pltfm_exit(struct sdhci_host *host)
 
 	clk_disable(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
+	kfree(imx_data);
 }
 
 struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
-- 
1.7.1


