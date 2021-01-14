Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74258C43381
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 15:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BBFD2311F
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 15:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbhANP31 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jan 2021 10:29:27 -0500
Received: from mga14.intel.com ([192.55.52.115]:7042 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbhANP30 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 14 Jan 2021 10:29:26 -0500
IronPort-SDR: ny2TLsjmy9KAIHqP2YEUjAFWBm33A40eM016NOSj4wAcYYaVVZL9sO74QluTaz3ZAcasv+R3I4
 897mjE8lAhxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="177604665"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="177604665"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 07:28:40 -0800
IronPort-SDR: AS4mNqcG2wk0u/TRvfh3ApX4GNMKKeXCY4BWJ+XTA7Wbp0wZ6PhBB93B9NHTMO/sliAJowc5YK
 gz9HqozVd8Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="568193603"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2021 07:28:37 -0800
From:   Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To:     ulf.hansson@linaro.org, broonie@kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@intel.com, Rashmi.A@intel.com,
        mahesh.r.vaidya@intel.com, muhammad.husaini.zulkifli@intel.com
Subject: [PATCH v1 4/9] mmc: sdhci-of-arasan: Use dev_err_probe() to avoid spamming logs
Date:   Thu, 14 Jan 2021 23:26:55 +0800
Message-Id: <20210114152700.21916-5-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
References: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Using dev_err_probe() can avoid spamming logs when probe is deferred.
This function can also help to reduce code the size, uniform error handling
and simplify the code.

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 4e6ee9e69a1b..585ca32ff330 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1545,15 +1545,14 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 	sdhci_arasan->clk_ahb = devm_clk_get(dev, "clk_ahb");
 	if (IS_ERR(sdhci_arasan->clk_ahb)) {
-		dev_err(dev, "clk_ahb clock not found.\n");
-		ret = PTR_ERR(sdhci_arasan->clk_ahb);
+		ret = dev_err_probe(dev, PTR_ERR(sdhci_arasan->clk_ahb),
+				    "clk_ahb clock not found.\n");
 		goto err_pltfm_free;
 	}
 
 	clk_xin = devm_clk_get(dev, "clk_xin");
 	if (IS_ERR(clk_xin)) {
-		dev_err(dev, "clk_xin clock not found.\n");
-		ret = PTR_ERR(clk_xin);
+		ret = dev_err_probe(dev, PTR_ERR(clk_xin), "clk_xin clock not found.\n");
 		goto err_pltfm_free;
 	}
 
@@ -1606,8 +1605,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 	ret = mmc_of_parse(host->mmc);
 	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "parsing dt failed (%d)\n", ret);
+		ret = dev_err_probe(dev, ret, "parsing dt failed.\n");
 		goto unreg_clk;
 	}
 
@@ -1615,8 +1613,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(np, "arasan,sdhci-5.1")) {
 		sdhci_arasan->phy = devm_phy_get(dev, "phy_arasan");
 		if (IS_ERR(sdhci_arasan->phy)) {
-			ret = PTR_ERR(sdhci_arasan->phy);
-			dev_err(dev, "No phy for arasan,sdhci-5.1.\n");
+			ret = dev_err_probe(dev, PTR_ERR(sdhci_arasan->phy),
+					    "No phy for arasan,sdhci-5.1.\n");
 			goto unreg_clk;
 		}
 
-- 
2.17.1

