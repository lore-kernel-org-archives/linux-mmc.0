From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] mmc: Fix hardware dependencies for sdhci-pxav3
Date: Mon, 23 Feb 2015 11:30:40 +0100
Message-ID: <20150223113040.09187221@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38990 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951AbbBWKan (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 23 Feb 2015 05:30:43 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Peter Robinson <pbrobinson@gmail.com>

It was brought to my attention that the sdhci-pxav3 driver is needed
on a few more ARM machines than I initially thought. Add the missing
architectures to the dependency list.

Credits to Peter Robinson for noticing my mistake and reporting.

Reported-by: Peter Robinson <pbrobinson@gmail.com>
Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
---
This could alternatively become ARM || COMPILE_TEST, both are fine
with me.

 drivers/mmc/host/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.20-rc0.orig/drivers/mmc/host/Kconfig	2015-02-20 17:34:20.636069178 +0100
+++ linux-3.20-rc0/drivers/mmc/host/Kconfig	2015-02-20 17:36:01.871206267 +0100
@@ -230,7 +230,7 @@ config MMC_SDHCI_PXAV3
 	tristate "Marvell MMP2 SD Host Controller support (PXAV3)"
 	depends on CLKDEV_LOOKUP
 	depends on MMC_SDHCI_PLTFM
-	depends on ARCH_MMP || COMPILE_TEST
+	depends on ARCH_BERLIN || ARCH_MMP || ARCH_MVEBU || COMPILE_TEST
 	default CPU_MMP2
 	help
 	  This selects the Marvell(R) PXAV3 SD Host Controller.


-- 
Jean Delvare
SUSE L3 Support
