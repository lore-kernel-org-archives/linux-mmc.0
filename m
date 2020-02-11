Return-Path: <SRS0=tDgF=37=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4746AC35242
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Feb 2020 23:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29CA02086A
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Feb 2020 23:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgBKXir (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 Feb 2020 18:38:47 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63262 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbgBKXir (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Feb 2020 18:38:47 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 20770e2449c7a7fa; Wed, 12 Feb 2020 00:38:45 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: [PATCH 19/28] drivers: mmc: Call cpu_latency_qos_*() instead of pm_qos_*()
Date:   Wed, 12 Feb 2020 00:21:53 +0100
Message-ID: <3311890.58F1UHHIxI@kreacher>
In-Reply-To: <1654227.8mz0SueHsU@kreacher>
References: <1654227.8mz0SueHsU@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Call cpu_latency_qos_add/remove_request() instead of
pm_qos_add/remove_request(), respectively, because the
latter are going to be dropped.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 382f25b2fa45..b2bdf5012c55 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1452,8 +1452,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 						  pdev->id_entry->driver_data;
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
-		pm_qos_add_request(&imx_data->pm_qos_req,
-			PM_QOS_CPU_DMA_LATENCY, 0);
+		cpu_latency_qos_add_request(&imx_data->pm_qos_req, 0);
 
 	imx_data->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(imx_data->clk_ipg)) {
@@ -1572,7 +1571,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	clk_disable_unprepare(imx_data->clk_per);
 free_sdhci:
 	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
-		pm_qos_remove_request(&imx_data->pm_qos_req);
+		cpu_latency_qos_remove_request(&imx_data->pm_qos_req);
 	sdhci_pltfm_free(pdev);
 	return err;
 }
@@ -1595,7 +1594,7 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
 	clk_disable_unprepare(imx_data->clk_ahb);
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
-		pm_qos_remove_request(&imx_data->pm_qos_req);
+		cpu_latency_qos_remove_request(&imx_data->pm_qos_req);
 
 	sdhci_pltfm_free(pdev);
 
@@ -1667,7 +1666,7 @@ static int sdhci_esdhc_runtime_suspend(struct device *dev)
 	clk_disable_unprepare(imx_data->clk_ahb);
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
-		pm_qos_remove_request(&imx_data->pm_qos_req);
+		cpu_latency_qos_remove_request(&imx_data->pm_qos_req);
 
 	return ret;
 }
@@ -1680,8 +1679,7 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
 	int err;
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
-		pm_qos_add_request(&imx_data->pm_qos_req,
-			PM_QOS_CPU_DMA_LATENCY, 0);
+		cpu_latency_qos_add_request(&imx_data->pm_qos_req, 0);
 
 	err = clk_prepare_enable(imx_data->clk_ahb);
 	if (err)
@@ -1714,7 +1712,7 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
 	clk_disable_unprepare(imx_data->clk_ahb);
 remove_pm_qos_request:
 	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
-		pm_qos_remove_request(&imx_data->pm_qos_req);
+		cpu_latency_qos_remove_request(&imx_data->pm_qos_req);
 	return err;
 }
 #endif
-- 
2.16.4





