From: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Subject: [PATCH V5 6/6] ARM: imx53_loco: add esdhc device support
Date: Wed, 2 Mar 2011 18:04:43 +0800
Message-ID: <1299060283-6404-6-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1299060283-6404-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe006.messaging.microsoft.com ([213.199.154.209]:24466
	"EHLO AM1EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756444Ab1CBKIe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Mar 2011 05:08:34 -0500
In-Reply-To: <1299060283-6404-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, w.sang@pengutronix.de, linuxzsc@gmail.com, richard.zhao@freescale.com, eric.miao@linaro.org, Richard Zhu <Hong-Xing.Zhu@freescale.com>

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
Acked-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/arm/mach-mx5/Kconfig           |    1 +
 arch/arm/mach-mx5/board-mx53_loco.c |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index f065a0d..a72c833 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -162,6 +162,7 @@ config MACH_MX53_LOCO
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	help
 	  Include support for MX53 LOCO platform. This includes specific
 	  configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 160899e..0a18f8d 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -213,6 +213,8 @@ static void __init mx53_loco_board_init(void)
 	imx53_add_imx2_wdt(0, NULL);
 	imx53_add_imx_i2c(0, &mx53_loco_i2c_data);
 	imx53_add_imx_i2c(1, &mx53_loco_i2c_data);
+	imx53_add_sdhci_esdhc_imx(0, NULL);
+	imx53_add_sdhci_esdhc_imx(2, NULL);
 }
 
 static void __init mx53_loco_timer_init(void)
-- 
1.7.1


