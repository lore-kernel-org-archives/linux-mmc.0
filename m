From: Chris Ball <cjb@laptop.org>
Subject: [PATCH 2/2] mmc: sdhci: Replace SDHCI_QUIRK_NO_MULTIBLOCK with a platform hook.
Date: Sun, 06 Feb 2011 01:13:26 -0500
Message-ID: <m3zkq9n115.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37035 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549Ab1BFGKa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 6 Feb 2011 01:10:30 -0500
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
 drivers/mmc/host/sdhci-esdhc-imx.c |   12 ++++++++----
 drivers/mmc/host/sdhci.c           |    5 ++++-
 drivers/mmc/host/sdhci.h           |    1 +
 include/linux/mmc/sdhci.h          |    4 ++--
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 6249b75..f19b818 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -107,6 +107,13 @@ static unsigned int esdhc_pltfm_get_max_blk_size(struct sdhci_host *host)
 	return 2;
 }
 
+static unsigned int esdhc_pltfm_get_max_blk_count(struct sdhci_host *host)
+{
+	/* Fix errata ENGcm07207 which is present on i.MX25 and i.MX35 */
+
+	return (cpu_is_mx25() || cpu_is_mx35()) ? 1 : 65535;
+}
+
 static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pdata)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -123,10 +130,6 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
 	if (cpu_is_mx35() || cpu_is_mx51())
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
-	/* Fix errata ENGcm07207 which is present on i.MX25 and i.MX35 */
-	if (cpu_is_mx25() || cpu_is_mx35())
-		host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK;
-
 	return 0;
 }
 
@@ -146,6 +149,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.get_max_clock = esdhc_pltfm_get_max_clock,
 	.get_min_clock = esdhc_pltfm_get_min_clock,
 	.get_max_blk_size = esdhc_pltfm_get_max_blk_size,
+	.get_max_blk_count = esdhc_pltfm_get_max_blk_count,
 };
 
 struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fcd6188..8a794fb 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1979,7 +1979,10 @@ int sdhci_add_host(struct sdhci_host *host)
 	/*
 	 * Maximum block count.
 	 */
-	mmc->max_blk_count = (host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK) ? 1 : 65535;
+	if (host->ops->get_max_blk_count)
+		mmc->max_blk_count = host->ops->get_max_blk_count(host);
+	else
+		mmc->max_blk_count = 65535;
 
 	/*
 	 * Init tasklets.
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 08c1071..a9de7b1 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -218,6 +218,7 @@ struct sdhci_ops {
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
 	unsigned int	(*get_max_blk_size)(struct sdhci_host *host);
+	unsigned int	(*get_max_blk_count)(struct sdhci_host *host);
 	int		(*platform_8bit_width)(struct sdhci_host *host,
 					       int width);
 	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 2fde25c..52de824 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -65,8 +65,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET		(1<<19)
 /* Reclaimed */
 #define SDHCI_QUIRK_UNUSED_20				(1<<20)
-/* Controller cannot do multi-block transfers */
-#define SDHCI_QUIRK_NO_MULTIBLOCK			(1<<21)
+/* Reclaimed */
+#define SDHCI_QUIRK_UNUSED_21				(1<<21)
 /* Controller can only handle 1-bit data transfers */
 #define SDHCI_QUIRK_FORCE_1_BIT_DATA			(1<<22)
 /* Controller needs 10ms delay between applying power and clock */
-- 
Chris Ball   <cjb@laptop.org>
One Laptop Per Child
