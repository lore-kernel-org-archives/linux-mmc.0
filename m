From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH 1/2] mmc: dw_mmc: exynos: Stop claiming wp-gpio
Date: Wed, 21 Nov 2012 14:03:02 -0800
Message-ID: <1353535387-32106-1-git-send-email-dianders@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f202.google.com ([209.85.212.202]:33659 "EHLO
	mail-wi0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756570Ab2KVTM2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Nov 2012 14:12:28 -0500
Received: by mail-wi0-f202.google.com with SMTP id cb5so81960wib.1
        for <linux-mmc@vger.kernel.org>; Thu, 22 Nov 2012 11:12:27 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, Thomas Abraham <thomas.abraham@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Will Newton <will.newton@imgtec.com>, Chris Ball <cjb@laptop.org>, Doug Anderson <dianders@chromium.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

The exynos code claimed wp-gpio with devm_gpio_request() but never did
anything with it.  That meant that anyone using a write protect GPIO
would effectively be write protected all the time.

A future change will move the wp-gpio support to the core dw_mmc.c
file.  Now the exynos-specific code won't claim the GPIO but will
just set the DW_MCI_QUIRK_NO_WRITE_PROTECT quirk if write protect
won't be used.

Signed-off-by: Doug Anderson <dianders@chromium.org>

---
 drivers/mmc/host/dw_mmc-exynos.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 4d50da6..58cc03e 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -175,12 +175,12 @@ static int dw_mci_exynos_setup_bus(struct dw_mci *host,
 		}
 	}
 
-	gpio = of_get_named_gpio(slot_np, "wp-gpios", 0);
-	if (gpio_is_valid(gpio)) {
-		if (devm_gpio_request(host->dev, gpio, "dw-mci-wp"))
-			dev_info(host->dev, "gpio [%d] request failed\n",
-						gpio);
-	} else {
+	/*
+	 * If there are no write-protect GPIOs present then we assume no write
+	 * protect.  The mci_readl() in dw_mmc.c won't work since it's not
+	 * hooked up on exynos.
+	 */
+	if (!of_find_property(slot_np, "wp-gpios", NULL)) {
 		dev_info(host->dev, "wp gpio not available");
 		host->pdata->quirks |= DW_MCI_QUIRK_NO_WRITE_PROTECT;
 	}
-- 
1.7.7.3

