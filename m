From: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Subject: [PATCH V7 3/4] mmc: sdhci-esdhc: make the writel/readl as the general APIs
Date: Fri, 18 Mar 2011 17:56:56 +0800
Message-ID: <1300442217-1060-3-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1300442217-1060-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-tx2.bigfish.com ([65.55.88.10]:13777 "EHLO
	TX2EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932366Ab1CRJ5N (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Mar 2011 05:57:13 -0400
In-Reply-To: <1300442217-1060-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, w.sang@pengutronix.de, linuxzsc@gmail.com, eric.miao@linaro.org, Richard Zhu <Hong-Xing.Zhu@freescale.com>

Add one flag to indicate the GPIO CD/WP is enabled or not
on imx platforms, and reuse the writel/readl as the general
APIs for imx SOCs.

Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   43 ++++++++++++++++++++++++++++++------
 drivers/mmc/host/sdhci-pltfm.h     |    2 +-
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 3b52485..a558d86 100644
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
 
+#define ESDHC_FLAG_GPIO_FOR_CD_WP	(1 << 0)
+
+struct pltfm_imx_data {
+	int flags;
+	u32 scratchpad;
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
+				(struct pltfm_imx_data *)pltfm_host->priv;
+
 	/* fake CARD_PRESENT flag on mx25/35 */
 	u32 val = readl(host->ioaddr + reg);
 
-	if (unlikely(reg == SDHCI_PRESENT_STATE)) {
+	if (unlikely((reg == SDHCI_PRESENT_STATE)
+			&& (imx_data->flags & ESDHC_FLAG_GPIO_FOR_CD_WP))) {
 		struct esdhc_platform_data *boarddata =
 				host->mmc->parent->platform_data;
 
@@ -55,7 +68,12 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 
 static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 {
-	if (unlikely(reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE))
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data =
+				(struct pltfm_imx_data *)pltfm_host->priv;
+
+	if (unlikely((reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE)
+			&& (imx_data->flags & ESDHC_FLAG_GPIO_FOR_CD_WP)))
 		/*
 		 * these interrupts won't work with a custom card_detect gpio
 		 * (only applied to mx25/35)
@@ -76,6 +94,8 @@ static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
 static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data =
+				(struct pltfm_imx_data *)pltfm_host->priv;
 
 	switch (reg) {
 	case SDHCI_TRANSFER_MODE:
@@ -83,10 +103,10 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 		 * Postpone this write, we must do it together with a
 		 * command write that is down below.
 		 */
-		pltfm_host->scratchpad = val;
+		imx_data->scratchpad = val;
 		return;
 	case SDHCI_COMMAND:
-		writel(val << 16 | pltfm_host->scratchpad,
+		writel(val << 16 | imx_data->scratchpad,
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
@@ -168,6 +190,7 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
 	struct esdhc_platform_data *boarddata = host->mmc->parent->platform_data;
 	struct clk *clk;
 	int err;
+	struct pltfm_imx_data *imx_data;
 
 	clk = clk_get(mmc_dev(host->mmc), NULL);
 	if (IS_ERR(clk)) {
@@ -177,7 +200,10 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
 	clk_enable(clk);
 	pltfm_host->clk = clk;
 
-	if (cpu_is_mx35() || cpu_is_mx51())
+	imx_data = kzalloc(sizeof(struct pltfm_imx_data), GFP_KERNEL);
+	pltfm_host->priv = (void *)imx_data;
+
+	if (!cpu_is_mx25())
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
 	if (cpu_is_mx25() || cpu_is_mx35()) {
@@ -214,8 +240,7 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
 			goto no_card_detect_irq;
 		}
 
-		sdhci_esdhc_ops.write_l = esdhc_writel_le;
-		sdhci_esdhc_ops.read_l = esdhc_readl_le;
+		imx_data->flags |= ESDHC_FLAG_GPIO_FOR_CD_WP;
 		/* Now we have a working card_detect again */
 		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 	}
@@ -227,6 +252,7 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
  no_card_detect_pin:
 	boarddata->cd_gpio = err;
  not_supported:
+	kfree(imx_data);
 	return 0;
 }
 
@@ -234,6 +260,8 @@ static void esdhc_pltfm_exit(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct esdhc_platform_data *boarddata = host->mmc->parent->platform_data;
+	struct pltfm_imx_data *imx_data =
+				(struct pltfm_imx_data *)pltfm_host->priv;
 
 	if (boarddata && gpio_is_valid(boarddata->wp_gpio))
 		gpio_free(boarddata->wp_gpio);
@@ -247,6 +275,7 @@ static void esdhc_pltfm_exit(struct sdhci_host *host)
 
 	clk_disable(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
+	kfree(imx_data);
 }
 
 struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
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


