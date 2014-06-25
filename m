From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: [PATCH 1/1] mmc: host: Kconfig: Update SDHCI S3C entry
Date: Wed, 25 Jun 2014 15:28:06 +0530
Message-ID: <1403690286-1264-1-git-send-email-sachin.kamat@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:53040 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbaFYKB0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Jun 2014 06:01:26 -0400
Received: by mail-pd0-f181.google.com with SMTP id v10so1458480pde.40
        for <linux-mmc@vger.kernel.org>; Wed, 25 Jun 2014 03:01:25 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, tgih.jun@samsung.com, spk.linux@gmail.com, Doug Anderson <dianders@chromium.org>

All Exynos4 SoC based boards have SDHCI controller and mostly
use SD mounted filesystem. Hence it makes sense to default it
to yes on Exynos4 platform. While at it also fix a couple of
typos in the help text.

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
---
 drivers/mmc/host/Kconfig |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index a5652548230a..fe812dd876df 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -193,10 +193,11 @@ config MMC_SDHCI_TEGRA
 config MMC_SDHCI_S3C
 	tristate "SDHCI support on Samsung S3C SoC"
 	depends on MMC_SDHCI && PLAT_SAMSUNG
+	default y if ARCH_EXYNOS4
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
-	  often referrered to as the HSMMC block in some of the Samsung S3C
-	  range of SoC.
+	  often referred to as the HSMMC block in some of the Samsung S3C
+	  range of SoCs.
 
 	  If you have a controller with this interface, say Y or M here.
 
-- 
1.7.9.5

