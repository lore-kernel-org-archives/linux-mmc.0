From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH v2] mmc: Add hardware dependencies for sdhci-pxav3 and
 sdhci-pxav2
Date: Mon, 16 Jun 2014 14:18:03 +0200
Message-ID: <20140616141803.7d1e2b8a@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57362 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216AbaFPMSH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 16 Jun 2014 08:18:07 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>

I seem to understand that the sdhci-pxav3 and sdhci-pxav2 drivers are
only needed on the MMP architecture. So add a hardware dependency on
ARCH_MMP, so that other users don't get to build useless drivers.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
---
Changes since v1:
 * Rebased on kernel 3.16-rc1

 drivers/mmc/host/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- linux-3.16-rc1.orig/drivers/mmc/host/Kconfig	2014-06-16 14:03:26.195946537 +0200
+++ linux-3.16-rc1/drivers/mmc/host/Kconfig	2014-06-16 14:04:02.128663037 +0200
@@ -217,6 +217,7 @@ config MMC_SDHCI_PXAV3
 	tristate "Marvell MMP2 SD Host Controller support (PXAV3)"
 	depends on CLKDEV_LOOKUP
 	depends on MMC_SDHCI_PLTFM
+	depends on ARCH_MMP || COMPILE_TEST
 	default CPU_MMP2
 	help
 	  This selects the Marvell(R) PXAV3 SD Host Controller.
@@ -229,6 +230,7 @@ config MMC_SDHCI_PXAV2
 	tristate "Marvell PXA9XX SD Host Controller support (PXAV2)"
 	depends on CLKDEV_LOOKUP
 	depends on MMC_SDHCI_PLTFM
+	depends on ARCH_MMP || COMPILE_TEST
 	default CPU_PXA910
 	help
 	  This selects the Marvell(R) PXAV2 SD Host Controller.


-- 
Jean Delvare
SUSE L3 Support
