From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 6/6] mmc: sh-mmcif: final error path cleanup
Date: Tue,  1 Apr 2014 11:25:54 +0100
Message-ID: <1396347954-13740-7-git-send-email-ben.dooks@codethink.co.uk>
References: <1396347954-13740-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:43770 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751240AbaDAK0I (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Apr 2014 06:26:08 -0400
In-Reply-To: <1396347954-13740-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk, Ben Dooks <ben.dooks@codethink.co.uk>

Remove the error path items that are no longer needed. The mmc card-detect
code cleans up after itself (and registers with devm) and the host error
is the same as the clock disable.

This should also fix a double call to clk_disable_unprepare() if the call
to mmc_add_host() fails.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/mmc/host/sh_mmcif.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index c951760..d63cfa7 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1462,7 +1462,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	if (pd && pd->use_cd_gpio) {
 		ret = mmc_gpio_request_cd(mmc, pd->cd_gpio, 0);
 		if (ret < 0)
-			goto erqcd;
+			goto err_clk;
 	}
 
 	mutex_init(&host->thread_lock);
@@ -1470,7 +1470,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	clk_disable_unprepare(host->hclk);
 	ret = mmc_add_host(mmc);
 	if (ret < 0)
-		goto emmcaddh;
+		goto err_pm;
 
 	dev_pm_qos_expose_latency_limit(&pdev->dev, 100);
 
@@ -1480,8 +1480,6 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 		sh_mmcif_readl(host->addr, MMCIF_CE_VERSION) & 0x0000ffff);
 	return ret;
 
-emmcaddh:
-erqcd:
 err_clk:
 	clk_disable_unprepare(host->hclk);
 err_pm:
-- 
1.9.0

