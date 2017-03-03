From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v4 8/10] mmc: meson-gx: improve initial configuration
Date: Fri, 3 Mar 2017 20:58:18 +0100
Message-ID: <58eac416-40da-8a20-e54a-0e6be3b7ba33@gmail.com>
References: <62912f3d-2307-cfff-3c69-c8b8ffaeb474@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35251 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbdCCUAu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Mar 2017 15:00:50 -0500
Received: by mail-wm0-f66.google.com with SMTP id z63so2507111wmg.2
        for <linux-mmc@vger.kernel.org>; Fri, 03 Mar 2017 12:00:49 -0800 (PST)
In-Reply-To: <62912f3d-2307-cfff-3c69-c8b8ffaeb474@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Config values which are not changed during runtime we can set
in the probe function already.
The block size setting is overwritten later in
meson_mmc_start_cmd anyway if needed, so it doesn't harm if we
remove this setting in meson_mmc_set_ios.

In addition:
- write config register only if configuration changed
- Initialize clocks after other config registers have been initialized

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Acked-by: Kevin Hilman <khilman@baylibre.com>
---
v2:
- added acked-by
v3:
- rebased
v4:
- no changes
---
 drivers/mmc/host/meson-gx-mmc.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 684cc088..e904b0a5 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -394,15 +394,6 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	val &= ~(CFG_BUS_WIDTH_MASK << CFG_BUS_WIDTH_SHIFT);
 	val |= bus_width << CFG_BUS_WIDTH_SHIFT;
 
-	val &= ~(CFG_BLK_LEN_MASK << CFG_BLK_LEN_SHIFT);
-	val |= ilog2(SD_EMMC_CFG_BLK_SIZE) << CFG_BLK_LEN_SHIFT;
-
-	val &= ~(CFG_RESP_TIMEOUT_MASK << CFG_RESP_TIMEOUT_SHIFT);
-	val |= ilog2(SD_EMMC_CFG_RESP_TIMEOUT) << CFG_RESP_TIMEOUT_SHIFT;
-
-	val &= ~(CFG_RC_CC_MASK << CFG_RC_CC_SHIFT);
-	val |= ilog2(SD_EMMC_CFG_CMD_GAP) << CFG_RC_CC_SHIFT;
-
 	val &= ~CFG_DDR;
 	if (ios->timing == MMC_TIMING_UHS_DDR50 ||
 	    ios->timing == MMC_TIMING_MMC_DDR52 ||
@@ -413,11 +404,11 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (ios->timing == MMC_TIMING_MMC_HS400)
 		val |= CFG_CHK_DS;
 
-	writel(val, host->regs + SD_EMMC_CFG);
-
-	if (val != orig)
+	if (val != orig) {
+		writel(val, host->regs + SD_EMMC_CFG);
 		dev_dbg(host->dev, "%s: SD_EMMC_CFG: 0x%08x -> 0x%08x\n",
 			__func__, orig, val);
+	}
 }
 
 static void meson_mmc_request_done(struct mmc_host *mmc,
@@ -695,6 +686,17 @@ static int meson_mmc_get_cd(struct mmc_host *mmc)
 	return status;
 }
 
+static void meson_mmc_cfg_init(struct meson_host *host)
+{
+	u32 cfg = 0;
+
+	cfg |= ilog2(SD_EMMC_CFG_RESP_TIMEOUT) << CFG_RESP_TIMEOUT_SHIFT;
+	cfg |= ilog2(SD_EMMC_CFG_CMD_GAP) << CFG_RC_CC_SHIFT;
+	cfg |= ilog2(SD_EMMC_CFG_BLK_SIZE) << CFG_BLK_LEN_SHIFT;
+
+	writel(cfg, host->regs + SD_EMMC_CFG);
+}
+
 static const struct mmc_host_ops meson_mmc_ops = {
 	.request	= meson_mmc_request,
 	.set_ios	= meson_mmc_set_ios,
@@ -755,10 +757,6 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_host;
 
-	ret = meson_mmc_clk_init(host);
-	if (ret)
-		goto free_host;
-
 	/* Stop execution */
 	writel(0, host->regs + SD_EMMC_START);
 
@@ -767,6 +765,13 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	writel(IRQ_EN_MASK, host->regs + SD_EMMC_STATUS);
 	writel(IRQ_EN_MASK, host->regs + SD_EMMC_IRQ_EN);
 
+	/* set config to sane default */
+	meson_mmc_cfg_init(host);
+
+	ret = meson_mmc_clk_init(host);
+	if (ret)
+		goto free_host;
+
 	ret = devm_request_threaded_irq(&pdev->dev, irq, meson_mmc_irq,
 					meson_mmc_irq_thread, IRQF_SHARED,
 					DRIVER_NAME, host);
-- 
2.11.1

