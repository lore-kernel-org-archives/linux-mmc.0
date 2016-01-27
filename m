From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 02/21] mmc: sdhci-iproc: consolidate parsing path
Date: Wed, 27 Jan 2016 13:04:39 +0800
Message-ID: <1453871079-3071-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:45150 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbcA0FJR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 00:09:17 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Scott Branden <sbranden@broadcom.com>

This patch remove mmc_of_parse and check return value
of sdhci_get_of_property.

Cc: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-iproc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 3b423b0..18cfe2c 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -196,8 +196,9 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
 
 	iproc_host->data = iproc_data;
 
-	mmc_of_parse(host->mmc);
-	sdhci_get_of_property(pdev);
+	ret = sdhci_get_of_property(pdev);
+	if (ret)
+		return ret;
 
 	/* Enable EMMC 1/8V DDR capable */
 	host->mmc->caps |= MMC_CAP_1_8V_DDR;
-- 
2.3.7


