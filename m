From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 4/6] mmc: sdhci: rename platform_8bit_width to platform_bus_width
Date: Mon, 21 Jan 2013 19:02:27 +0800
Message-ID: <1358766149-9534-5-git-send-email-shawn.guo@linaro.org>
References: <1358766149-9534-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:37867
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752002Ab3AUKeM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jan 2013 05:34:12 -0500
In-Reply-To: <1358766149-9534-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>

From: Sascha Hauer <s.hauer@pengutronix.de>

The 8bit in the function name is misleading. When set, it will be
used to set the bus width, regardless of whether 8bit or another
bus width is requested, so change the function name to
platform_bus_width.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci-pci.c   |    4 ++--
 drivers/mmc/host/sdhci-pxav2.c |    2 +-
 drivers/mmc/host/sdhci-s3c.c   |    8 ++++----
 drivers/mmc/host/sdhci-tegra.c |    4 ++--
 drivers/mmc/host/sdhci.c       |    8 ++++----
 drivers/mmc/host/sdhci.h       |    2 +-
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index c7dd0cb..c7ccf30 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -935,7 +935,7 @@ static int sdhci_pci_enable_dma(struct sdhci_host *host)
 	return 0;
 }
 
-static int sdhci_pci_8bit_width(struct sdhci_host *host, int width)
+static int sdhci_pci_bus_width(struct sdhci_host *host, int width)
 {
 	u8 ctrl;
 
@@ -977,7 +977,7 @@ static void sdhci_pci_hw_reset(struct sdhci_host *host)
 
 static struct sdhci_ops sdhci_pci_ops = {
 	.enable_dma	= sdhci_pci_enable_dma,
-	.platform_8bit_width	= sdhci_pci_8bit_width,
+	.platform_bus_width	= sdhci_pci_bus_width,
 	.hw_reset		= sdhci_pci_hw_reset,
 };
 
diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index ac854aa..7e57565 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -121,7 +121,7 @@ static u32 pxav2_get_max_clock(struct sdhci_host *host)
 static struct sdhci_ops pxav2_sdhci_ops = {
 	.get_max_clock = pxav2_get_max_clock,
 	.platform_reset_exit = pxav2_set_private_registers,
-	.platform_8bit_width = pxav2_mmc_set_width,
+	.platform_bus_width = pxav2_mmc_set_width,
 };
 
 #ifdef CONFIG_OF
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 82a8de1..b16dae0 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -332,14 +332,14 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
 }
 
 /**
- * sdhci_s3c_platform_8bit_width - support 8bit buswidth
+ * sdhci_s3c_platform_bus_width - support 8bit buswidth
  * @host: The SDHCI host being queried
  * @width: MMC_BUS_WIDTH_ macro for the bus width being requested
  *
  * We have 8-bit width support but is not a v3 controller.
- * So we add platform_8bit_width() and support 8bit width.
+ * So we add platform_bus_width() and support 8bit width.
  */
-static int sdhci_s3c_platform_8bit_width(struct sdhci_host *host, int width)
+static int sdhci_s3c_platform_bus_width(struct sdhci_host *host, int width)
 {
 	u8 ctrl;
 
@@ -369,7 +369,7 @@ static struct sdhci_ops sdhci_s3c_ops = {
 	.get_max_clock		= sdhci_s3c_get_max_clk,
 	.set_clock		= sdhci_s3c_set_clock,
 	.get_min_clock		= sdhci_s3c_get_min_clock,
-	.platform_8bit_width	= sdhci_s3c_platform_8bit_width,
+	.platform_bus_width	= sdhci_s3c_platform_bus_width,
 };
 
 static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 3695b2e..5a600a5 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -143,7 +143,7 @@ static void tegra_sdhci_reset_exit(struct sdhci_host *host, u8 mask)
 	}
 }
 
-static int tegra_sdhci_8bit(struct sdhci_host *host, int bus_width)
+static int tegra_sdhci_buswidth(struct sdhci_host *host, int bus_width)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_tegra *tegra_host = pltfm_host->priv;
@@ -170,7 +170,7 @@ static struct sdhci_ops tegra_sdhci_ops = {
 	.read_l     = tegra_sdhci_readl,
 	.read_w     = tegra_sdhci_readw,
 	.write_l    = tegra_sdhci_writel,
-	.platform_8bit_width = tegra_sdhci_8bit,
+	.platform_bus_width = tegra_sdhci_buswidth,
 	.platform_reset_exit = tegra_sdhci_reset_exit,
 };
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 336ab06..3bb9b88 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1395,11 +1395,11 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 	/*
 	 * If your platform has 8-bit width support but is not a v3 controller,
 	 * or if it requires special setup code, you should implement that in
-	 * platform_8bit_width().
+	 * platform_bus_width().
 	 */
-	if (host->ops->platform_8bit_width)
-		host->ops->platform_8bit_width(host, ios->bus_width);
-	else {
+	if (host->ops->platform_bus_width) {
+		host->ops->platform_bus_width(host, ios->bus_width);
+	} else {
 		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
 		if (ios->bus_width == MMC_BUS_WIDTH_8) {
 			ctrl &= ~SDHCI_CTRL_4BITBUS;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index a6d69b7..c8d11b9 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -269,7 +269,7 @@ struct sdhci_ops {
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
-	int		(*platform_8bit_width)(struct sdhci_host *host,
+	int		(*platform_bus_width)(struct sdhci_host *host,
 					       int width);
 	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
 					     u8 power_mode);
-- 
1.7.9.5


