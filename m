From: thomas.ab@samsung.com
Subject: [PATCH 2/8] s3c6410: sdhci: Adding additional data in sdhci platform data structure.
Date: Tue,  8 Sep 2009 15:47:38 +0900
Message-ID: <1252392458-23921-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:57695 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470AbZIHG5Q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Sep 2009 02:57:16 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Thomas Abraham <thomas.ab@samsung.com>

From: Thomas Abraham <thomas.ab@samsung.com>

This patch adds additional information about the parent clock
name, sdhci clock name and desired sdhci operating frequency
in the sdhci platform data structure.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/plat-s3c/dev-hsmmc.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-s3c/dev-hsmmc.c b/arch/arm/plat-s3c/dev-hsmmc.c
index 4c05b39..357ec60 100644
--- a/arch/arm/plat-s3c/dev-hsmmc.c
+++ b/arch/arm/plat-s3c/dev-hsmmc.c
@@ -38,9 +38,12 @@ static struct resource s3c_hsmmc_resource[] = {
 static u64 s3c_device_hsmmc_dmamask = 0xffffffffUL;
 
 struct s3c_sdhci_platdata s3c_hsmmc0_def_platdata = {
-	.max_width	= 4,
-	.host_caps	= (MMC_CAP_4_BIT_DATA |
-			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
+	.max_width		= 4,
+	.host_caps		= (MMC_CAP_4_BIT_DATA |
+				  MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
+	.clk_parent_name	= "dout_mpll",
+	.clk_source_name 	= "mmc_bus",
+	.clk_speed		= 50*MHZ,
 };
 
 struct platform_device s3c_device_hsmmc0 = {
-- 
1.5.3.4

