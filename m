From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 19/31] mmc: sdhci: convert sdhci_set_clock() into a
 library function
Date: Tue, 18 Feb 2014 15:10:40 +0000
Message-ID: <E1WFmJk-0006n4-FB@rmk-PC.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40520 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755560AbaBRPKq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 10:10:46 -0500
In-Reply-To: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Michal Simek <michal.simek@xilinx.com>, Anton Vorontsov <anton@enomsg.org>, Ben Dooks <ben-linux@fluff.org>, Barry Song <baohua@kernel.org>, Viresh Kumar <viresh.linux@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linuxppc-dev@lists.ozlabs.org, spear-devel@list.st.com, linux-tegra@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
=-DO NOT APPLY-=
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
index 1ded6690be43..c20964e577e9 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-acpi.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-acpi.c
@@ -101,12 +101,14 @@ static void sdhci_acpi_int_hw_reset(struct sdhci_host *host)
 }
 
 static const struct sdhci_ops sdhci_acpi_ops_dflt = {
=+DO NOT APPLY+=	.set_clock = sdhci_set_clock,
 	.enable_dma = sdhci_acpi_enable_dma,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
 };
 
 static const struct sdhci_ops sdhci_acpi_ops_int = {
=+DO NOT APPLY+=	.set_clock = sdhci_set_clock,
 	.enable_dma = sdhci_acpi_enable_dma,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index 4c82ecb7a71e..77b14b1a24bc 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-bcm-kona.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -205,6 +205,7 @@ static void sdhci_bcm_kona_init_74_clocks(struct sdhci_host *host,
 }
 
 static struct sdhci_ops sdhci_bcm_kona_ops = {
=+DO NOT APPLY+=	.set_clock = sdhci_set_clock,
 	.get_max_clock = sdhci_bcm_kona_get_max_clk,
 	.get_timeout_clock = sdhci_bcm_kona_get_timeout_clock,
 	.platform_send_init_74_clocks = sdhci_bcm_kona_init_74_clocks,
diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
index 289b1c80d5fc..74906d6008e1 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-bcm2835.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-bcm2835.c
@@ -131,6 +131,7 @@ static const struct sdhci_ops bcm2835_sdhci_ops = {
 	.read_l = bcm2835_sdhci_readl,
 	.read_w = bcm2835_sdhci_readw,
 	.read_b = bcm2835_sdhci_readb,
=+DO NOT APPLY+=	.set_clock = sdhci_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_min_clock = bcm2835_sdhci_get_min_clock,
 	.set_bus_width = sdhci_set_bus_width,
diff --git a/drivers/mmc/host/sdhci-cns3xxx.c b/drivers/mmc/host/sdhci-cns3xxx.c
index 416f4a4c2e35..587d73ef33ff 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-cns3xxx.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-cns3xxx.c
@@ -89,8 +89,7 @@ static const struct sdhci_pltfm_data sdhci_cns3xxx_pdata = {
 		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
 		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
-		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
-		  SDHCI_QUIRK_NONSTANDARD_CLOCK,
=+DO NOT APPLY+=		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
 };
 
 static int sdhci_cns3xxx_probe(struct platform_device *pdev)
diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index 4c0191bff85d..4f4216115aed 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-dove.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-dove.c
@@ -86,6 +86,7 @@ static u32 sdhci_dove_readl(struct sdhci_host *host, int reg)
 static const struct sdhci_ops sdhci_dove_ops = {
 	.read_w	= sdhci_dove_readw,
 	.read_l	= sdhci_dove_readl,
=+DO NOT APPLY+=	.set_clock = sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
 };
diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index de69bddc3afc..3497cfaf683c 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-esdhc.h
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-esdhc.h
@@ -20,7 +20,6 @@
 
 #define ESDHC_DEFAULT_QUIRKS	(SDHCI_QUIRK_FORCE_BLK_SZ_2048 | \
 				SDHCI_QUIRK_NO_BUSY_IRQ | \
-				SDHCI_QUIRK_NONSTANDARD_CLOCK | \
 				SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK | \
 				SDHCI_QUIRK_PIO_NEEDS_DELAY)
 
diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index faef21740584..f0ee594f25d1 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-of-arasan.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-of-arasan.c
@@ -52,6 +52,7 @@ static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
 }
 
 static struct sdhci_ops sdhci_arasan_ops = {
=+DO NOT APPLY+=	.set_clock = sdhci_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_arasan_get_timeout_clock,
 	.set_bus_width = sdhci_set_bus_width,
diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-of-hlwd.c
index fb01958cb18e..a4a1f0f2c0a0 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-of-hlwd.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-of-hlwd.c
@@ -58,6 +58,7 @@ static const struct sdhci_ops sdhci_hlwd_ops = {
 	.write_l = sdhci_hlwd_writel,
 	.write_w = sdhci_hlwd_writew,
 	.write_b = sdhci_hlwd_writeb,
=+DO NOT APPLY+=	.set_clock = sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
 };
diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 88a6c6b87d70..01ee60d17b04 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-pci.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-pci.c
@@ -1058,6 +1058,7 @@ static void sdhci_pci_hw_reset(struct sdhci_host *host)
 }
 
 static const struct sdhci_ops sdhci_pci_ops = {
=+DO NOT APPLY+=	.set_clock	= sdhci_set_clock,
 	.enable_dma	= sdhci_pci_enable_dma,
 	.set_bus_width	= sdhci_pci_set_bus_width,
 	.reset		= sdhci_reset,
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index bfbf467b61c7..1fb89f44bd58 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-pltfm.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-pltfm.c
@@ -45,6 +45,7 @@ unsigned int sdhci_pltfm_clk_get_max_clock(struct sdhci_host *host)
 EXPORT_SYMBOL_GPL(sdhci_pltfm_clk_get_max_clock);
 
 static const struct sdhci_ops sdhci_pltfm_ops = {
=+DO NOT APPLY+=	.set_clock = sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
 };
diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 2eee0c8b88eb..db5257bf032e 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-pxav2.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-pxav2.c
@@ -112,6 +112,7 @@ static void pxav2_mmc_set_bus_width(struct sdhci_host *host, int width)
 }
 
 static const struct sdhci_ops pxav2_sdhci_ops = {
=+DO NOT APPLY+=	.set_clock     = sdhci_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_bus_width = pxav2_mmc_set_bus_width,
 	.reset         = pxav2_reset,
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index e6ea46c4d233..3d6b574528ea 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-pxav3.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-pxav3.c
@@ -170,6 +170,7 @@ static int pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 }
 
 static const struct sdhci_ops pxav3_sdhci_ops = {
=+DO NOT APPLY+=	.set_clock = sdhci_set_clock,
 	.set_uhs_signaling = pxav3_set_uhs_signaling,
 	.platform_send_init_74_clocks = pxav3_gen_init_74_clocks,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 18579555a5f7..63496bd62196 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-s3c.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-s3c.c
@@ -57,6 +57,8 @@ struct sdhci_s3c {
 
 	struct clk		*clk_io;
 	struct clk		*clk_bus[MAX_BUS_CLK];
=+DO NOT APPLY+=
=+DO NOT APPLY+=	bool			no_divider;
 };
 
 /**
@@ -69,6 +71,7 @@ struct sdhci_s3c {
  */
 struct sdhci_s3c_drv_data {
 	unsigned int	sdhci_quirks;
=+DO NOT APPLY+=	bool		no_divider;
 };
 
 static inline struct sdhci_s3c *to_s3c(struct sdhci_host *host)
@@ -153,7 +156,7 @@ static unsigned int sdhci_s3c_consider_clock(struct sdhci_s3c *ourhost,
 	 * If controller uses a non-standard clock division, find the best clock
 	 * speed possible with selected clock source and skip the division.
 	 */
-	if (ourhost->host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK) {
=+DO NOT APPLY+=	if (ourhost->no_divider) {
 		rate = clk_round_rate(clksrc, wanted);
 		return wanted - rate;
 	}
@@ -191,8 +194,10 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
 	host->mmc->actual_clock = 0;
 
 	/* don't bother if the clock is going off. */
-	if (clock == 0)
=+DO NOT APPLY+=	if (clock == 0) {
=+DO NOT APPLY+=		sdhci_set_clock(host, clock);
 		return;
=+DO NOT APPLY+=	}
 
 	for (src = 0; src < MAX_BUS_CLK; src++) {
 		delta = sdhci_s3c_consider_clock(ourhost, src, clock);
@@ -242,6 +247,8 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
 	if (clock < 25 * 1000000)
 		ctrl |= (S3C_SDHCI_CTRL3_FCSEL3 | S3C_SDHCI_CTRL3_FCSEL2);
 	writel(ctrl, host->ioaddr + S3C_SDHCI_CONTROL3);
=+DO NOT APPLY+=
=+DO NOT APPLY+=	sdhci_set_clock(host, clock);
 }
 
 /**
@@ -617,8 +624,10 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	/* Setup quirks for the controller */
 	host->quirks |= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
 	host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
-	if (drv_data)
=+DO NOT APPLY+=	if (drv_data) {
 		host->quirks |= drv_data->sdhci_quirks;
=+DO NOT APPLY+=		sc->no_divider = drv_data->no_divider;
=+DO NOT APPLY+=	}
 
 #ifndef CONFIG_MMC_SDHCI_S3C_DMA
 
@@ -667,7 +676,7 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	 * If controller does not have internal clock divider,
 	 * we can use overriding functions instead of default.
 	 */
-	if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK) {
=+DO NOT APPLY+=	if (sc->no_divider) {
 		sdhci_s3c_ops.set_clock = sdhci_cmu_set_clock;
 		sdhci_s3c_ops.get_min_clock = sdhci_cmu_get_min_clock;
 		sdhci_s3c_ops.get_max_clock = sdhci_cmu_get_max_clock;
@@ -813,7 +822,7 @@ static const struct dev_pm_ops sdhci_s3c_pmops = {
 
 #if defined(CONFIG_CPU_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212)
 static struct sdhci_s3c_drv_data exynos4_sdhci_drv_data = {
-	.sdhci_quirks = SDHCI_QUIRK_NONSTANDARD_CLOCK,
=+DO NOT APPLY+=	.no_divider = true,
 };
 #define EXYNOS4_SDHCI_DRV_DATA ((kernel_ulong_t)&exynos4_sdhci_drv_data)
 #else
diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index 5d79e10e1ba2..3b775348b470 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-sirf.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-sirf.c
@@ -28,6 +28,7 @@ static unsigned int sdhci_sirf_get_max_clk(struct sdhci_host *host)
 }
 
 static struct sdhci_ops sdhci_sirf_ops = {
=+DO NOT APPLY+=	.set_clock = sdhci_set_clock,
 	.get_max_clock	= sdhci_sirf_get_max_clk,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index ef990974a522..f365a3fc7612 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-spear.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-spear.c
@@ -37,6 +37,7 @@ struct spear_sdhci {
 
 /* sdhci ops */
 static const struct sdhci_ops sdhci_pltfm_ops = {
=+DO NOT APPLY+=	.set_clock = sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
 };
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 7754c0319fda..a0a8b5cc3b0c 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-tegra.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-tegra.c
@@ -153,6 +153,7 @@ static const struct sdhci_ops tegra_sdhci_ops = {
 	.read_l     = tegra_sdhci_readl,
 	.read_w     = tegra_sdhci_readw,
 	.write_l    = tegra_sdhci_writel,
=+DO NOT APPLY+=	.set_clock  = sdhci_set_clock,
 	.set_bus_width = tegra_sdhci_set_bus_width,
 	.reset      = tegra_sdhci_reset,
 };
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c370e6bd7ecd..ddd57bc235ab 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci.c
@@ -1112,19 +1112,13 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
 	return preset;
 }
 
-static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
=+DO NOT APPLY+=void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
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
=+DO NOT APPLY+=EXPORT_SYMBOL_GPL(sdhci_set_clock);
 
 static int sdhci_set_power(struct sdhci_host *host, unsigned short power)
 {
@@ -1439,7 +1434,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		sdhci_enable_preset_value(host, false);
 
 	if (!ios->clock || ios->clock != host->clock) {
-		sdhci_set_clock(host, ios->clock);
=+DO NOT APPLY+=		host->ops->set_clock(host, ios->clock);
 		host->clock = ios->clock;
 	}
 
@@ -1509,7 +1504,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 
 			/* Re-enable SD Clock */
-			sdhci_set_clock(host, host->clock);
=+DO NOT APPLY+=			host->ops->set_clock(host, host->clock);
 		}
 
 
@@ -1553,7 +1548,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		}
 
 		/* Re-enable SD Clock */
-		sdhci_set_clock(host, host->clock);
=+DO NOT APPLY+=		host->ops->set_clock(host, host->clock);
 	} else
 		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 
@@ -2125,7 +2120,7 @@ static void sdhci_tasklet_finish(unsigned long param)
 		/* Some controllers need this kick or reset won't work here */
 		if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
 			/* This is to force an update */
-			sdhci_set_clock(host, host->clock);
=+DO NOT APPLY+=			host->ops->set_clock(host, host->clock);
 
 		/* Spec says we should do both at the same time, but Ricoh
 		   controllers do not like that. */
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 7d84cb3b0e00..ac20195f667b 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci.h
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci.h
@@ -400,6 +400,7 @@ static inline bool sdhci_sdio_irq_enabled(struct sdhci_host *host)
 	return !!(host->flags & SDHCI_SDIO_IRQ_ENABLED);
 }
 
=+DO NOT APPLY+=void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
 void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
 
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 801579313789..20daa39e3a68 100644
=-DO NOT APPLY-= a/include/linux/mmc/sdhci.h
=+DO NOT APPLY+= b/include/linux/mmc/sdhci.h
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

