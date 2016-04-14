From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 1/2] mmc: sdhci: use IS_REACHABLE(CONFIG_LEDS_CLASS) to enable LED code
Date: Thu, 14 Apr 2016 13:19:39 +0900
Message-ID: <1460607580-22599-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conuserg-09.nifty.com ([210.131.2.76]:44612 "EHLO
	conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbcDNETI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Apr 2016 00:19:08 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

defined(CONFIG_LEDS_CLASS) || (defined(CONFIG_LEDS_CLASS_MODULE) && \
    defined(CONFIG_MMC_SDHCI_MODULE))

is equivalent to:

defined(CONFIG_LEDS_CLASS) || (defined(CONFIG_LEDS_CLASS_MODULE) && \
    defined(MODULE))

and it can also be written shortly as:

IS_REACHABLE(CONFIG_LEDS_CLASS)

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Rebase on the next branch (7766e58f5be39dcc35d30a703422a3d0b8ec8c0c)

 drivers/mmc/host/sdhci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b284924..eedc18a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -259,9 +259,7 @@ static void __sdhci_led_deactivate(struct sdhci_host *host)
 	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 }
 
-#if defined(CONFIG_LEDS_CLASS) || (defined(CONFIG_LEDS_CLASS_MODULE) && \
-				   defined(CONFIG_MMC_SDHCI_MODULE))
-
+#if IS_REACHABLE(CONFIG_LEDS_CLASS)
 static void sdhci_led_control(struct led_classdev *led,
 			      enum led_brightness brightness)
 {
-- 
1.9.1

