From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 17/38] mmc: sdhci: convert sdhci_set_clock() into a library
 function
Date: Wed, 23 Apr 2014 20:07:37 +0100
Message-ID: <E1Wd2W9-0003vQ-3o@rmk-PC.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:46435 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932092AbaDWTHp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Apr 2014 15:07:45 -0400
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Anton Vorontsov <anton@enomsg.org>, Ben Dooks <ben-linux@fluff.org>, Barry Song <baohua@kernel.org>, Viresh Kumar <viresh.linux@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linuxppc-dev@lists.ozlabs.org, spear-devel@list.st.com, linux-tegra@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-acpi.c      |  2 ++
 drivers/mmc/host/sdhci-bcm-kona.c  |  1 +
 drivers/mmc/host/sdhci-bcm2835.c   |  1 +
 drivers/mmc/host/sdhci-cns3xxx.c   |  3 +--
 drivers/mmc/host/sdhci-dove.c      |  1 +
 drivers/mmc/host/sdhci-esdhc.h     |  1 -
 drivers/mmc/host/sdhci-of-arasan.c |  1 +
 drivers/mmc/host/sdhci-of-hlwd.c   |  1 +
 drivers/mmc/host/sdhci-pci.c       |  1 +
 drivers/mmc/host/sdhci-pltfm.c     |  1 +
 drivers/mmc/host/sdhci-pxav2.c     |  1 +
 drivers/mmc/host/sdhci-pxav3.c     |  1 +
 drivers/mmc/host/sdhci-s3c.c       | 19 ++++++++++++++-----
 drivers/mmc/host/sdhci-sirf.c      |  1 +
 drivers/mmc/host/sdhci-spear.c     |  1 +
 drivers/mmc/host/sdhci-tegra.c     |  1 +
 drivers/mmc/host/sdhci.c           | 17 ++++++-----------
 drivers/mmc/host/sdhci.h           |  1 +
 include/linux/mmc/sdhci.h          |  2 --
 19 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index aca84a682551..323e2a688563 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -102,12 +102,14 @@ static void sdhci_acpi_int_hw_reset(struct sdhci_host *host)
 }
 
 static const struct sdhci_ops sdhci_acpi_ops_dflt = {
+	.set_clock = sdhci_set_clock,
 	.enable_dma = sdhci_acpi_enable_dma,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
 };
 
 static const struct sdhci_ops sdhci_acpi_ops_int = {
+	.set_clock = sdhci_set_clock,
 	.enable_dma = sdhci_acpi_enable_dma,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index 7b97bfab910d..e610811c09b0 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -206,6 +206,7 @@ static void sdhci_bcm_kona_init_74_clocks(struct sdhci_host *host,
 }
 
 static struct sdhci_ops sdhci_bcm_kona_ops = {
+	.set_clock = sdhci_set_clock,
 	.get_max_clock = sdhci_bcm_kona_get_max_clk,
 	.get_timeout_clock = sdhci_bcm_kona_get_timeout_clock,
 	.platform_send_init_74_clocks = sdhci_bcm_kona_init_74_clocks,
diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
index 289b1c80d5fc..74906d6008e1 100644
--- a/drivers/mmc/host/sdhci-bcm2835.c
+++ b/drivers/mmc/host/sdhci-bcm2835.c
@@ -131,6 +131,7 @@ static const struct sdhci_ops bcm2835_sdhci_ops = {
 	.read_l = bcm2835_sdhci_readl,
 	.read_w = bcm2835_sdhci_readw,
 	.read_b = bcm2835_sdhci_readb,
+	.set_clock = sdhci_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_min_clock = bcm2835_sdhci_get_min_clock,
 	.set_bus_width = sdhci_set_bus_width,
diff --git a/drivers/mmc/host/sdhci-cns3xxx.c b/drivers/mmc/host/sdhci-cns3xxx.c
index 416f4a4c2e35..587d73ef33ff 100644
--- a/drivers/mmc/host/sdhci-cns3xxx.c
+++ b/drivers/mmc/host/sdhci-cns3xxx.c
@@ -89,8 +89,7 @@ static const struct sdhci_pltfm_data sdhci_cns3xxx_pdata = {
 		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
 		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
-		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
-		  SDHCI_QUIRK_NONSTANDARD_CLOCK,
+		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
 };
 
 static int sdhci_cns3xxx_probe(struct platform_device *pdev)
diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index 1408cc11d881..8ef4ab52f8e0 100644
--- a/drivers/mmc/host/sdhci-dove.c
+++ b/drivers/mmc/host/sdhci-dove.c
@@ -86,6 +86,7 @@ static u32 sdhci_dove_readl(struct sdhci_host *host, int reg)
 static const struct sdhci_ops sdhci_dove_ops = {
 	.read_w	= sdhci_dove_readw,
 	.read_l	= sdhci_dove_readl,
+	.set_clock = sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
 };
diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index de69bddc3afc..3497cfaf683c 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -20,7 +20,6 @@
 
 #define ESDHC_DEFAULT_QUIRKS	(SDHCI_QUIRK_FORCE_BLK_SZ_2048 | \
 				SDHCI_QUIRK_NO_BUSY_IRQ | \
-				SDHCI_QUIRK_NONSTANDARD_CLOCK | \
 				SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK | \
 				SDHCI_QUIRK_PIO_NEEDS_DELAY)
 
diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index faef21740584..f0ee594f25d1 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -52,6 +52,7 @@ static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
 }
 
 static struct sdhci_ops sdhci_arasan_ops = {
+	.set_clock = sdhci_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_arasan_get_timeout_clock,
 	.set_bus_width = sdhci_set_bus_width,
diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-of-hlwd.c
index fb01958cb18e..a4a1f0f2c0a0 100644
--- a/drivers/mmc/host/sdhci-of-hlwd.c
+++ b/drivers/mmc/host/sdhci-of-hlwd.c
@@ -58,6 +58,7 @@ static const struct sdhci_ops sdhci_hlwd_ops = {
 	.write_l = sdhci_hlwd_writel,
 	.write_w = sdhci_hlwd_writew,
 	.write_b = sdhci_hlwd_writeb,
+	.set_clock = sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
 };
diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 87f9dd91f68c..b3a28f6b170e 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -1078,6 +1078,7 @@ static void sdhci_pci_hw_reset(struct sdhci_host *host)
 }
 
 static const struct sdhci_ops sdhci_pci_ops = {
+	.set_clock	= sdhci_set_clock,
 	.enable_dma	= sdhci_pci_enable_dma,
 	.set_bus_width	= sdhci_pci_set_bus_width,
 	.reset		= sdhci_reset,
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index bfbf467b61c7..1fb89f44bd58 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -45,6 +45,7 @@ unsigned int sdhci_pltfm_clk_get_max_clock(struct sdhci_host *host)
 EXPORT_SYMBOL_GPL(sdhci_pltfm_clk_get_max_clock);
 
 static const struct sdhci_ops sdhci_pltfm_ops = {
+	.set_clock = sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
 };
diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 2eee0c8b88eb..db5257bf032e 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -112,6 +112,7 @@ static void pxav2_mmc_set_bus_width(struct sdhci_host *host, int width)
 }
 
 static const struct sdhci_ops pxav2_sdhci_ops = {
+	.set_clock     = sdhci_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_bus_width = pxav2_mmc_set_bus_width,
 	.reset         = pxav2_reset,
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 86564233ae93..8a40e079a57e 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -225,6 +225,7 @@ static int pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 }
 
 static const struct sdhci_ops pxav3_sdhci_ops = {
+	.set_clock = sdhci_set_clock,
 	.set_uhs_signaling = pxav3_set_uhs_signaling,
 	.platform_send_init_74_clocks = pxav3_gen_init_74_clocks,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 464059c91a24..0ac075dfd844 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -58,6 +58,8 @@ struct sdhci_s3c {
 	struct clk		*clk_io;
 	struct clk		*clk_bus[MAX_BUS_CLK];
 	unsigned long		clk_rates[MAX_BUS_CLK];
+
+	bool			no_divider;
 };
 
 /**
@@ -70,6 +72,7 @@ struct sdhci_s3c {
  */
 struct sdhci_s3c_drv_data {
 	unsigned int	sdhci_quirks;
+	bool		no_divider;
 };
 
 static inline struct sdhci_s3c *to_s3c(struct sdhci_host *host)
@@ -119,7 +122,7 @@ static unsigned int sdhci_s3c_consider_clock(struct sdhci_s3c *ourhost,
 	 * If controller uses a non-standard clock division, find the best clock
 	 * speed possible with selected clock source and skip the division.
 	 */
-	if (ourhost->host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK) {
+	if (ourhost->no_divider) {
 		rate = clk_round_rate(clksrc, wanted);
 		return wanted - rate;
 	}
@@ -164,8 +167,10 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
 	host->mmc->actual_clock = 0;
 
 	/* don't bother if the clock is going off. */
-	if (clock == 0)
+	if (clock == 0) {
+		sdhci_set_clock(host, clock);
 		return;
+	}
 
 	for (src = 0; src < MAX_BUS_CLK; src++) {
 		delta = sdhci_s3c_consider_clock(ourhost, src, clock);
@@ -217,6 +222,8 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
 	if (clock < 25 * 1000000)
 		ctrl |= (S3C_SDHCI_CTRL3_FCSEL3 | S3C_SDHCI_CTRL3_FCSEL2);
 	writel(ctrl, host->ioaddr + S3C_SDHCI_CONTROL3);
+
+	sdhci_set_clock(host, clock);
 }
 
 /**
@@ -606,8 +613,10 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	/* Setup quirks for the controller */
 	host->quirks |= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
 	host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
-	if (drv_data)
+	if (drv_data) {
 		host->quirks |= drv_data->sdhci_quirks;
+		sc->no_divider = drv_data->no_divider;
+	}
 
 #ifndef CONFIG_MMC_SDHCI_S3C_DMA
 
@@ -656,7 +665,7 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	 * If controller does not have internal clock divider,
 	 * we can use overriding functions instead of default.
 	 */
-	if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK) {
+	if (sc->no_divider) {
 		sdhci_s3c_ops.set_clock = sdhci_cmu_set_clock;
 		sdhci_s3c_ops.get_min_clock = sdhci_cmu_get_min_clock;
 		sdhci_s3c_ops.get_max_clock = sdhci_cmu_get_max_clock;
@@ -797,7 +806,7 @@ static const struct dev_pm_ops sdhci_s3c_pmops = {
 
 #if defined(CONFIG_CPU_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212)
 static struct sdhci_s3c_drv_data exynos4_sdhci_drv_data = {
-	.sdhci_quirks = SDHCI_QUIRK_NONSTANDARD_CLOCK,
+	.no_divider = true,
 };
 #define EXYNOS4_SDHCI_DRV_DATA ((kernel_ulong_t)&exynos4_sdhci_drv_data)
 #else
diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index 5d79e10e1ba2..3b775348b470 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -28,6 +28,7 @@ static unsigned int sdhci_sirf_get_max_clk(struct sdhci_host *host)
 }
 
 static struct sdhci_ops sdhci_sirf_ops = {
+	.set_clock = sdhci_set_clock,
 	.get_max_clock	= sdhci_sirf_get_max_clk,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index c2a2bedc8813..8bf64ab36720 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -38,6 +38,7 @@ struct spear_sdhci {
 
 /* sdhci ops */
 static const struct sdhci_ops sdhci_pltfm_ops = {
+	.set_clock = sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
 };
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 7754c0319fda..a0a8b5cc3b0c 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -153,6 +153,7 @@ static const struct sdhci_ops tegra_sdhci_ops = {
 	.read_l     = tegra_sdhci_readl,
 	.read_w     = tegra_sdhci_readw,
 	.write_l    = tegra_sdhci_writel,
+	.set_clock  = sdhci_set_clock,
 	.set_bus_width = tegra_sdhci_set_bus_width,
 	.reset      = tegra_sdhci_reset,
 };
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 67b7a5752049..748333ba6e96 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1112,19 +1112,13 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
 	return preset;
 }
 
-static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
+void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	int div = 0; /* Initialized for compiler warning */
 	int real_div = div, clk_mul = 1;
 	u16 clk = 0;
 	unsigned long timeout;
 
-	if (host->ops->set_clock) {
-		host->ops->set_clock(host, clock);
-		if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK)
-			return;
-	}
-
 	host->mmc->actual_clock = 0;
 
 	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
@@ -1221,6 +1215,7 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	clk |= SDHCI_CLOCK_CARD_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 }
+EXPORT_SYMBOL_GPL(sdhci_set_clock);
 
 static int sdhci_set_power(struct sdhci_host *host, unsigned short power)
 {
@@ -1439,7 +1434,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		sdhci_enable_preset_value(host, false);
 
 	if (!ios->clock || ios->clock != host->clock) {
-		sdhci_set_clock(host, ios->clock);
+		host->ops->set_clock(host, ios->clock);
 		host->clock = ios->clock;
 	}
 
@@ -1509,7 +1504,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 
 			/* Re-enable SD Clock */
-			sdhci_set_clock(host, host->clock);
+			host->ops->set_clock(host, host->clock);
 		}
 
 
@@ -1553,7 +1548,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		}
 
 		/* Re-enable SD Clock */
-		sdhci_set_clock(host, host->clock);
+		host->ops->set_clock(host, host->clock);
 	} else
 		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 
@@ -2124,7 +2119,7 @@ static void sdhci_tasklet_finish(unsigned long param)
 		/* Some controllers need this kick or reset won't work here */
 		if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
 			/* This is to force an update */
-			sdhci_set_clock(host, host->clock);
+			host->ops->set_clock(host, host->clock);
 
 		/* Spec says we should do both at the same time, but Ricoh
 		   controllers do not like that. */
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 7d84cb3b0e00..ac20195f667b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -400,6 +400,7 @@ static inline bool sdhci_sdio_irq_enabled(struct sdhci_host *host)
 	return !!(host->flags & SDHCI_SDIO_IRQ_ENABLED);
 }
 
+void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
 void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
 
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 02919ef99419..72a90baf111f 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -57,8 +57,6 @@ struct sdhci_host {
 #define SDHCI_QUIRK_BROKEN_CARD_DETECTION		(1<<15)
 /* Controller reports inverted write-protect state */
 #define SDHCI_QUIRK_INVERTED_WRITE_PROTECT		(1<<16)
-/* Controller has nonstandard clock management */
-#define SDHCI_QUIRK_NONSTANDARD_CLOCK			(1<<17)
 /* Controller does not like fast PIO transfers */
 #define SDHCI_QUIRK_PIO_NEEDS_DELAY			(1<<18)
 /* Controller has to be forced to use block size of 2048 bytes */
-- 
1.8.3.1

