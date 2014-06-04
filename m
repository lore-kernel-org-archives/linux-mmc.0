From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 6/6] mmc: sh-mmcif: final error path cleanup
Date: Wed,  4 Jun 2014 12:42:13 +0100
Message-ID: <1401882133-11050-7-git-send-email-ben.dooks@codethink.co.uk>
References: <1401882133-11050-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:45947 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752697AbaFDLmi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jun 2014 07:42:38 -0400
In-Reply-To: <1401882133-11050-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@lists.codethink.co.uk, ulf.hansson@linaro.org, chris@printf.net, magnus.damm@opensource.se, linus-sh@vger.kernel.org, horms@verge.net.au, Ben Dooks <ben.dooks@codethink.co.uk>

Remove the error path items that are no longer needed. The mmc card-detect
code cleans up after itself (and registers with devm) and the host error
is the same as the clock disable.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/mmc/host/sh_mmcif.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index b378aa0..35c77ad 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1458,14 +1458,14 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	if (pd && pd->use_cd_gpio) {
 		ret = mmc_gpio_request_cd(mmc, pd->cd_gpio, 0);
 		if (ret < 0)
-			goto erqcd;
+			goto err_clk;
 	}
 
 	mutex_init(&host->thread_lock);
 
 	ret = mmc_add_host(mmc);
 	if (ret < 0)
-		goto emmcaddh;
+		goto err_clk;
 
 	dev_pm_qos_expose_latency_limit(&pdev->dev, 100);
 
@@ -1476,8 +1476,6 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	clk_disable_unprepare(host->hclk);
 	return ret;
 
-emmcaddh:
-erqcd:
 err_clk:
 	clk_disable_unprepare(host->hclk);
 err_pm:
-- 
2.0.0.rc2

