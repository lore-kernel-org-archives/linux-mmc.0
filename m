From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH 2/3] arm: exynos4: use 'exynos4-sdhci' as device name for sdhci
 controllers
Date: Tue, 04 Oct 2011 12:58:34 +0530
Message-ID: <1317713315-5830-3-git-send-email-thomas.abraham@linaro.org>
References: <1317713315-5830-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:29590 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071Ab1JDH2e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Oct 2011 03:28:34 -0400
In-reply-to: <1317713315-5830-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org

With the addition of platform specific driver data in the sdhci driver
for exynos4, the device name of sdhci controllers on exynos4 is changed
accordingly.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos4/clock.c              |   16 ++++++++--------
 arch/arm/mach-exynos4/cpu.c                |    5 +++++
 arch/arm/plat-samsung/include/plat/sdhci.h |   27 +++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
index a25c818..d89b45e 100644
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
@@ -1198,7 +1198,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "sclk_mmc",
-			.devname	= "s3c-sdhci.0",
+			.devname	= "exynos4-sdhci.0",
 			.parent		= &clk_dout_mmc0.clk,
 			.enable		= exynos4_clksrc_mask_fsys_ctrl,
 			.ctrlbit	= (1 << 0),
@@ -1207,7 +1207,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "sclk_mmc",
-			.devname	= "s3c-sdhci.1",
+			.devname	= "exynos4-sdhci.1",
 			.parent         = &clk_dout_mmc1.clk,
 			.enable		= exynos4_clksrc_mask_fsys_ctrl,
 			.ctrlbit	= (1 << 4),
@@ -1216,7 +1216,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "sclk_mmc",
-			.devname	= "s3c-sdhci.2",
+			.devname	= "exynos4-sdhci.2",
 			.parent         = &clk_dout_mmc2.clk,
 			.enable		= exynos4_clksrc_mask_fsys_ctrl,
 			.ctrlbit	= (1 << 8),
@@ -1225,7 +1225,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "sclk_mmc",
-			.devname	= "s3c-sdhci.3",
+			.devname	= "exynos4-sdhci.3",
 			.parent         = &clk_dout_mmc3.clk,
 			.enable		= exynos4_clksrc_mask_fsys_ctrl,
 			.ctrlbit	= (1 << 12),
diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
index 2aa3df0..8f0f897 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -175,6 +175,11 @@ void __init exynos4_map_io(void)
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
index e7b3c75..8f9a7d7 100644
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
@@ -340,4 +342,29 @@ static inline void exynos4_default_sdhci3(void) { }
 
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

