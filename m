From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: [PATCH v7 2/5] ARM: davinci: mmc: derive version information from device name
Date: Thu, 28 Mar 2013 18:41:59 +0530
Message-ID: <1364476322-15882-3-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45805 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755949Ab3C1NMe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Mar 2013 09:12:34 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com, linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, nsekhar@ti.com, grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, hs@denx.de, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, arnd@arndb.de, "Manjunathappa, Prakash" <prakash.pm@ti.com>

Remove specifying mmc controller IP version information via platform
data, instead specify device name so that driver derives it from
platform_device_id table. Also change the clock node name to match
the changed dev_id.
Tested on da850-evm to make sure driver loads without clk_get failures.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
Reviewed-by: Sekhar Nori <nsekhar@ti.com>
---
Since v5:
Choose smaller device name, da830-mmc instead of davinci-mmc-da830
and dm6441-mmc instead of davinci-mmc-dm355.

Since v4:
Merged patch "ARM: davinci: mmc: derive version information from device name"
with this patch

 arch/arm/mach-davinci/board-da830-evm.c     |    1 -
 arch/arm/mach-davinci/board-da850-evm.c     |    2 --
 arch/arm/mach-davinci/board-dm355-evm.c     |    1 -
 arch/arm/mach-davinci/board-dm365-evm.c     |    1 -
 arch/arm/mach-davinci/board-dm644x-evm.c    |    1 -
 arch/arm/mach-davinci/board-neuros-osd2.c   |    1 -
 arch/arm/mach-davinci/board-omapl138-hawk.c |    1 -
 arch/arm/mach-davinci/board-tnetv107x-evm.c |    1 -
 arch/arm/mach-davinci/da830.c               |    2 +-
 arch/arm/mach-davinci/da850.c               |    4 ++--
 arch/arm/mach-davinci/devices-da8xx.c       |    4 ++--
 arch/arm/mach-davinci/devices-tnetv107x.c   |    4 ++--
 arch/arm/mach-davinci/devices.c             |    6 ++++--
 arch/arm/mach-davinci/dm355.c               |    4 ++--
 arch/arm/mach-davinci/dm365.c               |    4 ++--
 arch/arm/mach-davinci/dm644x.c              |    2 +-
 arch/arm/mach-davinci/tnetv107x.c           |    4 ++--
 drivers/mmc/host/davinci_mmc.c              |   18 +++++++++++++++++-
 include/linux/platform_data/mmc-davinci.h   |    3 ---
 19 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 6da25ee..12e6f75 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -246,7 +246,6 @@ static struct davinci_mmc_config da830_evm_mmc_config = {
 	.wires			= 8,
 	.max_freq		= 50000000,
 	.caps			= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED,
-	.version		= MMC_CTLR_VERSION_2,
 };
 
 static inline void da830_evm_init_mmc(void)
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index c2dfe06..dcc8710 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -802,7 +802,6 @@ static struct davinci_mmc_config da850_mmc_config = {
 	.wires		= 4,
 	.max_freq	= 50000000,
 	.caps		= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED,
-	.version	= MMC_CTLR_VERSION_2,
 };
 
 static const short da850_evm_mmcsd0_pins[] __initconst = {
@@ -1372,7 +1371,6 @@ static struct davinci_mmc_config da850_wl12xx_mmc_config = {
 	.max_freq	= 25000000,
 	.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_NONREMOVABLE |
 			  MMC_CAP_POWER_OFF_CARD,
-	.version	= MMC_CTLR_VERSION_2,
 };
 
 static const short da850_wl12xx_pins[] __initconst = {
diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 147b8e1..bfdf8b9 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -280,7 +280,6 @@ static struct davinci_mmc_config dm355evm_mmc_config = {
 	.wires		= 4,
 	.max_freq       = 50000000,
 	.caps           = MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED,
-	.version	= MMC_CTLR_VERSION_1,
 };
 
 /* Don't connect anything to J10 unless you're only using USB host
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 1c9440b..312cc72 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -256,7 +256,6 @@ static struct davinci_mmc_config dm365evm_mmc_config = {
 	.wires		= 4,
 	.max_freq	= 50000000,
 	.caps		= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED,
-	.version	= MMC_CTLR_VERSION_2,
 };
 
 static void dm365evm_emac_configure(void)
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 71735e7..c0206d5 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -570,7 +570,6 @@ static struct davinci_mmc_config dm6446evm_mmc_config = {
 	.get_cd		= dm6444evm_mmc_get_cd,
 	.get_ro		= dm6444evm_mmc_get_ro,
 	.wires		= 4,
-	.version	= MMC_CTLR_VERSION_1
 };
 
 static struct i2c_board_info __initdata i2c_info[] =  {
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index 1c98107..b70e83c 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -164,7 +164,6 @@ static void __init davinci_ntosd2_map_io(void)
 
 static struct davinci_mmc_config davinci_ntosd2_mmc_config = {
 	.wires		= 4,
-	.version	= MMC_CTLR_VERSION_1
 };
 
 
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 5a2bd44..328dbd8 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -136,7 +136,6 @@ static struct davinci_mmc_config da850_mmc_config = {
 	.wires		= 4,
 	.max_freq	= 50000000,
 	.caps		= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED,
-	.version	= MMC_CTLR_VERSION_2,
 };
 
 static __init void omapl138_hawk_mmc_init(void)
diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index 10c9efd..78ea395 100644
--- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
+++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
@@ -85,7 +85,6 @@ static struct davinci_mmc_config mmc_config = {
 	.wires		= 4,
 	.max_freq	= 50000000,
 	.caps		= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED,
-	.version	= MMC_CTLR_VERSION_1,
 };
 
 static const short sdio1_pins[] __initconst = {
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 678a54a..abbaf02 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -394,7 +394,7 @@ static struct clk_lookup da830_clks[] = {
 	CLK(NULL,		"tpcc",		&tpcc_clk),
 	CLK(NULL,		"tptc0",	&tptc0_clk),
 	CLK(NULL,		"tptc1",	&tptc1_clk),
-	CLK("davinci_mmc.0",	NULL,		&mmcsd_clk),
+	CLK("da830-mmc.0",	NULL,		&mmcsd_clk),
 	CLK(NULL,		"uart0",	&uart0_clk),
 	CLK(NULL,		"uart1",	&uart1_clk),
 	CLK(NULL,		"uart2",	&uart2_clk),
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 0c4a26d..98642bd 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -420,8 +420,8 @@ static struct clk_lookup da850_clks[] = {
 	CLK("davinci_emac.1",	NULL,		&emac_clk),
 	CLK("davinci-mcasp.0",	NULL,		&mcasp_clk),
 	CLK("da8xx_lcdc.0",	"fck",		&lcdc_clk),
-	CLK("davinci_mmc.0",	NULL,		&mmcsd0_clk),
-	CLK("davinci_mmc.1",	NULL,		&mmcsd1_clk),
+	CLK("da830-mmc.0",	NULL,		&mmcsd0_clk),
+	CLK("da830-mmc.1",	NULL,		&mmcsd1_clk),
 	CLK(NULL,		"aemif",	&aemif_clk),
 	CLK(NULL,		"usb11",	&usb11_clk),
 	CLK(NULL,		"usb20",	&usb20_clk),
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index fc50243..cb97e07 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -664,7 +664,7 @@ static struct resource da8xx_mmcsd0_resources[] = {
 };
 
 static struct platform_device da8xx_mmcsd0_device = {
-	.name		= "davinci_mmc",
+	.name		= "da830-mmc",
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(da8xx_mmcsd0_resources),
 	.resource	= da8xx_mmcsd0_resources,
@@ -701,7 +701,7 @@ static struct resource da850_mmcsd1_resources[] = {
 };
 
 static struct platform_device da850_mmcsd1_device = {
-	.name		= "davinci_mmc",
+	.name		= "da830-mmc",
 	.id		= 1,
 	.num_resources	= ARRAY_SIZE(da850_mmcsd1_resources),
 	.resource	= da850_mmcsd1_resources,
diff --git a/arch/arm/mach-davinci/devices-tnetv107x.c b/arch/arm/mach-davinci/devices-tnetv107x.c
index ba37760..612a085 100644
--- a/arch/arm/mach-davinci/devices-tnetv107x.c
+++ b/arch/arm/mach-davinci/devices-tnetv107x.c
@@ -218,7 +218,7 @@ static u64 mmc1_dma_mask = DMA_BIT_MASK(32);
 
 static struct platform_device mmc_devices[2] = {
 	{
-		.name		= "davinci_mmc",
+		.name		= "dm6441-mmc",
 		.id		= 0,
 		.dev		= {
 			.dma_mask		= &mmc0_dma_mask,
@@ -228,7 +228,7 @@ static struct platform_device mmc_devices[2] = {
 		.resource	= mmc0_resources
 	},
 	{
-		.name		= "davinci_mmc",
+		.name		= "dm6441-mmc",
 		.id		= 1,
 		.dev		= {
 			.dma_mask		= &mmc1_dma_mask,
diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index ca0c7b3..69320eb 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -154,7 +154,7 @@ static struct resource mmcsd0_resources[] = {
 };
 
 static struct platform_device davinci_mmcsd0_device = {
-	.name = "davinci_mmc",
+	.name = "dm6441-mmc",
 	.id = 0,
 	.dev = {
 		.dma_mask = &mmcsd0_dma_mask,
@@ -191,7 +191,7 @@ static struct resource mmcsd1_resources[] = {
 };
 
 static struct platform_device davinci_mmcsd1_device = {
-	.name = "davinci_mmc",
+	.name = "dm6441-mmc",
 	.id = 1,
 	.dev = {
 		.dma_mask = &mmcsd1_dma_mask,
@@ -239,6 +239,7 @@ void __init davinci_setup_mmc(int module, struct davinci_mmc_config *config)
 			mmcsd1_resources[0].end = DM365_MMCSD1_BASE +
 							SZ_4K - 1;
 			mmcsd1_resources[2].start = IRQ_DM365_SDIOINT1;
+			davinci_mmcsd1_device.name = "da830-mmc";
 		} else
 			break;
 
@@ -260,6 +261,7 @@ void __init davinci_setup_mmc(int module, struct davinci_mmc_config *config)
 			mmcsd0_resources[0].end = DM365_MMCSD0_BASE +
 							SZ_4K - 1;
 			mmcsd0_resources[2].start = IRQ_DM365_SDIOINT0;
+			davinci_mmcsd0_device.name = "da830-mmc";
 		} else if (cpu_is_davinci_dm644x()) {
 			/* REVISIT: should this be in board-init code? */
 			/* Power-on 3.3V IO cells */
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 53998d8..771f4bd 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -361,8 +361,8 @@ static struct clk_lookup dm355_clks[] = {
 	CLK("i2c_davinci.1", NULL, &i2c_clk),
 	CLK("davinci-mcbsp.0", NULL, &asp0_clk),
 	CLK("davinci-mcbsp.1", NULL, &asp1_clk),
-	CLK("davinci_mmc.0", NULL, &mmcsd0_clk),
-	CLK("davinci_mmc.1", NULL, &mmcsd1_clk),
+	CLK("dm6441-mmc.0", NULL, &mmcsd0_clk),
+	CLK("dm6441-mmc.1", NULL, &mmcsd1_clk),
 	CLK("spi_davinci.0", NULL, &spi0_clk),
 	CLK("spi_davinci.1", NULL, &spi1_clk),
 	CLK("spi_davinci.2", NULL, &spi2_clk),
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 9b41d33..ba41435 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -454,8 +454,8 @@ static struct clk_lookup dm365_clks[] = {
 	CLK(NULL, "uart0", &uart0_clk),
 	CLK(NULL, "uart1", &uart1_clk),
 	CLK("i2c_davinci.1", NULL, &i2c_clk),
-	CLK("davinci_mmc.0", NULL, &mmcsd0_clk),
-	CLK("davinci_mmc.1", NULL, &mmcsd1_clk),
+	CLK("da830-mmc.0", NULL, &mmcsd0_clk),
+	CLK("da830-mmc.1", NULL, &mmcsd1_clk),
 	CLK("spi_davinci.0", NULL, &spi0_clk),
 	CLK("spi_davinci.1", NULL, &spi1_clk),
 	CLK("spi_davinci.2", NULL, &spi2_clk),
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index e8bf21f..8854caa 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -310,7 +310,7 @@ static struct clk_lookup dm644x_clks[] = {
 	CLK("i2c_davinci.1", NULL, &i2c_clk),
 	CLK("palm_bk3710", NULL, &ide_clk),
 	CLK("davinci-mcbsp", NULL, &asp_clk),
-	CLK("davinci_mmc.0", NULL, &mmcsd_clk),
+	CLK("dm6441-mmc.0", NULL, &mmcsd_clk),
 	CLK(NULL, "spi", &spi_clk),
 	CLK(NULL, "gpio", &gpio_clk),
 	CLK(NULL, "usb", &usb_clk),
diff --git a/arch/arm/mach-davinci/tnetv107x.c b/arch/arm/mach-davinci/tnetv107x.c
index dc1a209..3b2a70d 100644
--- a/arch/arm/mach-davinci/tnetv107x.c
+++ b/arch/arm/mach-davinci/tnetv107x.c
@@ -272,7 +272,7 @@ static struct clk_lookup clks[] = {
 	CLK("tnetv107x-keypad.0", NULL,			&clk_keypad),
 	CLK(NULL,		"clk_gpio",		&clk_gpio),
 	CLK(NULL,		"clk_mdio",		&clk_mdio),
-	CLK("davinci_mmc.0",	NULL,			&clk_sdio0),
+	CLK("dm6441-mmc.0",	NULL,			&clk_sdio0),
 	CLK(NULL,		"uart0",		&clk_uart0),
 	CLK(NULL,		"uart1",		&clk_uart1),
 	CLK(NULL,		"timer0",		&clk_timer0),
@@ -292,7 +292,7 @@ static struct clk_lookup clks[] = {
 	CLK(NULL,		"clk_system",		&clk_system),
 	CLK(NULL,		"clk_imcop",		&clk_imcop),
 	CLK(NULL,		"clk_spare",		&clk_spare),
-	CLK("davinci_mmc.1",	NULL,			&clk_sdio1),
+	CLK("dm6441-mmc.1",	NULL,			&clk_sdio1),
 	CLK(NULL,		"clk_ddr2_vrst",	&clk_ddr2_vrst),
 	CLK(NULL,		"clk_ddr2_vctl_rst",	&clk_ddr2_vctl_rst),
 	CLK(NULL,		NULL,			NULL),
diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index bd848d3..7d0e684 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1158,6 +1158,18 @@ static void __init init_mmcsd_host(struct mmc_davinci_host *host)
 	mmc_davinci_reset_ctrl(host, 0);
 }
 
+static struct platform_device_id davinci_mmc_devtype[] = {
+	{
+		.name	= "dm6441-mmc",
+		.driver_data = MMC_CTLR_VERSION_1,
+	}, {
+		.name	= "da830-mmc",
+		.driver_data = MMC_CTLR_VERSION_2,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(platform, davinci_mmc_devtype);
+
 static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 {
 	struct davinci_mmc_config *pdata = pdev->dev.platform_data;
@@ -1166,6 +1178,7 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 	struct resource *r, *mem = NULL;
 	int ret = 0, irq = 0;
 	size_t mem_size;
+	const struct platform_device_id *id_entry;
 
 	/* REVISIT:  when we're fully converted, fail if pdata is NULL */
 
@@ -1240,7 +1253,9 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 	if (pdata && (pdata->wires == 8))
 		mmc->caps |= (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA);
 
-	host->version = pdata->version;
+	id_entry = platform_get_device_id(pdev);
+	if (id_entry)
+		host->version = id_entry->driver_data;
 
 	mmc->ops = &mmc_davinci_ops;
 	mmc->f_min = 312500;
@@ -1411,6 +1426,7 @@ static struct platform_driver davinci_mmcsd_driver = {
 		.pm	= davinci_mmcsd_pm_ops,
 	},
 	.remove		= __exit_p(davinci_mmcsd_remove),
+	.id_table	= davinci_mmc_devtype,
 };
 
 static int __init davinci_mmcsd_init(void)
diff --git a/include/linux/platform_data/mmc-davinci.h b/include/linux/platform_data/mmc-davinci.h
index 5ba6b22..9cea4ee 100644
--- a/include/linux/platform_data/mmc-davinci.h
+++ b/include/linux/platform_data/mmc-davinci.h
@@ -23,9 +23,6 @@ struct davinci_mmc_config {
 	/* any additional host capabilities: OR'd in to mmc->f_caps */
 	u32     caps;
 
-	/* Version of the MMC/SD controller */
-	u8	version;
-
 	/* Number of sg segments */
 	u8	nr_sg;
 };
-- 
1.7.4.1

