From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 2/6] mmc: sh_mobile_sdhi: remove obsolete irq_by_name registration
Date: Wed,  6 Apr 2016 11:25:30 +0200
Message-ID: <1459934734-3613-3-git-send-email-wsa@the-dreams.de>
References: <1459934734-3613-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1459934734-3613-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: linux-mmc@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

There is no user left in the kernel, so this code can be removed.
(Legacy, non-DT sh_mobile boards have been removed a while ago.) The
diff looks more complicated than it is: The if-block for multiplexed isr
is now the main code path, the rest is removed. A number of sh boards
included the now deleted include file without needing it. Remove that,
too.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/sh/boards/board-sh7757lcr.c     |  1 -
 arch/sh/boards/mach-ap325rxa/setup.c |  1 -
 arch/sh/boards/mach-ecovec24/setup.c |  1 -
 arch/sh/boards/mach-kfr2r09/setup.c  |  1 -
 arch/sh/boards/mach-migor/setup.c    |  1 -
 arch/sh/boards/mach-se/7724/setup.c  |  1 -
 drivers/mmc/host/sh_mobile_sdhi.c    | 57 +++++-------------------------------
 include/linux/mmc/sh_mobile_sdhi.h   | 10 -------
 8 files changed, 8 insertions(+), 65 deletions(-)
 delete mode 100644 include/linux/mmc/sh_mobile_sdhi.h

diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh7757lcr.c
index 324599bfad1420..0104c8199c48fe 100644
--- a/arch/sh/boards/board-sh7757lcr.c
+++ b/arch/sh/boards/board-sh7757lcr.c
@@ -20,7 +20,6 @@
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
-#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/sh_eth.h>
 #include <linux/sh_intc.h>
 #include <linux/usb/renesas_usbhs.h>
diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
index 62c3b81300ed28..de8393cb7313bc 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -15,7 +15,6 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/mmc/host.h>
-#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/sh_flctl.h>
 #include <linux/mfd/tmio.h>
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index a9c0c07386fddd..6d612792f6b8ec 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -13,7 +13,6 @@
 #include <linux/platform_device.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
-#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mfd/tmio.h>
 #include <linux/gpio.h>
diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 6bd9230e64e300..5deb2d82f19f78 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -11,7 +11,6 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/mmc/host.h>
-#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/onenand.h>
diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index 7a04da3efce402..5de60a77eaa1ab 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -13,7 +13,6 @@
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
 #include <linux/mmc/host.h>
-#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mtd/nand.h>
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index e0e1df136642cd..f1fecd395679ae 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -15,7 +15,6 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/mmc/host.h>
-#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mtd/physmap.h>
 #include <linux/delay.h>
diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 9beee48d2e280d..51d8dbd5b06a3e 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -28,7 +28,6 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/mmc/host.h>
-#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
 #include <linux/sh_dma.h>
 #include <linux/delay.h>
@@ -315,7 +314,6 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	struct tmio_mmc_host *host;
 	struct resource *res;
 	int irq, ret, i = 0;
-	bool multiplexed_isr = true;
 	struct tmio_mmc_dma *dma_priv;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -405,62 +403,23 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto efree;
 
-	/*
-	 * Allow one or more specific (named) ISRs or
-	 * one or more multiplexed (un-named) ISRs.
-	 */
-
-	irq = platform_get_irq_byname(pdev, SH_MOBILE_SDHI_IRQ_CARD_DETECT);
-	if (irq >= 0) {
-		multiplexed_isr = false;
-		ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_card_detect_irq, 0,
+	while (1) {
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0)
+			break;
+		i++;
+		ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_irq, 0,
 				  dev_name(&pdev->dev), host);
 		if (ret)
 			goto eirq;
 	}
 
-	irq = platform_get_irq_byname(pdev, SH_MOBILE_SDHI_IRQ_SDIO);
-	if (irq >= 0) {
-		multiplexed_isr = false;
-		ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_sdio_irq, 0,
-				  dev_name(&pdev->dev), host);
-		if (ret)
-			goto eirq;
-	}
-
-	irq = platform_get_irq_byname(pdev, SH_MOBILE_SDHI_IRQ_SDCARD);
-	if (irq >= 0) {
-		multiplexed_isr = false;
-		ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_sdcard_irq, 0,
-				  dev_name(&pdev->dev), host);
-		if (ret)
-			goto eirq;
-	} else if (!multiplexed_isr) {
-		dev_err(&pdev->dev,
-			"Principal SD-card IRQ is missing among named interrupts\n");
+	/* There must be at least one IRQ source */
+	if (!i) {
 		ret = irq;
 		goto eirq;
 	}
 
-	if (multiplexed_isr) {
-		while (1) {
-			irq = platform_get_irq(pdev, i);
-			if (irq < 0)
-				break;
-			i++;
-			ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_irq, 0,
-					  dev_name(&pdev->dev), host);
-			if (ret)
-				goto eirq;
-		}
-
-		/* There must be at least one IRQ source */
-		if (!i) {
-			ret = irq;
-			goto eirq;
-		}
-	}
-
 	dev_info(&pdev->dev, "%s base at 0x%08lx max clock rate %u MHz\n",
 		 mmc_hostname(host->mmc), (unsigned long)
 		 (platform_get_resource(pdev, IORESOURCE_MEM, 0)->start),
diff --git a/include/linux/mmc/sh_mobile_sdhi.h b/include/linux/mmc/sh_mobile_sdhi.h
deleted file mode 100644
index 95d6f0314a7ded..00000000000000
--- a/include/linux/mmc/sh_mobile_sdhi.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef LINUX_MMC_SH_MOBILE_SDHI_H
-#define LINUX_MMC_SH_MOBILE_SDHI_H
-
-#include <linux/types.h>
-
-#define SH_MOBILE_SDHI_IRQ_CARD_DETECT	"card_detect"
-#define SH_MOBILE_SDHI_IRQ_SDCARD	"sdcard"
-#define SH_MOBILE_SDHI_IRQ_SDIO		"sdio"
-
-#endif /* LINUX_MMC_SH_MOBILE_SDHI_H */
-- 
2.7.0
