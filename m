From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH V2 7/7] mmc: msm_sdcc: Handle dma resource not present case
Date: Mon,  2 May 2011 18:10:40 +0530
Message-ID: <1304340040-9149-1-git-send-email-stummala@codeaurora.org>
References: <1303796066-6784-7-git-send-email-stummala@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:43288 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754941Ab1EBMkv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 May 2011 08:40:51 -0400
In-Reply-To: <1303796066-6784-7-git-send-email-stummala@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: davidb@codeaurora.org, bryanh@codeaurora.org, dwalker@fifo99.com
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, san@google.com, Subhash Jadavani <subhashj@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>

From: Subhash Jadavani <subhashj@codeaurora.org>

If DMA resource is not available then SDCC driver
should atleast work in PIO data transfer mode.

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 drivers/mmc/host/msm_sdcc.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index 1fe4102..0a0d582 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -1233,9 +1233,13 @@ msmsdcc_probe(struct platform_device *pdev)
 	/*
 	 * Setup DMA
 	 */
-	ret = msmsdcc_init_dma(host);
-	if (ret)
-		goto ioremap_free;
+	if (host->dmares) {
+		ret = msmsdcc_init_dma(host);
+		if (ret)
+			goto ioremap_free;
+	} else {
+		host->dma.channel = -1;
+	}
 
 	/* Get our clocks */
 	host->pclk = clk_get(&pdev->dev, "sdc_pclk");
@@ -1379,8 +1383,9 @@ msmsdcc_probe(struct platform_device *pdev)
  pclk_put:
 	clk_put(host->pclk);
 dma_free:
-	dma_free_coherent(NULL, sizeof(struct msmsdcc_nc_dmadata),
-				host->dma.nc, host->dma.nc_busaddr);
+	if (host->dmares)
+		dma_free_coherent(NULL, sizeof(struct msmsdcc_nc_dmadata),
+					host->dma.nc, host->dma.nc_busaddr);
 ioremap_free:
 	tasklet_kill(&host->dma_tlet);
 	iounmap(host->base);
-- 
1.7.1

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
