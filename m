From: Chris Ball <cjb@laptop.org>
Subject: [PATCH 1/2] mmc: sdhci: Replace SDHCI_QUIRK_FORCE_BLK_SZ_2048 with a pklatform hook.
Date: Sun, 06 Feb 2011 01:13:10 -0500
Message-ID: <m31v3lofm1.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37032 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519Ab1BFGKR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 6 Feb 2011 01:10:17 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>

Part of a quirk cleanup run.  This quirk was only used by sdhci-esdhc.
This patch is untested.

Signed-off-by: Chris Ball <cjb@laptop.org>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    8 ++++++++
 drivers/mmc/host/sdhci-esdhc.h     |    3 +--
 drivers/mmc/host/sdhci-of-esdhc.c  |    8 ++++++++
 drivers/mmc/host/sdhci.c           |    4 ++--
 drivers/mmc/host/sdhci.h           |    1 +
 include/linux/mmc/sdhci.h          |    4 ++--
 6 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 9b82910..6249b75 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -100,6 +100,13 @@ static unsigned int esdhc_pltfm_get_min_clock(struct sdhci_host *host)
 	return clk_get_rate(pltfm_host->clk) / 256 / 16;
 }
 
+static unsigned int esdhc_pltfm_get_max_blk_size(struct sdhci_host *host)
+{
+	/* Force 2048 bytes, which is the maximum supported size in SDHCI. */
+
+	return 2;
+}
+
 static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pdata)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -138,6 +145,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.set_clock = esdhc_set_clock,
 	.get_max_clock = esdhc_pltfm_get_max_clock,
 	.get_min_clock = esdhc_pltfm_get_min_clock,
+	.get_max_blk_size = esdhc_pltfm_get_max_blk_size,
 };
 
 struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index afaf1bc..b18bb5f 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -18,8 +18,7 @@
  * Ops and quirks for the Freescale eSDHC controller.
  */
 
-#define ESDHC_DEFAULT_QUIRKS	(SDHCI_QUIRK_FORCE_BLK_SZ_2048 | \
-				SDHCI_QUIRK_BROKEN_CARD_DETECTION | \
+#define ESDHC_DEFAULT_QUIRKS	(SDHCI_QUIRK_BROKEN_CARD_DETECTION | \
 				SDHCI_QUIRK_NO_BUSY_IRQ | \
 				SDHCI_QUIRK_NONSTANDARD_CLOCK | \
 				SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK | \
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index fcd0e1f..43e5f56 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -72,6 +72,13 @@ static unsigned int esdhc_of_get_min_clock(struct sdhci_host *host)
 	return of_host->clock / 256 / 16;
 }
 
+static unsigned int esdhc_of_get_max_blk_size(struct sdhci_host *host)
+{
+	/* Force 2048 bytes, which is the maximum supported size in SDHCI. */
+
+	return 2;
+}
+
 struct sdhci_of_data sdhci_esdhc = {
 	.quirks = ESDHC_DEFAULT_QUIRKS,
 	.ops = {
@@ -85,5 +92,6 @@ struct sdhci_of_data sdhci_esdhc = {
 		.enable_dma = esdhc_of_enable_dma,
 		.get_max_clock = esdhc_of_get_max_clock,
 		.get_min_clock = esdhc_of_get_min_clock,
+		.get_max_blk_size = esdhc_of_get_max_blk_size,
 	},
 };
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9e15f41..fcd6188 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1962,8 +1962,8 @@ int sdhci_add_host(struct sdhci_host *host)
 	 * Maximum block size. This varies from controller to controller and
 	 * is specified in the capabilities register.
 	 */
-	if (host->quirks & SDHCI_QUIRK_FORCE_BLK_SZ_2048) {
-		mmc->max_blk_size = 2;
+	if (host->ops->get_max_blk_size) {
+		mmc->max_blk_size = host->ops->get_max_blk_size(host);
 	} else {
 		mmc->max_blk_size = (caps & SDHCI_MAX_BLOCK_MASK) >>
 				SDHCI_MAX_BLOCK_SHIFT;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 6e0969e..08c1071 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -217,6 +217,7 @@ struct sdhci_ops {
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
+	unsigned int	(*get_max_blk_size)(struct sdhci_host *host);
 	int		(*platform_8bit_width)(struct sdhci_host *host,
 					       int width);
 	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 83bd9f7..2fde25c 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -63,8 +63,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_PIO_NEEDS_DELAY			(1<<18)
 /* Controller losing signal/interrupt enable states after reset */
 #define SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET		(1<<19)
-/* Controller has to be forced to use block size of 2048 bytes */
-#define SDHCI_QUIRK_FORCE_BLK_SZ_2048			(1<<20)
+/* Reclaimed */
+#define SDHCI_QUIRK_UNUSED_20				(1<<20)
 /* Controller cannot do multi-block transfers */
 #define SDHCI_QUIRK_NO_MULTIBLOCK			(1<<21)
 /* Controller can only handle 1-bit data transfers */
-- 
Chris Ball   <cjb@laptop.org>
One Laptop Per Child
