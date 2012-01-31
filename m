From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH v3 2/6] arm: exynos4: use 'exynos4-sdhci' as device name for
 sdhci controllers
Date: Tue, 31 Jan 2012 23:26:12 +0530
Message-ID: <1328032576-9269-3-git-send-email-thomas.abraham@linaro.org>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:32015 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372Ab2AaRvI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2012 12:51:08 -0500
In-reply-to: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org, patches@linaro.org

With the addition of platform specific driver data in the sdhci driver
for exynos4, the device name of sdhci controllers on exynos4 is changed
accordingly.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/clock.c               |   24 ++++++++++++------------
 arch/arm/mach-exynos/common.c              |    5 +++++
 arch/arm/plat-samsung/include/plat/sdhci.h |   28 ++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-exynos/clock.c b/arch/arm/mach-exynos/clock.c
index 5a8c42e..f94c99d 100644
--- a/arch/arm/mach-exynos/clock.c
+++ b/arch/arm/mach-exynos/clock.c
@@ -496,25 +496,25 @@ static struct clk init_clocks_off[] = {
 		.ctrlbit	= (1 << 0),
 	}, {
 		.name		= "hsmmc",
-		.devname	= "s3c-sdhci.0",
+		.devname	= "exynos4-sdhci.0",
 		.parent		= &clk_aclk_133.clk,
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 5),
 	}, {
 		.name		= "hsmmc",
-		.devname	= "s3c-sdhci.1",
+		.devname	= "exynos4-sdhci.1",
 		.parent		= &clk_aclk_133.clk,
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 6),
 	}, {
 		.name		= "hsmmc",
-		.devname	= "s3c-sdhci.2",
+		.devname	= "exynos4-sdhci.2",
 		.parent		= &clk_aclk_133.clk,
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 7),
 	}, {
 		.name		= "hsmmc",
-		.devname	= "s3c-sdhci.3",
+		.devname	= "exynos4-sdhci.3",
 		.parent		= &clk_aclk_133.clk,
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 8),
@@ -1187,7 +1187,7 @@ static struct clksrc_clk clk_sclk_uart3 = {
 static struct clksrc_clk clk_sclk_mmc0 = {
 	.clk		= {
 		.name		= "sclk_mmc",
-		.devname	= "s3c-sdhci.0",
+		.devname	= "exynos4-sdhci.0",
 		.parent		= &clk_dout_mmc0.clk,
 		.enable		= exynos4_clksrc_mask_fsys_ctrl,
 		.ctrlbit	= (1 << 0),
@@ -1198,7 +1198,7 @@ static struct clksrc_clk clk_sclk_mmc0 = {
 static struct clksrc_clk clk_sclk_mmc1 = {
 	.clk		= {
 		.name		= "sclk_mmc",
-		.devname	= "s3c-sdhci.1",
+		.devname	= "exynos4-sdhci.1",
 		.parent         = &clk_dout_mmc1.clk,
 		.enable		= exynos4_clksrc_mask_fsys_ctrl,
 		.ctrlbit	= (1 << 4),
@@ -1209,7 +1209,7 @@ static struct clksrc_clk clk_sclk_mmc1 = {
 static struct clksrc_clk clk_sclk_mmc2 = {
 	.clk		= {
 		.name		= "sclk_mmc",
-		.devname	= "s3c-sdhci.2",
+		.devname	= "exynos4-sdhci.2",
 		.parent         = &clk_dout_mmc2.clk,
 		.enable		= exynos4_clksrc_mask_fsys_ctrl,
 		.ctrlbit	= (1 << 8),
@@ -1220,7 +1220,7 @@ static struct clksrc_clk clk_sclk_mmc2 = {
 static struct clksrc_clk clk_sclk_mmc3 = {
 	.clk		= {
 		.name		= "sclk_mmc",
-		.devname	= "s3c-sdhci.3",
+		.devname	= "exynos4-sdhci.3",
 		.parent         = &clk_dout_mmc3.clk,
 		.enable		= exynos4_clksrc_mask_fsys_ctrl,
 		.ctrlbit	= (1 << 12),
@@ -1323,10 +1323,10 @@ static struct clk_lookup exynos4_clk_lookup[] = {
 	CLKDEV_INIT("exynos4210-uart.1", "clk_uart_baud0", &clk_sclk_uart1.clk),
 	CLKDEV_INIT("exynos4210-uart.2", "clk_uart_baud0", &clk_sclk_uart2.clk),
 	CLKDEV_INIT("exynos4210-uart.3", "clk_uart_baud0", &clk_sclk_uart3.clk),
-	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &clk_sclk_mmc0.clk),
-	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
-	CLKDEV_INIT("s3c-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
-	CLKDEV_INIT("s3c-sdhci.3", "mmc_busclk.2", &clk_sclk_mmc3.clk),
+	CLKDEV_INIT("exynos4-sdhci.0", "mmc_busclk.2", &clk_sclk_mmc0.clk),
+	CLKDEV_INIT("exynos4-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1.clk),
+	CLKDEV_INIT("exynos4-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2.clk),
+	CLKDEV_INIT("exynos4-sdhci.3", "mmc_busclk.2", &clk_sclk_mmc3.clk),
 	CLKDEV_INIT("dma-pl330.0", "apb_pclk", &clk_pdma0),
 	CLKDEV_INIT("dma-pl330.1", "apb_pclk", &clk_pdma1),
 	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk0", &clk_sclk_spi0.clk),
diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index c59e188..ca2f78a 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -255,6 +255,11 @@ void __init exynos4_map_io(void)
 	s3c_fimc_setname(2, "exynos4-fimc");
 	s3c_fimc_setname(3, "exynos4-fimc");
 
+	s3c_sdhci_setname(0, "exynos4-sdhci");
+	s3c_sdhci_setname(1, "exynos4-sdhci");
+	s3c_sdhci_setname(2, "exynos4-sdhci");
+	s3c_sdhci_setname(3, "exynos4-sdhci");
+
 	/* The I2C bus controllers are directly compatible with s3c2440 */
 	s3c_i2c0_setname("s3c2440-i2c");
 	s3c_i2c1_setname("s3c2440-i2c");
diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index f82f888..e00d35a 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -18,6 +18,8 @@
 #ifndef __PLAT_S3C_SDHCI_H
 #define __PLAT_S3C_SDHCI_H __FILE__
 
+#include <plat/devs.h>
+
 struct platform_device;
 struct mmc_host;
 struct mmc_card;
@@ -354,4 +356,30 @@ static inline void exynos4_default_sdhci3(void) { }
 
 #endif /* CONFIG_EXYNOS4_SETUP_SDHCI */
 
+static inline void s3c_sdhci_setname(int id, char *name)
+{
+	switch (id) {
+#ifdef CONFIG_S3C_DEV_HSMMC
+	case 0:
+		s3c_device_hsmmc0.name = name;
+		break;
+#endif
+#ifdef CONFIG_S3C_DEV_HSMMC1
+	case 1:
+		s3c_device_hsmmc1.name = name;
+		break;
+#endif
+#ifdef CONFIG_S3C_DEV_HSMMC2
+	case 2:
+		s3c_device_hsmmc2.name = name;
+		break;
+#endif
+#ifdef CONFIG_S3C_DEV_HSMMC3
+	case 3:
+		s3c_device_hsmmc3.name = name;
+		break;
+#endif
+	}
+}
+
 #endif /* __PLAT_S3C_SDHCI_H */
-- 
1.6.6.rc2

