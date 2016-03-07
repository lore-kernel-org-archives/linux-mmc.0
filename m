From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v7 2/4] mmc: sdhci-of-arasan: remove disable clk_ahb from sdhci_arasan_resume
Date: Mon,  7 Mar 2016 23:38:56 +0800
Message-ID: <1457365136-23332-1-git-send-email-shawn.lin@rock-chips.com>
References: <1457365099-23248-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:38046 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752913AbcCGPrO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Mar 2016 10:47:14 -0500
In-Reply-To: <1457365099-23248-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

We don't really need disable clk_ahb when failing to resume. Otherwise
we may take risk of bus error for accessing register without clk_ahb.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/mmc/host/sdhci-of-arasan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 1e4b5e0..ae8052d 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -118,7 +118,6 @@ static int sdhci_arasan_resume(struct device *dev)
 	ret = clk_enable(pltfm_host->clk);
 	if (ret) {
 		dev_err(dev, "Cannot enable SD clock.\n");
-		clk_disable(sdhci_arasan->clk_ahb);
 		return ret;
 	}
 
-- 
2.3.7


