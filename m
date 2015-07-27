From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: sdhci-of-arasan: Get quirks from device tree
Date: Mon, 27 Jul 2015 16:04:09 +0800
Message-ID: <1437984249-18332-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular2.263xmail.com ([211.157.152.3]:42592 "EHLO
	regular2.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbbG0IH0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jul 2015 04:07:26 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

This patch adds the interface to get quirks from dts, and
there is no need to assign different quirks by condition statement
of arasan IP version.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-of-arasan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index ef5a7d2..db07788 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -132,6 +132,7 @@ static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
 static int sdhci_arasan_probe(struct platform_device *pdev)
 {
 	int ret;
+	u32 quirktab[2];
 	struct clk *clk_xin;
 	struct sdhci_host *host;
 	struct sdhci_pltfm_host *pltfm_host;
@@ -172,6 +173,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		goto clk_disable_all;
 	}
 
+	if (of_property_read_u32_array(pdev->dev.of_node,
+				       "arasan,quirks", &quirktab[0], 2)) {
+		host->quirks |= quirktab[0];
+		host->quirks2 |= quirktab[1];
+	}
+
 	if (of_device_is_compatible(pdev->dev.of_node, "arasan,sdhci-4.9a")) {
 		host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
 		host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
-- 
2.3.7


