From: Rajeshwari Shinde <rajeshwari.s@samsung.com>
Subject: RFC[PATCH] SDHCI: S3C: Use bus clocks created using clkdev
Date: Mon, 08 Aug 2011 14:25:31 +0530
Message-ID: <1312793731-18766-1-git-send-email-rajeshwari.s@samsung.com>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:16020 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab1HHI5U (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Aug 2011 04:57:20 -0400
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LPL00BH8Q7EJIT0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 08 Aug 2011 17:57:19 +0900 (KST)
Received: from rajeshwari-linux.sisodomain.com ([107.108.215.115])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LPL00FS4Q7FQG@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 08 Aug 2011 17:57:19 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, ben-linux@fluff.org

This patch modifies the driver to stop depending on the clock names
being passed from the platform and switch over to lookup clocks generic
names created using clkdev.

Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 69e3ee3..d07d774 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -426,14 +426,12 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 
 	for (clks = 0, ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
 		struct clk *clk;
-		char *name = pdata->clocks[ptr];
+		char name[14];
 
-		if (name == NULL)
-			continue;
+		sprintf(name, "mmc_busclk.%d", ptr);
 
 		clk = clk_get(dev, name);
 		if (IS_ERR(clk)) {
-			dev_err(dev, "failed to get clock %s\n", name);
 			continue;
 		}
 
-- 
1.7.4.4

