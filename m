From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Subject: [RFC 1/3] mmc: dw_mmc: exynos: move the exynos private init
Date: Fri, 16 Aug 2013 19:17:40 +0530
Message-ID: <1376660862-387-1-git-send-email-yuvaraj.cd@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:48338 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754517Ab3HPNr5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Aug 2013 09:47:57 -0400
Received: by mail-pa0-f44.google.com with SMTP id fz6so1898979pac.31
        for <linux-mmc@vger.kernel.org>; Fri, 16 Aug 2013 06:47:57 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, linux-mmc@vger.kernel.org, thomas.ab@samsung.com
Cc: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

Currently platform specific private data initialisation is done by
dw_mci_exynos_priv_init and dw_mci_exynos_parse_dt.As we already have
separate platform specific device tree parser dw_mci_exynos_parse_dt,
move the dw_mci_exynos_priv_init code to dw_mci_exynos_parse_dt.
We can use the dw_mci_exynos_priv_init to do some actual platform
specific initialisation of SMU and etc.

Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
---
 drivers/mmc/host/dw_mmc-exynos.c |   31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 9990f98..19c845b 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -72,22 +72,8 @@ static struct dw_mci_exynos_compatible {
 
 static int dw_mci_exynos_priv_init(struct dw_mci *host)
 {
-	struct dw_mci_exynos_priv_data *priv;
-	int idx;
-
-	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		dev_err(host->dev, "mem alloc failed for private data\n");
-		return -ENOMEM;
-	}
-
-	for (idx = 0; idx < ARRAY_SIZE(exynos_compat); idx++) {
-		if (of_device_is_compatible(host->dev->of_node,
-					exynos_compat[idx].compatible))
-			priv->ctrl_type = exynos_compat[idx].ctrl_type;
-	}
+	struct dw_mci_exynos_priv_data *priv = host->priv;
 
-	host->priv = priv;
 	return 0;
 }
 
@@ -177,12 +163,24 @@ static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 
 static int dw_mci_exynos_parse_dt(struct dw_mci *host)
 {
-	struct dw_mci_exynos_priv_data *priv = host->priv;
+	struct dw_mci_exynos_priv_data *priv;
 	struct device_node *np = host->dev->of_node;
 	u32 timing[2];
 	u32 div = 0;
+	int idx;
 	int ret;
 
+	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		dev_err(host->dev, "mem alloc failed for private data\n");
+		return -ENOMEM;
+	}
+
+	for (idx = 0; idx < ARRAY_SIZE(exynos_compat); idx++) {
+		if (of_device_is_compatible(np, exynos_compat[idx].compatible))
+			priv->ctrl_type = exynos_compat[idx].ctrl_type;
+	}
+
 	of_property_read_u32(np, "samsung,dw-mshc-ciu-div", &div);
 	priv->ciu_div = div;
 
@@ -199,6 +197,7 @@ static int dw_mci_exynos_parse_dt(struct dw_mci *host)
 		return ret;
 
 	priv->ddr_timing = SDMMC_CLKSEL_TIMING(timing[0], timing[1], div);
+	host->priv = priv;
 	return 0;
 }
 
-- 
1.7.9.5

