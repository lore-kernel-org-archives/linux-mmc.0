From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 5/6] mmc: sdhi: print out something useful
Date: Mon,  9 May 2011 09:55:15 +0900
Message-ID: <1304902516-14150-6-git-send-email-horms@verge.net.au>
References: <1304902516-14150-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:50167 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756285Ab1EIAzh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 May 2011 20:55:37 -0400
In-Reply-To: <1304902516-14150-1-git-send-email-horms@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>
Cc: Ian Molton <ian@mnementh.co.uk>, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>

From: Magnus Damm <damm@opensource.se>

Instead of printing out useless information such
as the virtual base address and one of 4 interrupts,
convert the SDHI probe() to print out physical base
address together with clock rate.

We do have a struct device so make use of dev_info().

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Reviewed-by: Simon Horman <horms@verge.net.au>
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
1.7.4.4

