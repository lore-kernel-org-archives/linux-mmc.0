From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 1/6] mmc: sh-mmcif: print bus clock rate on probe
Date: Tue,  1 Apr 2014 11:25:49 +0100
Message-ID: <1396347954-13740-2-git-send-email-ben.dooks@codethink.co.uk>
References: <1396347954-13740-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1396347954-13740-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk, Ben Dooks <ben.dooks@codethink.co.uk>
List-Id: linux-mmc@vger.kernel.org

Add a print to show the host-bus clock rate for mmcif on probe to allow
easy check on what clock rate the bus clock is at.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/mmc/host/sh_mmcif.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index e8713d7..c48df98 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1477,7 +1477,8 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 
 	dev_pm_qos_expose_latency_limit(&pdev->dev, 100);
 
-	dev_info(&pdev->dev, "driver version %s\n", DRIVER_VERSION);
+	dev_info(&pdev->dev, "driver version %s, clock rate %ldMHz\n",
+		 DRIVER_VERSION, clk_get_rate(host->hclk) / 1000000);
 	dev_dbg(&pdev->dev, "chip ver H'%04x\n",
 		sh_mmcif_readl(host->addr, MMCIF_CE_VERSION) & 0x0000ffff);
 	return ret;
-- 
1.9.0

