From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] mmc: sdhci-of-at91: remove bogus MMC_SDHCI_IO_ACCESSORS select
Date: Thu,  1 Dec 2016 13:05:46 +0900
Message-ID: <1480565146-4857-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conuserg-11.nifty.com ([210.131.2.78]:18745 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbcLAEHQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2016 23:07:16 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>, Al Cooper <alcooperx@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Andrei Pistirica <andrei.pistirica@microchip.com>, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>

I see no override of read/write callbacks in sdhci-of-at91.c.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

BTW, this config may not be so useful in recent multi-platforms.
Perhaps, is it better to remove this config entirely instead of
the AT91 fix only.


 drivers/mmc/host/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 39f6f96..8ac1640 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -135,7 +135,6 @@ config MMC_SDHCI_OF_AT91
 	tristate "SDHCI OF support for the Atmel SDMMC controller"
 	depends on MMC_SDHCI_PLTFM
 	depends on OF
-	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the Atmel SDMMC driver
 
-- 
2.7.4

