From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH v2 4/8] mmc: omap: context save after enabling runtime pm
Date: Fri, 16 Mar 2012 19:09:00 +0530
Message-ID: <1331905144-31655-5-git-send-email-svenkatr@ti.com>
References: <y>
 <1331905144-31655-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41786 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760859Ab2CPNki (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 16 Mar 2012 09:40:38 -0400
In-Reply-To: <1331905144-31655-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, balajitk@ti.com, balbi@ti.com, Venkatraman S <svenkatr@ti.com>, stable <stable@vger.kernel.org>

From: Balaji T K <balajitk@ti.com>

call context save api after enabling runtime pm
to make sure register access in context save api happens with clk enabled.

Signed-off-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
Cc: stable <stable@vger.kernel.org>
---
 drivers/mmc/host/omap_hsmmc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index baa06f9..2822442 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1870,8 +1870,6 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	omap_hsmmc_context_save(host);
-
 	if (host->pdata->controller_flags & OMAP_HSMMC_BROKEN_MULTIBLOCK_READ) {
 		dev_info(&pdev->dev, "multiblock reads disabled due to 35xx erratum 2.1.1.128; MMC read performance may suffer\n");
 		mmc->caps2 |= MMC_CAP2_NO_MULTI_READ;
@@ -1882,6 +1880,8 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(host->dev, MMC_AUTOSUSPEND_DELAY);
 	pm_runtime_use_autosuspend(host->dev);
 
+	omap_hsmmc_context_save(host);
+
 	if (cpu_is_omap2430()) {
 		host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
 		/*
-- 
1.7.10.rc0.41.gfa678

