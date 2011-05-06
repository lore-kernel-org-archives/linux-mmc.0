From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 3/4] mmc: sdhi: print out something useful
Date: Fri, 6 May 2011 13:02:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105061300040.10445@axis700.grange>
References: <Pine.LNX.4.64.1105061244120.10445@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:64493 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755005Ab1EFLCx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 May 2011 07:02:53 -0400
In-Reply-To: <Pine.LNX.4.64.1105061244120.10445@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: cjb@laptop.org, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, horms@verge.net.au, linux-mmc@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Instead of printing out useless information such
as the virtual base address and one of 4 interrupts,
convert the SDHI probe() to print out physical base
address together with clock rate.

We do have a struct device so make use of dev_info().

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mobile_sdhi.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index c489547..2bd235b 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -126,8 +126,10 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	if (ret)
 		goto eirq;
 
-	pr_info("%s at 0x%08lx irq %d\n", mmc_hostname(host->mmc),
-		(unsigned long)host->ctl, irq);
+	dev_info(&pdev->dev, "%s base at 0x%08lx clock rate %u MHz\n",
+		 mmc_hostname(host->mmc), (unsigned long)
+		 (platform_get_resource(pdev,IORESOURCE_MEM, 0)->start),
+		 mmc_data->hclk / 1000000);
 
 	return ret;
 
-- 
1.7.2.5

