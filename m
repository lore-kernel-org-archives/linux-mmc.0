From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [PATCH] mmc: sdhci-esdhc: add default quirk SDHCI_QUIRK_NO_HISPD_BIT
Date: Fri, 10 Jul 2015 11:42:37 +0800
Message-ID: <1436499757-16342-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0137.outbound.protection.outlook.com ([157.56.111.137]:36994
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751720AbbGJDrY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jul 2015 23:47:24 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

eSDHC supports high speed mode, but has no enabling bit for it.
Add this quirk to avoid writing to eSDHC_PROCTL[DTW] by mistake.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index 3497cfa..1b2c4f9 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -21,7 +21,8 @@
 #define ESDHC_DEFAULT_QUIRKS	(SDHCI_QUIRK_FORCE_BLK_SZ_2048 | \
 				SDHCI_QUIRK_NO_BUSY_IRQ | \
 				SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK | \
-				SDHCI_QUIRK_PIO_NEEDS_DELAY)
+				SDHCI_QUIRK_PIO_NEEDS_DELAY | \
+				SDHCI_QUIRK_NO_HISPD_BIT)
 
 #define ESDHC_SYSTEM_CONTROL	0x2c
 #define ESDHC_CLOCK_MASK	0x0000fff0
-- 
2.1.0.27.g96db324

