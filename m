From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] mmc: read alias from device-tree if probing via of.
Date: Fri,  2 Oct 2015 17:36:53 +0100
Message-ID: <1443803813-13369-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:40384 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbbJBQg4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Oct 2015 12:36:56 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@lists.codethink.co.uk, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, kejia.hu@codethink.co.uk
Cc: devicetree@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>

The mmc host controller fails to check for the presence
of an aliases entry in the device tree when creating a
new mmc host. This means that  mmc bus numbers are not
as specified in the aliases node.

For example, the following on an imx6 would make mmc0
the second sdhci, and mmc2 the first sdhci:

aliases {
	mmc0 = &usdhc2;
	mmc2 = &usdhc0;
}

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Tested-by: Kejia Hu <kejia.hu@codethink.co.uk>
---
 drivers/mmc/core/host.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index abd933b..3bed4d0 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -561,7 +561,11 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	host->rescan_disable = 1;
 	idr_preload(GFP_KERNEL);
 	spin_lock(&mmc_host_lock);
-	err = idr_alloc(&mmc_host_idr, host, 0, 0, GFP_NOWAIT);
+	err = of_alias_get_id(dev->of_node, "mmc");
+	if (err >= 0)
+		err = idr_alloc(&mmc_host_idr, host, err, err+1, GFP_NOWAIT);
+	if (err < 0)
+		err = idr_alloc(&mmc_host_idr, host, 0, 0, GFP_NOWAIT);
 	if (err >= 0)
 		host->index = err;
 	spin_unlock(&mmc_host_lock);
-- 
2.5.3

