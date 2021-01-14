Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4983C4332E
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 15:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 844532311F
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 15:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbhANP3X (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jan 2021 10:29:23 -0500
Received: from mga14.intel.com ([192.55.52.115]:7040 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbhANP3X (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 Jan 2021 10:29:23 -0500
IronPort-SDR: XBuGuQw1kUP8iq7g9PWPEqJsNRVbR7o7+Suy8gmn9uXF4dX4LZYYhzWw1pZ0UGbBP1zXbam3UZ
 aYvmUn/9lp4g==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="177604656"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="177604656"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 07:28:37 -0800
IronPort-SDR: ZG4P16/Othm9qt5oxgjNakxTNBxKdYBmyvn6xMOivb3rCecCBHStIXOxMVzqOpbBxuX951Vopm
 uSAkRl839bNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="568193590"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2021 07:28:34 -0800
From:   Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To:     ulf.hansson@linaro.org, broonie@kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@intel.com, Rashmi.A@intel.com,
        mahesh.r.vaidya@intel.com, muhammad.husaini.zulkifli@intel.com
Subject: [PATCH v1 3/9] mmc: sdhci-of-arasan: Add structure device pointer in probe function
Date:   Thu, 14 Jan 2021 23:26:54 +0800
Message-Id: <20210114152700.21916-4-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
References: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add struct device *dev in probe func() so that it can widely use in
probe to make code more readable.

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 34 +++++++++++++++---------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index ecaea4b45367..4e6ee9e69a1b 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1512,11 +1512,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	struct clk *clk_xin;
 	struct sdhci_host *host;
 	struct sdhci_pltfm_host *pltfm_host;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct sdhci_arasan_data *sdhci_arasan;
-	struct device_node *np = pdev->dev.of_node;
 	const struct sdhci_arasan_of_data *data;
 
-	data = of_device_get_match_data(&pdev->dev);
+	data = of_device_get_match_data(dev);
 	host = sdhci_pltfm_init(pdev, data->pdata, sizeof(*sdhci_arasan));
 
 	if (IS_ERR(host))
@@ -1535,36 +1536,36 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		of_node_put(node);
 
 		if (IS_ERR(sdhci_arasan->soc_ctl_base)) {
-			ret = dev_err_probe(&pdev->dev,
+			ret = dev_err_probe(dev,
 					    PTR_ERR(sdhci_arasan->soc_ctl_base),
 					    "Can't get syscon\n");
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
 
@@ -1592,7 +1593,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 	sdhci_arasan_update_baseclkfreq(host);
 
-	ret = sdhci_arasan_register_sdclk(sdhci_arasan, clk_xin, &pdev->dev);
+	ret = sdhci_arasan_register_sdclk(sdhci_arasan, clk_xin, dev);
 	if (ret)
 		goto clk_disable_all;
 
@@ -1601,28 +1602,27 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
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
 	if (of_device_is_compatible(np, "arasan,sdhci-5.1")) {
-		sdhci_arasan->phy = devm_phy_get(&pdev->dev,
-						 "phy_arasan");
+		sdhci_arasan->phy = devm_phy_get(dev, "phy_arasan");
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
 
@@ -1647,7 +1647,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
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

