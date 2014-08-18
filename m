From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] mmc: select GPIOLIB for MMC support
Date: Mon, 18 Aug 2014 10:20:17 -0500
Message-ID: <1408375217-20500-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:62882 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbaHRPU1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Aug 2014 11:20:27 -0400
Received: by mail-ig0-f172.google.com with SMTP id h15so8407247igd.17
        for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2014 08:20:26 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

The slot-gpio support has been compiled into the core for some time,
and it basically requires GPIOLIB to be present, very few systems
are using the archaic GPIO API (just defined function names) and
those should be migrated to GPIOLIB anyway.

The rewrite to use GPIO descriptors require that we enable GPIOLIB,
so make CONFIG_MMC select CONFIG_GPIOLIB.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index f2eeb38efa65..bf44002793c4 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -5,6 +5,7 @@
 menuconfig MMC
 	tristate "MMC/SD/SDIO card support"
 	depends on HAS_IOMEM
+	select GPIOLIB
 	help
 	  This selects MultiMediaCard, Secure Digital and Secure
 	  Digital I/O support.
-- 
1.9.3

