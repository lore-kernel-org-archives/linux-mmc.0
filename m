From: Richard Zhao <richard.zhao@freescale.com>
Subject: [PATCH 3/5] ARM: imx53_loco: add esdhc device support
Date: Mon, 21 Feb 2011 17:54:53 +0800
Message-ID: <1298282095-2279-3-git-send-email-richard.zhao@freescale.com>
References: <1298282095-2279-1-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:53737 "EHLO
	TX2EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339Ab1BUJzY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Feb 2011 04:55:24 -0500
Received: from mail41-tx2 (localhost.localdomain [127.0.0.1])	by
 mail41-tx2-R.bigfish.com (Postfix) with ESMTP id 4686F7E0102	for
 <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2011 09:55:23 +0000 (UTC)
Received: from TX2EHSMHS029.bigfish.com (unknown [10.9.14.250])	by
 mail41-tx2.bigfish.com (Postfix) with ESMTP id 2688E598050	for
 <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2011 09:55:23 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
 [10.64.34.199])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
 p1L9t0cM022391	for <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2011 02:55:11
 -0700 (MST)
Received: from b20223-02 (B20223-02.ap.freescale.net [10.192.242.48])	by
 az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id p1L9sx3Q028487	for
 <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2011 03:55:00 -0600 (CST)
In-Reply-To: <1298282095-2279-1-git-send-email-richard.zhao@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, w.sang@pengutronix.de, linuxzsc@gmail.com, r65037@freescale.com, Richard Zhao <richard.zhao@freescale.com>

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>

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


