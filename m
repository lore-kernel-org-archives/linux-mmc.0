From: Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/6] arm: exynos4: use 'exynos4-sdhci' as device name for sdhci
 controllers
Date: Thu, 03 Nov 2011 02:05:59 +0530
Message-ID: <1320266163-15292-3-git-send-email-thomas.abraham@linaro.org>
References: <1320266163-15292-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-reply-to: <1320266163-15292-1-git-send-email-thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

With the addition of platform specific driver data in the sdhci driver
for exynos4, the device name of sdhci controllers on exynos4 is changed
accordingly.

Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/mach-exynos4/clock.c              |   24 ++++++++++++------------
 arch/arm/mach-exynos4/cpu.c                |    5 +++++
 arch/arm/plat-samsung/include/plat/sdhci.h |   27 +++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
index 6eeabdd..94fc337 100644
--- a/arch/arm/mach-exynos4/clock.c
+++ b/arch/arm/mach-exynos4/clock.c
@@ -495,25 +495,25 @@ static struct clk init_clocks_off[] = {
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
@@ -1221,7 +1221,7 @@ static struct clksrc_clk clk_sclk_uart3 = {
 static struct clksrc_clk clk_sclk_mmc0 = {
 	.clk		= {
 		.name		= "sclk_mmc",
-		.devname	= "s3c-sdhci.0",
+		.devname	= "exynos4-sdhci.0",
 		.parent		= &clk_dout_mmc0.clk,
 		.enable		= exynos4_clksrc_mask_fsys_ctrl,
 		.ctrlbit	= (1 << 0),
@@ -1232,7 +1232,7 @@ static struct clksrc_clk clk_sclk_mmc0 = {
 static struct clksrc_clk clk_sclk_mmc1 = {
 	.clk		= {
 		.name		= "sclk_mmc",
-		.devname	= "s3c-sdhci.1",
+		.devname	= "exynos4-sdhci.1",
 		.parent         = &clk_dout_mmc1.clk,
 		.enable		= exynos4_clksrc_mask_fsys_ctrl,
 		.ctrlbit	= (1 << 4),
@@ -1243,7 +1243,7 @@ static struct clksrc_clk clk_sclk_mmc1 = {
 static struct clksrc_clk clk_sclk_mmc2 = {
 	.clk		= {
 		.name		= "sclk_mmc",
-		.devname	= "s3c-sdhci.2",
+		.devname	= "exynos4-sdhci.2",
 		.parent         = &clk_dout_mmc2.clk,
 		.enable		= exynos4_clksrc_mask_fsys_ctrl,
 		.ctrlbit	= (1 << 8),
@@ -1254,7 +1254,7 @@ static struct clksrc_clk clk_sclk_mmc2 = {
 static struct clksrc_clk clk_sclk_mmc3 = {
 	.clk		= {
 		.name		= "sclk_mmc",
-		.devname	= "s3c-sdhci.3",
+		.devname	= "exynos4-sdhci.3",
 		.parent         = &clk_dout_mmc3.clk,
 		.enable		= exynos4_clksrc_mask_fsys_ctrl,
 		.ctrlbit	= (1 << 12),
@@ -1317,10 +1317,10 @@ static struct clk_lookup exynos4_clk_lookup[] = {
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
 };
diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
index 6ac9baf..152c8b1 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -195,6 +195,11 @@ void __init exynos4_map_io(void)
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
index dcff7dd..8daaa4d 100644
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
@@ -309,4 +311,29 @@ static inline void exynos4_default_sdhci3(void) { }
 
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
 #endif /* __PLAT_S3C_SDHCI_H */
-- 
1.6.6.rc2
