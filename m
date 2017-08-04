From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 10/14] mmc: meson-gx: implement card_busy callback
Date: Fri,  4 Aug 2017 19:43:49 +0200
Message-ID: <20170804174353.16486-11-jbrunet@baylibre.com>
References: <20170804174353.16486-1-jbrunet@baylibre.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35540 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753146AbdHDRoP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Aug 2017 13:44:15 -0400
Received: by mail-wm0-f49.google.com with SMTP id m85so25330699wma.0
        for <linux-mmc@vger.kernel.org>; Fri, 04 Aug 2017 10:44:14 -0700 (PDT)
In-Reply-To: <20170804174353.16486-1-jbrunet@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

The card_busy callback is important to then add the voltage switch
callback as it allow to verify that the card is done dealing with
the voltage switch

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index d876b80db27d..33ab341a8b33 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -76,6 +76,7 @@
 
 #define SD_EMMC_STATUS 0x48
 #define   STATUS_BUSY BIT(31)
+#define   STATUS_DATI GENMASK(23, 16)
 
 #define SD_EMMC_IRQ_EN 0x4c
 #define   IRQ_RXD_ERR_MASK GENMASK(7, 0)
@@ -845,6 +846,17 @@ static void meson_mmc_cfg_init(struct meson_host *host)
 	writel(cfg, host->regs + SD_EMMC_CFG);
 }
 
+static int meson_mmc_card_busy(struct mmc_host *mmc)
+{
+	struct meson_host *host = mmc_priv(mmc);
+	u32 regval;
+
+	regval = readl(host->regs + SD_EMMC_STATUS);
+
+	/* We are only interrested in lines 0 to 3, so mask the other ones */
+	return !(FIELD_GET(STATUS_DATI, regval) & 0xf);
+}
+
 static const struct mmc_host_ops meson_mmc_ops = {
 	.request	= meson_mmc_request,
 	.set_ios	= meson_mmc_set_ios,
@@ -852,6 +864,7 @@ static const struct mmc_host_ops meson_mmc_ops = {
 	.pre_req	= meson_mmc_pre_req,
 	.post_req	= meson_mmc_post_req,
 	.execute_tuning = meson_mmc_execute_tuning,
+	.card_busy	= meson_mmc_card_busy,
 };
 
 static int meson_mmc_probe(struct platform_device *pdev)
-- 
2.9.4

