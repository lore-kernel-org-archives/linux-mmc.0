From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 4/6] mmc: sdhi: no need for special interrupt flags
Date: Mon,  9 May 2011 09:55:14 +0900
Message-ID: <1304902516-14150-5-git-send-email-horms@verge.net.au>
References: <1304902516-14150-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:50155 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756411Ab1EIAzf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 May 2011 20:55:35 -0400
In-Reply-To: <1304902516-14150-1-git-send-email-horms@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>
Cc: Ian Molton <ian@mnementh.co.uk>, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>

From: Magnus Damm <damm@opensource.se>

Modify the SDHI driver to get rid of unwanted irq flags.

IRQF_DISABLED unused, see include/linux/interrupt.h
IRQF_TRIGGER_FALLING only relevant on external IRQ pins,
but since SDHI is internal in the SoC this can go away.

Needed to support SDHI on sh73a0 that comes with a GIC
that errors out with the IRQF_TRIGGER_FALLING setting.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Reviewed-by: Simon Horman <horms@verge.net.au>
---
 drivers/mmc/host/sh_mobile_sdhi.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 9ee51ac..c489547 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -122,8 +122,7 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 		goto eirq;
 	}
 
-	ret = request_irq(irq, tmio_mmc_irq, IRQF_DISABLED |
-			  IRQF_TRIGGER_FALLING, dev_name(&pdev->dev), host);
+	ret = request_irq(irq, tmio_mmc_irq, 0, dev_name(&pdev->dev), host);
 	if (ret)
 		goto eirq;
 
-- 
1.7.4.4

