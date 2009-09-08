From: thomas.ab@samsung.com
Subject: [PATCH 6/8] s3c6410: sdhci: Modify platform data for sdhci-1
Date: Tue,  8 Sep 2009 15:57:38 +0900
Message-ID: <1252393058-31226-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:43439 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562AbZIHHHO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Sep 2009 03:07:14 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Thomas Abraham <thomas.ab@samsung.com>

From: Thomas Abraham <thomas.ab@samsung.com>

This patch removes the unused entry host_caps from sdhci-1
platform data. It adds entries for parent clock name, source
clock name and operating clock speed.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/plat-s3c/dev-hsmmc1.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-s3c/dev-hsmmc1.c b/arch/arm/plat-s3c/dev-hsmmc1.c
index e49bc4c..88d4064 100644
--- a/arch/arm/plat-s3c/dev-hsmmc1.c
+++ b/arch/arm/plat-s3c/dev-hsmmc1.c
@@ -38,9 +38,10 @@ static struct resource s3c_hsmmc1_resource[] = {
 static u64 s3c_device_hsmmc1_dmamask = 0xffffffffUL;
 
 struct s3c_sdhci_platdata s3c_hsmmc1_def_platdata = {
-	.max_width	= 4,
-	.host_caps	= (MMC_CAP_4_BIT_DATA |
-			   MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
+	.max_width		= 4,
+        .clk_parent_name        = "dout_mpll",
+        .clk_source_name        = "mmc_bus",
+        .clk_speed              = 50*MHZ,
 };
 
 struct platform_device s3c_device_hsmmc1 = {
-- 
1.5.3.4

