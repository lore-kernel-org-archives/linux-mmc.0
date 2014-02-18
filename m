From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 12/31] mmc: sdhci: convert reset into a library function
Date: Tue, 18 Feb 2014 15:10:04 +0000
Message-ID: <E1WFmJA-0006ma-3u@rmk-PC.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40477 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755906AbaBRPKI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 10:10:08 -0500
In-Reply-To: <20140218150801.GD21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Michal Simek <michal.simek@xilinx.com>, Anton Vorontsov <anton@enomsg.org>, Ben Dooks <ben-linux@fluff.org>, Barry Song <baohua@kernel.org>, Viresh Kumar <viresh.linux@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linuxppc-dev@lists.ozlabs.org, spear-devel@list.st.com, linux-tegra@vger.kernel.org

Rather than having platform_reset_enter/platform_reset_exit methods,
turn the core of the reset handling into a library function which
platforms can call at the appropriate moment in their (new) reset
method.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
=-DO NOT APPLY-=
 drivers/mmc/host/sdhci-acpi.c      |  2 ++
 drivers/mmc/host/sdhci-bcm-kona.c  |  1 +
 drivers/mmc/host/sdhci-bcm2835.c   |  1 +
 drivers/mmc/host/sdhci-cns3xxx.c   |  1 +
 drivers/mmc/host/sdhci-dove.c      |  1 +
 drivers/mmc/host/sdhci-esdhc-imx.c |  1 +
 drivers/mmc/host/sdhci-of-arasan.c |  1 +
 drivers/mmc/host/sdhci-of-esdhc.c  |  1 +
 drivers/mmc/host/sdhci-of-hlwd.c   |  1 +
 drivers/mmc/host/sdhci-pci.c       |  1 +
 drivers/mmc/host/sdhci-pltfm.c     |  1 +
 drivers/mmc/host/sdhci-pxav2.c     |  6 +++--
 drivers/mmc/host/sdhci-pxav3.c     |  6 +++--
 drivers/mmc/host/sdhci-s3c.c       |  1 +
 drivers/mmc/host/sdhci-sirf.c      |  1 +
 drivers/mmc/host/sdhci-spear.c     |  1 +
 drivers/mmc/host/sdhci-tegra.c     |  6 +++--
 drivers/mmc/host/sdhci.c           | 47 +++++++++++++++++++-------------------
 drivers/mmc/host/sdhci.h           |  4 ++--
 19 files changed, 53 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index b138bfdd3843..1ded6690be43 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-acpi.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-acpi.c
@@ -103,11 +103,13 @@ static void sdhci_acpi_int_hw_reset(struct sdhci_host *host)
 static const struct sdhci_ops sdhci_acpi_ops_dflt = {
 	.enable_dma = sdhci_acpi_enable_dma,
 	.set_bus_width = sdhci_set_bus_width,
=+DO NOT APPLY+=	.reset = sdhci_reset,
 };
 
 static const struct sdhci_ops sdhci_acpi_ops_int = {
 	.enable_dma = sdhci_acpi_enable_dma,
 	.set_bus_width = sdhci_set_bus_width,
=+DO NOT APPLY+=	.reset = sdhci_reset,
 	.hw_reset   = sdhci_acpi_int_hw_reset,
 };
 
diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index bf851a6e4e8e..4c82ecb7a71e 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-bcm-kona.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -209,6 +209,7 @@ static struct sdhci_ops sdhci_bcm_kona_ops = {
 	.get_timeout_clock = sdhci_bcm_kona_get_timeout_clock,
 	.platform_send_init_74_clocks = sdhci_bcm_kona_init_74_clocks,
 	.set_bus_width = sdhci_set_bus_width,
=+DO NOT APPLY+=	.reset = sdhci_reset,
 	.card_event = sdhci_bcm_kona_card_event,
 };
 
diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
index 7ab69af979b4..289b1c80d5fc 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-bcm2835.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-bcm2835.c
@@ -134,6 +134,7 @@ static const struct sdhci_ops bcm2835_sdhci_ops = {
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_min_clock = bcm2835_sdhci_get_min_clock,
 	.set_bus_width = sdhci_set_bus_width,
=+DO NOT APPLY+=	.reset = sdhci_reset,
 };
 
 static const struct sdhci_pltfm_data bcm2835_sdhci_pdata = {
diff --git a/drivers/mmc/host/sdhci-cns3xxx.c b/drivers/mmc/host/sdhci-cns3xxx.c
index 5e0cc9c47887..87af66bb1ea8 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-cns3xxx.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-cns3xxx.c
@@ -83,6 +83,7 @@ static const struct sdhci_ops sdhci_cns3xxx_ops = {
 	.get_max_clock	= sdhci_cns3xxx_get_max_clk,
 	.set_clock	= sdhci_cns3xxx_set_clock,
 	.set_bus_width	= sdhci_set_bus_width,
=+DO NOT APPLY+=	.reset          = sdhci_reset,
 };
 
 static const struct sdhci_pltfm_data sdhci_cns3xxx_pdata = {
diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index 7eef4890fd22..4c0191bff85d 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-dove.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-dove.c
@@ -87,6 +87,7 @@ static const struct sdhci_ops sdhci_dove_ops = {
 	.read_w	= sdhci_dove_readw,
 	.read_l	= sdhci_dove_readl,
 	.set_bus_width = sdhci_set_bus_width,
=+DO NOT APPLY+=	.reset = sdhci_reset,
 };
 
 static const struct sdhci_pltfm_data sdhci_dove_pdata = {
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 568239d84cbe..b1d74fa33c5f 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-esdhc-imx.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -888,6 +888,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.get_ro = esdhc_pltfm_get_ro,
 	.set_bus_width = esdhc_pltfm_set_bus_width,
 	.set_uhs_signaling = esdhc_set_uhs_signaling,
=+DO NOT APPLY+=	.reset = sdhci_reset,
 };
 
 static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 9bb1dd263a45..faef21740584 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-of-arasan.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-of-arasan.c
@@ -55,6 +55,7 @@ static struct sdhci_ops sdhci_arasan_ops = {
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_arasan_get_timeout_clock,
 	.set_bus_width = sdhci_set_bus_width,
=+DO NOT APPLY+=	.reset = sdhci_reset,
 };
 
 static struct sdhci_pltfm_data sdhci_arasan_pdata = {
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 86b8326e77c3..4530f9957f20 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-of-esdhc.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -309,6 +309,7 @@ static const struct sdhci_ops sdhci_esdhc_ops = {
 #endif
 	.adma_workaround = esdhci_of_adma_workaround,
 	.set_bus_width = esdhc_pltfm_set_bus_width,
=+DO NOT APPLY+=	.reset = sdhci_reset,
 };
 
 static const struct sdhci_pltfm_data sdhci_esdhc_pdata = {
diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-of-hlwd.c
index 4d5d0015e392..fb01958cb18e 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-of-hlwd.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-of-hlwd.c
@@ -59,6 +59,7 @@ static const struct sdhci_ops sdhci_hlwd_ops = {
 	.write_w = sdhci_hlwd_writew,
 	.write_b = sdhci_hlwd_writeb,
 	.set_bus_width = sdhci_set_bus_width,
=+DO NOT APPLY+=	.reset = sdhci_reset,
 };
 
 static const struct sdhci_pltfm_data sdhci_hlwd_pdata = {
diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 59cc938b450d..88a6c6b87d70 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-pci.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-pci.c
@@ -1060,6 +1060,7 @@ static void sdhci_pci_hw_reset(struct sdhci_host *host)
 static const struct sdhci_ops sdhci_pci_ops = {
 	.enable_dma	= sdhci_pci_enable_dma,
 	.set_bus_width	= sdhci_pci_set_bus_width,
=+DO NOT APPLY+=	.reset		= sdhci_reset,
 	.hw_reset		= sdhci_pci_hw_reset,
 };
 
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 40b0fe224f9d..bfbf467b61c7 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-pltfm.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-pltfm.c
@@ -46,6 +46,7 @@ EXPORT_SYMBOL_GPL(sdhci_pltfm_clk_get_max_clock);
 
 static const struct sdhci_ops sdhci_pltfm_ops = {
 	.set_bus_width = sdhci_set_bus_width,
=+DO NOT APPLY+=	.reset = sdhci_reset,
 };
 
 #ifdef CONFIG_OF
diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index d24c282e5eb8..2eee0c8b88eb 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-pxav2.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-pxav2.c
@@ -51,11 +51,13 @@
 #define MMC_CARD		0x1000
 #define MMC_WIDTH		0x0100
 
-static void pxav2_set_private_registers(struct sdhci_host *host, u8 mask)
=+DO NOT APPLY+=static void pxav2_reset(struct sdhci_host *host, u8 mask)
 {
 	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
 	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
 
=+DO NOT APPLY+=	sdhci_reset(host, mask);
=+DO NOT APPLY+=
 	if (mask == SDHCI_RESET_ALL) {
 		u16 tmp = 0;
 
@@ -111,8 +113,8 @@ static void pxav2_mmc_set_bus_width(struct sdhci_host *host, int width)
 
 static const struct sdhci_ops pxav2_sdhci_ops = {
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
-	.platform_reset_exit = pxav2_set_private_registers,
 	.set_bus_width = pxav2_mmc_set_bus_width,
=+DO NOT APPLY+=	.reset         = pxav2_reset,
 };
 
 #ifdef CONFIG_OF
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 89c932d9685e..e6ea46c4d233 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-pxav3.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-pxav3.c
@@ -57,11 +57,13 @@
 #define SDCE_MISC_INT		(1<<2)
 #define SDCE_MISC_INT_EN	(1<<1)
 
-static void pxav3_set_private_registers(struct sdhci_host *host, u8 mask)
=+DO NOT APPLY+=static void pxav3_reset(struct sdhci_host *host, u8 mask)
 {
 	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
 	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
 
=+DO NOT APPLY+=	sdhci_reset(host, mask);
=+DO NOT APPLY+=
 	if (mask == SDHCI_RESET_ALL) {
 		/*
 		 * tune timing of read data/command when crc error happen
@@ -168,11 +170,11 @@ static int pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 }
 
 static const struct sdhci_ops pxav3_sdhci_ops = {
-	.platform_reset_exit = pxav3_set_private_registers,
 	.set_uhs_signaling = pxav3_set_uhs_signaling,
 	.platform_send_init_74_clocks = pxav3_gen_init_74_clocks,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_bus_width = sdhci_set_bus_width,
=+DO NOT APPLY+=	.reset = pxav3_reset,
 };
 
 static struct sdhci_pltfm_data sdhci_pxav3_pdata = {
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 1c4ebd69d4e5..619047be00c9 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-s3c.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-s3c.c
@@ -366,6 +366,7 @@ static struct sdhci_ops sdhci_s3c_ops = {
 	.set_clock		= sdhci_s3c_set_clock,
 	.get_min_clock		= sdhci_s3c_get_min_clock,
 	.set_bus_width		= sdhci_s3c_set_bus_width,
=+DO NOT APPLY+=	.reset			= sdhci_reset,
 };
 
 static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index 16fcd48f9556..5d79e10e1ba2 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-sirf.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-sirf.c
@@ -30,6 +30,7 @@ static unsigned int sdhci_sirf_get_max_clk(struct sdhci_host *host)
 static struct sdhci_ops sdhci_sirf_ops = {
 	.get_max_clock	= sdhci_sirf_get_max_clk,
 	.set_bus_width = sdhci_set_bus_width,
=+DO NOT APPLY+=	.reset = sdhci_reset,
 };
 
 static struct sdhci_pltfm_data sdhci_sirf_pdata = {
diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 549e9e0edb27..ef990974a522 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-spear.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-spear.c
@@ -38,6 +38,7 @@ struct spear_sdhci {
 /* sdhci ops */
 static const struct sdhci_ops sdhci_pltfm_ops = {
 	.set_bus_width = sdhci_set_bus_width,
=+DO NOT APPLY+=	.reset = sdhci_reset,
 };
 
 /* gpio card detection interrupt handler */
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index feed799b827a..7754c0319fda 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci-tegra.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci-tegra.c
@@ -108,12 +108,14 @@ static unsigned int tegra_sdhci_get_ro(struct sdhci_host *host)
 	return mmc_gpio_get_ro(host->mmc);
 }
 
-static void tegra_sdhci_reset_exit(struct sdhci_host *host, u8 mask)
=+DO NOT APPLY+=static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_tegra *tegra_host = pltfm_host->priv;
 	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
 
=+DO NOT APPLY+=	sdhci_reset(host, mask);
=+DO NOT APPLY+=
 	if (!(mask & SDHCI_RESET_ALL))
 		return;
 
@@ -152,7 +154,7 @@ static const struct sdhci_ops tegra_sdhci_ops = {
 	.read_w     = tegra_sdhci_readw,
 	.write_l    = tegra_sdhci_writel,
 	.set_bus_width = tegra_sdhci_set_bus_width,
-	.platform_reset_exit = tegra_sdhci_reset_exit,
=+DO NOT APPLY+=	.reset      = tegra_sdhci_reset,
 };
 
 static const struct sdhci_pltfm_data sdhci_tegra20_pdata = {
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ad744941fdf8..10540192d544 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci.c
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci.c
@@ -163,17 +163,9 @@ static void sdhci_disable_card_detection(struct sdhci_host *host)
 	sdhci_set_card_detection(host, false);
 }
 
-static void sdhci_reset(struct sdhci_host *host, u8 mask)
=+DO NOT APPLY+=void sdhci_reset(struct sdhci_host *host, u8 mask)
 {
 	unsigned long timeout;
-	if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
-		if (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
-			SDHCI_CARD_PRESENT))
-			return;
-	}
-
-	if (host->ops->platform_reset_enter)
-		host->ops->platform_reset_enter(host, mask);
 
 	sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
 
@@ -198,9 +190,18 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 		timeout--;
 		mdelay(1);
 	}
=+DO NOT APPLY+=}
=+DO NOT APPLY+=EXPORT_SYMBOL_GPL(sdhci_reset);
=+DO NOT APPLY+=
=+DO NOT APPLY+=static void sdhci_do_reset(struct sdhci_host *host, u8 mask)
=+DO NOT APPLY+={
=+DO NOT APPLY+=	if (host->quirks & SDHCI_QUIRK_NO_CARD_NO_RESET) {
=+DO NOT APPLY+=		if (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
=+DO NOT APPLY+=			SDHCI_CARD_PRESENT))
=+DO NOT APPLY+=			return;
=+DO NOT APPLY+=	}
 
-	if (host->ops->platform_reset_exit)
-		host->ops->platform_reset_exit(host, mask);
=+DO NOT APPLY+=	host->ops->reset(host, mask);
 
 	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET) {
 		sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
@@ -218,9 +219,9 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 static void sdhci_init(struct sdhci_host *host, int soft)
 {
 	if (soft)
-		sdhci_reset(host, SDHCI_RESET_CMD|SDHCI_RESET_DATA);
=+DO NOT APPLY+=		sdhci_do_reset(host, SDHCI_RESET_CMD|SDHCI_RESET_DATA);
 	else
-		sdhci_reset(host, SDHCI_RESET_ALL);
=+DO NOT APPLY+=		sdhci_do_reset(host, SDHCI_RESET_ALL);
 
 	host->ier = SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT |
 		    SDHCI_INT_DATA_CRC | SDHCI_INT_DATA_TIMEOUT |
@@ -962,8 +963,8 @@ static void sdhci_finish_data(struct sdhci_host *host)
 		 * upon error conditions.
 		 */
 		if (data->error) {
-			sdhci_reset(host, SDHCI_RESET_CMD);
-			sdhci_reset(host, SDHCI_RESET_DATA);
=+DO NOT APPLY+=			sdhci_do_reset(host, SDHCI_RESET_CMD);
=+DO NOT APPLY+=			sdhci_do_reset(host, SDHCI_RESET_DATA);
 		}
 
 		sdhci_send_command(host, data->stop);
@@ -1585,7 +1586,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 	 * it on each ios seems to solve the problem.
 	 */
 	if(host->quirks & SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS)
-		sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
=+DO NOT APPLY+=		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
 
 	mmiowb();
 	spin_unlock_irqrestore(&host->lock, flags);
@@ -2082,8 +2083,8 @@ static void sdhci_card_event(struct mmc_host *mmc)
 		pr_err("%s: Resetting controller.\n",
 			mmc_hostname(host->mmc));
 
-		sdhci_reset(host, SDHCI_RESET_CMD);
-		sdhci_reset(host, SDHCI_RESET_DATA);
=+DO NOT APPLY+=		sdhci_do_reset(host, SDHCI_RESET_CMD);
=+DO NOT APPLY+=		sdhci_do_reset(host, SDHCI_RESET_DATA);
 
 		host->mrq->cmd->error = -ENOMEDIUM;
 		tasklet_schedule(&host->finish_tasklet);
@@ -2151,8 +2152,8 @@ static void sdhci_tasklet_finish(unsigned long param)
 
 		/* Spec says we should do both at the same time, but Ricoh
 		   controllers do not like that. */
-		sdhci_reset(host, SDHCI_RESET_CMD);
-		sdhci_reset(host, SDHCI_RESET_DATA);
=+DO NOT APPLY+=		sdhci_do_reset(host, SDHCI_RESET_CMD);
=+DO NOT APPLY+=		sdhci_do_reset(host, SDHCI_RESET_DATA);
 	}
 
 	host->mrq = NULL;
@@ -2789,7 +2790,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (debug_quirks2)
 		host->quirks2 = debug_quirks2;
 
-	sdhci_reset(host, SDHCI_RESET_ALL);
=+DO NOT APPLY+=	sdhci_do_reset(host, SDHCI_RESET_ALL);
 
 	host->version = sdhci_readw(host, SDHCI_HOST_VERSION);
 	host->version = (host->version & SDHCI_SPEC_VER_MASK)
@@ -3272,7 +3273,7 @@ int sdhci_add_host(struct sdhci_host *host)
 
 #ifdef SDHCI_USE_LEDS_CLASS
 reset:
-	sdhci_reset(host, SDHCI_RESET_ALL);
=+DO NOT APPLY+=	sdhci_do_reset(host, SDHCI_RESET_ALL);
 	sdhci_writel(host, 0, SDHCI_INT_ENABLE);
 	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
 	free_irq(host->irq, host);
@@ -3314,7 +3315,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 #endif
 
 	if (!dead)
-		sdhci_reset(host, SDHCI_RESET_ALL);
=+DO NOT APPLY+=		sdhci_do_reset(host, SDHCI_RESET_ALL);
 
 	sdhci_writel(host, 0, SDHCI_INT_ENABLE);
 	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0301f928eb11..7d84cb3b0e00 100644
=-DO NOT APPLY-= a/drivers/mmc/host/sdhci.h
=+DO NOT APPLY+= b/drivers/mmc/host/sdhci.h
@@ -285,8 +285,7 @@ struct sdhci_ops {
 	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
 					     u8 power_mode);
 	unsigned int    (*get_ro)(struct sdhci_host *host);
-	void	(*platform_reset_enter)(struct sdhci_host *host, u8 mask);
-	void	(*platform_reset_exit)(struct sdhci_host *host, u8 mask);
=+DO NOT APPLY+=	void		(*reset)(struct sdhci_host *host, u8 mask);
 	int	(*platform_execute_tuning)(struct sdhci_host *host, u32 opcode);
 	int	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
 	void	(*hw_reset)(struct sdhci_host *host);
@@ -402,6 +401,7 @@ static inline bool sdhci_sdio_irq_enabled(struct sdhci_host *host)
 }
 
 void sdhci_set_bus_width(struct sdhci_host *host, int width);
=+DO NOT APPLY+=void sdhci_reset(struct sdhci_host *host, u8 mask);
 
 #ifdef CONFIG_PM
 extern int sdhci_suspend_host(struct sdhci_host *host);
-- 
1.8.3.1

