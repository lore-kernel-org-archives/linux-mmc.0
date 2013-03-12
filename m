From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] mmc: sdhci: Constify sdhci_ops structs where possible
Date: Tue, 12 Mar 2013 11:53:00 +0100
Message-ID: <1363085580-3690-3-git-send-email-lars@metafoo.de>
References: <1363085580-3690-1-git-send-email-lars@metafoo.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out-038.synserver.de ([212.40.185.38]:1212 "EHLO
	smtp-out-038.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932207Ab3CLKvO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Mar 2013 06:51:14 -0400
In-Reply-To: <1363085580-3690-1-git-send-email-lars@metafoo.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>, Viresh Kumar <viresh.linux@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Mike Rapoport <mike@compulab.co.il>, Shawn Guo <shawn.guo@linaro.org>, Albert Herranz <albert_herranz@yahoo.es>, Kevin Liu <kliu5@marvell.com>, linux-mmc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>

Basically all drivers can have sdhci_ops struct const, but almost none do so.
This patch constifies all sdhci_ops struct declarations where possible.

The patch was auto-generated with the following coccinelle semantic patch:

// <smpl>
@r1@
identifier ops;
identifier fld;
@@
ops.fld = ...;

@disable optional_qualifier@
identifier ops != r1.ops;
@@
static
+const
struct sdhci_ops ops = { ... };
// </smpl>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci-bcm2835.c   | 2 +-
 drivers/mmc/host/sdhci-cns3xxx.c   | 2 +-
 drivers/mmc/host/sdhci-dove.c      | 2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 drivers/mmc/host/sdhci-of-esdhc.c  | 2 +-
 drivers/mmc/host/sdhci-of-hlwd.c   | 2 +-
 drivers/mmc/host/sdhci-pci.c       | 2 +-
 drivers/mmc/host/sdhci-pltfm.c     | 2 +-
 drivers/mmc/host/sdhci-pxav2.c     | 2 +-
 drivers/mmc/host/sdhci-pxav3.c     | 2 +-
 drivers/mmc/host/sdhci-spear.c     | 2 +-
 drivers/mmc/host/sdhci-tegra.c     | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
index 29e9e40..d49bc95 100644
--- a/drivers/mmc/host/sdhci-bcm2835.c
+++ b/drivers/mmc/host/sdhci-bcm2835.c
@@ -124,7 +124,7 @@ unsigned int bcm2835_sdhci_get_min_clock(struct sdhci_host *host)
 	return MIN_FREQ;
 }
 
