From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v3 1/3] ARM: OMAP2+: remove unused defines from mach-omap2/mmc header
Date: Sun,  5 Oct 2014 01:26:55 +0200
Message-ID: <1412465217-17454-2-git-send-email-afenkart@gmail.com>
References: <1412465217-17454-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:64770 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbaJDX1J (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Oct 2014 19:27:09 -0400
In-Reply-To: <1412465217-17454-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, pascal.huerst@gmail.com, Andreas Fenkart <afenkart@gmail.com>

build tested for these architectures
CONFIG_MACH_OMAP2_TUSB6010=y
CONFIG_MACH_OMAP3_BEAGLE=y
CONFIG_MACH_DEVKIT8000=y
CONFIG_MACH_OMAP_LDP=y
CONFIG_MACH_OMAP3530_LV_SOM=y
CONFIG_MACH_OMAP3_TORPEDO=y
CONFIG_MACH_OVERO=y
CONFIG_MACH_OMAP3517EVM=y
CONFIG_MACH_CRANEBOARD=y
CONFIG_MACH_OMAP3_PANDORA=y
CONFIG_MACH_TOUCHBOOK=y
CONFIG_MACH_OMAP_3430SDP=y
CONFIG_MACH_NOKIA_N810=y
CONFIG_MACH_NOKIA_N810_WIMAX=y
CONFIG_MACH_NOKIA_N8X0=y
CONFIG_MACH_NOKIA_RX51=y
CONFIG_MACH_CM_T35=y
CONFIG_MACH_CM_T3517=y
CONFIG_MACH_CM_T3730=y
CONFIG_MACH_SBC3530=y
CONFIG_MACH_TI8168EVM=y
CONFIG_MACH_TI8148EVM=y

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

diff --git a/arch/arm/mach-omap2/mmc.h b/arch/arm/mach-omap2/mmc.h
index 0cd4b08..ea4fddf 100644
--- a/arch/arm/mach-omap2/mmc.h
+++ b/arch/arm/mach-omap2/mmc.h
@@ -2,18 +2,6 @@
 #include <linux/platform_data/mmc-omap.h>
 
 #define OMAP24XX_NR_MMC		2
-#define OMAP2420_MMC_SIZE	OMAP1_MMC_SIZE
-#define OMAP2_MMC1_BASE		0x4809c000
-
-#define OMAP4_MMC_REG_OFFSET	0x100
-
-#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
-void omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data);
-#else
-static inline void omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data)
-{
-}
-#endif
 
 struct omap_hwmod;
 int omap_msdi_reset(struct omap_hwmod *oh);
-- 
2.1.0

