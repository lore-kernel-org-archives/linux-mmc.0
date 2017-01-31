From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 9/9] mmc: meson-gx: add support for HS400 mode
Date: Tue, 31 Jan 2017 21:59:03 +0100
Message-ID: <d2016e6d-81d7-57ed-0333-3972b948f651@gmail.com>
References: <24e8bf35-50ce-270d-c0aa-12bb90d2e3d8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36639 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbdAaVIb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2017 16:08:31 -0500
Received: by mail-wm0-f68.google.com with SMTP id r18so942742wmd.3
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2017 13:08:31 -0800 (PST)
In-Reply-To: <24e8bf35-50ce-270d-c0aa-12bb90d2e3d8@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, linux-mmc@vger.kernel.org

Add support for HS400 mode.

Successfully tested on a Odroid C2 (S905 GXBB).

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index bc787444..83a94cf5 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -83,6 +83,7 @@
 #define   CFG_RC_CC_MASK 0xf
 #define   CFG_STOP_CLOCK BIT(22)
 #define   CFG_CLK_ALWAYS_ON BIT(18)
+#define   CFG_CHK_DS BIT(20)
 #define   CFG_AUTO_CLK BIT(23)
 
 #define SD_EMMC_STATUS 0x48
@@ -412,6 +413,16 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	val &= ~(CFG_RC_CC_MASK << CFG_RC_CC_SHIFT);
 	val |= ilog2(SD_EMMC_CFG_CMD_GAP) << CFG_RC_CC_SHIFT;
 
+	val &= ~CFG_DDR;
+	if (ios->timing == MMC_TIMING_UHS_DDR50 ||
+	    ios->timing == MMC_TIMING_MMC_DDR52 ||
+	    ios->timing == MMC_TIMING_MMC_HS400)
+		val |= CFG_DDR;
+
+	val &= ~CFG_CHK_DS;
+	if (ios->timing == MMC_TIMING_MMC_HS400)
+		val |= CFG_CHK_DS;
+
 	writel(val, host->regs + SD_EMMC_CFG);
 
 	if (val != orig)
-- 
2.11.0