-static struct sdhci_ops bcm2835_sdhci_ops = {
+static const struct sdhci_ops bcm2835_sdhci_ops = {
 	.write_l = bcm2835_sdhci_writel,
 	.write_w = bcm2835_sdhci_writew,
 	.write_b = bcm2835_sdhci_writeb,
diff --git a/drivers/mmc/host/sdhci-cns3xxx.c b/drivers/mmc/host/sdhci-cns3xxx.c
index 15a936a..4fa26de 100644
--- a/drivers/mmc/host/sdhci-cns3xxx.c
+++ b/drivers/mmc/host/sdhci-cns3xxx.c
@@ -80,7 +80,7 @@ out:
 	host->clock = clock;
 }
 
-static struct sdhci_ops sdhci_cns3xxx_ops = {
+static const struct sdhci_ops sdhci_cns3xxx_ops = {
 	.get_max_clock	= sdhci_cns3xxx_get_max_clk,
 	.set_clock	= sdhci_cns3xxx_set_clock,
 };
diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index b514f68..15e7803 100644
--- a/drivers/mmc/host/sdhci-dove.c
+++ b/drivers/mmc/host/sdhci-dove.c
@@ -83,7 +83,7 @@ static u32 sdhci_dove_readl(struct sdhci_host *host, int reg)
 	return ret;
 }
 
-static struct sdhci_ops sdhci_dove_ops = {
+static const struct sdhci_ops sdhci_dove_ops = {
 	.read_w	= sdhci_dove_readw,
 	.read_l	= sdhci_dove_readl,
 };
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 68c301d..67d6dde 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -399,7 +399,7 @@ static int esdhc_pltfm_bus_width(struct sdhci_host *host, int width)
 	return 0;
 }
 
-static struct sdhci_ops sdhci_esdhc_ops = {
+static const struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl_le,
 	.read_w = esdhc_readw_le,
 	.write_l = esdhc_writel_le,
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index b98b919..5e68adc 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -230,7 +230,7 @@ static void esdhc_of_platform_init(struct sdhci_host *host)
 		host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
 }
 
-static struct sdhci_ops sdhci_esdhc_ops = {
+static const struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl,
 	.read_w = esdhc_readw,
 	.read_b = esdhc_readb,
diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-of-hlwd.c
index 7ea5c02..200a6a9 100644
--- a/drivers/mmc/host/sdhci-of-hlwd.c
+++ b/drivers/mmc/host/sdhci-of-hlwd.c
@@ -51,7 +51,7 @@ static void sdhci_hlwd_writeb(struct sdhci_host *host, u8 val, int reg)
 	udelay(SDHCI_HLWD_WRITE_DELAY);
 }
 
-static struct sdhci_ops sdhci_hlwd_ops = {
+static const struct sdhci_ops sdhci_hlwd_ops = {
 	.read_l = sdhci_be32bs_readl,
 	.read_w = sdhci_be32bs_readw,
 	.read_b = sdhci_be32bs_readb,
diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index c7ccf30..f55c19e 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -975,7 +975,7 @@ static void sdhci_pci_hw_reset(struct sdhci_host *host)
 	usleep_range(300, 1000);
 }
 
-static struct sdhci_ops sdhci_pci_ops = {
+static const struct sdhci_ops sdhci_pci_ops = {
 	.enable_dma	= sdhci_pci_enable_dma,
 	.platform_bus_width	= sdhci_pci_bus_width,
 	.hw_reset		= sdhci_pci_hw_reset,
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index b5b8a21..de21925 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -44,7 +44,7 @@ unsigned int sdhci_pltfm_clk_get_max_clock(struct sdhci_host *host)
 }
 EXPORT_SYMBOL_GPL(sdhci_pltfm_clk_get_max_clock);
 
-static struct sdhci_ops sdhci_pltfm_ops = {
+static const struct sdhci_ops sdhci_pltfm_ops = {
 };
 
 #ifdef CONFIG_OF
diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index eeb7d43..6a3f702 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -111,7 +111,7 @@ static int pxav2_mmc_set_width(struct sdhci_host *host, int width)
 	return 0;
 }
 
-static struct sdhci_ops pxav2_sdhci_ops = {
+static const struct sdhci_ops pxav2_sdhci_ops = {
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.platform_reset_exit = pxav2_set_private_registers,
 	.platform_bus_width = pxav2_mmc_set_width,
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index a0cdbc5..5663a6e 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -167,7 +167,7 @@ static int pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 	return 0;
 }
 
-static struct sdhci_ops pxav3_sdhci_ops = {
+static const struct sdhci_ops pxav3_sdhci_ops = {
 	.platform_reset_exit = pxav3_set_private_registers,
 	.set_uhs_signaling = pxav3_set_uhs_signaling,
 	.platform_send_init_74_clocks = pxav3_gen_init_74_clocks,
diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index c6ece0b..8d28334 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -36,7 +36,7 @@ struct spear_sdhci {
 };
 
 /* sdhci ops */
-static struct sdhci_ops sdhci_pltfm_ops = {
+static const struct sdhci_ops sdhci_pltfm_ops = {
 	/* Nothing to do for now. */
 };
 
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 4a42055..0e30c44 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -164,7 +164,7 @@ static int tegra_sdhci_buswidth(struct sdhci_host *host, int bus_width)
 	return 0;
 }
 
-static struct sdhci_ops tegra_sdhci_ops = {
+static const struct sdhci_ops tegra_sdhci_ops = {
 	.get_ro     = tegra_sdhci_get_ro,
 	.read_l     = tegra_sdhci_readl,
 	.read_w     = tegra_sdhci_readw,
-- 
1.8.0

