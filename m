From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 07/21] mmc: sdhci-pxav3: consolidate parsing path
Date: Wed, 27 Jan 2016 13:07:36 +0800
Message-ID: <1453871256-3599-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:33049 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbcA0FMJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 00:12:09 -0500
In-Reply-To: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Jisheng Zhang <jszhang@marvell.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>

This patch remove mmc_of_parse and check return value
of sdhci_get_of_property.

Cc: Jisheng Zhang <jszhang@marvell.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-pxav3.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index f5edf9d..06eda25 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -410,10 +410,8 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 
 	match = of_match_device(of_match_ptr(sdhci_pxav3_of_match), &pdev->dev);
 	if (match) {
-		ret = mmc_of_parse(host->mmc);
-		if (ret)
+		ret = sdhci_get_of_property(pdev);
 			goto err_of_parse;
-		sdhci_get_of_property(pdev);
 		pdata = pxav3_get_mmc_pdata(dev);
 		pdev->dev.platform_data = pdata;
 	} else if (pdata) {
-- 
2.3.7


