From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4/4] mmc: simplify SDHCI Kconfig dependencies
Date: Thu,  5 Jun 2014 23:14:41 +0200
Message-ID: <1402002881-1986640-5-git-send-email-arnd@arndb.de>
References: <1402002881-1986640-1-git-send-email-arnd@arndb.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:52421 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbaFEVO5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jun 2014 17:14:57 -0400
In-Reply-To: <1402002881-1986640-1-git-send-email-arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

We have a number of front-end drivers for SDHCI_PLTFM, some of them
use 'select MMC_SDHCI_PLTFM', others use 'depends on'. This is
inconsistent and confusing, and in one case has also led to a
build error because of incomplete dependencies:

warning: (MMC_SDHCI_PXAV3 && MMC_SDHCI_PXAV2 && MMC_SDHCI_BCM_KONA) selects MMC_SDHCI_PLTFM which has unmet direct dependencies (MMC && MMC_SDHCI)
drivers/built-in.o: In function `sdhci_sirf_resume':
:(.text+0xaaacb4): undefined reference to `sdhci_resume_host'
drivers/built-in.o: In function `sdhci_sirf_suspend':
:(.text+0xaaacf8): undefined reference to `sdhci_suspend_host'
drivers/built-in.o: In function `sdhci_sirf_probe':
:(.text+0xaaaf44): undefined reference to `sdhci_add_host'
:(.text+0xaaaf50): undefined reference to `sdhci_remove_host'

This changes Kconfig to use 'depends on MMC_SDHCI_PLTFM' for all these
cases, to fix the build error and make the logic more logical.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/Kconfig | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index adffe0e..9682ad1 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -216,8 +216,7 @@ config MMC_SDHCI_SIRF
 config MMC_SDHCI_PXAV3
 	tristate "Marvell MMP2 SD Host Controller support (PXAV3)"
 	depends on CLKDEV_LOOKUP
-	select MMC_SDHCI
-	select MMC_SDHCI_PLTFM
+	depends on MMC_SDHCI_PLTFM
 	default CPU_MMP2
 	help
 	  This selects the Marvell(R) PXAV3 SD Host Controller.
@@ -229,8 +228,7 @@ config MMC_SDHCI_PXAV3
 config MMC_SDHCI_PXAV2
 	tristate "Marvell PXA9XX SD Host Controller support (PXAV2)"
 	depends on CLKDEV_LOOKUP
-	select MMC_SDHCI
-	select MMC_SDHCI_PLTFM
+	depends on MMC_SDHCI_PLTFM
 	default CPU_PXA910
 	help
 	  This selects the Marvell(R) PXAV2 SD Host Controller.
@@ -264,7 +262,7 @@ config MMC_SDHCI_S3C_DMA
 config MMC_SDHCI_BCM_KONA
 	tristate "SDHCI support on Broadcom KONA platform"
 	depends on ARCH_BCM_MOBILE
-	select MMC_SDHCI_PLTFM
+	depends on MMC_SDHCI_PLTFM
 	help
 	  This selects the Broadcom Kona Secure Digital Host Controller
 	  Interface(SDHCI) support.
-- 
1.8.3.2

