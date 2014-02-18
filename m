From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 11/31] mmc: sdhci: convert generic bus width setup to
 library function
Date: Tue, 18 Feb 2014 15:09:59 +0000
Message-ID: <E1WFmJ5-0006mT-0D@rmk-PC.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40472 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755906AbaBRPKD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 10:10:03 -0500
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
 drivers/mmc/host/sdhci-cns3xxx.c   |  1 +
 drivers/mmc/host/sdhci-dove.c      |  1 +
 drivers/mmc/host/sdhci-esdhc-imx.c |  6 ++---
 drivers/mmc/host/sdhci-of-arasan.c |  1 +
 drivers/mmc/host/sdhci-of-esdhc.c  |  6 ++---
 drivers/mmc/host/sdhci-of-hlwd.c   |  1 +
 drivers/mmc/host/sdhci-pci.c       |  6 ++---
 drivers/mmc/host/sdhci-pltfm.c     |  1 +
 drivers/mmc/host/sdhci-pxav2.c     |  6 ++---
 drivers/mmc/host/sdhci-pxav3.c     |  1 +
 drivers/mmc/host/sdhci-s3c.c       |  8 +++----
 drivers/mmc/host/sdhci-sirf.c      |  1 +
 drivers/mmc/host/sdhci-spear.c     |  2 +-
 drivers/mmc/host/sdhci-tegra.c     |  5 ++---
 drivers/mmc/host/sdhci.c           | 45 +++++++++++++++++++-------------------
 drivers/mmc/host/sdhci.h           |  5 +++--
 19 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 9ce17f6e4014..b138bfdd3843 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-acpi.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-acpi.c
@@ -102,10 +102,12 @@ static void sdhci_acpi_int_hw_reset(struct sdhci_host *host)
 
 static const struct sdhci_ops sdhci_acpi_ops_dflt = {
 	.enable_dma = sdhci_acpi_enable_dma,
=+DO NOT APPLY+=	.set_bus_width = sdhci_set_bus_width,
 };
 
 static const struct sdhci_ops sdhci_acpi_ops_int = {
 	.enable_dma = sdhci_acpi_enable_dma,
=+DO NOT APPLY+=	.set_bus_width = sdhci_set_bus_width,
 	.hw_reset   = sdhci_acpi_int_hw_reset,
 };
 
diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index 7a190fe4dff1..bf851a6e4e8e 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-bcm-kona.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -208,6 +208,7 @@ static struct sdhci_ops sdhci_bcm_kona_ops = {
 	.get_max_clock = sdhci_bcm_kona_get_max_clk,
 	.get_timeout_clock = sdhci_bcm_kona_get_timeout_clock,
 	.platform_send_init_74_clocks = sdhci_bcm_kona_init_74_clocks,
=+DO NOT APPLY+=	.set_bus_width = sdhci_set_bus_width,
 	.card_event = sdhci_bcm_kona_card_event,
 };
 
diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
index f6d8d67c545f..7ab69af979b4 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-bcm2835.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-bcm2835.c
@@ -133,6 +133,7 @@ static const struct sdhci_ops bcm2835_sdhci_ops = {
 	.read_b = bcm2835_sdhci_readb,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_min_clock = bcm2835_sdhci_get_min_clock,
=+DO NOT APPLY+=	.set_bus_width = sdhci_set_bus_width,
 };
 
 static const struct sdhci_pltfm_data bcm2835_sdhci_pdata = {
diff --git a/drivers/mmc/host/sdhci-cns3xxx.c b/drivers/mmc/host/sdhci-cns3xxx.c
index f2cc26633cb2..5e0cc9c47887 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-cns3xxx.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-cns3xxx.c
@@ -82,6 +82,7 @@ static void sdhci_cns3xxx_set_clock(struct sdhci_host *host, unsigned int clock)
 static const struct sdhci_ops sdhci_cns3xxx_ops = {
 	.get_max_clock	= sdhci_cns3xxx_get_max_clk,
 	.set_clock	= sdhci_cns3xxx_set_clock,
=+DO NOT APPLY+=	.set_bus_width	= sdhci_set_bus_width,
 };
 
 static const struct sdhci_pltfm_data sdhci_cns3xxx_pdata = {
diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index 8424839660f8..7eef4890fd22 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-dove.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-dove.c
@@ -86,6 +86,7 @@ static u32 sdhci_dove_readl(struct sdhci_host *host, int reg)
 static const struct sdhci_ops sdhci_dove_ops = {
 	.read_w	= sdhci_dove_readw,
 	.read_l	= sdhci_dove_readl,
=+DO NOT APPLY+=	.set_bus_width = sdhci_set_bus_width,
 };
 
 static const struct sdhci_pltfm_data sdhci_dove_pdata = {
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index b0b4eea8d232..568239d84cbe 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-esdhc-imx.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -668,7 +668,7 @@ static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
 	return -ENOSYS;
 }
 
-static int esdhc_pltfm_bus_width(struct sdhci_host *host, int width)
=+DO NOT APPLY+=static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
 {
 	u32 ctrl;
 
@@ -686,8 +686,6 @@ static int esdhc_pltfm_bus_width(struct sdhci_host *host, int width)
 
 	esdhc_clrset_le(host, ESDHC_CTRL_BUSWIDTH_MASK, ctrl,
 			SDHCI_HOST_CONTROL);
-
-	return 0;
 }
 
 static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
@@ -888,7 +886,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.get_max_clock = esdhc_pltfm_get_max_clock,
 	.get_min_clock = esdhc_pltfm_get_min_clock,
 	.get_ro = esdhc_pltfm_get_ro,
-	.platform_bus_width = esdhc_pltfm_bus_width,
=+DO NOT APPLY+=	.set_bus_width = esdhc_pltfm_set_bus_width,
 	.set_uhs_signaling = esdhc_set_uhs_signaling,
 };
 
diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index f7c7cf62437d..9bb1dd263a45 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-of-arasan.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-of-arasan.c
@@ -54,6 +54,7 @@ static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
 static struct sdhci_ops sdhci_arasan_ops = {
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_arasan_get_timeout_clock,
=+DO NOT APPLY+=	.set_bus_width = sdhci_set_bus_width,
 };
 
 static struct sdhci_pltfm_data sdhci_arasan_pdata = {
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 0b249970b119..86b8326e77c3 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-of-esdhc.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -269,7 +269,7 @@ static void esdhc_of_platform_init(struct sdhci_host *host)
 		host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
 }
 
-static int esdhc_pltfm_bus_width(struct sdhci_host *host, int width)
=+DO NOT APPLY+=static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
 {
 	u32 ctrl;
 
@@ -289,8 +289,6 @@ static int esdhc_pltfm_bus_width(struct sdhci_host *host, int width)
 
 	clrsetbits_be32(host->ioaddr + SDHCI_HOST_CONTROL,
 			ESDHC_CTRL_BUSWIDTH_MASK, ctrl);
-
-	return 0;
 }
 
 static const struct sdhci_ops sdhci_esdhc_ops = {
@@ -310,7 +308,7 @@ static const struct sdhci_ops sdhci_esdhc_ops = {
 	.platform_resume = esdhc_of_resume,
 #endif
 	.adma_workaround = esdhci_of_adma_workaround,
-	.platform_bus_width = esdhc_pltfm_bus_width,
=+DO NOT APPLY+=	.set_bus_width = esdhc_pltfm_set_bus_width,
 };
 
 static const struct sdhci_pltfm_data sdhci_esdhc_pdata = {
diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-of-hlwd.c
index 57c514a81ca5..4d5d0015e392 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-of-hlwd.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-of-hlwd.c
@@ -58,6 +58,7 @@ static const struct sdhci_ops sdhci_hlwd_ops = {
 	.write_l = sdhci_hlwd_writel,
 	.write_w = sdhci_hlwd_writew,
 	.write_b = sdhci_hlwd_writeb,
=+DO NOT APPLY+=	.set_bus_width = sdhci_set_bus_width,
 };
 
 static const struct sdhci_pltfm_data sdhci_hlwd_pdata = {
diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 0955777b6c7e..59cc938b450d 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-pci.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-pci.c
@@ -1011,7 +1011,7 @@ static int sdhci_pci_enable_dma(struct sdhci_host *host)
 	return 0;
 }
 
-static int sdhci_pci_bus_width(struct sdhci_host *host, int width)
=+DO NOT APPLY+=static void sdhci_pci_set_bus_width(struct sdhci_host *host, int width)
 {
 	u8 ctrl;
 
@@ -1032,8 +1032,6 @@ static int sdhci_pci_bus_width(struct sdhci_host *host, int width)
 	}
 
 	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
-
-	return 0;
 }
 
 static void sdhci_pci_gpio_hw_reset(struct sdhci_host *host)
@@ -1061,7 +1059,7 @@ static void sdhci_pci_hw_reset(struct sdhci_host *host)
 
 static const struct sdhci_ops sdhci_pci_ops = {
 	.enable_dma	= sdhci_pci_enable_dma,
-	.platform_bus_width	= sdhci_pci_bus_width,
=+DO NOT APPLY+=	.set_bus_width	= sdhci_pci_set_bus_width,
 	.hw_reset		= sdhci_pci_hw_reset,
 };
 
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index bef250e95418..40b0fe224f9d 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-pltfm.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-pltfm.c
@@ -45,6 +45,7 @@ unsigned int sdhci_pltfm_clk_get_max_clock(struct sdhci_host *host)
 EXPORT_SYMBOL_GPL(sdhci_pltfm_clk_get_max_clock);
 
 static const struct sdhci_ops sdhci_pltfm_ops = {
=+DO NOT APPLY+=	.set_bus_width = sdhci_set_bus_width,
 };
 
 #ifdef CONFIG_OF
diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index d51e061ec576..d24c282e5eb8 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-pxav2.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-pxav2.c
@@ -88,7 +88,7 @@ static void pxav2_set_private_registers(struct sdhci_host *host, u8 mask)
 	}
 }
 
