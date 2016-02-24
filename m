From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] mmc: sh_mmcif, tmio: Use ARCH_RENESAS
Date: Wed, 24 Feb 2016 11:39:33 +0900
Message-ID: <1456281573-16458-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:43822 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223AbcBXCjl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Feb 2016 21:39:41 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.

This is part of an ongoing process to migrate from ARCH_SHMOBILE to
ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/mmc/host/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

 Based on mmc/next

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index d9a9d92fa837..04feea8354cb 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -561,7 +561,7 @@ config MMC_TMIO
 config MMC_SDHI
 	tristate "SH-Mobile SDHI SD/SDIO controller support"
 	depends on SUPERH || ARM || ARM64
-	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
+	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
 	select MMC_TMIO_CORE
 	help
 	  This provides support for the SDHI SD/SDIO controller found in
@@ -674,7 +674,7 @@ config MMC_DW_ROCKCHIP
 config MMC_SH_MMCIF
 	tristate "SuperH Internal MMCIF support"
 	depends on HAS_DMA
-	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
+	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
 	help
 	  This selects the MMC Host Interface controller (MMCIF).
 
-- 
2.1.4

