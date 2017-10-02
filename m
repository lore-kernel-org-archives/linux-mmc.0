From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH] mmc: cavium: Depend on GPIO driver
Date: Mon,  2 Oct 2017 14:02:41 +0200
Message-ID: <1506945761-23482-1-git-send-email-jglauber@cavium.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54762 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750891AbdJBMCr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Oct 2017 08:02:47 -0400
Received: by mail-wm0-f66.google.com with SMTP id i124so10078308wmf.3
        for <linux-mmc@vger.kernel.org>; Mon, 02 Oct 2017 05:02:46 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, David Daney <david.daney@cavium.com>, "Steven J. Hill" <Steven.Hill@cavium.com>, Jan Glauber <jglauber@cavium.com>

Without the ThunderX/OcteonTx GPIO driver the MMC driver
would not power up any MMC devices. Therefore add a
dependency to the GPIO driver and remove the unneeded GPIOLIB
dependency.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 8c15637178ff..a47a2f1d8ae4 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -663,7 +663,7 @@ config MMC_CAVIUM_OCTEON
 config MMC_CAVIUM_THUNDERX
 	tristate "Cavium ThunderX SD/MMC Card Interface support"
 	depends on PCI && 64BIT && (ARM64 || COMPILE_TEST)
-	depends on GPIOLIB
+	depends on GPIO_THUNDERX
 	depends on OF_ADDRESS
 	help
 	  This selects Cavium ThunderX SD/MMC Card Interface.
-- 
2.9.0.rc0.21.g7777322

