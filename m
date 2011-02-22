From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 1/5] mmc: sdhci-esdhc-imx: add support for write protect on custom GPIO
Date: Tue, 22 Feb 2011 13:58:16 +0100
Message-ID: <1298379500-27590-2-git-send-email-w.sang@pengutronix.de>
References: <1298379500-27590-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55297 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062Ab1BVM61 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Feb 2011 07:58:27 -0500
In-Reply-To: <1298379500-27590-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Wolfram Sang <w.sang@pengutronix.de>

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Tested-by: Marc Reilly <marc@cpdesign.com.au>
---

Change since last version:

* rewrote the warning message to apply to non-existant wp_gpio

 arch/arm/plat-mxc/include/mach/esdhc.h |   10 +++++-
 drivers/mmc/host/sdhci-esdhc-imx.c     |   52 +++++++++++++++++++++++++-------
 2 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/esdhc.h b/arch/arm/plat-mxc/include/mach/esdhc.h
index a48a9aa..dbf6d56 100644
--- a/arch/arm/plat-mxc/include/mach/esdhc.h
+++ b/arch/arm/plat-mxc/include/mach/esdhc.h
@@ -10,7 +10,15 @@
 #ifndef __ASM_ARCH_IMX_ESDHC_H
 #define __ASM_ARCH_IMX_ESDHC_H
 
+/**
+ * struct esdhc_platform_data - optional platform data for esdhc on i.MX
+ *
+ * strongly recommended for i.MX25/35, not needed for other variants
+ *
+ * @wp_gpio:	gpio for write_protect
+ */
+
 struct esdhc_platform_data {
-	unsigned int wp_gpio;	/* write protect pin */
+	unsigned int wp_gpio;
 };
 #endif /* __ASM_ARCH_IMX_ESDHC_H */
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 9b82910..65df00b 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -15,9 +15,11 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/gpio.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sdhci-pltfm.h>
 #include <mach/hardware.h>
+#include <mach/esdhc.h>
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
@@ -100,10 +102,31 @@ static unsigned int esdhc_pltfm_get_min_clock(struct sdhci_host *host)
 	return clk_get_rate(pltfm_host->clk) / 256 / 16;
 }
 
+static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
+{
+	struct esdhc_platform_data *boarddata = host->mmc->parent->platform_data;
+
+	if (boarddata && gpio_is_valid(boarddata->wp_gpio))
+		return gpio_get_value(boarddata->wp_gpio);
+	else
+		return -ENOSYS;
+}
+
+static struct sdhci_ops sdhci_esdhc_ops = {
+	.read_w = esdhc_readw_le,
+	.write_w = esdhc_writew_le,
+	.write_b = esdhc_writeb_le,
+	.set_clock = esdhc_set_clock,
+	.get_max_clock = esdhc_pltfm_get_max_clock,
+	.get_min_clock = esdhc_pltfm_get_min_clock,
+};
+
 static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pdata)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct esdhc_platform_data *boarddata = host->mmc->parent->platform_data;
 	struct clk *clk;
+	int err;
 
 	clk = clk_get(mmc_dev(host->mmc), NULL);
 	if (IS_ERR(clk)) {
@@ -116,9 +139,21 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
 	if (cpu_is_mx35() || cpu_is_mx51())
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
-	/* Fix errata ENGcm07207 which is present on i.MX25 and i.MX35 */
-	if (cpu_is_mx25() || cpu_is_mx35())
+	if (cpu_is_mx25() || cpu_is_mx35()) {
+		/* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */
 		host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK;
+		/* write_protect can't be routed to controller, use gpio */
+		sdhci_esdhc_ops.get_ro = esdhc_pltfm_get_ro;
+	}
+
+	if (boarddata) {
+		err = gpio_request_one(boarddata->wp_gpio, GPIOF_IN, "ESDHC_WP");
+		if (err) {
+			dev_warn(mmc_dev(host->mmc),
+				"no write-protect pin available!\n");
+			boarddata->wp_gpio = err;
+		}
+	}
 
 	return 0;
 }
@@ -126,20 +161,15 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
 static void esdhc_pltfm_exit(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct esdhc_platform_data *boarddata = host->mmc->parent->platform_data;
+
+	if (boarddata && gpio_is_valid(boarddata->wp_gpio))
+		gpio_free(boarddata->wp_gpio);
 
 	clk_disable(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
 }
 
-static struct sdhci_ops sdhci_esdhc_ops = {
-	.read_w = esdhc_readw_le,
-	.write_w = esdhc_writew_le,
-	.write_b = esdhc_writeb_le,
-	.set_clock = esdhc_set_clock,
-	.get_max_clock = esdhc_pltfm_get_max_clock,
-	.get_min_clock = esdhc_pltfm_get_min_clock,
-};
-
 struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
 	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_ADMA,
 	/* ADMA has issues. Might be fixable */
-- 
1.7.2.3

