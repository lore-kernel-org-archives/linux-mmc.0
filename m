From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] mmc: Add hardware dependencies for sdhci-pxav3 and
 sdhci-pxav2
Date: Wed, 23 Apr 2014 14:57:52 +0200
Message-ID: <20140423145752.004e5e7d@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33057 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752927AbaDWM54 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 23 Apr 2014 08:57:56 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>

I seem to understand that the sdhci-pxav3 and sdhci-pxav2 drivers are
only needed on the MMP architecture. So add a hardware dependency on
ARCH_MMP, so that other users don't get to build useless drivers.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-3.15-rc2.orig/drivers/mmc/host/Kconfig	2014-04-14 09:42:30.197082285 +0200
+++ linux-3.15-rc2/drivers/mmc/host/Kconfig	2014-04-23 14:10:48.863916201 +0200
@@ -215,7 +215,7 @@ config MMC_SDHCI_SIRF
 
 config MMC_SDHCI_PXAV3
 	tristate "Marvell MMP2 SD Host Controller support (PXAV3)"
-	depends on CLKDEV_LOOKUP
+	depends on CLKDEV_LOOKUP && (ARCH_MMP || COMPILE_TEST)
 	select MMC_SDHCI
 	select MMC_SDHCI_PLTFM
 	default CPU_MMP2
@@ -228,7 +228,7 @@ config MMC_SDHCI_PXAV3
 
 config MMC_SDHCI_PXAV2
 	tristate "Marvell PXA9XX SD Host Controller support (PXAV2)"
-	depends on CLKDEV_LOOKUP
+	depends on CLKDEV_LOOKUP && (ARCH_MMP || COMPILE_TEST)
 	select MMC_SDHCI
 	select MMC_SDHCI_PLTFM
 	default CPU_PXA910


-- 
Jean Delvare
SUSE L3 Support
