From: Zhangfei Gao <zhangfei.gao@marvell.com>
Subject: [PATCH v2 3/3] ARM: mmp2: update mmp2 mmc resource
Date: Wed, 25 May 2011 05:23:37 -0400
Message-ID: <1306315417-16096-1-git-send-email-zhangfei.gao@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:48659 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab1EYJXk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 May 2011 05:23:40 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, linux-mmc@vg
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>

	mmp2 mmc driver name update to sdhci-mmp2 according with sdhci-mmp2.c

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 arch/arm/mach-mmp/mmp2.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index 8e6c3ac..a7ba5cf 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -168,10 +168,10 @@ static struct clk_lookup mmp2_clkregs[] = {
 	INIT_CLKREG(&clk_twsi5, "pxa2xx-i2c.4", NULL),
 	INIT_CLKREG(&clk_twsi6, "pxa2xx-i2c.5", NULL),
 	INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
-	INIT_CLKREG(&clk_sdh0, "sdhci-pxa.0", "PXA-SDHCLK"),
-	INIT_CLKREG(&clk_sdh1, "sdhci-pxa.1", "PXA-SDHCLK"),
-	INIT_CLKREG(&clk_sdh2, "sdhci-pxa.2", "PXA-SDHCLK"),
-	INIT_CLKREG(&clk_sdh3, "sdhci-pxa.3", "PXA-SDHCLK"),
+	INIT_CLKREG(&clk_sdh0, "sdhci-mmp2.0", "PXA-SDHCLK"),
+	INIT_CLKREG(&clk_sdh1, "sdhci-mmp2.1", "PXA-SDHCLK"),
+	INIT_CLKREG(&clk_sdh2, "sdhci-mmp2.2", "PXA-SDHCLK"),
+	INIT_CLKREG(&clk_sdh3, "sdhci-mmp2.3", "PXA-SDHCLK"),
 };
 
 static int __init mmp2_init(void)
@@ -222,8 +222,8 @@ MMP2_DEVICE(twsi4, "pxa2xx-i2c", 3, TWSI4, 0xd4033000, 0x70);
 MMP2_DEVICE(twsi5, "pxa2xx-i2c", 4, TWSI5, 0xd4033800, 0x70);
 MMP2_DEVICE(twsi6, "pxa2xx-i2c", 5, TWSI6, 0xd4034000, 0x70);
 MMP2_DEVICE(nand, "pxa3xx-nand", -1, NAND, 0xd4283000, 0x100, 28, 29);
-MMP2_DEVICE(sdh0, "sdhci-pxa", 0, MMC, 0xd4280000, 0x120);
-MMP2_DEVICE(sdh1, "sdhci-pxa", 1, MMC2, 0xd4280800, 0x120);
-MMP2_DEVICE(sdh2, "sdhci-pxa", 2, MMC3, 0xd4281000, 0x120);
-MMP2_DEVICE(sdh3, "sdhci-pxa", 3, MMC4, 0xd4281800, 0x120);
+MMP2_DEVICE(sdh0, "sdhci-mmp2", 0, MMC, 0xd4280000, 0x120);
+MMP2_DEVICE(sdh1, "sdhci-mmp2", 1, MMC2, 0xd4280800, 0x120);
+MMP2_DEVICE(sdh2, "sdhci-mmp2", 2, MMC3, 0xd4281000, 0x120);
+MMP2_DEVICE(sdh3, "sdhci-mmp2", 3, MMC4, 0xd4281800, 0x120);
 
-- 
1.7.0.4

