From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 05/22] mmc: dw_mmc: exynos: move the exynos private init
Date: Sat, 31 Aug 2013 00:11:57 +0900
Message-ID: <000801cea593$45304550$cf90cff0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:47169 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794Ab3H3PL7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Aug 2013 11:11:59 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSC00GC9NJWHW40@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 31 Aug 2013 00:11:58 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>

From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>

Currently platform specific private data initialization is done by
dw_mci_exynos_priv_init and dw_mci_exynos_parse_dt. As we already have
separate platform specific device tree parser dw_mci_exynos_parse_dt,
move the dw_mci_exynos_priv_init code to dw_mci_exynos_parse_dt.
We can use the dw_mci_exynos_priv_init to do some actual platform
specific initialization of SMU and etc.

Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc-exynos.c |   34 ++++++++++++++++------------------
 1 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 2f28dd8..37bad61 100644
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
 
@@ -174,12 +160,24 @@ static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 
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
 
@@ -188,14 +186,14 @@ static int dw_mci_exynos_parse_dt(struct dw_mci *host)
 	if (ret)
 		return ret;
 
-	priv->sdr_timing = SDMMC_CLKSEL_TIMING(timing[0], timing[1], div);
-
 	ret = of_property_read_u32_array(np,
 			"samsung,dw-mshc-ddr-timing", timing, 2);
 	if (ret)
 		return ret;
 
+	priv->sdr_timing = SDMMC_CLKSEL_TIMING(timing[0], timing[1], div);
 	priv->ddr_timing = SDMMC_CLKSEL_TIMING(timing[0], timing[1], div);
+	host->priv = priv;
 	return 0;
 }
 
-- 
1.7.0.4


