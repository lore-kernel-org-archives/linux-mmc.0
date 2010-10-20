From: Richard Zhu <r65037@freescale.com>
Subject: [PATCH 2/2] Add the HW board caps flag for MX51 BBG
Date: Wed, 20 Oct 2010 18:00:28 +0800
Message-ID: <1287568828-22563-3-git-send-email-r65037@freescale.com>
References: <1287568828-22563-1-git-send-email-r65037@freescale.com>
 <1287568828-22563-2-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:8447
	"EHLO DB3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751251Ab0JTJ4K (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Oct 2010 05:56:10 -0400
Received: from mail1-db3 (localhost.localdomain [127.0.0.1])	by
 mail1-db3-R.bigfish.com (Postfix) with ESMTP id 941EDAF84D0	for
 <linux-mmc@vger.kernel.org>; Wed, 20 Oct 2010 09:56:08 +0000 (UTC)
Received: from DB3EHSMHS009.bigfish.com (unknown [10.3.81.241])	by
 mail1-db3.bigfish.com (Postfix) with ESMTP id 7D1C311C80C4	for
 <linux-mmc@vger.kernel.org>; Wed, 20 Oct 2010 09:55:35 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
 [10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
 o9K9tVm8017164	for <linux-mmc@vger.kernel.org>; Wed, 20 Oct 2010 02:55:32
 -0700 (MST)
Received: from shlinux1.ap.freescale.net (R62363-04.ap.freescale.net
 [10.192.225.216])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
 o9K9tV2V008999	for <linux-mmc@vger.kernel.org>; Wed, 20 Oct 2010 04:55:31
 -0500 (CDT)
In-Reply-To: <1287568828-22563-2-git-send-email-r65037@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, eric@eukrea.com, w.sang@pengutronix.de
Cc: r65037@freescale.com

Some HW boards may have the bus-width caps limitation in HW design refer
to the caps of the IC module.
For example, the MAX BUS width the eSDHC module on i.MX51 is up to
8bits.
But only the 1/4bits bus are supported on i.MX51 BBG boards.

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 arch/arm/mach-mx5/board-mx51_babbage.c |    3 +++
 arch/arm/plat-mxc/include/mach/esdhc.h |    1 +
 drivers/mmc/host/sdhci-esdhc-imx.c     |    1 +
 drivers/mmc/host/sdhci.c               |    8 ++++++--
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 5a69cda..9261ce9 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -24,6 +24,7 @@
 #include <mach/iomux-mx51.h>
 #include <mach/i2c.h>
 #include <mach/mxc_ehci.h>
+#include <mach/mmc.h>
 
 #include <asm/irq.h>
 #include <asm/setup.h>
@@ -263,10 +264,12 @@ __setup("otg_mode=", babbage_otg_mode);
 
 static struct esdhc_platform_data esdhc_imx_pdata1 = {
 	.wp_gpio = BABBAGE_SDHCI1_WP,
+	.caps = MMC_CAP_4_BIT_DATA,
 };
 
 static struct esdhc_platform_data esdhc_imx_pdata2 = {
 	.wp_gpio = BABBAGE_SDHCI2_WP,
+	.caps = MMC_CAP_4_BIT_DATA,
 };
 
 /*
diff --git a/arch/arm/plat-mxc/include/mach/esdhc.h b/arch/arm/plat-mxc/include/mach/esdhc.h
index a48a9aa..de6e84b 100644
--- a/arch/arm/plat-mxc/include/mach/esdhc.h
+++ b/arch/arm/plat-mxc/include/mach/esdhc.h
@@ -12,5 +12,6 @@
 
 struct esdhc_platform_data {
 	unsigned int wp_gpio;	/* write protect pin */
+	unsigned int caps;	/* hw board esdhc caps */
 };
 #endif /* __ASM_ARCH_IMX_ESDHC_H */
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 6556762..1f80936 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -129,6 +129,7 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
 	if (boarddata) {
 		gpio_request(boarddata->wp_gpio, "SD_WP");
 		gpio_direction_input(boarddata->wp_gpio);
+		host->caps |=  boarddata->caps;
 	}
 	return 0;
 }
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 782c0ee..7c12442 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1848,8 +1848,12 @@ int sdhci_add_host(struct sdhci_host *host)
 	mmc->f_max = host->max_clk;
 	mmc->caps |= MMC_CAP_SDIO_IRQ;
 
-	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
-		mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
+	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA)) {
+		if (host->caps & MMC_CAP_8_BIT_DATA)
+			mmc->caps |= MMC_CAP_8_BIT_DATA;
+		if (host->caps & MMC_CAP_4_BIT_DATA)
+			mmc->caps |= MMC_CAP_4_BIT_DATA;
+	}
 
 	if (caps & SDHCI_CAN_DO_HISPD)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
-- 
1.6.3.3


