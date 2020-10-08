Return-Path: <SRS0=iGfF=DP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8108EC43457
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 18:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D9D422203
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 18:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgJHSWI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Oct 2020 14:22:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:32109 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgJHSWH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 8 Oct 2020 14:22:07 -0400
IronPort-SDR: S4gQIjWvJEdFnHyxrxd3U5lSNnxQhjtsD/mA/+FmTnGex0isL6U3ZO0MtF0cOx1vw59GB2IDzd
 uOkC7IoSBg/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="250078424"
X-IronPort-AV: E=Sophos;i="5.77,351,1596524400"; 
   d="scan'208";a="250078424"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 11:22:06 -0700
IronPort-SDR: tvp8US/UhPgYpAFeA1cCUsWdiyFLFMm8H7sL12S5UfHwMvsa2ZlusWAFgnXsk4gVAmM7eI+zz8
 cZXlxroFV3Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,351,1596524400"; 
   d="scan'208";a="349572568"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by fmsmga002.fm.intel.com with ESMTP; 08 Oct 2020 11:22:03 -0700
From:   muhammad.husaini.zulkifli@intel.com
To:     adrian.hunter@intel.com, michal.simek@xilinx.com,
        andriy.shevchenko@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        muhammad.husaini.zulkifli@intel.com, arnd@arndb.de
Subject: [PATCH v5 3/4] mmc: sdhci-of-arasan: Add structure device pointer in probe
Date:   Fri,  9 Oct 2020 02:18:43 +0800
Message-Id: <20201008181844.27947-4-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008181844.27947-1-muhammad.husaini.zulkifli@intel.com>
References: <20201008181844.27947-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

Add struct device *dev in probe func() so that it can widely use in
probe to make code more readable.

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 37 +++++++++++++++---------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index f186fbd016b1..6a9412dee975 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1521,9 +1521,10 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_arasan_data *sdhci_arasan;
 	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
 	const struct sdhci_arasan_of_data *data;
 
-	match = of_match_node(sdhci_arasan_of_match, pdev->dev.of_node);
+	match = of_match_node(sdhci_arasan_of_match, dev->of_node);
 	data = match->data;
 	host = sdhci_pltfm_init(pdev, data->pdata, sizeof(*sdhci_arasan));
 
@@ -1537,7 +1538,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	sdhci_arasan->soc_ctl_map = data->soc_ctl_map;
 	sdhci_arasan->clk_ops = data->clk_ops;
 
-	node = of_parse_phandle(pdev->dev.of_node, "arasan,soc-ctl-syscon", 0);
+	node = of_parse_phandle(dev->of_node, "arasan,soc-ctl-syscon", 0);
 	if (node) {
 		sdhci_arasan->soc_ctl_base = syscon_node_to_regmap(node);
 		of_node_put(node);
@@ -1545,35 +1546,35 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		if (IS_ERR(sdhci_arasan->soc_ctl_base)) {
 			ret = PTR_ERR(sdhci_arasan->soc_ctl_base);
 			if (ret != -EPROBE_DEFER)
-				dev_err(&pdev->dev, "Can't get syscon: %d\n",
+				dev_err(dev, "Can't get syscon: %d\n",
 					ret);
 			goto err_pltfm_free;
 		}
 	}
 
-	sdhci_arasan->clk_ahb = devm_clk_get(&pdev->dev, "clk_ahb");
+	sdhci_arasan->clk_ahb = devm_clk_get(dev, "clk_ahb");
 	if (IS_ERR(sdhci_arasan->clk_ahb)) {
-		dev_err(&pdev->dev, "clk_ahb clock not found.\n");
+		dev_err(dev, "clk_ahb clock not found.\n");
 		ret = PTR_ERR(sdhci_arasan->clk_ahb);
 		goto err_pltfm_free;
 	}
 
-	clk_xin = devm_clk_get(&pdev->dev, "clk_xin");
+	clk_xin = devm_clk_get(dev, "clk_xin");
 	if (IS_ERR(clk_xin)) {
-		dev_err(&pdev->dev, "clk_xin clock not found.\n");
+		dev_err(dev, "clk_xin clock not found.\n");
 		ret = PTR_ERR(clk_xin);
 		goto err_pltfm_free;
 	}
 
 	ret = clk_prepare_enable(sdhci_arasan->clk_ahb);
 	if (ret) {
-		dev_err(&pdev->dev, "Unable to enable AHB clock.\n");
+		dev_err(dev, "Unable to enable AHB clock.\n");
 		goto err_pltfm_free;
 	}
 
 	ret = clk_prepare_enable(clk_xin);
 	if (ret) {
-		dev_err(&pdev->dev, "Unable to enable SD clock.\n");
+		dev_err(dev, "Unable to enable SD clock.\n");
 		goto clk_dis_ahb;
 	}
 
@@ -1587,7 +1588,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 	pltfm_host->clk = clk_xin;
 
-	if (of_device_is_compatible(pdev->dev.of_node,
+	if (of_device_is_compatible(dev->of_node,
 				    "rockchip,rk3399-sdhci-5.1"))
 		sdhci_arasan_update_clockmultiplier(host, 0x0);
 
@@ -1602,7 +1603,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 	sdhci_arasan_update_baseclkfreq(host);
 
-	ret = sdhci_arasan_register_sdclk(sdhci_arasan, clk_xin, &pdev->dev);
+	ret = sdhci_arasan_register_sdclk(sdhci_arasan, clk_xin, dev);
 	if (ret)
 		goto clk_disable_all;
 
@@ -1611,29 +1612,29 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 			arasan_zynqmp_execute_tuning;
 	}
 
-	arasan_dt_parse_clk_phases(&pdev->dev, &sdhci_arasan->clk_data);
+	arasan_dt_parse_clk_phases(dev, &sdhci_arasan->clk_data);
 
 	ret = mmc_of_parse(host->mmc);
 	if (ret) {
 		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "parsing dt failed (%d)\n", ret);
+			dev_err(dev, "parsing dt failed (%d)\n", ret);
 		goto unreg_clk;
 	}
 
 	sdhci_arasan->phy = ERR_PTR(-ENODEV);
-	if (of_device_is_compatible(pdev->dev.of_node,
+	if (of_device_is_compatible(dev->of_node,
 				    "arasan,sdhci-5.1")) {
-		sdhci_arasan->phy = devm_phy_get(&pdev->dev,
+		sdhci_arasan->phy = devm_phy_get(dev,
 						 "phy_arasan");
 		if (IS_ERR(sdhci_arasan->phy)) {
 			ret = PTR_ERR(sdhci_arasan->phy);
-			dev_err(&pdev->dev, "No phy for arasan,sdhci-5.1.\n");
+			dev_err(dev, "No phy for arasan,sdhci-5.1.\n");
 			goto unreg_clk;
 		}
 
 		ret = phy_init(sdhci_arasan->phy);
 		if (ret < 0) {
-			dev_err(&pdev->dev, "phy_init err.\n");
+			dev_err(dev, "phy_init err.\n");
 			goto unreg_clk;
 		}
 
@@ -1658,7 +1659,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	if (!IS_ERR(sdhci_arasan->phy))
 		phy_exit(sdhci_arasan->phy);
 unreg_clk:
-	sdhci_arasan_unregister_sdclk(&pdev->dev);
+	sdhci_arasan_unregister_sdclk(dev);
 clk_disable_all:
 	clk_disable_unprepare(clk_xin);
 clk_dis_ahb:
-- 
2.17.1

