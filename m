From: Rajeshwari Shinde <rajeshwari.s@samsung.com>
Subject: [PATCH V3 1/3] SDHCI: S3C: Use generic clock names for sdhci bus clock
 options
Date: Wed, 12 Oct 2011 15:13:05 +0530
Message-ID: <1318412587-29987-2-git-send-email-rajeshwari.s@samsung.com>
References: <1318412587-29987-1-git-send-email-rajeshwari.s@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:14183 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476Ab1JLJqs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Oct 2011 05:46:48 -0400
In-reply-to: <1318412587-29987-1-git-send-email-rajeshwari.s@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org

This patch modifies the driver to stop depending on the clock names
being passed from the platform and switch over to bus clock lookup
using generic clock names.

Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 82709b6..a5fde87 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -435,14 +435,12 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 
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

