From: thomas.ab@samsung.com
Subject: [PATCH 5/8] s3c6410: sdhci: Removing unused host_caps entry from sdhci0 platform data
Date: Tue,  8 Sep 2009 15:55:10 +0900
Message-ID: <1252392910-31200-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:43438 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636AbZIHHHO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Sep 2009 03:07:14 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Thomas Abraham <thomas.ab@samsung.com>

From: Thomas Abraham <thomas.ab@samsung.com>

This patch removes the unused 'host_caps' entry from the sdhci0
platform data.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/plat-s3c/dev-hsmmc.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-s3c/dev-hsmmc.c b/arch/arm/plat-s3c/dev-hsmmc.c
index 357ec60..647ca09 100644
--- a/arch/arm/plat-s3c/dev-hsmmc.c
+++ b/arch/arm/plat-s3c/dev-hsmmc.c
@@ -39,8 +39,6 @@ static u64 s3c_device_hsmmc_dmamask = 0xffffffffUL;
 
 struct s3c_sdhci_platdata s3c_hsmmc0_def_platdata = {
 	.max_width		= 4,
-	.host_caps		= (MMC_CAP_4_BIT_DATA |
-				  MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
 	.clk_parent_name	= "dout_mpll",
 	.clk_source_name 	= "mmc_bus",
 	.clk_speed		= 50*MHZ,
-- 
1.5.3.4