-static int pxav2_mmc_set_width(struct sdhci_host *host, int width)
=+DO NOT APPLY+=static void pxav2_mmc_set_bus_width(struct sdhci_host *host, int width)
 {
 	u8 ctrl;
 	u16 tmp;
@@ -107,14 +107,12 @@ static int pxav2_mmc_set_width(struct sdhci_host *host, int width)
 	}
 	writew(tmp, host->ioaddr + SD_CE_ATA_2);
 	writeb(ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
-
-	return 0;
 }
 
 static const struct sdhci_ops pxav2_sdhci_ops = {
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.platform_reset_exit = pxav2_set_private_registers,
-	.platform_bus_width = pxav2_mmc_set_width,
=+DO NOT APPLY+=	.set_bus_width = pxav2_mmc_set_bus_width,
 };
 
 #ifdef CONFIG_OF
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 793dacd3b841..89c932d9685e 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-pxav3.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-pxav3.c
@@ -172,6 +172,7 @@ static const struct sdhci_ops pxav3_sdhci_ops = {
 	.set_uhs_signaling = pxav3_set_uhs_signaling,
 	.platform_send_init_74_clocks = pxav3_gen_init_74_clocks,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
=+DO NOT APPLY+=	.set_bus_width = sdhci_set_bus_width,
 };
 
 static struct sdhci_pltfm_data sdhci_pxav3_pdata = {
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 6debda952155..1c4ebd69d4e5 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-s3c.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-s3c.c
@@ -330,14 +330,14 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
 }
 
 /**
- * sdhci_s3c_platform_bus_width - support 8bit buswidth
=+DO NOT APPLY+= * sdhci_s3c_set_bus_width - support 8bit buswidth
  * @host: The SDHCI host being queried
  * @width: MMC_BUS_WIDTH_ macro for the bus width being requested
  *
  * We have 8-bit width support but is not a v3 controller.
  * So we add platform_bus_width() and support 8bit width.
  */
-static int sdhci_s3c_platform_bus_width(struct sdhci_host *host, int width)
=+DO NOT APPLY+=static void sdhci_s3c_set_bus_width(struct sdhci_host *host, int width)
 {
 	u8 ctrl;
 
@@ -359,15 +359,13 @@ static int sdhci_s3c_platform_bus_width(struct sdhci_host *host, int width)
 	}
 
 	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
-
-	return 0;
 }
 
 static struct sdhci_ops sdhci_s3c_ops = {
 	.get_max_clock		= sdhci_s3c_get_max_clk,
 	.set_clock		= sdhci_s3c_set_clock,
 	.get_min_clock		= sdhci_s3c_get_min_clock,
-	.platform_bus_width	= sdhci_s3c_platform_bus_width,
=+DO NOT APPLY+=	.set_bus_width		= sdhci_s3c_set_bus_width,
 };
 
 static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index 696122c1b468..16fcd48f9556 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-sirf.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-sirf.c
@@ -29,6 +29,7 @@ static unsigned int sdhci_sirf_get_max_clk(struct sdhci_host *host)
 
 static struct sdhci_ops sdhci_sirf_ops = {
 	.get_max_clock	= sdhci_sirf_get_max_clk,
=+DO NOT APPLY+=	.set_bus_width = sdhci_set_bus_width,
 };
 
 static struct sdhci_pltfm_data sdhci_sirf_pdata = {
diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 2dba9f8d1760..549e9e0edb27 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-spear.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-spear.c
@@ -37,7 +37,7 @@ struct spear_sdhci {
 
 /* sdhci ops */
 static const struct sdhci_ops sdhci_pltfm_ops = {
-	/* Nothing to do for now. */
=+DO NOT APPLY+=	.set_bus_width = sdhci_set_bus_width,
 };
 
 /* gpio card detection interrupt handler */
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index a835898a68dd..feed799b827a 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-tegra.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-tegra.c
@@ -127,7 +127,7 @@ static void tegra_sdhci_reset_exit(struct sdhci_host *host, u8 mask)
 	}
 }
 
