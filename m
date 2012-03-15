From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH RESEND 4/8] mmc: omap: context save after enabling runtime pm
Date: Thu, 15 Mar 2012 20:03:38 +0530
Message-ID: <1331822022-26714-5-git-send-email-svenkatr@ti.com>
References: <y>
 <1331822022-26714-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53682 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758871Ab2COOer (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Mar 2012 10:34:47 -0400
In-Reply-To: <1331822022-26714-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, balajitk@ti.com, balbi@ti.com

From: Balaji T K <balajitk@ti.com>

call context save api after enabling runtime pm
to make sure register access in context save api happens with clk enabled.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 0f8d34b..9fa2f39 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1871,8 +1871,6 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	omap_hsmmc_context_save(host);
-
 	if (host->pdata->controller_flags & OMAP_HSMMC_BROKEN_MULTIBLOCK_READ) {
 		dev_info(&pdev->dev, "multiblock reads disabled due to 35xx erratum 2.1.1.128; MMC read performance may suffer\n");
 		mmc->caps2 |= MMC_CAP2_NO_MULTI_READ;
@@ -1883,6 +1881,8 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(host->dev, MMC_AUTOSUSPEND_DELAY);
 	pm_runtime_use_autosuspend(host->dev);
 
+	omap_hsmmc_context_save(host);
+
 	if (cpu_is_omap2430()) {
 		host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
 		/*
-- 
1.7.10.rc0.41.gfa678

