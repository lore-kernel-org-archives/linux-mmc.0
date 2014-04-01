From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH v2 6/6] mmc: sh-mmcif: final error path cleanup
Date: Tue,  1 Apr 2014 13:01:46 +0100
Message-ID: <1396353706-31864-7-git-send-email-ben.dooks@codethink.co.uk>
References: <1396353706-31864-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1396353706-31864-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk, Ben Dooks <ben.dooks@codethink.co.uk>
List-Id: linux-mmc@vger.kernel.org

Remove the error path items that are no longer needed. The mmc card-detect
code cleans up after itself (and registers with devm) and the host error
is the same as the clock disable.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/mmc/host/sh_mmcif.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 33f2365..efe997f 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1460,14 +1460,14 @@ static int sh_mmcif_probe(struct platform_device *pdev)
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
 
@@ -1478,8 +1478,6 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	clk_disable_unprepare(host->hclk);
 	return ret;
 
-emmcaddh:
-erqcd:
 err_clk:
 	clk_disable_unprepare(host->hclk);
 err_pm:
-- 
1.9.0

