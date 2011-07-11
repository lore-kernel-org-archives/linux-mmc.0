From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: pxav3 controller needs 32 bit ADMA addressing
Date: Mon, 11 Jul 2011 14:47:54 -0700
Message-ID: <44DD7577-7CB6-42D0-9427-A8731C248612@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:39303 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753875Ab1GKVrv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Jul 2011 17:47:51 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Zhangfei Gao <zgao6@marvell.com>


enable the quirk.

Best used in conjunction with patch downgrading
ADMA to SDMA when transfer is not aligned.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 4198dbb..fc7e4a5 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -195,7 +195,8 @@ static int __devinit sdhci_pxav3_probe(struct platform_device *pdev)
 	clk_enable(clk);
 
 	host->quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
-		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
+		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
+		| SDHCI_QUIRK_32BIT_ADMA_SIZE;
 
 	/* enable 1/8V DDR capable */
 	host->mmc->caps |= MMC_CAP_1_8V_DDR;
-- 
1.7.0.4


