From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 12/16] mmc: meson-gx: implement card_busy callback
Date: Mon, 21 Aug 2017 18:02:57 +0200
Message-ID: <20170821160301.21899-13-jbrunet@baylibre.com>
References: <20170821160301.21899-1-jbrunet@baylibre.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:38310 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754327AbdHUQDT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Aug 2017 12:03:19 -0400
Received: by mail-wr0-f179.google.com with SMTP id p8so39042070wrf.5
        for <linux-mmc@vger.kernel.org>; Mon, 21 Aug 2017 09:03:19 -0700 (PDT)
In-Reply-To: <20170821160301.21899-1-jbrunet@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

The card_busy callback is important to then add the voltage switch
callback as it allow to verify that the card is done dealing with
the voltage switch

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 5203a9f76fe3..441ebf2b0146 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -76,6 +76,7 @@
 
 #define SD_EMMC_STATUS 0x48
 #define   STATUS_BUSY BIT(31)
+#define   STATUS_DATI GENMASK(23, 16)
 
 #define SD_EMMC_IRQ_EN 0x4c
 #define   IRQ_RXD_ERR_MASK GENMASK(7, 0)
@@ -903,6 +904,17 @@ static void meson_mmc_cfg_init(struct meson_host *host)
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
@@ -910,6 +922,7 @@ static const struct mmc_host_ops meson_mmc_ops = {
 	.pre_req	= meson_mmc_pre_req,
 	.post_req	= meson_mmc_post_req,
 	.execute_tuning = meson_mmc_execute_tuning,
+	.card_busy	= meson_mmc_card_busy,
 };
 
 static int meson_mmc_probe(struct platform_device *pdev)
-- 
2.9.5

