From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 23/38] mmc: sdhci: convert sdhci_set_uhs_signaling() into a
 library function
Date: Wed, 23 Apr 2014 20:08:07 +0100
Message-ID: <E1Wd2Wd-0003vp-S2@rmk-PC.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46469 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932222AbaDWTIN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Apr 2014 15:08:13 -0400
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Anton Vorontsov <anton@enomsg.org>, Ben Dooks <ben-linux@fluff.org>, Barry Song <baohua@kernel.org>, Viresh Kumar <viresh.linux@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linuxppc-dev@lists.ozlabs.org, spear-devel@list.st.com, linux-tegra@vger.kernel.org

Add sdhci_set_uhs_signaling() and always call the set_uhs_signaling
method.  This avoids quirks being added into sdhci_set_uhs_signaling().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-acpi.c      |  2 ++
 drivers/mmc/host/sdhci-bcm-kona.c  |  1 +
 drivers/mmc/host/sdhci-bcm2835.c   |  1 +
 drivers/mmc/host/sdhci-cns3xxx.c   |  1 +
 drivers/mmc/host/sdhci-dove.c      |  1 +
 drivers/mmc/host/sdhci-of-arasan.c |  1 +
 drivers/mmc/host/sdhci-of-esdhc.c  |  1 +
 drivers/mmc/host/sdhci-of-hlwd.c   |  1 +
 drivers/mmc/host/sdhci-pci.c       |  1 +
 drivers/mmc/host/sdhci-pltfm.c     |  1 +
 drivers/mmc/host/sdhci-pxav2.c     |  1 +
 drivers/mmc/host/sdhci-pxav3.c     |  1 +
 drivers/mmc/host/sdhci-s3c.c       |  1 +
 drivers/mmc/host/sdhci-sirf.c      |  1 +
 drivers/mmc/host/sdhci-spear.c     |  1 +
 drivers/mmc/host/sdhci-tegra.c     |  1 +
 drivers/mmc/host/sdhci.c           | 42 +++++++++++++++++++++-----------------
 drivers/mmc/host/sdhci.h           |  1 +
 18 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 323e2a688563..8ce3c28cb76e 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -106,6 +106,7 @@ static const struct sdhci_ops sdhci_acpi_ops_dflt = {
 	.enable_dma = sdhci_acpi_enable_dma,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
 static const struct sdhci_ops sdhci_acpi_ops_int = {
@@ -113,6 +114,7 @@ static const struct sdhci_ops sdhci_acpi_ops_int = {
 	.enable_dma = sdhci_acpi_enable_dma,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
 	.hw_reset   = sdhci_acpi_int_hw_reset,
 };
 
diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index e610811c09b0..dd780c315a63 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -212,6 +212,7 @@ static struct sdhci_ops sdhci_bcm_kona_ops = {
 	.platform_send_init_74_clocks = sdhci_bcm_kona_init_74_clocks,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
 	.card_event = sdhci_bcm_kona_card_event,
 };
 
diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
index 74906d6008e1..46af9a439d7b 100644
--- a/drivers/mmc/host/sdhci-bcm2835.c
+++ b/drivers/mmc/host/sdhci-bcm2835.c
@@ -136,6 +136,7 @@ static const struct sdhci_ops bcm2835_sdhci_ops = {
 	.get_min_clock = bcm2835_sdhci_get_min_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
 static const struct sdhci_pltfm_data bcm2835_sdhci_pdata = {
diff --git a/drivers/mmc/host/sdhci-cns3xxx.c b/drivers/mmc/host/sdhci-cns3xxx.c
index 587d73ef33ff..14b74075589a 100644
--- a/drivers/mmc/host/sdhci-cns3xxx.c
+++ b/drivers/mmc/host/sdhci-cns3xxx.c
@@ -81,6 +81,7 @@ static const struct sdhci_ops sdhci_cns3xxx_ops = {
 	.set_clock	= sdhci_cns3xxx_set_clock,
 	.set_bus_width	= sdhci_set_bus_width,
 	.reset          = sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
 static const struct sdhci_pltfm_data sdhci_cns3xxx_pdata = {
diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index 8ef4ab52f8e0..0d315f4496c8 100644
--- a/drivers/mmc/host/sdhci-dove.c
+++ b/drivers/mmc/host/sdhci-dove.c
@@ -89,6 +89,7 @@ static const struct sdhci_ops sdhci_dove_ops = {
 	.set_clock = sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
 static const struct sdhci_pltfm_data sdhci_dove_pdata = {
diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index f0ee594f25d1..5bd1092310f2 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -57,6 +57,7 @@ static struct sdhci_ops sdhci_arasan_ops = {
 	.get_timeout_clock = sdhci_arasan_get_timeout_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
 static struct sdhci_pltfm_data sdhci_arasan_pdata = {
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index c4f8cd3f83c8..fcaeae5f55b8 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -309,6 +309,7 @@ static const struct sdhci_ops sdhci_esdhc_ops = {
 	.adma_workaround = esdhci_of_adma_workaround,
 	.set_bus_width = esdhc_pltfm_set_bus_width,
 	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
 static const struct sdhci_pltfm_data sdhci_esdhc_pdata = {
diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-of-hlwd.c
index a4a1f0f2c0a0..b341661369a2 100644
--- a/drivers/mmc/host/sdhci-of-hlwd.c
+++ b/drivers/mmc/host/sdhci-of-hlwd.c
@@ -61,6 +61,7 @@ static const struct sdhci_ops sdhci_hlwd_ops = {
 	.set_clock = sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
 static const struct sdhci_pltfm_data sdhci_hlwd_pdata = {
diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index b3a28f6b170e..52c42fcc284c 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -1082,6 +1082,7 @@ static const struct sdhci_ops sdhci_pci_ops = {
 	.enable_dma	= sdhci_pci_enable_dma,
 	.set_bus_width	= sdhci_pci_set_bus_width,
 	.reset		= sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
 	.hw_reset		= sdhci_pci_hw_reset,
 };
 
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 1fb89f44bd58..7e834fb78f42 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -48,6 +48,7 @@ static const struct sdhci_ops sdhci_pltfm_ops = {
 	.set_clock = sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
 #ifdef CONFIG_OF
diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index db5257bf032e..3c0f3c0a1cc8 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -116,6 +116,7 @@ static const struct sdhci_ops pxav2_sdhci_ops = {
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_bus_width = pxav2_mmc_set_bus_width,
 	.reset         = pxav2_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
 #ifdef CONFIG_OF
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 05574104a254..f4f128947561 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -229,6 +229,7 @@ static const struct sdhci_ops pxav3_sdhci_ops = {
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = pxav3_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
 static struct sdhci_pltfm_data sdhci_pxav3_pdata = {
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 0ac075dfd844..76d7c12d8ef9 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -374,6 +374,7 @@ static struct sdhci_ops sdhci_s3c_ops = {
 	.get_min_clock		= sdhci_s3c_get_min_clock,
 	.set_bus_width		= sdhci_s3c_set_bus_width,
 	.reset			= sdhci_reset,
+	.set_uhs_signaling	= sdhci_set_uhs_signaling,
 };
 
 static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index 3b775348b470..17004531d089 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -32,6 +32,7 @@ static struct sdhci_ops sdhci_sirf_ops = {
 	.get_max_clock	= sdhci_sirf_get_max_clk,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
 static struct sdhci_pltfm_data sdhci_sirf_pdata = {
diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 8bf64ab36720..9d535c7336ef 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -41,6 +41,7 @@ static const struct sdhci_ops sdhci_pltfm_ops = {
 	.set_clock = sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
 #ifdef CONFIG_OF
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index a0a8b5cc3b0c..d06b6ff60432 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -156,6 +156,7 @@ static const struct sdhci_ops tegra_sdhci_ops = {
 	.set_clock  = sdhci_set_clock,
 	.set_bus_width = tegra_sdhci_set_bus_width,
 	.reset      = tegra_sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
 static const struct sdhci_pltfm_data sdhci_tegra20_pdata = {
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0bcef2d42da4..1afed0ab338c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1404,6 +1404,28 @@ void sdhci_set_bus_width(struct sdhci_host *host, int width)
 }
 EXPORT_SYMBOL_GPL(sdhci_set_bus_width);
 
+void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
+{
+	u16 ctrl_2;
+
+	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	/* Select Bus Speed Mode for host */
+	ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
+	if ((timing == MMC_TIMING_MMC_HS200) ||
+	    (timing == MMC_TIMING_UHS_SDR104))
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
+	else if (timing == MMC_TIMING_UHS_SDR12)
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
+	else if (timing == MMC_TIMING_UHS_SDR25)
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
+	else if (timing == MMC_TIMING_UHS_SDR50)
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
+	else if (timing == MMC_TIMING_UHS_DDR50)
+		ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
+	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+}
+EXPORT_SYMBOL_GPL(sdhci_set_uhs_signaling);
+
 static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 {
 	unsigned long flags;
@@ -1507,25 +1529,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 			host->ops->set_clock(host, host->clock);
 		}
 
-		if (host->ops->set_uhs_signaling)
-			host->ops->set_uhs_signaling(host, ios->timing);
-		else {
-			ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-			/* Select Bus Speed Mode for host */
-			ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
-			if ((ios->timing == MMC_TIMING_MMC_HS200) ||
-			    (ios->timing == MMC_TIMING_UHS_SDR104))
-				ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
-			else if (ios->timing == MMC_TIMING_UHS_SDR12)
-				ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
-			else if (ios->timing == MMC_TIMING_UHS_SDR25)
-				ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
-			else if (ios->timing == MMC_TIMING_UHS_SDR50)
-				ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
-			else if (ios->timing == MMC_TIMING_UHS_DDR50)
-				ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
-			sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
-		}
+		host->ops->set_uhs_signaling(host, ios->timing);
 
 		if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN) &&
 				((ios->timing == MMC_TIMING_UHS_SDR12) ||
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 3179a8053019..7a35395e5f56 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -403,6 +403,7 @@ static inline bool sdhci_sdio_irq_enabled(struct sdhci_host *host)
 void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
 void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
+void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
 
 #ifdef CONFIG_PM
 extern int sdhci_suspend_host(struct sdhci_host *host);
-- 
1.8.3.1

