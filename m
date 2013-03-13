From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 1/3] mmc: sdhci_pltfm: Constify sdhci_pltfm_data
Date: Wed, 13 Mar 2013 19:26:03 +0100
Message-ID: <1363199165-16211-1-git-send-email-lars@metafoo.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out-064.synserver.de ([212.40.185.64]:1031 "EHLO
	smtp-out-064.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933006Ab3CMSYe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Mar 2013 14:24:34 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Anton Vorontsov <cbou@mail.ru>, Viresh Kumar <viresh.linux@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Mike Rapoport <mike@compulab.co.il>, Shawn Guo <shawn.guo@linaro.org>, Albert Herranz <albert_herranz@yahoo.es>, Kevin Liu <kliu5@marvell.com>, linux-mmc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>

The sdhci_pltfm_data struct is never modified within the sdhci_pltfm module. So
make the pdata parameter to sdhci_pltfm_init and sdhci_pltfm_register const.
This allows drivers to declare their sdhci_pltfm_data struct as const.

This patch also makes the sdhci_pltfm_data declarations const where possible.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Shawn Guo <shawn.guo@linaro.org>

---
Changes since v2:
	* Also make sdhci_tegra114_pdata const
---
 drivers/mmc/host/sdhci-bcm2835.c   | 2 +-
 drivers/mmc/host/sdhci-cns3xxx.c   | 2 +-
 drivers/mmc/host/sdhci-dove.c      | 2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 drivers/mmc/host/sdhci-of-esdhc.c  | 2 +-
 drivers/mmc/host/sdhci-of-hlwd.c   | 2 +-
 drivers/mmc/host/sdhci-pltfm.c     | 4 ++--
 drivers/mmc/host/sdhci-pltfm.h     | 4 ++--
 drivers/mmc/host/sdhci-tegra.c     | 8 ++++----
 9 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
index 8ffea05..29e9e40 100644
--- a/drivers/mmc/host/sdhci-bcm2835.c
+++ b/drivers/mmc/host/sdhci-bcm2835.c
@@ -135,7 +135,7 @@ static struct sdhci_ops bcm2835_sdhci_ops = {
 	.get_min_clock = bcm2835_sdhci_get_min_clock,
 };
 
-static struct sdhci_pltfm_data bcm2835_sdhci_pdata = {
+static const struct sdhci_pltfm_data bcm2835_sdhci_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
 		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
 	.ops = &bcm2835_sdhci_ops,
diff --git a/drivers/mmc/host/sdhci-cns3xxx.c b/drivers/mmc/host/sdhci-cns3xxx.c
index 30bfdc4..15a936a 100644
--- a/drivers/mmc/host/sdhci-cns3xxx.c
+++ b/drivers/mmc/host/sdhci-cns3xxx.c
@@ -85,7 +85,7 @@ static struct sdhci_ops sdhci_cns3xxx_ops = {
 	.set_clock	= sdhci_cns3xxx_set_clock,
 };
 
-static struct sdhci_pltfm_data sdhci_cns3xxx_pdata = {
+static const struct sdhci_pltfm_data sdhci_cns3xxx_pdata = {
 	.ops = &sdhci_cns3xxx_ops,
 	.quirks = SDHCI_QUIRK_BROKEN_DMA |
 		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index 169fab9..b514f68 100644
--- a/drivers/mmc/host/sdhci-dove.c
+++ b/drivers/mmc/host/sdhci-dove.c
@@ -88,7 +88,7 @@ static struct sdhci_ops sdhci_dove_ops = {
 	.read_l	= sdhci_dove_readl,
 };
 
-static struct sdhci_pltfm_data sdhci_dove_pdata = {
+static const struct sdhci_pltfm_data sdhci_dove_pdata = {
 	.ops	= &sdhci_dove_ops,
 	.quirks	= SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER |
 		  SDHCI_QUIRK_NO_BUSY_IRQ |
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 78ac002..68c301d 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -412,7 +412,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.platform_bus_width = esdhc_pltfm_bus_width,
 };
 
-static struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
+static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
 	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_NO_HISPD_BIT
 			| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
 			| SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index f32526d..b98b919 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -249,7 +249,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.adma_workaround = esdhci_of_adma_workaround,
 };
 
-static struct sdhci_pltfm_data sdhci_esdhc_pdata = {
+static const struct sdhci_pltfm_data sdhci_esdhc_pdata = {
 	/*
 	 * card detection could be handled via GPIO
 	 * eSDHC cannot support End Attribute in NOP ADMA descriptor
diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-of-hlwd.c
index c3d3715..7ea5c02 100644
--- a/drivers/mmc/host/sdhci-of-hlwd.c
+++ b/drivers/mmc/host/sdhci-of-hlwd.c
@@ -60,7 +60,7 @@ static struct sdhci_ops sdhci_hlwd_ops = {
 	.write_b = sdhci_hlwd_writeb,
 };
 
-static struct sdhci_pltfm_data sdhci_hlwd_pdata = {
+static const struct sdhci_pltfm_data sdhci_hlwd_pdata = {
 	.quirks = SDHCI_QUIRK_32BIT_DMA_ADDR |
 		  SDHCI_QUIRK_32BIT_DMA_SIZE,
 	.ops = &sdhci_hlwd_ops,
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 3145a78..b5b8a21 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -114,7 +114,7 @@ void sdhci_get_of_property(struct platform_device *pdev) {}
 EXPORT_SYMBOL_GPL(sdhci_get_of_property);
 
 struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
-				    struct sdhci_pltfm_data *pdata)
+				    const struct sdhci_pltfm_data *pdata)
 {
 	struct sdhci_host *host;
 	struct sdhci_pltfm_host *pltfm_host;
@@ -201,7 +201,7 @@ void sdhci_pltfm_free(struct platform_device *pdev)
 EXPORT_SYMBOL_GPL(sdhci_pltfm_free);
 
 int sdhci_pltfm_register(struct platform_device *pdev,
-			 struct sdhci_pltfm_data *pdata)
+			 const struct sdhci_pltfm_data *pdata)
 {
 	struct sdhci_host *host;
 	int ret = 0;
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 153b6c5..a3bfc1e 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -91,11 +91,11 @@ static inline void sdhci_be32bs_writeb(struct sdhci_host *host, u8 val, int reg)
 extern void sdhci_get_of_property(struct platform_device *pdev);
 
 extern struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
-					   struct sdhci_pltfm_data *pdata);
+					  const struct sdhci_pltfm_data *pdata);
 extern void sdhci_pltfm_free(struct platform_device *pdev);
 
 extern int sdhci_pltfm_register(struct platform_device *pdev,
-				struct sdhci_pltfm_data *pdata);
+				const struct sdhci_pltfm_data *pdata);
 extern int sdhci_pltfm_unregister(struct platform_device *pdev);
 
 extern unsigned int sdhci_pltfm_clk_get_max_clock(struct sdhci_host *host);
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index ff99b63..f22cfcb 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -38,7 +38,7 @@
 #define NVQUIRK_ENABLE_SDHCI_SPEC_300	BIT(2)
 
 struct sdhci_tegra_soc_data {
-	struct sdhci_pltfm_data *pdata;
+	const struct sdhci_pltfm_data *pdata;
 	u32 nvquirks;
 };
 
@@ -173,7 +173,7 @@ static struct sdhci_ops tegra_sdhci_ops = {
 	.platform_reset_exit = tegra_sdhci_reset_exit,
 };
 
-static struct sdhci_pltfm_data sdhci_tegra20_pdata = {
+static const struct sdhci_pltfm_data sdhci_tegra20_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
 		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
 		  SDHCI_QUIRK_NO_HISPD_BIT |
@@ -187,7 +187,7 @@ static struct sdhci_tegra_soc_data soc_data_tegra20 = {
 		    NVQUIRK_ENABLE_BLOCK_GAP_DET,
 };
 
-static struct sdhci_pltfm_data sdhci_tegra30_pdata = {
+static const struct sdhci_pltfm_data sdhci_tegra30_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
 		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
 		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
@@ -201,7 +201,7 @@ static struct sdhci_tegra_soc_data soc_data_tegra30 = {
 	.nvquirks = NVQUIRK_ENABLE_SDHCI_SPEC_300,
 };
 
-static struct sdhci_pltfm_data sdhci_tegra114_pdata = {
+static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
 		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
 		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
-- 
1.8.0

