Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFE0C27C40
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Aug 2023 08:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjHXIrv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Aug 2023 04:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240636AbjHXIro (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Aug 2023 04:47:44 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC901BE4
        for <linux-mmc@vger.kernel.org>; Thu, 24 Aug 2023 01:47:14 -0700 (PDT)
Received: from kwepemm600014.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RWc9G35xTz1L9D2;
        Thu, 24 Aug 2023 16:45:22 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.175.28) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 24 Aug 2023 16:46:52 +0800
From:   Yi Yang <yiyang13@huawei.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>
Subject: [PATCH V3] mmc: sdhci-of-dwcmshc: Use helper function devm_clk_get_enabled()
Date:   Thu, 24 Aug 2023 16:46:29 +0800
Message-ID: <20230824084629.135361-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.28]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for
prepared and enabled clocks"), devm_clk_get() and clk_prepare_enable()
can now be replaced by devm_clk_get_enabled() when the driver enables
(and possibly prepares) the clocks for the whole lifetime of the device.
Moreover, it is no longer necessary to unprepare and disable the clocks
explicitly.

Signed-off-by: Yi Yang <yiyang13@huawei.com>
---
v3: Fix err check logic
v2: Remove clk_disable_unprepare in dwcmshc_remove()
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 31c1892f4ecd..7e1cf78d9695 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -495,19 +495,19 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	priv = sdhci_pltfm_priv(pltfm_host);
 
 	if (dev->of_node) {
-		pltfm_host->clk = devm_clk_get(dev, "core");
+		pltfm_host->clk = devm_clk_get_enabled(dev, "core");
 		if (IS_ERR(pltfm_host->clk)) {
 			err = PTR_ERR(pltfm_host->clk);
-			dev_err(dev, "failed to get core clk: %d\n", err);
+			dev_err(dev, "failed to get or enable core clk: %d\n", err);
 			goto free_pltfm;
 		}
-		err = clk_prepare_enable(pltfm_host->clk);
-		if (err)
-			goto free_pltfm;
 
-		priv->bus_clk = devm_clk_get(dev, "bus");
-		if (!IS_ERR(priv->bus_clk))
-			clk_prepare_enable(priv->bus_clk);
+		priv->bus_clk = devm_clk_get_enabled(dev, "bus");
+		if (IS_ERR(priv->bus_clk)) {
+			err = PTR_ERR(priv->bus_clk);
+			dev_err(dev, "failed to get or enable bus clk: %d\n", err);
+			goto free_pltfm;
+		}
 	}
 
 	err = mmc_of_parse(host->mmc);
@@ -564,8 +564,6 @@ static int dwcmshc_probe(struct platform_device *pdev)
 err_setup_host:
 	sdhci_cleanup_host(host);
 err_clk:
-	clk_disable_unprepare(pltfm_host->clk);
-	clk_disable_unprepare(priv->bus_clk);
 	if (rk_priv)
 		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
 					   rk_priv->rockchip_clks);
@@ -583,8 +581,6 @@ static void dwcmshc_remove(struct platform_device *pdev)
 
 	sdhci_remove_host(host, 0);
 
-	clk_disable_unprepare(pltfm_host->clk);
-	clk_disable_unprepare(priv->bus_clk);
 	if (rk_priv)
 		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
 					   rk_priv->rockchip_clks);
-- 
2.17.1