-static int tegra_sdhci_buswidth(struct sdhci_host *host, int bus_width)
=+DO NOT APPLY+=static void tegra_sdhci_set_bus_width(struct sdhci_host *host, int bus_width)
 {
 	u32 ctrl;
 
@@ -144,7 +144,6 @@ static int tegra_sdhci_buswidth(struct sdhci_host *host, int bus_width)
 			ctrl &= ~SDHCI_CTRL_4BITBUS;
 	}
 	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
-	return 0;
 }
 
 static const struct sdhci_ops tegra_sdhci_ops = {
@@ -152,7 +151,7 @@ static const struct sdhci_ops tegra_sdhci_ops = {
 	.read_l     = tegra_sdhci_readl,
 	.read_w     = tegra_sdhci_readw,
 	.write_l    = tegra_sdhci_writel,
-	.platform_bus_width = tegra_sdhci_buswidth,
=+DO NOT APPLY+=	.set_bus_width = tegra_sdhci_set_bus_width,
 	.platform_reset_exit = tegra_sdhci_reset_exit,
 };
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5fe211dfb792..ad744941fdf8 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci.c
@@ -1413,6 +1413,27 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
=+DO NOT APPLY+=void sdhci_set_bus_width(struct sdhci_host *host, int width)
=+DO NOT APPLY+={
=+DO NOT APPLY+=	u8 ctrl;
=+DO NOT APPLY+=
=+DO NOT APPLY+=	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
=+DO NOT APPLY+=	if (width == MMC_BUS_WIDTH_8) {
=+DO NOT APPLY+=		ctrl &= ~SDHCI_CTRL_4BITBUS;
=+DO NOT APPLY+=		if (host->version >= SDHCI_SPEC_300)
=+DO NOT APPLY+=			ctrl |= SDHCI_CTRL_8BITBUS;
=+DO NOT APPLY+=	} else {
=+DO NOT APPLY+=		if (host->version >= SDHCI_SPEC_300)
=+DO NOT APPLY+=			ctrl &= ~SDHCI_CTRL_8BITBUS;
=+DO NOT APPLY+=		if (width == MMC_BUS_WIDTH_4)
=+DO NOT APPLY+=			ctrl |= SDHCI_CTRL_4BITBUS;
=+DO NOT APPLY+=		else
=+DO NOT APPLY+=			ctrl &= ~SDHCI_CTRL_4BITBUS;
=+DO NOT APPLY+=	}
=+DO NOT APPLY+=	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
=+DO NOT APPLY+=}
=+DO NOT APPLY+=EXPORT_SYMBOL_GPL(sdhci_set_bus_width);
=+DO NOT APPLY+=
 static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 {
 	unsigned long flags;
@@ -1458,29 +1479,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 	if (host->ops->platform_send_init_74_clocks)
 		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
 
-	/*
-	 * If your platform has 8-bit width support but is not a v3 controller,
-	 * or if it requires special setup code, you should implement that in
-	 * platform_bus_width().
-	 */
-	if (host->ops->platform_bus_width) {
-		host->ops->platform_bus_width(host, ios->bus_width);
-	} else {
-		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
-		if (ios->bus_width == MMC_BUS_WIDTH_8) {
-			ctrl &= ~SDHCI_CTRL_4BITBUS;
-			if (host->version >= SDHCI_SPEC_300)
-				ctrl |= SDHCI_CTRL_8BITBUS;
-		} else {
-			if (host->version >= SDHCI_SPEC_300)
-				ctrl &= ~SDHCI_CTRL_8BITBUS;
-			if (ios->bus_width == MMC_BUS_WIDTH_4)
-				ctrl |= SDHCI_CTRL_4BITBUS;
-			else
-				ctrl &= ~SDHCI_CTRL_4BITBUS;
-		}
-		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
-	}
=+DO NOT APPLY+=	host->ops->set_bus_width(host, ios->bus_width);
 
 	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index fc6f81d2f377..0301f928eb11 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci.h
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci.h
@@ -281,8 +281,7 @@ struct sdhci_ops {
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
-	int		(*platform_bus_width)(struct sdhci_host *host,
-					       int width);
=+DO NOT APPLY+=	void		(*set_bus_width)(struct sdhci_host *host, int width);
 	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
 					     u8 power_mode);
 	unsigned int    (*get_ro)(struct sdhci_host *host);
@@ -402,6 +401,8 @@ static inline bool sdhci_sdio_irq_enabled(struct sdhci_host *host)
 	return !!(host->flags & SDHCI_SDIO_IRQ_ENABLED);
 }
 
=+DO NOT APPLY+=void sdhci_set_bus_width(struct sdhci_host *host, int width);
=+DO NOT APPLY+=
 #ifdef CONFIG_PM
 extern int sdhci_suspend_host(struct sdhci_host *host);
 extern int sdhci_resume_host(struct sdhci_host *host);
-- 
1.8.3.1

